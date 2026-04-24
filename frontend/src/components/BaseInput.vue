<template>
  <div class="form-group">
    <label v-if="label" class="form-label">{{ label }}</label>

    <Input
      v-bind="$attrs"
      :value="modelValue"
      @input="(e) => $emit('update:modelValue', e.target ? e.target.value : e)"
      size="md"
      class="w-full"
    />
  </div>
</template>

<script setup>
defineProps({
  label: String,
  modelValue: [String, Number],
});

defineEmits(["update:modelValue"]);
</script>

<style scoped>
.form-group {
  border: none !important;
  outline: none !important;
}

.form-label {
  display: block;
  margin-bottom: 0.3rem;
  font-size: 12px;
  font-weight: 600;
  color: var(--text-medium);
  text-transform: uppercase;
}

:deep(input) {
  height: 35px !important;
  font-size: 14px;
  border-radius: 6px;
  padding: 0 10px;
  border: 1px solid var(--border-form);
  background-color: var(--bg-neutral);
  color: var(--text-strong);
  transition: border-color 0.15s ease;
}

:deep(input:hover) {
  border-color: var(--border-form-hover);
}

:deep(input:focus) {
  outline: none;
  border-color: var(--border-form-active);
}

:deep(input:disabled) {
  background-color: var(--bg-neutral);
  color: var(--text-medium);
  cursor: not-allowed;
  border-color: var(--border-form-hover);
}
</style>
