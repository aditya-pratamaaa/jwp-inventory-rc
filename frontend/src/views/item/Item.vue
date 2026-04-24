<template>
  <div class="header">
    <h1 class="header-title">Daftar Barang</h1>

    <BaseButton variant="primary" @click="goToForm"> Tambah Barang </BaseButton>
  </div>

  <BaseTable
    :is-loading="inventory.loading"
    :is-empty="!inventory.loading && !inventory.data.length"
  >
    <template #thead>
      <th style="width: 10%">Kode</th>
      <th style="width: 50%">Nama Barang</th>
      <th style="width: 25%">Harga Barang</th>
      <th style="width: 15%">Aksi</th>
    </template>

    <template #tbody>
      <tr v-for="item in inventory.data" :key="item.kode_barang">
        <td>
          <span class="font-medium">#{{ item.kode_barang }}</span>
        </td>

        <td>
          <div class="font-medium text-gray-800">
            {{ item.nama_barang }}
          </div>
        </td>

        <td>
          {{ formatCurrency(item.harga_barang) }}
        </td>

        <td>
          <div class="action-group">
            <Edit @click="editBarang(item.kode_barang)" />
            <Delete @click="deleteBarang(item.kode_barang)" />
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

const inventory = reactive({
  data: [],
  loading: false,
});

const fetchBarang = async () => {
  inventory.loading = true;

  try {
    const response = await fetch("http://localhost:3000/api/barang", {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("token")}`,
      },
    });

    const data = await response.json();

    if (!response.ok) {
      throw new Error(data.message || "Gagal mengambil data");
    }

    inventory.data = data;
  } catch (error) {
    console.error(error);
  } finally {
    inventory.loading = false;
  }
};

const editBarang = (id) => {
  router.push(`/item-form/${id}/edit`);
};

const deleteBarang = async (id) => {
  if (!confirm("Apakah anda yakin ingin menghapus barang ini?")) return;

  try {
    const response = await fetch(`http://localhost:3000/api/barang/${id}`, {
      method: "DELETE",
      headers: {
        Authorization: `Bearer ${localStorage.getItem("token")}`,
      },
    });

    if (!response.ok) {
      throw new Error("Gagal menghapus barang");
    }

    await fetchBarang();
  } catch (error) {
    alert(error.message);
  }
};

const formatCurrency = (value) => {
  return new Intl.NumberFormat("id-ID", {
    style: "currency",
    currency: "IDR",
    minimumFractionDigits: 0,
  }).format(value);
};

const goToForm = () => {
  router.push({ name: "ItemForm" });
};

onMounted(() => {
  fetchBarang();
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

.btn-delete {
  color: #ef4444;
  background: none;
  border: none;
  cursor: pointer;
  font-size: 1.2rem;
  padding: 4px;
  border-radius: 4px;
}

.btn-delete:hover {
  background: #fee2e2;
}
</style>
