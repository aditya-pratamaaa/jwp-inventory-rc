<template>
  <div class="container">
    <div class="header">
      <h1 class="title">Tambah Barang</h1>
    </div>

    <div class="form-card">
      <form @submit.prevent="submitBarang" class="form">
        <div class="form-fields">
          <BaseInput
            label="Kode Barang"
            v-model="form.kode_barang"
            type="number"
            min="0"
            @keypress="preventMinus"
          />

          <BaseInput
            label="Nama Barang"
            v-model="form.nama_barang"
            type="text"
          />

          <BaseInput
            label="Harga Barang"
            v-model="form.harga_barang"
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
import { useRouter, useRoute } from "vue-router";
import BaseButton from "@/components/BaseButton.vue";
import BaseInput from "@/components/BaseInput.vue";

const router = useRouter();
const route = useRoute();
const loading = ref(false);
const isEdit = ref(false);

const form = reactive({
  kode_barang: "",
  nama_barang: "",
  harga_barang: "",
});

const submitBarang = async () => {
  if (Number(form.kode_barang) < 0 || Number(form.harga_barang) < 0) {
    alert("Nilai tidak boleh minus");
    return;
  }
  loading.value = true;

  try {
    const payload = {
      kode_barang: Number(form.kode_barang),
      nama_barang: form.nama_barang,
      harga_barang: Number(form.harga_barang),
    };

    let url = "http://localhost:3000/api/barang";
    let method = "POST";

    if (isEdit.value) {
      url = `http://localhost:3000/api/barang/${form.kode_barang}`;
      method = "PUT";
    }

    const response = await fetch(url, {
      method,
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${localStorage.getItem("token")}`,
      },
      body: JSON.stringify(payload),
    });

    const data = await response.json();

    if (!response.ok) {
      throw new Error(data.message || "Gagal menyimpan data");
    }

    router.push("/item");
  } catch (error) {
    alert(error.message);
  } finally {
    loading.value = false;
  }
};

const fetchBarangById = async (id) => {
  const response = await fetch(`http://localhost:3000/api/barang/${id}`, {
    headers: {
      Authorization: `Bearer ${localStorage.getItem("token")}`,
    },
  });

  const data = await response.json();

  form.kode_barang = data.kode_barang;
  form.nama_barang = data.nama_barang;
  form.harga_barang = data.harga_barang;
};

onMounted(() => {
  const id = route.params.id;

  if (id) {
    isEdit.value = true;
    fetchBarangById(id);
  }
});

const preventMinus = (event) => {
  if (event.key === "-" || event.key === "e") {
    event.preventDefault();
  }
};

const goBack = () => {
  router.push("/item");
};
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
</style>
