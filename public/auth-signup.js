(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["auth-signup"],{

/***/ "./node_modules/babel-loader/lib/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/auth/SignupPage.vue?vue&type=script&lang=js&":
/*!*********************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib??ref--4-0!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/pages/auth/SignupPage.vue?vue&type=script&lang=js& ***!
  \*********************************************************************************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

/*
|---------------------------------------------------------------------
| Sign Up Page Component
|---------------------------------------------------------------------
|
| Template for user sign up with external providers buttons
|
*/
/* harmony default export */ __webpack_exports__["default"] = ({
  data: function data() {
    return {
      // sign up buttons
      isLoading: false,
      isSignUpDisabled: false,
      // form
      isFormValid: true,
      email: '',
      password: '',
      name: '',
      // form error
      errorName: false,
      errorEmail: false,
      errorPassword: false,
      errorNameMessage: '',
      errorEmailMessage: '',
      errorPasswordMessage: '',
      errorProvider: false,
      errorProviderMessages: '',
      // show password field
      showPassword: false,
      // external providers
      providers: [{
        id: 'google',
        label: 'Google',
        isLoading: false
      }, {
        id: 'facebook',
        label: 'Facebook',
        isLoading: false
      }],
      // input rules
      rules: {
        required: function required(value) {
          return value && Boolean(value) || 'Required';
        }
      }
    };
  },
  methods: {
    submit: function submit() {
      if (this.$refs.form.validate()) {
        this.isLoading = true;
        this.isSignUpDisabled = true;
        this.signUp(this.email, this.password);
      }
    },
    signUp: function signUp(email, password) {},
    signInProvider: function signInProvider(provider) {},
    resetErrors: function resetErrors() {
      this.errorName = false;
      this.errorEmail = false;
      this.errorPassword = false;
      this.errorNameMessage = '';
      this.errorEmailMessage = '';
      this.errorPasswordMessage = '';
      this.errorProvider = false;
      this.errorProviderMessages = '';
    }
  }
});

/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/auth/SignupPage.vue?vue&type=template&id=932bc556&":
/*!*************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/pages/auth/SignupPage.vue?vue&type=template&id=932bc556& ***!
  \*************************************************************************************************************************************************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "render", function() { return render; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "staticRenderFns", function() { return staticRenderFns; });
var render = function() {
  var _vm = this
  var _h = _vm.$createElement
  var _c = _vm._self._c || _h
  return _c(
    "div",
    [
      _c(
        "v-card",
        { staticClass: "text-center pa-1" },
        [
          _c("v-card-title", { staticClass: "justify-center display-1 mb-2" }, [
            _vm._v(_vm._s(_vm.$t("register.title")))
          ]),
          _vm._v(" "),
          _c("v-card-subtitle", [_vm._v("Let's build amazing products")]),
          _vm._v(" "),
          _c(
            "v-card-text",
            [
              _c(
                "v-form",
                {
                  ref: "form",
                  attrs: { "lazy-validation": "" },
                  model: {
                    value: _vm.isFormValid,
                    callback: function($$v) {
                      _vm.isFormValid = $$v
                    },
                    expression: "isFormValid"
                  }
                },
                [
                  _c("v-text-field", {
                    attrs: {
                      rules: [_vm.rules.required],
                      "validate-on-blur": false,
                      error: _vm.errorName,
                      "error-messages": _vm.errorNameMessage,
                      label: _vm.$t("register.name"),
                      name: "name",
                      outlined: ""
                    },
                    on: {
                      keyup: function($event) {
                        if (
                          !$event.type.indexOf("key") &&
                          _vm._k(
                            $event.keyCode,
                            "enter",
                            13,
                            $event.key,
                            "Enter"
                          )
                        ) {
                          return null
                        }
                        return _vm.submit($event)
                      },
                      change: _vm.resetErrors
                    },
                    model: {
                      value: _vm.name,
                      callback: function($$v) {
                        _vm.name = $$v
                      },
                      expression: "name"
                    }
                  }),
                  _vm._v(" "),
                  _c("v-text-field", {
                    attrs: {
                      rules: [_vm.rules.required],
                      "validate-on-blur": false,
                      error: _vm.errorEmail,
                      "error-messages": _vm.errorEmailMessage,
                      label: _vm.$t("register.email"),
                      name: "email",
                      outlined: ""
                    },
                    on: {
                      keyup: function($event) {
                        if (
                          !$event.type.indexOf("key") &&
                          _vm._k(
                            $event.keyCode,
                            "enter",
                            13,
                            $event.key,
                            "Enter"
                          )
                        ) {
                          return null
                        }
                        return _vm.submit($event)
                      },
                      change: _vm.resetErrors
                    },
                    model: {
                      value: _vm.email,
                      callback: function($$v) {
                        _vm.email = $$v
                      },
                      expression: "email"
                    }
                  }),
                  _vm._v(" "),
                  _c("v-text-field", {
                    attrs: {
                      "append-icon": _vm.showPassword
                        ? "mdi-eye"
                        : "mdi-eye-off",
                      rules: [_vm.rules.required],
                      type: _vm.showPassword ? "text" : "password",
                      error: _vm.errorPassword,
                      "error-messages": _vm.errorPasswordMessage,
                      label: _vm.$t("register.password"),
                      name: "password",
                      outlined: ""
                    },
                    on: {
                      change: _vm.resetErrors,
                      keyup: function($event) {
                        if (
                          !$event.type.indexOf("key") &&
                          _vm._k(
                            $event.keyCode,
                            "enter",
                            13,
                            $event.key,
                            "Enter"
                          )
                        ) {
                          return null
                        }
                        return _vm.submit($event)
                      },
                      "click:append": function($event) {
                        _vm.showPassword = !_vm.showPassword
                      }
                    },
                    model: {
                      value: _vm.password,
                      callback: function($$v) {
                        _vm.password = $$v
                      },
                      expression: "password"
                    }
                  }),
                  _vm._v(" "),
                  _c(
                    "v-btn",
                    {
                      attrs: {
                        loading: _vm.isLoading,
                        disabled: _vm.isSignUpDisabled,
                        block: "",
                        "x-large": "",
                        color: "primary"
                      },
                      on: { click: _vm.submit }
                    },
                    [_vm._v(_vm._s(_vm.$t("register.button")))]
                  ),
                  _vm._v(" "),
                  _c(
                    "div",
                    {
                      staticClass:
                        "caption font-weight-bold text-uppercase my-3"
                    },
                    [_vm._v(_vm._s(_vm.$t("register.orsign")))]
                  ),
                  _vm._v(" "),
                  _vm._l(_vm.providers, function(provider) {
                    return _c(
                      "v-btn",
                      {
                        key: provider.id,
                        staticClass:
                          "mb-2 primary lighten-2 primary--text text--darken-3",
                        attrs: {
                          loading: provider.isLoading,
                          disabled: _vm.isSignUpDisabled,
                          block: "",
                          "x-large": ""
                        },
                        on: {
                          click: function($event) {
                            return _vm.signInProvider(provider)
                          }
                        }
                      },
                      [
                        _c("v-icon", { attrs: { small: "", left: "" } }, [
                          _vm._v("mdi-" + _vm._s(provider.id))
                        ]),
                        _vm._v(
                          "\n          " + _vm._s(provider.label) + "\n        "
                        )
                      ],
                      1
                    )
                  }),
                  _vm._v(" "),
                  _vm.errorProvider
                    ? _c("div", { staticClass: "error--text" }, [
                        _vm._v(_vm._s(_vm.errorProviderMessages))
                      ])
                    : _vm._e(),
                  _vm._v(" "),
                  _c(
                    "div",
                    { staticClass: "mt-5 overline" },
                    [
                      _vm._v(
                        "\n          " +
                          _vm._s(_vm.$t("register.agree")) +
                          "\n          "
                      ),
                      _c("br"),
                      _vm._v(" "),
                      _c("router-link", { attrs: { to: "" } }, [
                        _vm._v(_vm._s(_vm.$t("common.tos")))
                      ]),
                      _vm._v("\n          &\n          "),
                      _c("router-link", { attrs: { to: "" } }, [
                        _vm._v(_vm._s(_vm.$t("common.policy")))
                      ])
                    ],
                    1
                  )
                ],
                2
              )
            ],
            1
          )
        ],
        1
      ),
      _vm._v(" "),
      _c(
        "div",
        { staticClass: "text-center mt-6" },
        [
          _vm._v("\n    " + _vm._s(_vm.$t("register.account")) + "\n    "),
          _c(
            "router-link",
            { staticClass: "font-weight-bold", attrs: { to: "/auth/signin" } },
            [_vm._v("\n      " + _vm._s(_vm.$t("register.signin")) + "\n    ")]
          )
        ],
        1
      )
    ],
    1
  )
}
var staticRenderFns = []
render._withStripped = true



/***/ }),

