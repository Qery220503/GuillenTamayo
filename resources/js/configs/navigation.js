import menuPages from "./menus/pages.menu";
import menuSecurity from "./menus/security.menu";
export default {
  // main navigation - side menu
  menu: [
    {
      text: "",
      key: "",
      items: [
        {
          icon: "mdi-view-dashboard-outline",
          key: "menu.dashboard",
          text: "Dashboard",
          link: "/dashboard"
        }
      ]
    },
    {
      text: "Ventas",
      items: [
        {
          icon: "mdi-text-box-outline",
          text: "Comprobantes",
          link: "/comprobantes"
        },
        {
          icon: "mdi-file-question-outline",
          text: "Cotizaciones",
          link: "/cotizaciones",
          gate: "cotizaciones_read"
        },
        {
          icon: "mdi-text-box-plus-outline",
          text: "Notas",
          link: "/notas"
        },
        {
          icon: "mdi-hand-heart",
          text: "Campañas",
          link: "/campaigns"
        }
        // { icon: 'mdi-cash-multiple', text: 'Pago Deudas', link: '/' },
      ]
    },
    {
      text: "Almacen",
      items: [
        {
          icon: "mdi-warehouse",
          text: "Movimientos en Almacén",
          link: "/almacen-movimientos"
        },
        {
          icon: "mdi-dolly",
          text: "Stock de Productos",
          link: "/stock-productos"
        },
        {
          icon: "mdi-truck",
          text: "Traslado de Productos",
          link: "/traslado-productos"
        },
        {
          icon: "mdi-cart-outline",
          text: "Compras",
          link: "/compras"
        }
        // { icon: 'mdi-cash-multiple', text: 'Pago Deudas', link: '/' },
      ]
    },
    {
      text: "Procesos",
      items: [
        {
          icon: "mdi-format-list-checkbox",
          text: "Anamnesis",
          items: [
            {
              text: "Crear Anamnesis",
              link: "/anamnesis"
            },
            {
              text: "Listado",
              link: "/anamnesis-lista"
            }
          ]
        },
        {
            icon: "mdi-cash-register",
            text: "Caja",
            items: [
                { text: "Abrir Caja", link: "/abrir-caja", gate: "read_users" },
                { text: "Ver Caja", link: "/ver-caja", gate: "read_users" },
                { text: "Reportes de Caja", link: "/reporte-caja", gate: "read_users" }
            ]
        },
        /*{
            icon: "mdi-account-cash",
            text: "Cuentas",
            items: [
                { text: "Cuentas por Pagar", link: "/cuentas-pagar", gate: "read_users" },
            ]
        },*/
        {
          icon: "mdi-microscope",
          text: "Órdenes de Laboratorio",
          link: "/orden-laboratorio"
        },
        {
          icon: "mdi-cash",
          text: "Egresos",
          link: "/egresos"
        },
        {
          icon: "mdi-file-document",
          text: "Guías de Remisión",
          link: "/guias_remision"
        },
        {
          icon: "mdi-poll",
          text: "Contabilidad",
          items: [
            {
              text: "Exportar Reporte",
              link: "/contabilidad/reportes",
              gate: "read_users"
            }
          ]
        },
        {
          icon: "mdi-chart-areaspline",
          text: "Reportes",
          items: [
            {
              text: "Cuadro General",
              link: "/reportes/cuadro-general",
              gate: "cuadro_general"
            },
            {
              text: "Reporte de Deudas",
              link: "/reportes/deudas-comprobantes",
              gate: "reporte_deudas_comprobantes"
            },
            {
              text: "Reporte de Clínicas",
              link: "/reportes/clinicas-referentes",
              gate: "reporte_clinicas_referentes"
            },
          ]
        }
      ]
    },
    {
      text: "Maestros",
      items: [
        {
          icon: "mdi-sunglasses",
          text: "Productos",
          items: [
            {
              icon: "mdi-cards",
              text: "Categorias",
              link: "/productos/categorias",
              gate: "read_users"
            },
            {
              icon: "mdi-sunglasses",
              text: "Formas Monturas",
              link: "/productos/monturas",
              gate: "read_users"
            },
            {
              icon: "mdi-palette",
              text: "Marcas",
              link: "/productos/marcas",
              gate: "read_users"
            },
            {
              icon: "mdi-factory",
              text: "Materiales",
              link: "/productos/materiales",
              gate: "read_users"
            },
            {
              icon: "mdi-glasses",
              text: "Tipo Aros",
              link: "/productos/aros",
              gate: "read_users"
            },
            {
              icon: "mdi-shape-plus",
              text: "Productos",
              link: "/producto",
              gate: "read_users"
            }
          ]
        },
        {
          icon: "mdi-office-building-marker-outline",
          text: "Sucursales",
          link: "/sucursales"
        },
        {
          icon: "mdi-truck-outline",
          text: "Proveedores",
          link: "/proveedores"
        },
        { icon: "mdi-doctor", text: "Doctores", link: "/doctores" },
        { icon: "mdi-hospital-building", text: "Clinicas", link: "/clinicas" },
        {
          icon: "mdi-office-building-marker-outline",
          text: "Empresas Convenios",
          link: "/empresas-convenios"
        },
        { icon: "mdi-wrench-outline", text: "Servicios", link: "/servicios" },
        {
          icon: "mdi-account-group-outline",
          text: "Ocupaciones",
          link: "/ocupaciones"
        },
        {
          icon: "mdi-glasses",
          text: "Precios Lentes",
          link: "/precios-lentes"
        },
        {
            icon: "mdi-ticket-percent-outline",
            text: "Cupones",
            link: "/cupones"
        },
        { icon: "mdi-account-outline", text: "Pacientes", link: "/pacientes" }
      ]
    },
    {
      text: "Configuración",
      key: "menu.config",
      items: [
        {
          icon: "mdi-cogs",
          text: "Mantenimiento",
          items: [
            {
              icon: "mdi-format-list-checks",
              text: "Precio Lentes",
              link: "/mantenimiento/precios-lentes",
              gate: "read_users"
            },
            {
              icon: "mdi-format-list-checks",
              text: "Precio Productos",
              link: "/mantenimiento/precios-productos",
              gate: "mantenimiento-precios-lentes"
            }
          ]
        },
        {
          icon: "mdi-account-multiple",
          // key: "menu.security",
          text: "Seguridad",
          items: [
            {
              icon: "mdi-account-multiple",
              key: "menu.users",
              text: "Usuarios",
              link: "/users/list",
              gate: "read_users"
            },
            {
              icon: "mdi-badge-account",
              // key: "menu.roles",
              text: "Roles y Permisos",
              link: "/roles_permisos",
              gate: "read_roles"
            }
          ]
        },
      ]
    }
  ],

  // footer links
  footer: []
};
