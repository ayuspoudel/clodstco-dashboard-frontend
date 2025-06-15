<template>
  <div class="main-nav-wrapper">
    <nav class="main-nav">
      <!-- Home on the left -->
      <div class="nav-left">
        <!-- Menu button -->
        <button class="menu-button" @click="emit('toggle-sidebar')">
          <Menu class="nav-icon" />
        </button>

        <!-- Home -->
        <RouterLink to="/" class="nav-link" exact-active-class="active">
          <component :is="icons['Home']" class="nav-icon" />
          <span class="nav-label">Home</span>
          <div class="underline" />
        </RouterLink>
      </div>


      <!-- Centered nav items -->
      <div class="nav-center">
        <div
          v-for="item in navSections"
          :key="item.title"
          class="nav-item nav-tile"
          @mouseenter="handleMouseEnter(item.title)"
          @mouseleave="startLeaveTimer"
        >
          <div
            class="nav-link"
            :class="{ active: isActive(item) }"
            @click.prevent="handleMouseEnter(item.title)"
          >
            <span class="nav-label">{{ item.title }}</span>
            <div class="underline" />
            <span class="nav-description">
              {{ item.subpages[0]?.description }}
            </span>
          </div>
        </div>
      </div>


      <!-- Right-side Search -->
      <div class="nav-right">
  <div
    class="nav-item"
    @mouseenter="handleMouseEnter('Search')"
    @mouseleave="startLeaveTimer"
  >
    <div
      class="nav-link"
      :class="{ active: searchExpanded }"
      @click.prevent="handleMouseEnter('Search')"
    >
      <span class="nav-label">Search</span>
      <div class="underline" />
    </div>
  </div>
</div>

<!-- Search shutter dropdown -->
<transition name="shutter">
  <div
    v-if="hoverItem?.title === 'Search'"
    class="submenu-overlay"
    @mouseenter="cancelLeaveTimer"
    @mouseleave="startLeaveTimer"
  >
    <div class="submenu search-submenu">
      <input
        v-model="searchQuery"
        type="text"
        class="search-input-inline"
        placeholder="Search dashboards..."
        @blur="collapseSearch"
      />
    </div>
  </div>
</transition>


    </nav>

    <transition name="shutter">
      <div
        v-if="submenuVisible && hoverItem?.subpages?.length"
        class="submenu-overlay"
        @mouseenter="cancelLeaveTimer"
        @mouseleave="startLeaveTimer"
      >
        <div class="submenu">
          <RouterLink
            v-for="sub in hoverItem.subpages"
            :key="sub.path"
            :to="sub.path"
            class="submenu-link"
            :class="{ active: route.path === sub.path }"
            @click="handleSubmenuClick"
          >
            <div class="submenu-title">{{ sub.title }}</div>
            <div class="submenu-description">{{ sub.description }}</div>
          </RouterLink>
        </div>
      </div>
    </transition>
  </div>
</template>


<script setup>
import { ref, computed } from 'vue'
import { useRoute } from 'vue-router'
import { useNavSections } from './useNavSections'
import {
  CloudCog, ShieldCheck, Activity, HomeIcon,Menu,Search
  // plus others you're using
} from 'lucide-vue-next'

const icons = {
  CloudCog,
  ShieldCheck,
  Activity,
  Home: HomeIcon,
  Menu,
  Search
  // add other icons here
}


const route = useRoute()
const hover = ref(null)
const submenuVisible = ref(false)
let leaveTimeout = null

const { navSections } = useNavSections()



const searchQuery = ref('')
const searchExpanded = computed(() => hover.value === 'Search')



function toggleSearch() {
  searchExpanded.value = !searchExpanded.value
  if (searchExpanded.value) {
    nextTick(() => document.querySelector('.search-input')?.focus())
  }
}

function collapseSearch() {
  setTimeout(() => {
    searchExpanded.value = false
  }, 100) // small delay to allow input click
}

const hoverItem = computed(() =>
  navSections.value.find(i => i.title === hover.value) || (hover.value === 'Search' ? { title: 'Search' } : null)
)
const isActive = (item) =>
  route.path.startsWith(item.base) ||
  item.subpages?.some(sub => route.path === sub.path)

function handleMouseEnter(sectionTitle) {
  clearTimeout(leaveTimeout)
  hover.value = sectionTitle
  submenuVisible.value = true
}

function startLeaveTimer() {
  leaveTimeout = setTimeout(() => {
    submenuVisible.value = false
    hover.value = null
  }, 200)
}

function cancelLeaveTimer() {
  clearTimeout(leaveTimeout)
}

function handleSubmenuClick() {
  submenuVisible.value = false
  hover.value = null
}
</script>