/***/ "./resources/js/pages/auth/SignupPage.vue":
/*!************************************************!*\
  !*** ./resources/js/pages/auth/SignupPage.vue ***!
  \************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _SignupPage_vue_vue_type_template_id_932bc556___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./SignupPage.vue?vue&type=template&id=932bc556& */ "./resources/js/pages/auth/SignupPage.vue?vue&type=template&id=932bc556&");
/* harmony import */ var _SignupPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./SignupPage.vue?vue&type=script&lang=js& */ "./resources/js/pages/auth/SignupPage.vue?vue&type=script&lang=js&");
/* empty/unused harmony star reexport *//* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ "./node_modules/vue-loader/lib/runtime/componentNormalizer.js");





/* normalize component */

var component = Object(_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__["default"])(
  _SignupPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__["default"],
  _SignupPage_vue_vue_type_template_id_932bc556___WEBPACK_IMPORTED_MODULE_0__["render"],
  _SignupPage_vue_vue_type_template_id_932bc556___WEBPACK_IMPORTED_MODULE_0__["staticRenderFns"],
  false,
  null,
  null,
  null
  
)

/* hot reload */
if (false) { var api; }
component.options.__file = "resources/js/pages/auth/SignupPage.vue"
/* harmony default export */ __webpack_exports__["default"] = (component.exports);

