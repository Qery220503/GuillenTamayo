export default [
    { icon: 'mdi-file-cancel-outline', key: 'menu.errorPages', text: 'Error Pages', regex: /^\/error/,
      items: [
        { icon: 'mdi-file-outline', key: 'menu.errorNotFound', text: 'Not Found / 404', link: '/error/not-found' },
        { icon: 'mdi-file-outline', key: 'menu.errorUnexpected', text: 'Unexpected / 500', link: '/error/unexpected' }
      ]
    },
    { icon: 'mdi-file-cog-outline', key: 'menu.utilityPages', text: 'Utility Pages', regex: /^\/utility/,
      items: [
        { icon: 'mdi-file-outline', key: 'menu.utilityMaintenance', text: 'Maintenance', link: '/utility/maintenance' },
        { icon: 'mdi-file-outline', key: 'menu.utilitySoon', text: 'Coming Soon', link: '/utility/coming-soon' },
        { icon: 'mdi-file-outline', key: 'menu.utilityHelp', text: 'FAQs / Help', link: '/utility/help' }
      ]
    }
  ]
  