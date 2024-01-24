<template>
  <div class="flex-grow-1">
    <custom-breadcrumbs
      :breadcrumbs_title="breadcrumbs_title"
      :breadcrumbs="breadcrumbs"
    ></custom-breadcrumbs>
    <!--<v-card class="pa-2">-->
    <v-tabs v-model="tab" class="my-tabs mb-2" background-color="transparent">
      <v-tab to="#info">
        <v-icon left>mdi-information-outline</v-icon>
        Información
      </v-tab>
      <!--<v-tab to="#social-network">
                    <v-icon left>mdi-link-variant</v-icon>
                    Redes Sociales
                </v-tab>-->
      <v-tab to="#next_enrollment">
        <v-icon left>mdi-menu-open</v-icon>
        Próximas Insc.
      </v-tab>
      <v-tab to="#navigator">
        <v-icon left>mdi-menu-open</v-icon>
        Navegador
      </v-tab>
      <v-tab to="#terms-conditions">
        <v-icon left>mdi-book-open-outline</v-icon>
        Términos y condiciones
      </v-tab>
      <v-tab to="#policy-privacy">
        <v-icon left>mdi-shield-lock-outline</v-icon>
        Política de privacidad
      </v-tab>
      <v-tab to="#facturacion">
        <v-icon left>mdi-file-document-multiple-outline</v-icon>
        Facturación
      </v-tab>
    </v-tabs>
    <v-tabs-items v-model="tab">
      <!-- Informacion  -->
      <v-tab-item value="info">
        <v-card flat class="pa-3">
          <v-card-title>Información</v-card-title>
          <v-card-text>
            <v-form ref="infoForm" v-model="validAddForm" lazy-validation>
              <v-switch
                v-model="form.allow_sale"
                :label="
                  form.allow_sale == 1
                    ? 'Compras habilitadas'
                    : 'Compras deshabilitadas'
                "
              ></v-switch>
              <v-text-field
                v-model="form.name"
                label="Nombre"
                :rules="rules.required"
                prepend-icon="mdi-office-building-outline"
              ></v-text-field>
              <v-text-field
                v-model="form.address"
                label="Dirección"
                :rules="rules.required"
                prepend-icon="mdi-map-marker-outline"
              ></v-text-field>
              <v-text-field
                v-model="form.phone"
                label="Teléfono"
                :rules="rules.required"
                prepend-icon="mdi-phone-outline"
              ></v-text-field>
              <v-text-field
                v-model="form.email"
                label="Email"
                :rules="rules.required"
                prepend-icon="mdi-at"
              ></v-text-field>
            </v-form>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn
              depressed
              color="primary"
              :disabled="!validAddForm"
              @click="updateInfo(0)"
            >
              <v-icon>mdi-content-save</v-icon>
              Guardar Cambios
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-tab-item>
      <!-- Fin -->

      <!-- Redes Sociales -->
      <v-tab-item value="social-network">
        <v-card flat class="pa-3">
          <v-card-title>Redes Sociales</v-card-title>
          <v-card-text>
            <v-row>
              <v-col cols="5">
                <v-text-field
                  v-model="social_media.facebook"
                  label="Facebook"
                  prepend-icon="mdi-facebook"
                ></v-text-field>
                <v-text-field
                  v-model="social_media.instagram"
                  label="Instagram"
                  prepend-icon="mdi-instagram"
                ></v-text-field>
                <v-text-field
                  v-model="social_media.twitter"
                  label="Twitter"
                  prepend-icon="mdi-twitter"
                ></v-text-field>
                <v-text-field
                  v-model="social_media.youtube"
                  label="YouTube"
                  prepend-icon="mdi-youtube"
                ></v-text-field>
                <v-text-field
                  v-model="social_media.tiktok"
                  label="Tiktok"
                  prepend-icon="mdi-music-note-eighth"
                ></v-text-field>
              </v-col>
              <v-col cols="7">
                <v-text-field
                  v-model="social_media_links.facebook"
                  label="URL Facebook"
                ></v-text-field>
                <v-text-field
                  v-model="social_media_links.instagram"
                  label="URL Instagram"
                ></v-text-field>
                <v-text-field
                  v-model="social_media_links.twitter"
                  label="URL Twitter"
                ></v-text-field>
                <v-text-field
                  v-model="social_media_links.youtube"
                  label="URL YouTube"
                ></v-text-field>
                <v-text-field
                  v-model="social_media_links.tiktok"
                  label="URL Tiktok"
                ></v-text-field> </v-col
              >`
            </v-row>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn depressed color="primary" @click="updateInfo(1)">
              <v-icon>mdi-content-save</v-icon>
              Guardar Cambios
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-tab-item>
      <!-- Fin -->

      <!-- Navegador -->
      <v-tab-item value="navigator">
        <v-card flat class="pa-3">
          <v-card-title>Navegador</v-card-title>
          <v-card-text>
            <v-treeview
              v-model="tree"
              :open="open"
              :items="items"
              item-key="name"
              item-children="menu"
            >
              <template v-slot:prepend="{ item }">
                <v-btn class="ma-2" icon small fab @click="changeMenu(item)">
                  <v-icon medium color="primary">
                    {{
                      item.active == 1
                        ? "mdi-eye-outline"
                        : "mdi-eye-off-outline"
                    }}
                  </v-icon>
                </v-btn>
              </template>
            </v-treeview>
          </v-card-text>
        </v-card>
      </v-tab-item>
      <!-- Fin -->
      <v-tab-item value="terms-conditions">
        <v-card flat class="pa-3">
          <v-card-title>Términos y condiciones</v-card-title>
          <v-card-text>
            <text-editor
              v-if="loading"
              :content.sync="form.info_terms_and_conditions"
            ></text-editor>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn depressed color="primary" @click="updateInfo(0)">
              <v-icon>mdi-content-save</v-icon>
              Guardar Cambios
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-tab-item>
      <v-tab-item value="policy-privacy">
        <v-card flat class="pa-3">
          <v-card-title>Política de privacidad</v-card-title>
          <v-card-text>
            <text-editor
              v-if="loading"
              :content.sync="form.info_privacy_policies"
            ></text-editor>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn depressed color="primary" @click="updateInfo(0)">
              <v-icon>mdi-content-save</v-icon>
              Guardar Cambios
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-tab-item>

      <!-- Facturacion -->
      <v-tab-item value="facturacion">
        <v-card flat class="pa-3">
          <v-card-title>Facturación</v-card-title>
          <v-card-text>
            <v-row class="align-center">
              <v-col cols="3">
                <b>Emitir Boleta/Factura</b>
              </v-col>
              <v-col cols="9">
                <v-switch
                  v-model="invoice_settings.issue_invoice"
                  :label="
                    invoice_settings.issue_invoice == 1 ? 'Emitir' : 'No emitir'
                  "
                ></v-switch>
              </v-col>

              <v-col cols="3">
                <b>API Token</b>
              </v-col>
              <v-col cols="9">
                <v-text-field
                  v-model="invoice_settings.api_token"
                  label="API Token"
                ></v-text-field>
              </v-col>

              <v-col cols="3">
                <b>API URL</b>
              </v-col>
              <v-col cols="9">
                <v-text-field
                  v-model="invoice_settings.api_url"
                  label="API URL"
                ></v-text-field>
              </v-col>

              <v-col cols="3">
                <b>Serie Factura</b>
              </v-col>
              <v-col cols="9">
                <v-text-field
                  v-model="invoice_settings.serie_invoice"
                  label="Serie Factura"
                ></v-text-field>
              </v-col>

              <v-col cols="3">
                <b>Serie Boleta</b>
              </v-col>
              <v-col cols="9">
                <v-text-field
                  v-model="invoice_settings.serie_ticket"
                  label="Serie Boleta"
                ></v-text-field>
              </v-col>
            </v-row>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn depressed color="primary" @click="updateInvoiceConfig(1)">
              <v-icon>mdi-content-save</v-icon>
              Guardar Cambios
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-tab-item>
      <v-tab-item value="next_enrollment">
        <v-card flat class="pa-3">
          <v-card-title>Próximas inscripciones</v-card-title>
          <v-card-text>
            <v-row class="align-center">
              <v-col cols="3">
                <b>Habilitar/Deshabilitar</b>
              </v-col>
              <v-col cols="9">
                <v-switch
                  v-model="form.next_enrollment_date.enable_next_enrollment"
                  :label="
                    form.next_enrollment_date.enable_next_enrollment == 1
                      ? 'Aviso Habilitado'
                      : 'Aviso deshabilitado.'
                  "
                ></v-switch>
              </v-col>

              <v-col cols="3">
                <b>Mensaje</b>
              </v-col>
              <v-col cols="9">
                <v-text-field
                  v-model="form.next_enrollment_date.enrollment_message"
                  label="Mensaje"
                ></v-text-field>
              </v-col>

              <v-col cols="3">
                <b>Fecha Apertura</b>
              </v-col>
              <v-col cols="9">
                <v-date-picker
                  v-model="form.next_enrollment_date.next_enrollment_date"
                  label="Fecha Apertua"
                >
                </v-date-picker>
              </v-col>
            </v-row>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn depressed color="primary" @click="updateInfo(0)">
              <v-icon>mdi-content-save</v-icon>
              Guardar Cambios
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-tab-item>
      <!-- Fin -->
    </v-tabs-items>
    <!--</v-card>-->
  </div>
</template>
<script>
import TextEditor from "../../components/common/TextEditor.vue";
export default {
  components: {
    TextEditor
  },
  data: () => ({
    tab: null,
    breadcrumbs_title: "Configuración",
    breadcrumbs: [
      {
        text: "Inicio",
        disabled: false,
        href: "#"
      },
      {
        text: "Configuración"
      }
    ],
    files: [],
    banners: [],

    open: [],
    tree: [],
    items: [],
    form: {
      name: "",
      address: "",
      phone: "",
      email: "",
      info_terms_and_conditions: "",
      info_privacy_policies: "",
      next_enrollment_date: {
        enable_next_enrollment: "",
        enrollment_message: "",
        next_enrollment_date: ""
      }
    },
    social_media: {
      facebook: "",
      instagram: "",
      youtube: "",
      twitter: "",
      tiktok: ""
    },
    landing_url: "",
    social_media_links: {
      facebook: "",
      instagram: "",
      youtube: "",
      twitter: "",
      tiktok: ""
    },

    //--- Invoice Settings ---
    invoice_settings: {},
    //--- Fin ---

    validAddForm: false,
    rules: {
      required: UTILS.rules.required
    },
    loading: false
  }),
  mounted() {
    this.landing_url = document.head.querySelector(
      'meta[name="landing-url"]'
    ).content;
    this.getTree();
    this.getConfig();
    this.getInvoiceConfig();
  },
  methods: {
    async changeMenu(item) {
      this.$store.commit("loader", true);
      try {
        let data = {
          parent: item.parent == 1 ? 1 : 0,
          active: item.active
        };
        const response = await API.menu.update(item.id, data);
        this.getTree();
        this.$store.commit("loader", false);
      } catch (e) {
        this.$store.commit("loader", false);
        console.error(e);
      }
    },
    //-----------functions tree---------------
    async getTree() {
      try {
        const response = await API.menu.tree();
        for (let index = 0; index < response.data.length; index++) {
          response.data[index].parent = 1;
        }
        this.items = response.data;
        // console.log(this.items);
      } catch (e) {
        console.error(e);
      }
    },
    //-----------functions tree---------------

    //-----------functions config---------------
    async getConfig() {
      try {
        const response = await API.configuration.list();
        const data_enrollment = JSON.parse(response.data.next_enrollment_date);
        this.form.name = response.data.name;
        this.form.address = response.data.address;
        this.form.phone = response.data.phone;
        this.form.email = response.data.email;
        this.form.info_terms_and_conditions =
          response.data.info_terms_and_conditions;
        this.form.info_privacy_policies = response.data.info_privacy_policies;
        this.social_media = JSON.parse(response.data.social_media);
        this.social_media_links = JSON.parse(response.data.social_media_links);
        this.form.allow_sale = response.data.allow_sale;
        this.form.next_enrollment_date.enable_next_enrollment =
          data_enrollment.enable_next_enrollment;
        this.form.next_enrollment_date.enrollment_message =
          data_enrollment.enrollment_message;
        this.form.next_enrollment_date.next_enrollment_date =
          data_enrollment.next_enrollment_date;
        this.loading = true;
      } catch (e) {
        console.error(e);
      }
    },

    async updateInfo(n) {
      try {
        if (n == 0) {
          const response = await API.configuration.update(1, this.form);
          UTILS.toastr.success("Configuración actualizada correctamente", this);
        }
        if (n == 1) {
          const response = await API.configuration.update(1, {
            social_media: JSON.stringify(this.social_media),
            social_media_links: JSON.stringify(this.social_media_links)
          });
          UTILS.toastr.success("Configuración actualizada correctamente", this);
        }
      } catch (e) {
        console.error(e);
      }
    },
    //-----------functions config---------------

    //--- Invoice Config ---
    async getInvoiceConfig() {
      try {
        const response = await API.invoice_configuration.list();
        this.invoice_settings = Object.assign({}, response.data);
      } catch (e) {
        console.error(e);
      }
    },
    async updateInvoiceConfig(id) {
      try {
        const response = await API.invoice_configuration.update(
          id,
          this.invoice_settings
        );
        UTILS.toastr.success("Configuración actualizada correctamente", this);
      } catch (e) {
        console.error(e);
      }
    }
    //--- Fin ---
  }
};
</script>
<style scoped>
input[type="file"] {
  opacity: 0;
  width: 100%;
  height: 200px;
  position: absolute;
  cursor: pointer;
}
.filezone {
  outline: 2px dashed grey;
  outline-offset: -10px;
  background: #ccc;
  color: dimgray;
  padding: 10px 10px;
  min-height: 200px;
  position: relative;
  cursor: pointer;
}
.filezone:hover {
  background: #c0c0c0;
}

.filezone p {
  font-size: 1.2em;
  text-align: center;
  padding: 50px 50px 50px 50px;
}
div.file-listing img {
  max-width: 90%;
}

div.file-listing {
  margin: auto;
  padding: 10px;
  border-bottom: 1px solid #ddd;
}

div.file-listing img {
  /*height: 100px;*/
  width: 200px;
}
div.success-container {
  text-align: center;
  color: green;
}

div.remove-container {
  text-align: center;
}

div.remove-container a {
  color: red;
  cursor: pointer;
}

a.submit-button {
  display: block;
  margin: auto;
  text-align: center;
  width: 200px;
  padding: 10px;
  text-transform: uppercase;
  background-color: #ccc;
  color: white;
  font-weight: bold;
  margin-top: 20px;
}
div.my-tabs [role="tab"] {
  justify-content: flex-start;
}
</style>
