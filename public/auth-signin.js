(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["auth-signin"],{

/***/ "./node_modules/babel-loader/lib/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/auth/SigninPage.vue?vue&type=script&lang=js&":
/*!*********************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib??ref--4-0!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/pages/auth/SigninPage.vue?vue&type=script&lang=js& ***!
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

/*
|---------------------------------------------------------------------
| Sign In Page Component
|---------------------------------------------------------------------
|
| Sign in template for user authentication into the application
|
*/
/* harmony default export */ __webpack_exports__["default"] = ({
  data: function data() {
    return {
      // sign in buttons
      isLoading: false,
      isSignInDisabled: false,
      // form
      isFormValid: true,
      email: '',
      password: '',
      // form error
      error: false,
      errorMessages: '',
      errorProvider: false,
      errorProviderMessages: '',
      // show password field
      showPassword: false,
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
        this.isSignInDisabled = true;
        this.signIn(this.email, this.password);
      }
    },
    signIn: function signIn(email, password) {
      this.$router.push('/');
    },
    signInProvider: function signInProvider(provider) {},
    resetErrors: function resetErrors() {
      this.error = false;
      this.errorMessages = '';
      this.errorProvider = false;
      this.errorProviderMessages = '';
    }
  }
});

/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/auth/SigninPage.vue?vue&type=template&id=1a6ff1df&":
/*!*************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/pages/auth/SigninPage.vue?vue&type=template&id=1a6ff1df& ***!
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
            _vm._v("Welcome")
          ]),
          _vm._v(" "),
          _c("v-card-subtitle", [_vm._v("Sign in to your account")]),
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
                      error: _vm.error,
                      label: _vm.$t("login.email"),
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
                      error: _vm.error,
                      "error-messages": _vm.errorMessages,
                      label: _vm.$t("login.password"),
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
                        disabled: _vm.isSignInDisabled,
                        block: "",
                        "x-large": "",
                        color: "primary"
                      },
                      on: { click: _vm.submit }
                    },
                    [_vm._v(_vm._s(_vm.$t("login.button")))]
                  ),
                  _vm._v(" "),
                  _c(
                    "div",
                    {
                      staticClass:
                        "caption font-weight-bold text-uppercase my-3"
                    },
                    [_vm._v(_vm._s(_vm.$t("login.orsign")))]
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
                          disabled: _vm.isSignInDisabled,
                          block: "",
                          "x-large": "",
                          to: "/"
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
                    { staticClass: "mt-5" },
                    [
                      _c(
                        "router-link",
                        { attrs: { to: "/auth/forgot-password" } },
                        [
                          _vm._v(
                            "\n            " +
                              _vm._s(_vm.$t("login.forgot")) +
                              "\n          "
                          )
                        ]
                      )
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
          _vm._v("\n    " + _vm._s(_vm.$t("login.noaccount")) + "\n    "),
          _c(
            "router-link",
            { staticClass: "font-weight-bold", attrs: { to: "/auth/signup" } },
            [_vm._v("\n      " + _vm._s(_vm.$t("login.create")) + "\n    ")]
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

/***/ "./resources/js/pages/auth/SigninPage.vue":
/*!************************************************!*\
  !*** ./resources/js/pages/auth/SigninPage.vue ***!
  \************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _SigninPage_vue_vue_type_template_id_1a6ff1df___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./SigninPage.vue?vue&type=template&id=1a6ff1df& */ "./resources/js/pages/auth/SigninPage.vue?vue&type=template&id=1a6ff1df&");
/* harmony import */ var _SigninPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./SigninPage.vue?vue&type=script&lang=js& */ "./resources/js/pages/auth/SigninPage.vue?vue&type=script&lang=js&");
/* empty/unused harmony star reexport *//* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ "./node_modules/vue-loader/lib/runtime/componentNormalizer.js");





/* normalize component */

var component = Object(_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__["default"])(
  _SigninPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__["default"],
  _SigninPage_vue_vue_type_template_id_1a6ff1df___WEBPACK_IMPORTED_MODULE_0__["render"],
  _SigninPage_vue_vue_type_template_id_1a6ff1df___WEBPACK_IMPORTED_MODULE_0__["staticRenderFns"],
  false,
  null,
  null,
  null
  
)

/* hot reload */
if (false) { var api; }
component.options.__file = "resources/js/pages/auth/SigninPage.vue"
/* harmony default export */ __webpack_exports__["default"] = (component.exports);

/***/ }),

/***/ "./resources/js/pages/auth/SigninPage.vue?vue&type=script&lang=js&":
/*!*************************************************************************!*\
  !*** ./resources/js/pages/auth/SigninPage.vue?vue&type=script&lang=js& ***!
  \*************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_babel_loader_lib_index_js_ref_4_0_node_modules_vue_loader_lib_index_js_vue_loader_options_SigninPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/babel-loader/lib??ref--4-0!../../../../node_modules/vue-loader/lib??vue-loader-options!./SigninPage.vue?vue&type=script&lang=js& */ "./node_modules/babel-loader/lib/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/auth/SigninPage.vue?vue&type=script&lang=js&");
/* empty/unused harmony star reexport */ /* harmony default export */ __webpack_exports__["default"] = (_node_modules_babel_loader_lib_index_js_ref_4_0_node_modules_vue_loader_lib_index_js_vue_loader_options_SigninPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__["default"]); 

/***/ }),

/***/ "./resources/js/pages/auth/SigninPage.vue?vue&type=template&id=1a6ff1df&":
/*!*******************************************************************************!*\
  !*** ./resources/js/pages/auth/SigninPage.vue?vue&type=template&id=1a6ff1df& ***!
  \*******************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_SigninPage_vue_vue_type_template_id_1a6ff1df___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../node_modules/vue-loader/lib??vue-loader-options!./SigninPage.vue?vue&type=template&id=1a6ff1df& */ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/auth/SigninPage.vue?vue&type=template&id=1a6ff1df&");
/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "render", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_SigninPage_vue_vue_type_template_id_1a6ff1df___WEBPACK_IMPORTED_MODULE_0__["render"]; });

/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "staticRenderFns", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_SigninPage_vue_vue_type_template_id_1a6ff1df___WEBPACK_IMPORTED_MODULE_0__["staticRenderFns"]; });



/***/ })

}]);