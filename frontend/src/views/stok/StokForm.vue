<template>
  <div class="container">
    <div class="header">
      <h1 class="title">Update Stok</h1>
    </div>

    <div class="form-card">
      <form @submit.prevent="submitStok" class="form">
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
                {{ item.nama_barang }}
              </option>
            </select>
          </div>

          <BaseInput
            label="Jumlah Stok"
            v-model="form.jumlah_stok"
            type="number"
            min="0"
            @keypress="preventMinus"
          />
        </div>

        <div class="actions">
          <BaseButton type="button" variant="secondary" @click="goBack">
            Batal
          </BaseButton>

          <BaseButton type="submit" variant="primary" :disabled="loading">
            {{ loading ? "Menyimpan..." : "Simpan" }}
          </BaseButton>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup>
import { reactive, ref, onMounted } from "vue";
import { useRouter } from "vue-router";
import BaseButton from "@/components/BaseButton.vue";
import BaseInput from "@/components/BaseInput.vue";
import { useRoute } from "vue-router";

const route = useRoute();
const isEdit = ref(false);

const router = useRouter();
const loading = ref(false);

const barangList = ref([]);

const form = reactive({
  kode_barang: "",
  jumlah_stok: "",
});

const fetchBarang = async () => {
  const res = await fetch("http://localhost:3000/api/barang", {
    headers: {
      Authorization: `Bearer ${localStorage.getItem("token")}`,
    },
  });

  barangList.value = await res.json();
};

const submitStok = async () => {
  loading.value = true;

  try {
    let url = "http://localhost:3000/api/stok";
    let method = "POST";

    if (isEdit.value) {
      url = `http://localhost:3000/api/stok`;
      method = "POST";
    }

    const response = await fetch(url, {
      method,
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${localStorage.getItem("token")}`,
      },
      body: JSON.stringify({
        kode_barang: Number(form.kode_barang),
        jumlah_stok: Number(form.jumlah_stok),
      }),
    });

    const data = await response.json();

    if (!response.ok) {
      throw new Error(data.message || "Gagal menyimpan stok");
    }

    router.push("/stok");
  } catch (error) {
    alert(error.message);
  } finally {
    loading.value = false;
  }
};

const fetchStokById = async (kode) => {
  const res = await fetch(`http://localhost:3000/api/stok`, {
    headers: {
      Authorization: `Bearer ${localStorage.getItem("token")}`,
    },
  });

  const data = await res.json();

  const stokItem = data.find((item) => item.kode_barang == kode);

  if (stokItem) {
    form.kode_barang = stokItem.kode_barang;
    form.jumlah_stok = stokItem.jumlah_stok;
  }
};

onMounted(() => {
  fetchBarang();

  const kode = route.params.id;

  if (kode) {
    isEdit.value = true;
    fetchStokById(kode);
  }
});

const preventMinus = (event) => {
  if (event.key === "-" || event.key === "e") {
    event.preventDefault();
  }
};

const goBack = () => {
  router.push("/stok");
};

onMounted(() => {
  fetchBarang();
});
</script>

<style scoped>
.header {
  margin-bottom: 20px;
}

.title {
  font-size: 26px;
  font-weight: 600;
  color: var(--text-strong);
}

.form {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.form-fields {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.actions {
  display: flex;
  justify-content: flex-end;
  gap: 0.75rem;
}

select {
  height: 35px;
  border: 1px solid var(--border-form);
  border-radius: 6px;
  padding: 0 10px;
  background: var(--bg-neutral);
}
</style>
