<template>
  <aside class="sidebar">
    <div class="sidebar-header">Garasi RC</div>

    <nav class="sidebar-nav">
      <router-link
        v-for="menu in sidebarMenu"
        :key="menu.path"
        :to="menu.path"
        class="nav-item"
        :class="{ 'is-active': isActive(menu.path) }"
      >
        <i :class="['mdi', menu.icon]"></i>
        <span>{{ menu.title }}</span>
      </router-link>
    </nav>
  </aside>
</template>

<script setup>
import { useRoute } from "vue-router";
import { sidebarMenu } from "@/helpers/Navigation";

const route = useRoute();
const isActive = (path) => route.path.startsWith(path);
</script>

<style scoped>
.sidebar {
  width: 260px;
  background: white;
  border-right: 1px solid #e5e7eb;
  display: flex;
  flex-direction: column;
}

.sidebar-header {
  padding: 1.5rem;
  font-size: 1.25rem;
  font-weight: bold;
  color: #2563eb;
}

.sidebar-nav {
  padding: 0 1rem;
}

.nav-item {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 0.75rem 1rem;
  border-radius: 0.5rem;
  text-decoration: none;
  color: #6b7280;
  margin-bottom: 0.25rem;
  transition: all 0.2s;
}

.nav-item i {
  font-size: 1.4rem;
}

.nav-item:hover {
  background: #f3f4f6;
  color: #2563eb;
}

.nav-item.is-active {
  background: #2563eb;
  color: white;
}
</style>
