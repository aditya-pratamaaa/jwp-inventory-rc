<template>
  <div class="container">
    <div class="header">
      <h1 class="title">Dashboard</h1>
    </div>

    <div class="grid">
      <div class="card">
        <div class="card-title">Total Barang</div>
        <div class="card-value">{{ totalBarang }}</div>
      </div>

      <div class="card">
        <div class="card-title">Total Transaksi</div>
        <div class="card-value">{{ totalTransaksi }}</div>
      </div>

      <div class="card">
        <div class="card-title">Total Nilai</div>
        <div class="card-value">{{ formatCurrency(totalNilai) }}</div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";

const totalBarang = ref(0);
const totalTransaksi = ref(0);
const totalNilai = ref(0);

const fetchDashboard = async () => {
  try {
    const [barangRes, transaksiRes] = await Promise.all([
      fetch("http://localhost:3000/api/barang", {
        headers: {
          Authorization: `Bearer ${localStorage.getItem("token")}`,
        },
      }),
      fetch("http://localhost:3000/api/transaksi", {
        headers: {
          Authorization: `Bearer ${localStorage.getItem("token")}`,
        },
      }),
    ]);

    const barang = await barangRes.json();
    const transaksi = await transaksiRes.json();

    totalBarang.value = barang.length;
    totalTransaksi.value = transaksi.length;

    totalNilai.value = transaksi.reduce((acc, item) => {
      return acc + (item.total_harga || 0);
    }, 0);
  } catch (error) {
    console.error(error);
  }
};

const formatCurrency = (value) => {
  return new Intl.NumberFormat("id-ID", {
    style: "currency",
    currency: "IDR",
    minimumFractionDigits: 0,
  }).format(value);
};

onMounted(() => {
  fetchDashboard();
});
</script>

<style scoped>
.container {
  max-width: 1000px;
}

.header {
  margin-bottom: 20px;
}

.title {
  font-size: 26px;
  font-weight: 600;
  color: var(--text-strong);
}

.grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 16px;
}

.card {
  background: #fff;
  padding: 18px;
  border-radius: 10px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.06);
}

.card-title {
  font-size: 14px;
  color: #6b7280;
  margin-bottom: 8px;
}

.card-value {
  font-size: 22px;
  font-weight: 600;
  color: #111827;
}
</style>
