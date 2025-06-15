<template>
  <nav class="nav-bar">
    <div
      v-for="section in navSections"
      :key="section.base"
      class="nav-section"
      @mouseenter="hovered = section.base"
      @mouseleave="hovered = null"
    >
      <RouterLink :to="section.base" class="nav-link">
        {{ section.title }}
      </RouterLink>

      <div v-if="hovered === section.base" class="dropdown">
        <RouterLink
          v-for="sub in section.subpages"
          :key="sub.path"
          :to="sub.path"
          class="dropdown-item"
        >
          {{ sub.title }}
        </RouterLink>
      </div>
    </div>
  </nav>
</template>

<script setup>
import { ref } from 'vue'
import { useNavSections } from './useNavSections'

const { navSections } = useNavSections()
const hovered = ref(null)
</script>