import "dotenv/config";
import express from "express";
import cors from "cors";
import { PrismaClient } from "@prisma/client";
import { PrismaPg } from "@prisma/adapter-pg";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";

const adapter = new PrismaPg({
  connectionString: process.env.DATABASE_URL,
});

const prisma = new PrismaClient({
  adapter,
});

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());

const authMiddleware = (req, res, next) => {
  const authHeader = req.headers.authorization;

  if (!authHeader) {
    return res.status(401).json({ message: "No token" });
  }

  const token = authHeader.split(" ")[1];

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET || "SECRET_KEY");
    req.user = decoded;
    next();
  } catch (error) {
    return res.status(403).json({ message: "Invalid token" });
  }
};

app.post("/register", async (req, res) => {
  try {
    const { username, password } = req.body;

    const hashedPassword = await bcrypt.hash(password, 10);

    const user = await prisma.user.create({
      data: {
        username,
        password: hashedPassword,
      },
    });

    res.json({
      message: "User created",
      data: user,
    });
  } catch (error) {
    res.status(500).json({ message: "Register failed" });
  }
});

app.post("/login", async (req, res) => {
  try {
    const { username, password } = req.body;

    const user = await prisma.user.findUnique({
      where: { username },
    });

    if (!user) {
      return res.status(404).json({ message: "Invalid credentials" });
    }

    const isMatch = await bcrypt.compare(password, user.password);

    if (!isMatch) {
      return res.status(401).json({ message: "Invalid credentials" });
    }

    const token = jwt.sign(
      { id: user.id, username: user.username },
      process.env.JWT_SECRET || "SECRET_KEY",
      { expiresIn: "1h" },
    );

    res.json({
      message: "Authentication successful",
      token,
    });
  } catch (error) {
    res.status(500).json({ message: "Internal server error" });
  }
});

app.get("/me", authMiddleware, async (req, res) => {
  try {
    const user = await prisma.user.findUnique({
      where: { id: req.user.id },
    });

    res.json(user);
  } catch (error) {
    res.status(500).json({ message: "Error" });
  }
});

app.get("/api/barang", authMiddleware, async (req, res) => {
  try {
    const data = await prisma.barang.findMany();
    res.json(data);
  } catch (error) {
    res.status(500).json({ message: "Database connection error" });
  }
});

app.post("/api/barang", authMiddleware, async (req, res) => {
  try {
    const { kode_barang, nama_barang, harga_barang } = req.body;

    const newBarang = await prisma.barang.create({
      data: {
        kode_barang: parseInt(kode_barang),
        nama_barang,
        harga_barang: parseInt(harga_barang),
      },
    });

    res.json(newBarang);
  } catch (error) {
    res.status(500).json({ message: "Failed to create data" });
  }
});

app.get("/api/barang/:id", authMiddleware, async (req, res) => {
  try {
    const id = parseInt(req.params.id);

    const data = await prisma.barang.findUnique({
      where: { kode_barang: id },
    });

    if (!data) {
      return res.status(404).json({ message: "Data not found" });
    }

    res.json(data);
  } catch (error) {
    res.status(500).json({ message: "Error" });
  }
});

app.put("/api/barang/:id", authMiddleware, async (req, res) => {
  try {
    const id = parseInt(req.params.id);
    const { nama_barang, harga_barang } = req.body;

    const updated = await prisma.barang.update({
      where: { kode_barang: id },
      data: {
        nama_barang,
        harga_barang: parseInt(harga_barang),
      },
    });

    res.json(updated);
  } catch (error) {
    res.status(500).json({ message: "Update failed" });
  }
});

app.delete("/api/barang/:id", authMiddleware, async (req, res) => {
  try {
    const id = parseInt(req.params.id);

    await prisma.barang.delete({
      where: { kode_barang: id },
    });

    res.json({ message: "Data deleted" });
  } catch (error) {
    res.status(500).json({ message: "Delete failed" });
  }
});

app.get("/api/barang/search", authMiddleware, async (req, res) => {
  try {
    const { nama } = req.query;

    const data = await prisma.barang.findMany({
      where: {
        nama_barang: {
          contains: nama,
          mode: "insensitive",
        },
      },
    });

    res.json(data);
  } catch (error) {
    res.status(500).json({ message: "Search error" });
  }
});

app.get("/api/barang/paginate", authMiddleware, async (req, res) => {
  try {
    const page = parseInt(req.query.page) || 1;
    const limit = 5;
    const skip = (page - 1) * limit;

    const data = await prisma.barang.findMany({
      skip,
      take: limit,
    });

    res.json(data);
  } catch (error) {
    res.status(500).json({ message: "Pagination error" });
  }
});

app.post("/api/transaksi", authMiddleware, async (req, res) => {
  try {
    const kode = parseInt(req.body.kode_barang);
    const jumlah = parseInt(req.body.jumlah_barang);

    if (!kode || !jumlah) {
      return res.status(400).json({ message: "Input tidak valid" });
    }

    const barang = await prisma.barang.findUnique({
      where: { kode_barang: kode },
    });

    if (!barang) {
      return res.status(404).json({ message: "Barang not found" });
    }

    const stok = await prisma.stok.findUnique({
      where: { kode_barang: kode },
    });

    if (!stok || stok.jumlah_stok < jumlah) {
      return res.status(400).json({ message: "Stok tidak cukup" });
    }

    const total = barang.harga_barang * jumlah;

    const transaksi = await prisma.transaksi.create({
      data: {
        kode_barang: kode,
        jumlah_barang: jumlah,
        total_harga: total,
      },
    });

    await prisma.stok.update({
      where: { kode_barang: kode },
      data: {
        jumlah_stok: stok.jumlah_stok - jumlah,
      },
    });

    res.json(transaksi);
  } catch (error) {
    res.status(500).json({ message: "Error transaksi" });
  }
});

app.get("/api/transaksi", authMiddleware, async (req, res) => {
  try {
    const data = await prisma.transaksi.findMany({
      include: {
        barang: true,
      },
    });

    res.json(data);
  } catch (error) {
    res.status(500).json({ message: "Error get transaksi" });
  }
});

app.get("/api/stok", authMiddleware, async (req, res) => {
  try {
    const data = await prisma.stok.findMany({
      include: {
        barang: true,
      },
    });

    res.json(data);
  } catch (error) {
    res.status(500).json({ message: "Error get stok" });
  }
});

app.post("/api/stok", authMiddleware, async (req, res) => {
  try {
    const kode = parseInt(req.body.kode_barang);
    const jumlah = parseInt(req.body.jumlah_stok);

    if (!kode || isNaN(jumlah)) {
      return res.status(400).json({ message: "Input tidak valid" });
    }

    const data = await prisma.stok.upsert({
      where: { kode_barang: kode },
      update: { jumlah_stok: jumlah },
      create: {
        kode_barang: kode,
        jumlah_stok: jumlah,
      },
    });

    res.json(data);
  } catch (error) {
    res.status(500).json({
      message: "Error update stok",
      detail: error.message,
    });
  }
});

app.get("/api/stok/:id", authMiddleware, async (req, res) => {
  try {
    const id = parseInt(req.params.id);

    const data = await prisma.stok.findUnique({
      where: { kode_barang: id },
      include: { barang: true },
    });

    if (!data) {
      return res.status(404).json({ message: "Stok not found" });
    }

    res.json(data);
  } catch (error) {
    res.status(500).json({ message: "Error get stok" });
  }
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
