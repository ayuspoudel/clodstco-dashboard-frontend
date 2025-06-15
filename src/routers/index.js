import { createRouter, createWebHistory } from 'vue-router'

// Layout
import DashboardLayout from '@/main-layouts/DashboardLayout.vue'

// Pages
import HomePage from '@/pages/HomePage.vue'
import ClostOverview from '@/pages/Clost/Overview.vue'
import CloudogOverview from '@/pages/Cloudog/Overview.vue'
import ClodoctorOverview from '@/pages/Clodoctor/Overview.vue'

const routes = [
  {
    path: '/',
    component: DashboardLayout,
    children: [
      {
        path: '',
        name: 'Home',
        component: HomePage,
        meta: {
          title: 'Home'
        }
      },

      {
        path: 'clost/overview',
        name: 'ClostOverview',
        component: ClostOverview,
        meta: {
          section: 'Clost',
          title: 'Overview',
          icon: 'DollarSign',
          description: 'AI-powered AWS cost insights.'
        }
      },

      {
        path: 'cloudog/overview',
        name: 'CloudogOverview',
        component: CloudogOverview,
        meta: {
          section: 'Cloudog',
          title: 'Overview',
          icon: 'ShieldCheck',
          description: 'AI-powered security analysis and alerts.'
        }
      },

      {
        path: 'clodoctor/overview',
        name: 'ClodoctorOverview',
        component: ClodoctorOverview,
        meta: {
          section: 'Clodoctor',
          title: 'Overview',
          icon: 'Activity',
          description: 'AI-powered reliability diagnostics and pod failure insights.'
        }
      }
    ]
  }
]

export default createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior: () => ({ top: 0 })
})
