<template>
  <div class="dashboard-layout">
    <NavigationBar />
    <main class="main-content">
      <RouterView />
    </main>
  </div>
</template>

<script setup>
import NavigationBar from '@/main-layouts/navigation-bar/NavigationBar.vue'
</script>

<style scoped>
.dashboard-layout {
  display: flex;
  flex-direction: column;
  height: 100vh;
}

.main-content {
  flex: 1;
  padding: 1rem 2rem;
  overflow-y: auto;
}
</style>
