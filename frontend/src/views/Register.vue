<template>
  <div class="login-page">
    <div class="login-card">
      <h2>RC Kit</h2>
      <p>Buat akun baru untuk mulai menggunakan layanan</p>

      <form @submit.prevent="handleRegister">
        <div class="form-group">
          <label>Username</label>
          <input
            v-model="username"
            type="text"
            placeholder="Masukkan username"
            required
          />
        </div>

        <div class="form-group">
          <label>Password</label>
          <div class="input-wrapper">
            <input
              v-model="password"
              :type="showPassword ? 'text' : 'password'"
              placeholder="••••••••"
              required
            />
            <button type="button" class="eye-btn" @click="togglePassword">
              <svg
                v-if="showPassword"
                xmlns="http://www.w3.org/2000/svg"
                width="20"
                height="20"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
              >
                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                <circle cx="12" cy="12" r="3"></circle>
              </svg>

              <svg
                v-else
                xmlns="http://www.w3.org/2000/svg"
                width="20"
                height="20"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
              >
                <path
                  d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19"
                ></path>
                <path d="M12 17c-3.31 0-6-2.69-6-6"></path>
                <path d="M12 17c3.31 0 6-2.69 6-6"></path>
              </svg>
            </button>
          </div>
        </div>

        <div class="form-group">
          <label>Konfirmasi Password</label>
          <div class="input-wrapper">
            <input
              v-model="confirmPassword"
              :type="showPassword ? 'text' : 'password'"
              placeholder="••••••••"
              required
            />
          </div>
        </div>

        <p v-if="errorMessage" class="error-text">
          {{ errorMessage }}
        </p>

        <button type="submit" :disabled="isLoading">
          {{ isLoading ? "Memproses..." : "Daftar" }}
        </button>
      </form>

      <p class="login-text">
        Sudah punya akun?
        <span class="link-text" @click="goToLogin">Masuk sekarang</span>
      </p>
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";
import { useRouter } from "vue-router";

const username = ref("");
const password = ref("");
const confirmPassword = ref("");
const showPassword = ref(false);
const isLoading = ref(false);
const errorMessage = ref("");

const router = useRouter();

const togglePassword = () => {
  showPassword.value = !showPassword.value;
};

const handleRegister = async () => {
  if (!username.value || !password.value || !confirmPassword.value) {
    errorMessage.value = "Semua field wajib diisi";
    return;
  }

  if (password.value !== confirmPassword.value) {
    errorMessage.value = "Password tidak cocok";
    return;
  }

  isLoading.value = true;
  errorMessage.value = "";

  try {
    const res = await fetch("http://localhost:3000/register", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        username: username.value,
        password: password.value,
      }),
    });

    const data = await res.json();

    if (!res.ok) {
      throw new Error(data.message || "Register gagal");
    }

    router.push("/login");
  } catch (err) {
    errorMessage.value = err.message;
  } finally {
    isLoading.value = false;
  }
};

const goToLogin = () => {
  router.push("/login");
};
</script>

<style scoped>
.login-page {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  width: 100%;
  background: var(--bg-primary);
}

.login-card {
  background: var(--bg-neutral);
  padding: 1.6rem;
  border-radius: 12px;
  box-shadow: var(--shadow-md);
  width: 100%;
  max-width: 400px;
  text-align: center;
}

h2 {
  margin-bottom: 0.25rem;
  color: var(--text);
}

p {
  color: var(--text);
  margin-bottom: 1rem;
  font-size: 0.85rem;
}

.form-group {
  text-align: left;
  margin-bottom: 0.85rem;
}

label {
  display: block;
  font-size: 0.875rem;
  font-weight: 600;
  margin-bottom: 0.4rem;
  color: var(--text);
}

input {
  width: 100%;
  padding: 0.6rem 0.75rem;
  border: 1px solid;
  border-color: var(--border-form);
  border-radius: 6px;
  outline: none;
  transition: border-color 0.2s;
}

input:focus {
  border-color: var(--input-login-focus);
}

button {
  width: 100%;
  padding: 0.65rem;
  background-color: var(--btn-login);
  color: var(--bg-neutral);
  border: none;
  border-radius: 6px;
  font-weight: 600;
  cursor: pointer;
}

button:hover {
  background-color: var(--btn-login-hover);
}

button:disabled {
  background-color: var(--btn-login-disable);
  cursor: not-allowed;
}

.error-text {
  color: var(--invalid-credential);
  font-size: 0.85rem;
  margin-bottom: 0.75rem;
  text-align: left;
}

.input-wrapper {
  position: relative;
  display: flex;
  align-items: center;
}

.eye-btn {
  position: absolute;
  right: 10px;
  width: 32px;
  height: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: transparent;
  border: none;
  padding: 0;
  margin: 0;
  cursor: pointer;
  color: var(--eye-button);
  -webkit-appearance: none;
  appearance: none;
  transition: color 0.2s ease;
}

.eye-btn:hover {
  background: transparent;
  box-shadow: none;
  border: none;
  color: var(--eye-button);
  transform: none;
}

.eye-btn:focus,
.eye-btn:active {
  outline: none;
  box-shadow: none;
  background: transparent;
}

.input-wrapper input {
  padding-right: 40px;
}

.link-text {
  margin-top: 1rem;
  color: var(--btn-login);
  font-weight: 600;
  cursor: pointer;
  text-decoration: none;
}

.link-text:hover {
  text-decoration: underline;
}

.register-text,
.login-text {
  margin-top: 1rem;
  font-size: 0.85rem;
  color: var(--text);
}
</style>
