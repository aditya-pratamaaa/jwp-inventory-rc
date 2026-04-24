<template>
  <div class="header">
    <h1 class="header-title">Stok Barang</h1>

    <BaseButton variant="primary" @click="goToForm"> Tambah Stok </BaseButton>
  </div>

  <BaseTable
    :is-loading="stok.loading"
    :is-empty="!stok.loading && !stok.data.length"
  >
    <template #thead>
      <th style="width: 15%">Kode</th>
      <th style="width: 45%">Nama Barang</th>
      <th style="width: 20%">Jumlah Stok</th>
      <th style="width: 20%">Aksi</th>
    </template>

    <template #tbody>
      <tr v-for="item in stok.data" :key="item.id">
        <td>
          <span class="font-medium">#{{ item.kode_barang }}</span>
        </td>

        <td>
          <div class="font-medium text-gray-800">
            {{ item.barang?.nama_barang }}
          </div>
        </td>

        <td>
          <span
            :class="{
              'text-red-500': item.jumlah_stok === 0,
              'text-green-600': item.jumlah_stok > 0,
            }"
          >
            {{ item.jumlah_stok }}
          </span>
        </td>

        <td>
          <div class="action-group">
            <Edit @click="editStok(item.kode_barang)" />
          </div>
        </td>
      </tr>
    </template>
  </BaseTable>
</template>

<script setup>
import { reactive, onMounted } from "vue";
import { useRouter } from "vue-router";
import BaseButton from "@/components/BaseButton.vue";
import BaseTable from "@/components/BaseTable.vue";
import Edit from "@/components/icons/Edit.vue";

const router = useRouter();

const stok = reactive({
  data: [],
  loading: false,
});

const fetchStok = async () => {
  stok.loading = true;

  try {
    const response = await fetch("http://localhost:3000/api/stok", {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("token")}`,
      },
    });

    const data = await response.json();

    if (!response.ok) {
      throw new Error(data.message || "Gagal mengambil data stok");
    }

    stok.data = data;
  } catch (error) {
    console.error(error);
  } finally {
    stok.loading = false;
  }
};

const editStok = (kode_barang) => {
  router.push(`/stok-form/${kode_barang}/edit`);
};

const goToForm = () => {
  router.push("/stok-form");
};

onMounted(() => {
  fetchStok();
});
</script>

<style scoped>
.header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  margin-bottom: 20px;
}

.header-title {
  font-size: 26px;
  font-weight: 600;
  color: var(--text-strong);
}

.action-group {
  display: flex;
  gap: 8px;
}
</style>
