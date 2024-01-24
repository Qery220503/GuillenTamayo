(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["auth-reset"],{

/***/ "./node_modules/babel-loader/lib/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/auth/ResetPage.vue?vue&type=script&lang=js&":
/*!********************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib??ref--4-0!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/pages/auth/ResetPage.vue?vue&type=script&lang=js& ***!
  \********************************************************************************************************************************************************************/
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

/*
|---------------------------------------------------------------------
| Reset Page Component
|---------------------------------------------------------------------
|
| Page Form to insert new password and proceed to sign in
|
*/
/* harmony default export */ __webpack_exports__["default"] = ({
  data: function data() {
    return {
      isLoading: false,
      showNewPassword: true,
      newPassword: '',
      // form error
      errorNewPassword: false,
      errorNewPasswordMessage: '',
      // show password field
      showPassword: false,
      status: 'Resetting password',
      error: null,
      // input rules
      rules: {
        required: function required(value) {
          return value && Boolean(value) || 'Required';
        }
      }
    };
  },
  methods: {
    confirmPasswordReset: function confirmPasswordReset() {
      var _this = this;

      this.isLoading = true;
      setTimeout(function () {
        _this.isLoading = false;
      }, 500);
    },
    resetErrors: function resetErrors() {
      this.errorNewPassword = false;
      this.errorNewPasswordMessage = '';
    }
  }
});

/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/auth/ResetPage.vue?vue&type=template&id=6a2926e0&":
/*!************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/pages/auth/ResetPage.vue?vue&type=template&id=6a2926e0& ***!
  \************************************************************************************************************************************************************************************************************/
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
    "v-card",
    { staticClass: "pa-2" },
    [
      _c("v-card-title", { staticClass: "justify-center display-1 mb-2" }, [
        _vm._v("Set new password")
      ]),
      _vm._v(" "),
      _c("div", { staticClass: "overline" }, [_vm._v(_vm._s(_vm.status))]),
      _vm._v(" "),
      _c("div", { staticClass: "error--text mt-2 mb-4" }, [
        _vm._v(_vm._s(_vm.error))
      ]),
      _vm._v(" "),
      _vm.error
        ? _c("a", { attrs: { href: "/" } }, [_vm._v("Back to Sign In")])
        : _vm._e(),
      _vm._v(" "),
      _c("v-text-field", {
        staticClass: "mt-4",
        attrs: {
          "append-icon": _vm.showPassword ? "mdi-eye" : "mdi-eye-off",
          rules: [_vm.rules.required],
          type: _vm.showPassword ? "text" : "password",
          error: _vm.errorNewPassword,
          "error-messages": _vm.errorNewPasswordMessage,
          name: "password",
          label: "New Password",
          outlined: ""
        },
        on: {
          change: _vm.resetErrors,
          keyup: function($event) {
            if (
              !$event.type.indexOf("key") &&
              _vm._k($event.keyCode, "enter", 13, $event.key, "Enter")
            ) {
              return null
            }
            return _vm.confirmPasswordReset($event)
          },
          "click:append": function($event) {
            _vm.showPassword = !_vm.showPassword
          }
        },
        model: {
          value: _vm.newPassword,
          callback: function($$v) {
            _vm.newPassword = $$v
          },
          expression: "newPassword"
        }
      }),
      _vm._v(" "),
      _c(
        "v-btn",
        {
          attrs: {
            loading: _vm.isLoading,
            block: "",
            depressed: "",
            "x-large": "",
            color: "primary"
          },
          on: { click: _vm.confirmPasswordReset }
        },
        [_vm._v("Set new password and Sign In")]
      )
    ],
    1
  )
}
var staticRenderFns = []
render._withStripped = true



/***/ }),

/***/ "./resources/js/pages/auth/ResetPage.vue":
/*!***********************************************!*\
  !*** ./resources/js/pages/auth/ResetPage.vue ***!
  \***********************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _ResetPage_vue_vue_type_template_id_6a2926e0___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./ResetPage.vue?vue&type=template&id=6a2926e0& */ "./resources/js/pages/auth/ResetPage.vue?vue&type=template&id=6a2926e0&");
/* harmony import */ var _ResetPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./ResetPage.vue?vue&type=script&lang=js& */ "./resources/js/pages/auth/ResetPage.vue?vue&type=script&lang=js&");
/* empty/unused harmony star reexport *//* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ "./node_modules/vue-loader/lib/runtime/componentNormalizer.js");





/* normalize component */

var component = Object(_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__["default"])(
  _ResetPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__["default"],
  _ResetPage_vue_vue_type_template_id_6a2926e0___WEBPACK_IMPORTED_MODULE_0__["render"],
  _ResetPage_vue_vue_type_template_id_6a2926e0___WEBPACK_IMPORTED_MODULE_0__["staticRenderFns"],
  false,
  null,
  null,
  null
  
)

/* hot reload */
if (false) { var api; }
component.options.__file = "resources/js/pages/auth/ResetPage.vue"
/* harmony default export */ __webpack_exports__["default"] = (component.exports);

/***/ }),

/***/ "./resources/js/pages/auth/ResetPage.vue?vue&type=script&lang=js&":
/*!************************************************************************!*\
  !*** ./resources/js/pages/auth/ResetPage.vue?vue&type=script&lang=js& ***!
  \************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_babel_loader_lib_index_js_ref_4_0_node_modules_vue_loader_lib_index_js_vue_loader_options_ResetPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/babel-loader/lib??ref--4-0!../../../../node_modules/vue-loader/lib??vue-loader-options!./ResetPage.vue?vue&type=script&lang=js& */ "./node_modules/babel-loader/lib/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/auth/ResetPage.vue?vue&type=script&lang=js&");
/* empty/unused harmony star reexport */ /* harmony default export */ __webpack_exports__["default"] = (_node_modules_babel_loader_lib_index_js_ref_4_0_node_modules_vue_loader_lib_index_js_vue_loader_options_ResetPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__["default"]); 

/***/ }),

/***/ "./resources/js/pages/auth/ResetPage.vue?vue&type=template&id=6a2926e0&":
/*!******************************************************************************!*\
  !*** ./resources/js/pages/auth/ResetPage.vue?vue&type=template&id=6a2926e0& ***!
  \******************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_ResetPage_vue_vue_type_template_id_6a2926e0___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../node_modules/vue-loader/lib??vue-loader-options!./ResetPage.vue?vue&type=template&id=6a2926e0& */ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/auth/ResetPage.vue?vue&type=template&id=6a2926e0&");
/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "render", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_ResetPage_vue_vue_type_template_id_6a2926e0___WEBPACK_IMPORTED_MODULE_0__["render"]; });

/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "staticRenderFns", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_ResetPage_vue_vue_type_template_id_6a2926e0___WEBPACK_IMPORTED_MODULE_0__["staticRenderFns"]; });



/***/ })

}]);