# Tugas Akhir - Junior Web Programming

### Identitas Mahasiswa

- Nama: Muhammad Aditya Pratama
- NIM: 220103065
- Kelas: TI 22A2

### Tema Kasus

Sistem Manajemen Inventory Sparepart RC. Aplikasi ini dirancang untuk mengelola stok barang hobi, mencatat data barang, dan membatasi akses melalui sistem autentikasi.

### Fitur Utama

- Autentikasi: Login dan Register menggunakan JWT (JSON Web Token) dan enkripsi password.
- CRUD: Create, Read, Update, dan Delete data pada tabel barang.
- Keamanan: Proteksi rute halaman dashboard (Frontend) dan middleware autentikasi (Backend).
- Validasi Input: Pencegahan input nilai negatif pada kolom harga dan kode barang.

### Tech Stack

- Frontend: Vue.js 3 (Vite), Frappe UI.
- Backend: Node.js, Express.js.
- ORM: Prisma.
- Database: PostgreSQL.

### Cara Menjalankan Project

1. Persiapan Database

- Buat database baru di PostgreSQL dengan nama jwp_db.
- Import file jwp_db.sql yang tersedia di folder utama project ke dalam database tersebut.

2. Konfigurasi Backend

- Masuk ke folder backend: cd backend
- Instal dependencies: npm install
- Buat file .env dan sesuaikan DATABASE_URL (contoh: postgresql://user:password@localhost:5432/jwp_db).
- Generate Prisma client: npx prisma generate
- Jalankan server: npm start

3. Konfigurasi Frontend

- Masuk ke folder frontend: cd frontend
- Instal dependencies: npm install
- Jalankan aplikasi: npm run dev

### Informasi Penting dan Akun Uji Coba

- Akun Admin: Username: admin, Password: admin@123.
- Registrasi: Pengguna diperbolehkan mendaftarkan akun baru melalui halaman register.
- Masa Berlaku Token: Token JWT hanya berlaku selama 1 jam.
- Fitur Logout: Saat ini fitur logout belum diimplementasikan di antarmuka pengguna.
- Solusi Token Kadaluarsa: Jika data tidak muncul (karena token habis), silakan buka console browser dan jalankan perintah localStorage.removeItem("token"); lalu lakukan login ulang.

---
