export default {
  // global theme for the app
  globalTheme: "light", // light | dark

  // side menu theme, use global theme or custom
  menuTheme: "global", // global | light | dark

  // toolbar theme, use global theme or custom
  toolbarTheme: "global", // global | light | dark

  // show toolbar detached from top
  isToolbarDetached: true,

  // wrap pages content with a max-width
  isContentBoxed: false,

  // application is right to left
  isRTL: false,

  // dark theme colors

  dark: {
    background: "#05090c",
    surface: "#111b27",
    primary: "#345d98", //'#0B152A',
    secondary: "#d96017",
    accent: "#E44173",
    error: "#FF5252",
    info: "#2196F3",
    success: "#4CAF50",
    warning: "#FFC107"
  },

  // light theme colors
  light: {
    background: "#ffffff",
    surface: "#f2f5f8",
    primary: "#043c77", //'#0B152A',
    secondary: "#d96017",
    accent: "#E44173",
    error: "#ef476f",
    info: "#2196F3",
    success: "#06d6a0",
    warning: "#ffd166"
  }
};
