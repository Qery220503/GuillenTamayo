(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["auth-forgot"],{

/***/ "./node_modules/babel-loader/lib/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/auth/ForgotPage.vue?vue&type=script&lang=js&":
/*!*********************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib??ref--4-0!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/pages/auth/ForgotPage.vue?vue&type=script&lang=js& ***!
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

/*
|---------------------------------------------------------------------
| Forgot Page Component
|---------------------------------------------------------------------
|
| Template to send email to remember/replace password
|
*/
/* harmony default export */ __webpack_exports__["default"] = ({
  data: function data() {
    return {
      // reset button
      isLoading: false,
      // form
      isFormValid: true,
      email: '',
      // form error
      error: false,
      errorMessages: '',
      // input rules
      rules: {
        required: function required(value) {
          return value && Boolean(value) || 'Required';
        }
      }
    };
  },
  methods: {
    submit: function submit(e) {
      if (this.$refs.form.validate()) {
        console.log('submit');
      }
    },
    resetEmail: function resetEmail(email, password) {},
    resetErrors: function resetErrors() {
      this.error = false;
      this.errorMessages = '';
    }
  }
});

/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/auth/ForgotPage.vue?vue&type=template&id=a2195740&":
/*!*************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/pages/auth/ForgotPage.vue?vue&type=template&id=a2195740& ***!
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
            _vm._v(_vm._s(_vm.$t("forgot.title")))
          ]),
          _vm._v(" "),
          _c("v-card-subtitle", [
            _vm._v("\n      " + _vm._s(_vm.$t("forgot.subtitle")) + "\n    ")
          ]),
          _vm._v(" "),
          _c(
            "v-card-text",
            [
              _c(
                "v-form",
                {
                  ref: "form",
                  attrs: { "lazy-validation": "" },
                  on: {
                    submit: function($event) {
                      $event.preventDefault()
                      return _vm.submit($event)
                    }
                  },
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
                      "error-messages": _vm.errorMessages,
                      label: _vm.$t("forgot.email"),
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
                  _c(
                    "v-btn",
                    {
                      attrs: {
                        loading: _vm.isLoading,
                        block: "",
                        "x-large": "",
                        color: "primary"
                      },
                      on: { click: _vm.submit }
                    },
                    [_vm._v(_vm._s(_vm.$t("forgot.button")))]
                  )
                ],
                1
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
          _c("router-link", { attrs: { to: "/auth/signin" } }, [
            _vm._v("\n      " + _vm._s(_vm.$t("forgot.backtosign")) + "\n    ")
          ])
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

/***/ "./resources/js/pages/auth/ForgotPage.vue":
/*!************************************************!*\
  !*** ./resources/js/pages/auth/ForgotPage.vue ***!
  \************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _ForgotPage_vue_vue_type_template_id_a2195740___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./ForgotPage.vue?vue&type=template&id=a2195740& */ "./resources/js/pages/auth/ForgotPage.vue?vue&type=template&id=a2195740&");
/* harmony import */ var _ForgotPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./ForgotPage.vue?vue&type=script&lang=js& */ "./resources/js/pages/auth/ForgotPage.vue?vue&type=script&lang=js&");
/* empty/unused harmony star reexport *//* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ "./node_modules/vue-loader/lib/runtime/componentNormalizer.js");





/* normalize component */

var component = Object(_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__["default"])(
  _ForgotPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__["default"],
  _ForgotPage_vue_vue_type_template_id_a2195740___WEBPACK_IMPORTED_MODULE_0__["render"],
  _ForgotPage_vue_vue_type_template_id_a2195740___WEBPACK_IMPORTED_MODULE_0__["staticRenderFns"],
  false,
  null,
  null,
  null
  
)

/* hot reload */
if (false) { var api; }
component.options.__file = "resources/js/pages/auth/ForgotPage.vue"
/* harmony default export */ __webpack_exports__["default"] = (component.exports);

/***/ }),

/***/ "./resources/js/pages/auth/ForgotPage.vue?vue&type=script&lang=js&":
/*!*************************************************************************!*\
  !*** ./resources/js/pages/auth/ForgotPage.vue?vue&type=script&lang=js& ***!
  \*************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_babel_loader_lib_index_js_ref_4_0_node_modules_vue_loader_lib_index_js_vue_loader_options_ForgotPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/babel-loader/lib??ref--4-0!../../../../node_modules/vue-loader/lib??vue-loader-options!./ForgotPage.vue?vue&type=script&lang=js& */ "./node_modules/babel-loader/lib/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/auth/ForgotPage.vue?vue&type=script&lang=js&");
/* empty/unused harmony star reexport */ /* harmony default export */ __webpack_exports__["default"] = (_node_modules_babel_loader_lib_index_js_ref_4_0_node_modules_vue_loader_lib_index_js_vue_loader_options_ForgotPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__["default"]); 

/***/ }),

/***/ "./resources/js/pages/auth/ForgotPage.vue?vue&type=template&id=a2195740&":
/*!*******************************************************************************!*\
  !*** ./resources/js/pages/auth/ForgotPage.vue?vue&type=template&id=a2195740& ***!
  \*******************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_ForgotPage_vue_vue_type_template_id_a2195740___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../node_modules/vue-loader/lib??vue-loader-options!./ForgotPage.vue?vue&type=template&id=a2195740& */ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/auth/ForgotPage.vue?vue&type=template&id=a2195740&");
/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "render", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_ForgotPage_vue_vue_type_template_id_a2195740___WEBPACK_IMPORTED_MODULE_0__["render"]; });

/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "staticRenderFns", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_ForgotPage_vue_vue_type_template_id_a2195740___WEBPACK_IMPORTED_MODULE_0__["staticRenderFns"]; });



/***/ })

}]);