/***/ }),

/***/ "./resources/js/pages/auth/SignupPage.vue?vue&type=script&lang=js&":
/*!*************************************************************************!*\
  !*** ./resources/js/pages/auth/SignupPage.vue?vue&type=script&lang=js& ***!
  \*************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_babel_loader_lib_index_js_ref_4_0_node_modules_vue_loader_lib_index_js_vue_loader_options_SignupPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/babel-loader/lib??ref--4-0!../../../../node_modules/vue-loader/lib??vue-loader-options!./SignupPage.vue?vue&type=script&lang=js& */ "./node_modules/babel-loader/lib/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/auth/SignupPage.vue?vue&type=script&lang=js&");
/* empty/unused harmony star reexport */ /* harmony default export */ __webpack_exports__["default"] = (_node_modules_babel_loader_lib_index_js_ref_4_0_node_modules_vue_loader_lib_index_js_vue_loader_options_SignupPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__["default"]); 

/***/ }),

/***/ "./resources/js/pages/auth/SignupPage.vue?vue&type=template&id=932bc556&":
/*!*******************************************************************************!*\
  !*** ./resources/js/pages/auth/SignupPage.vue?vue&type=template&id=932bc556& ***!
  \*******************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_SignupPage_vue_vue_type_template_id_932bc556___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../node_modules/vue-loader/lib??vue-loader-options!./SignupPage.vue?vue&type=template&id=932bc556& */ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/auth/SignupPage.vue?vue&type=template&id=932bc556&");
/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "render", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_SignupPage_vue_vue_type_template_id_932bc556___WEBPACK_IMPORTED_MODULE_0__["render"]; });

/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "staticRenderFns", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_SignupPage_vue_vue_type_template_id_932bc556___WEBPACK_IMPORTED_MODULE_0__["staticRenderFns"]; });



/***/ })

}]);