-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Barang" (
    "kode_barang" INTEGER NOT NULL,
    "nama_barang" TEXT NOT NULL,
    "harga_barang" INTEGER NOT NULL,

    CONSTRAINT "Barang_pkey" PRIMARY KEY ("kode_barang")
);

-- CreateTable
CREATE TABLE "Transaksi" (
    "kode_transaksi" SERIAL NOT NULL,
    "kode_barang" INTEGER NOT NULL,
    "jumlah_barang" INTEGER NOT NULL,
    "total_harga" INTEGER NOT NULL,

    CONSTRAINT "Transaksi_pkey" PRIMARY KEY ("kode_transaksi")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- AddForeignKey
ALTER TABLE "Transaksi" ADD CONSTRAINT "Transaksi_kode_barang_fkey" FOREIGN KEY ("kode_barang") REFERENCES "Barang"("kode_barang") ON DELETE RESTRICT ON UPDATE CASCADE;
