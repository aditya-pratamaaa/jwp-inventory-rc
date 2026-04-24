<template>
  <button class="btn-action btn-edit" type="button">
    <svg
      class="icon-svg"
      fill="none"
      stroke="currentColor"
      viewBox="0 0 24 24"
      aria-hidden="true"
    >
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="2"
        d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"
      />
    </svg>
  </button>
</template>

<style scoped>
.btn-action {
  padding: 0.5rem;
  border-radius: 9999px;
  border: none;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background-color 0.2s ease;
}

.btn-edit {
  background-color: var(--btn-edit-bg);
  color: var(--btn-edit-icon);
}

.btn-edit:hover {
  background-color: var(--btn-edit-hover);
}

.icon-svg {
  width: 0.875rem;
  height: 0.875rem;
}
</style>
