<template>
  <div class="data-wrapper">
    <div class="data-content-card">
      <div class="table-responsive">
        <table class="data-table">
          <thead>
            <tr>
              <slot name="thead"></slot>
            </tr>
          </thead>

          <tbody v-if="isLoading">
            <tr>
              <td colspan="100" class="state-message">Sedang memuat data...</td>
            </tr>
          </tbody>

          <tbody v-else-if="isEmpty">
            <tr>
              <td colspan="100" class="state-message">Data tidak ditemukan.</td>
            </tr>
          </tbody>

          <tbody v-else>
            <slot name="tbody"></slot>
          </tbody>
        </table>
      </div>
      <div v-if="$slots.footer" class="data-table-footer">
        <slot name="footer"></slot>
      </div>
    </div>
  </div>
</template>

<script setup>
defineProps({
  isEmpty: { type: Boolean, default: false },
  isLoading: { type: Boolean, default: false },
});
</script>

<style scoped>
.data-wrapper {
  background-color: none;
}

.data-content-card {
  background-color: var(--table-data-bg);
  border-radius: 12px;
  padding: 1rem;
  margin-top: 10px;
  box-shadow: 0 24px 60px -40px rgba(34, 34, 59, 0.4);
}

.table-responsive {
  overflow-x: auto;
}

.data-table {
  width: 100%;
  font-size: 0.875rem;
  text-align: left;
  border-collapse: collapse;
  table-layout: fixed;
}

.data-table thead tr {
  border-bottom: 1px solid var(--border-table);
}

:deep(.data-table th) {
  padding: 0.75rem;
  text-transform: uppercase;
  font-size: 11px;
  font-weight: 700;
  color: #6b7280;
}

:deep(.data-table tbody tr) {
  border-bottom: 1px solid var(--border-table);
  transition: background-color 0.2s;
}

:deep(.data-table tbody tr:hover) {
  background-color: var(--table-data-hover);
}

:deep(.data-table td) {
  padding: 0.75rem;
}

.state-message {
  text-align: center;
  padding: 2rem;
  color: #6b7280;
}
.data-table-footer {
  padding-top: 1rem;
  margin-top: 0.5rem;
}
</style>
