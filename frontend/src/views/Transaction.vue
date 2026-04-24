<template>
  <div class="container">
    <div class="header">
      <h1 class="title">Transaksi</h1>
    </div>

    <div class="form-card">
      <form @submit.prevent="submitTransaksi" class="form">
        <div class="form-fields">
          <div class="form-group">
            <label>Barang</label>
            <select v-model="form.kode_barang">
              <option value="">Pilih Barang</option>
              <option
                v-for="item in barangList"
                :key="item.kode_barang"
                :value="item.kode_barang"
              >
                {{ item.nama_barang }} - Rp {{ item.harga_barang }}
              </option>
            </select>
          </div>

          <BaseInput
            label="Jumlah Barang"
            v-model="form.jumlah_barang"
            type="number"
            min="1"
            @keypress="preventMinus"
          />
        </div>

        <div class="actions">
          <BaseButton type="submit" variant="primary" :disabled="loading">
            {{ loading ? "Memproses..." : "Simpan Transaksi" }}
          </BaseButton>
        </div>
      </form>
    </div>

    <div class="table-card">
      <h2 class="subtitle">Riwayat Transaksi</h2>

      <table class="table">
        <thead>
          <tr>
            <th>ID</th>
            <th>Barang</th>
            <th>Jumlah</th>
            <th>Total</th>
          </tr>
        </thead>

        <tbody>
          <tr v-for="item in transaksi" :key="item.kode_transaksi">
            <td>#{{ item.kode_transaksi }}</td>
            <td>{{ item.barang?.nama_barang }}</td>
            <td>{{ item.jumlah_barang }}</td>
            <td>Rp {{ formatPrice(item.total_harga) }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from "vue";
import BaseInput from "@/components/BaseInput.vue";
import BaseButton from "@/components/BaseButton.vue";

const loading = ref(false);
const transaksi = ref([]);
const barangList = ref([]);

const form = reactive({
  kode_barang: "",
  jumlah_barang: "",
});

const token = () => localStorage.getItem("token");

const fetchBarang = async () => {
  const res = await fetch("http://localhost:3000/api/barang", {
    headers: {
      Authorization: `Bearer ${token()}`,
    },
  });

  barangList.value = await res.json();
};

const fetchTransaksi = async () => {
  const res = await fetch("http://localhost:3000/api/transaksi", {
    headers: {
      Authorization: `Bearer ${token()}`,
    },
  });

  transaksi.value = await res.json();
};

const submitTransaksi = async () => {
  if (!form.kode_barang || !form.jumlah_barang) {
    alert("Lengkapi data");
    return;
  }

  loading.value = true;

  try {
    const res = await fetch("http://localhost:3000/api/transaksi", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token()}`,
      },
      body: JSON.stringify({
        kode_barang: Number(form.kode_barang),
        jumlah_barang: Number(form.jumlah_barang),
      }),
    });

    const data = await res.json();

    if (!res.ok) throw new Error(data.message);

    form.kode_barang = "";
    form.jumlah_barang = "";

    await fetchTransaksi();
  } catch (err) {
    alert(err.message);
  } finally {
    loading.value = false;
  }
};

const preventMinus = (event) => {
  if (event.key === "-" || event.key === "e") {
    event.preventDefault();
  }
};

const formatPrice = (value) => {
  return new Intl.NumberFormat("id-ID").format(value);
};

onMounted(() => {
  fetchBarang();
  fetchTransaksi();
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
}

.form {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.form-fields {
  display: flex;
  gap: 1rem;
}

.form-group select {
  height: 35px;
  width: 100%;
  border: 1px solid var(--border-form);
  border-radius: 6px;
  padding: 0 10px;
}

.actions {
  display: flex;
  justify-content: flex-end;
}

.table-card {
  margin-top: 2rem;
}

.subtitle {
  margin-bottom: 10px;
  font-size: 18px;
}

.table {
  width: 100%;
  border-collapse: collapse;
}

.table th,
.table td {
  padding: 10px;
  border-bottom: 1px solid #ddd;
  text-align: left;
}
</style>
