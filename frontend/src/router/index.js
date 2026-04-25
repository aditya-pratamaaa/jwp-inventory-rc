import { createRouter, createWebHistory } from "vue-router";

const routes = [
  {
    path: "/",
    redirect: "/dashboard",
  },
  {
    path: "/login",
    name: "Login",
    component: () => import("@/views/Login.vue"),
    meta: { layout: "guest" },
  },
  {
    path: "/register",
    name: "Register",
    component: () => import("@/views/Register.vue"),
    meta: { layout: "guest" },
  },
  {
    path: "/dashboard",
    name: "Dashboard",
    component: () => import("@/views/Dashboard.vue"),
    meta: { layout: "dashboard" },
  },
  {
    path: "/item",
    name: "Item",
    component: () => import("@/views/item/Item.vue"),
    meta: { layout: "dashboard" },
  },
  {
    path: "/item-form",
    name: "ItemForm",
    component: () => import("@/views/item/ItemForm.vue"),
    meta: { layout: "dashboard" },
  },
  {
    path: "/item-form/:id/edit",
    name: "ItemUpdate",
    component: () => import("@/views/item/ItemForm.vue"),
    meta: { layout: "dashboard" },
  },
  {
    path: "/stok",
    name: "Stok",
    component: () => import("@/views/stok/Stok.vue"),
    meta: { layout: "dashboard" },
  },
  {
    path: "/stok-form",
    name: "StokForm",
    component: () => import("@/views/stok/StokForm.vue"),
    meta: { layout: "dashboard" },
  },
  {
    path: "/stok-form/:id/edit",
    name: "StokUpdate",
    component: () => import("@/views/stok/StokForm.vue"),
    meta: { layout: "dashboard" },
  },
  {
    path: "/transaction",
    name: "Transaction",
    component: () => import("@/views/Transaction.vue"),
    meta: { layout: "dashboard" },
  },
  {
    path: "/requests",
    name: "Requests",
    component: () => import("@/views/request/Request.vue"),
    meta: { layout: "dashboard" },
  },
  {
    path: "/requests/form",
    name: "RequestsForm",
    component: () => import("@/views/request/RequestForm.vue"),
    meta: { layout: "dashboard" },
  },
  {
    path: "/requests-form/:id/edit",
    name: "RequestsEdit",
    component: () => import("@/views/request/RequestForm.vue"),
    meta: { layout: "dashboard" },
  },
];

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes,
});

router.beforeEach((to, from, next) => {
  const token = localStorage.getItem("token");
  const publicPages = ["/login", "/register"];
  const authRequired = !publicPages.includes(to.path);

  if (authRequired && !token) {
    return next("/login");
  }

  if (to.path === "/login" && token) {
    return next("/dashboard");
  }

  next();
});

export default router;
