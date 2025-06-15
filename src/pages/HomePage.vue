<template>
  <div class="home-page">
    <h1>Welcome to Clostco</h1>
    <p class="subtext">Your AI-powered cloud intelligence platform</p>

    <div class="dash-links">
      <RouterLink to="/clost/overview" class="dash-link">🚀 Clost – AWS Cost Insights</RouterLink>
      <RouterLink to="/cloudog/overview" class="dash-link">🛡️ Cloudog – Security Insights</RouterLink>
      <RouterLink to="/clodoctor/overview" class="dash-link">🧠 Clodoctor – Reliability Diagnostics</RouterLink>
    </div>
  </div>
</template>

<script setup>
</script>

<style scoped>
.home-page {
  padding: 3rem 2rem;
  text-align: center;
}

h1 {
  font-size: 2.5rem;
  margin-bottom: 0.5rem;
}

.subtext {
  font-size: 1.1rem;
  color: #666;
  margin-bottom: 2rem;
}

.dash-links {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  max-width: 400px;
  margin: 0 auto;
}

.dash-link {
  display: block;
  padding: 1rem;
  border: 1px solid #ddd;
  border-radius: 8px;
  text-decoration: none;
  color: #333;
  font-weight: 500;
  transition: all 0.2s ease;
}

.dash-link:hover {
  background-color: #f5f5f5;
  border-color: #ccc;
}
</style>
