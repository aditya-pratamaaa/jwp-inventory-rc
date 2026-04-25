<template>
  <div class="header">
    <h1 class="header-title">Request Barang</h1>

    <BaseButton variant="primary" @click="goToForm">
      Tambah Request
    </BaseButton>
  </div>

  <BaseTable
    :is-loading="requestData.loading"
    :is-empty="!requestData.loading && !requestData.data.length"
  >
    <template #thead>
      <th style="width: 5%">ID</th>
      <th style="width: 25%">Nama Barang</th>
      <th style="width: 20%">Pemohon</th>
      <th style="width: 15%">Kontak</th>
      <th style="width: 25%">Catatan</th>
      <th style="width: 10%">Aksi</th>
    </template>

    <template #tbody>
      <tr v-for="item in requestData.data" :key="item.id">
        <td>
          <span class="font-medium">#{{ item.id }}</span>
        </td>

        <td>
          <div class="font-medium text-gray-800">
            {{ item.nama_barang }}
          </div>
        </td>

        <td>
          {{ item.nama_pemohon }}
        </td>

        <td>
          {{ item.kontak }}
        </td>

        <td class="text-sm text-gray-600">
          {{ item.catatan || "-" }}
        </td>

        <td>
          <div class="action-group">
            <Edit @click="editRequest(item.id)" />
            <Delete @click="deleteRequest(item.id)" />
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
import Delete from "@/components/icons/Delete.vue";
import Edit from "@/components/icons/Edit.vue";

const router = useRouter();

const requestData = reactive({
  data: [],
  loading: false,
});

const fetchRequests = async () => {
  requestData.loading = true;

  try {
    const response = await fetch("http://localhost:3000/api/requests", {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("token")}`,
      },
    });

    const data = await response.json();

    if (!response.ok) {
      throw new Error(data.message || "Gagal mengambil data");
    }

    requestData.data = data;
  } catch (error) {
    console.error(error);
  } finally {
    requestData.loading = false;
  }
};

const editRequest = (id) => {
  router.push(`/requests-form/${id}/edit`);
};

const deleteRequest = async (id) => {
  if (!confirm("Apakah anda yakin ingin menghapus data request ini?")) return;

  try {
    const response = await fetch(`http://localhost:3000/api/requests/${id}`, {
      method: "DELETE",
      headers: {
        Authorization: `Bearer ${localStorage.getItem("token")}`,
      },
    });

    if (!response.ok) {
      throw new Error("Gagal menghapus request");
    }

    await fetchRequests();
  } catch (error) {
    alert(error.message);
  }
};

const goToForm = () => {
  router.push({ name: "RequestsForm" });
};

onMounted(() => {
  fetchRequests();
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
  margin-right: auto;
}

.action-group {
  display: flex;
  gap: 8px;
}

.text-sm {
  font-size: 14px;
}

.text-gray-600 {
  color: #4b5563;
}
</style>
