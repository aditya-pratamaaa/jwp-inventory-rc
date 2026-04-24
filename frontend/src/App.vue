<script setup>
import { useRoute } from "vue-router";
import Sidebar from "@/views/Sidebar.vue";

const route = useRoute();
</script>

<template>
  <div class="app-root">
    <div v-if="route.meta.layout === 'dashboard'" class="dashboard-layout">
      <Sidebar />
      <main class="main-content">
        <div class="page-body">
          <router-view />
        </div>
      </main>
    </div>

    <div v-else class="guest-layout">
      <router-view />
    </div>

    <div v-if="isAuthLoading" class="loading-overlay">
      <div class="spinner"></div>
    </div>
  </div>
</template>

<style>
:root {
  --bg-app: #f8fafc;
}

body,
html {
  margin: 0;
  padding: 0;
  height: 100%;
}

.app-root {
  position: relative;
  min-height: 100vh;
}

.dashboard-layout {
  display: flex;
  height: 100vh;
  width: 100vw;
  overflow: hidden;
}

.main-content {
  flex: 1;
  background: var(--bg-app);
  display: flex;
  flex-direction: column;
  overflow-y: auto;
}

.page-body {
  padding: 1.5rem;
}

.guest-layout {
  min-height: 100vh;
  width: 100%;
}

.loading-overlay {
  position: fixed;
  inset: 0;
  background: rgba(255, 255, 255, 0.7);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 9999;
}

.spinner {
  width: 40px;
  height: 40px;
  border: 4px solid #e2e8f0;
  border-top-color: #2563eb;
  border-radius: 50%;
  animation: spin 0.8s linear infinite;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}
</style>
