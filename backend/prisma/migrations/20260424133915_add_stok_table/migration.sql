-- CreateTable
CREATE TABLE "Stok" (
    "id" SERIAL NOT NULL,
    "kode_barang" INTEGER NOT NULL,
    "jumlah_stok" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "Stok_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Stok_kode_barang_key" ON "Stok"("kode_barang");

-- AddForeignKey
ALTER TABLE "Stok" ADD CONSTRAINT "Stok_kode_barang_fkey" FOREIGN KEY ("kode_barang") REFERENCES "Barang"("kode_barang") ON DELETE RESTRICT ON UPDATE CASCADE;
