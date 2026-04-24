<template>
  <button class="btn-action btn-delete" type="button">
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
        d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"
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

.btn-delete {
  background-color: var(--btn-delete-bg);
  color: var(--btn-delete-icon);
}

.btn-delete:hover {
  background-color: var(--btn-delete-hover);
}

.icon-svg {
  width: 0.875rem;
  height: 0.875rem;
}
</style>
