import { useRouter } from 'vue-router'
import { computed } from 'vue'

export const useNavSections = () => {
  const router = useRouter()

  const navSections = computed(() => {
    const sections = {}

    router.getRoutes().forEach(route => {
      const { section, title, icon, description } = route.meta || {}
      if (!section || !title) return

      const base = '/' + route.path.split('/')[1] // e.g., /clost

      if (!sections[base]) {
        sections[base] = {
          title: section,
          icon: icon || 'File',
          base,
          subpages: []
        }
      }

      sections[base].subpages.push({
        title,
        path: route.path,
        description: description || ''
      })
    })

    return Object.values(sections)
  })

  return { navSections }
}
