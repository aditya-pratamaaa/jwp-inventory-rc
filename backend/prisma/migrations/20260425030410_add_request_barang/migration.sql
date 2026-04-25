-- CreateTable
CREATE TABLE "RequestBarang" (
    "id" SERIAL NOT NULL,
    "nama_barang" TEXT NOT NULL,
    "nama_pemohon" TEXT NOT NULL,
    "kontak" TEXT NOT NULL,
    "catatan" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "RequestBarang_pkey" PRIMARY KEY ("id")
);
