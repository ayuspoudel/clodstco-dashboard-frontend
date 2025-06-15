<!-- src/App.vue -->
<template>
  <div>
    <NavigationBar />
    <router-view />
  </div>
</template>

<script setup>
import NavigationBar from '@/main-layouts/navigation-bar/NavigationBar.vue'
</script>
