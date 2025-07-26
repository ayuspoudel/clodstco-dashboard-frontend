import { createRouter, createWebHistory } from 'vue-router'

// Layout
import DashboardLayout from '@/main-layouts/DashboardLayout.vue'

// Pages
import HomePage from '@/pages/HomePage.vue'

// Clost
import ClostOverview from '@/pages/clost/overview.vue'
import SpendTracker from '@/pages/clost/spend-tracker.vue'
import Forecast from '@/pages/clost/forecast.vue'
import Recommendations from '@/pages/clost/recommendations.vue'
import BudgetAlerts from '@/pages/clost/budget-alerts.vue'
import UsageBreakdown from '@/pages/clost/usage-breakdown.vue'

// Clodoctor
import ClodoctorOverview from '@/pages/clodoctor/overview.vue'
import Uptime from '@/pages/clodoctor/uptime.vue'
import OutageReport from '@/pages/clodoctor/outage-report.vue'
import FailurePredictor from '@/pages/clodoctor/failure-predictor.vue'
import PodHealth from '@/pages/clodoctor/pod-health.vue'
import EventTimeline from '@/pages/clodoctor/event-timeline.vue'

// Cloudog
import CloudogOverview from '@/pages/cloudog/overview.vue'
import Threats from '@/pages/cloudog/threats.vue'
import VulnerabilityScan from '@/pages/cloudog/vulnerability-scan.vue'
import Policies from '@/pages/cloudog/policies.vue'
import NetworkInsights from '@/pages/cloudog/network-insights.vue'
import AuditLog from '@/pages/cloudog/audit-log.vue'

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
          title: 'Home',
          icon: 'Home'
        }
      },

      // Clost routes
      {
        path: 'clost/overview',
        name: 'ClostOverview',
        component: ClostOverview,
        meta: {
          section: 'Clost',
          title: 'Overview',
          icon: 'CloudCog',
          description: 'AI-powered AWS cost insights.'
        }
      },
      {
        path: 'clost/spend-tracker',
        name: 'SpendTracker',
        component: SpendTracker,
        meta: {
          section: 'Clost',
          title: 'Spend Tracker',
          icon: 'TrendingUp',
          description: 'Track real-time and monthly cloud spend.'
        }
      },
      {
        path: 'clost/forecast',
        name: 'Forecast',
        component: Forecast,
        meta: {
          section: 'Clost',
          title: 'Forecast',
          icon: 'LineChart',
          description: 'Cost forecasting and prediction.'
        }
      },
      {
        path: 'clost/recommendations',
        name: 'Recommendations',
        component: Recommendations,
        meta: {
          section: 'Clost',
          title: 'Recommendations',
          icon: 'Lightbulb',
          description: 'Optimization recommendations.'
        }
      },
      {
        path: 'clost/budget-alerts',
        name: 'BudgetAlerts',
        component: BudgetAlerts,
        meta: {
          section: 'Clost',
          title: 'Budget Alerts',
          icon: 'BellRing',
          description: 'Budget limits and alert configuration.'
        }
      },
      {
        path: 'clost/usage-breakdown',
        name: 'UsageBreakdown',
        component: UsageBreakdown,
        meta: {
          section: 'Clost',
          title: 'Usage Breakdown',
          icon: 'PieChart',
          description: 'Resource-level spend analysis.'
        }
      },

      // Clodoctor routes
      {
        path: 'clodoctor/overview',
        name: 'ClodoctorOverview',
        component: ClodoctorOverview,
        meta: {
          section: 'Clodoctor',
          title: 'Overview',
          icon: 'Activity',
          description: 'Reliability overview and diagnostics.'
        }
      },
      {
        path: 'clodoctor/uptime',
        name: 'Uptime',
        component: Uptime,
        meta: {
          section: 'Clodoctor',
          title: 'Uptime',
          icon: 'TimerReset',
          description: 'Uptime by service/environment.'
        }
      },
      {
        path: 'clodoctor/outage-report',
        name: 'OutageReport',
        component: OutageReport,
        meta: {
          section: 'Clodoctor',
          title: 'Outage Report',
          icon: 'AlertOctagon',
          description: 'Past outages and root causes.'
        }
      },
      {
        path: 'clodoctor/failure-predictor',
        name: 'FailurePredictor',
        component: FailurePredictor,
        meta: {
          section: 'Clodoctor',
          title: 'Failure Predictor',
          icon: 'Brain',
          description: 'Predictive reliability modeling.'
        }
      },
      {
        path: 'clodoctor/pod-health',
        name: 'PodHealth',
        component: PodHealth,
        meta: {
          section: 'Clodoctor',
          title: 'Pod Health',
          icon: 'Heartbeat',
          description: 'Pod/container health metrics.'
        }
      },
      {
        path: 'clodoctor/event-timeline',
        name: 'EventTimeline',
        component: EventTimeline,
        meta: {
          section: 'Clodoctor',
          title: 'Event Timeline',
          icon: 'Clock',
          description: 'Incident and recovery timelines.'
        }
      },

      // Cloudog routes
      {
        path: 'cloudog/overview',
        name: 'CloudogOverview',
        component: CloudogOverview,
        meta: {
          section: 'Cloudog',
          title: 'Overview',
          icon: 'ShieldCheck',
          description: 'Security posture summary.'
        }
      },
      {
        path: 'cloudog/threats',
        name: 'Threats',
        component: Threats,
        meta: {
          section: 'Cloudog',
          title: 'Threats',
          icon: 'Bug',
          description: 'Active and historical threats.'
        }
      },
      {
        path: 'cloudog/vulnerability-scan',
        name: 'VulnerabilityScan',
        component: VulnerabilityScan,
        meta: {
          section: 'Cloudog',
          title: 'Vulnerability Scan',
          icon: 'Scan',
          description: 'Open port and vulnerability scan.'
        }
      },
      {
        path: 'cloudog/policies',
        name: 'Policies',
        component: Policies,
        meta: {
          section: 'Cloudog',
          title: 'Policies',
          icon: 'FileLock',
          description: 'IAM and policy violations.'
        }
      },
      {
        path: 'cloudog/network-insights',
        name: 'NetworkInsights',
        component: NetworkInsights,
        meta: {
          section: 'Cloudog',
          title: 'Network Insights',
          icon: 'Network',
          description: 'Suspicious traffic and access.'
        }
      },
      {
        path: 'cloudog/audit-log',
        name: 'AuditLog',
        component: AuditLog,
        meta: {
          section: 'Cloudog',
          title: 'Audit Log',
          icon: 'ClipboardList',
          description: 'Auth/access audit trail.'
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
