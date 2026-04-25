<template>
  <div class="container">
    <div class="header">
      <h1 class="title">
        {{ isEdit ? "Edit Request Barang" : "Tambah Request Barang" }}
      </h1>
    </div>

    <div class="form-card">
      <form @submit.prevent="submitRequest" class="form">
        <div class="form-fields">
          <BaseInput
            label="Nama Barang"
            v-model="form.nama_barang"
            type="text"
            placeholder=""
          />

          <BaseInput
            label="Nama Customer"
            v-model="form.nama_pemohon"
            type="text"
            placeholder=""
          />

          <BaseInput
            label="No. HP"
            v-model="form.kontak"
            type="text"
            placeholder=""
          />

          <BaseInput
            label="Catatan Tambahan"
            v-model="form.catatan"
            type="text"
            placeholder=""
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
  nama_barang: "",
  nama_pemohon: "",
  kontak: "",
  catatan: "",
});

const submitRequest = async () => {
  if (!form.nama_barang || !form.nama_pemohon || !form.kontak) {
    alert("Mohon isi field yang wajib (Nama Barang, Pemohon, dan Kontak)");
    return;
  }

  loading.value = true;

  try {
    const payload = {
      nama_barang: form.nama_barang,
      nama_pemohon: form.nama_pemohon,
      kontak: form.kontak,
      catatan: form.catatan,
    };

    let url = "http://localhost:3000/api/requests";
    let method = "POST";

    if (isEdit.value) {
      url = `http://localhost:3000/api/requests/${route.params.id}`;
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

    router.push("/requests");
  } catch (error) {
    alert(error.message);
  } finally {
    loading.value = false;
  }
};

const fetchRequestById = async (id) => {
  try {
    const response = await fetch(`http://localhost:3000/api/requests/${id}`, {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("token")}`,
      },
    });

    const data = await response.json();

    if (response.ok) {
      form.nama_barang = data.nama_barang;
      form.nama_pemohon = data.nama_pemohon;
      form.kontak = data.kontak;
      form.catatan = data.catatan;
    }
  } catch (error) {
    console.error("Gagal mengambil data detail:", error);
  }
};

onMounted(() => {
  const id = route.params.id;

  if (id) {
    isEdit.value = true;
    fetchRequestById(id);
  }
});

const goBack = () => {
  router.push("/requests");
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
