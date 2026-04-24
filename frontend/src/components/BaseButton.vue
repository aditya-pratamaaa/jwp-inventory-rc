<template>
  <button
    type="button"
    :class="classes"
    :disabled="disabled || loading"
    @click="$emit('click')"
  >
    <span v-if="loading">Loading...</span> <slot v-else />
  </button>
</template>

<script setup>
import { computed } from "vue";

const props = defineProps({
  variant: { type: String, default: "primary" },
  loading: Boolean,
  disabled: Boolean,
});

const classes = computed(() => ({
  btn: true,
  [`btn--${props.variant}`]: true,
}));
</script>

<style scoped>
.btn {
  padding: 8px 16px;
  border-radius: 6px;
  font-weight: 600;
}

.btn--primary {
  background: #2563eb;
  color: white;
}
.btn--add {
  background-color: var(--btn-add);
  color: var(--white-100);
  padding: 0.5rem 1rem;
  border-radius: 8px;
  font-size: 0.875rem;
  font-weight: 500;
  border: none;
  cursor: pointer;
  transition: background-color 0.2s;
}
.btn--import {
  background-color: var(--btn-import);
  color: var(--text-neutral);
  padding: 0.5rem 1rem;
  border-radius: 8px;
  font-size: 0.875rem;
  font-weight: 500;
  border: none;
  cursor: pointer;
  transition: background-color 0.2s;
}

.btn--export {
  background-color: var(--btn-export);
  color: var(--text-neutral);
  padding: 0.5rem 1rem;
  border-radius: 8px;
  font-size: 0.875rem;
  font-weight: 500;
  border: none;
  cursor: pointer;
  transition: background-color 0.2s;
}

.btn--back {
  background-color: var(--btn-add);
  color: var(--white-100);
  padding: 0.5rem 1rem;
  border-radius: 8px;
  font-size: 0.875rem;
  font-weight: 500;
  border: none;
  cursor: pointer;
  transition: background-color 0.2s;
}

.btn--upload {
  background-color: var(--btn-add);
  color: var(--white-100);
  padding: 0.5rem 0.5rem;
  border-radius: 8px;
  font-size: 0.875rem;
  font-weight: 500;
  border: none;
  cursor: pointer;
  transition: background-color 0.2s;
}

.btn--image {
  background: #e0f2fe;
  color: #0369a1;
  border: none;
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 12px;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 4px;
  transition: background 0.2s;
  &:hover {
    background: #bae6fd;
  }
}
</style>
