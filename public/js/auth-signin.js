"use strict";
(self["webpackChunk"] = self["webpackChunk"] || []).push([["auth-signin"],{

/***/ "./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/pages/auth/SigninPage.vue?vue&type=script&lang=js&":
/*!*****************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/pages/auth/SigninPage.vue?vue&type=script&lang=js& ***!
  \*****************************************************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _babel_runtime_regenerator__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @babel/runtime/regenerator */ "./node_modules/@babel/runtime/regenerator/index.js");
/* harmony import */ var _babel_runtime_regenerator__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_babel_runtime_regenerator__WEBPACK_IMPORTED_MODULE_0__);


function asyncGeneratorStep(gen, resolve, reject, _next, _throw, key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { Promise.resolve(value).then(_next, _throw); } }

function _asyncToGenerator(fn) { return function () { var self = this, args = arguments; return new Promise(function (resolve, reject) { var gen = fn.apply(self, args); function _next(value) { asyncGeneratorStep(gen, resolve, reject, _next, _throw, "next", value); } function _throw(err) { asyncGeneratorStep(gen, resolve, reject, _next, _throw, "throw", err); } _next(undefined); }); }; }

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
          return value && Boolean(value) || 'Campo Obligatorio';
        }
      },
      emailRules: [function (v) {
        return !!v || 'Correo Electrónico es obligatorio';
      }, function (v) {
        return /.+@.+\..+/.test(v) || 'Correo Electrónico debe ser válido';
      }]
    };
  },
  methods: {
    submit: function submit() {
      if (this.$refs.form.validate()) {
        this.isLoading = true;
        this.isSignInDisabled = true;
        this.login({
          email: this.email,
          password: this.password
        });
      }
    },
    login: function login(userCredentials) {
      var _this = this;

      return _asyncToGenerator( /*#__PURE__*/_babel_runtime_regenerator__WEBPACK_IMPORTED_MODULE_0___default().mark(function _callee() {
        var response, user, token;
        return _babel_runtime_regenerator__WEBPACK_IMPORTED_MODULE_0___default().wrap(function _callee$(_context) {
          while (1) {
            switch (_context.prev = _context.next) {
              case 0:
                _context.prev = 0;
                _context.next = 3;
                return API.users.login(userCredentials);

              case 3:
                response = _context.sent;
                user = response.data.user;
                token = response.data.token;
                console.log(response);
                localStorage.setItem('user_id', user.id);
                localStorage.setItem('user_token', token);
                localStorage.setItem('user_data', JSON.stringify(user));
                localStorage.setItem('user_permissions', JSON.stringify(user.permissions));
                localStorage.setItem('user_roles', JSON.stringify(user.roles));

                _this.$root.$emit("update_user", user);

                window.location.replace('/');
                _context.next = 22;
                break;

              case 16:
                _context.prev = 16;
                _context.t0 = _context["catch"](0);
                console.error(_context.t0.response.status);

                _this.$swal({
                  icon: 'error',
                  title: 'Opps!',
                  text: 'Usuario y/o Contraseña incorrecta!',
                  timerProgressBar: true,
                  timer: 2500
                });

                _this.isLoading = false;
                _this.isSignInDisabled = false;

              case 22:
              case "end":
                return _context.stop();
            }
          }
        }, _callee, null, [[0, 16]]);
      }))();
    },
    signInProvider: function signInProvider(provider) {},
    resetErrors: function resetErrors() {
      this.error = false;
      this.errorMessages = '';
      this.errorProvider = false;
      this.errorProviderMessages = '';
    }
  },
  mounted: function mounted() {
    return _asyncToGenerator( /*#__PURE__*/_babel_runtime_regenerator__WEBPACK_IMPORTED_MODULE_0___default().mark(function _callee2() {
      var response;
      return _babel_runtime_regenerator__WEBPACK_IMPORTED_MODULE_0___default().wrap(function _callee2$(_context2) {
        while (1) {
          switch (_context2.prev = _context2.next) {
            case 0:
              _context2.next = 2;
              return API.users.get_ip();

            case 2:
              response = _context2.sent;
              console.log(response);

            case 4:
            case "end":
              return _context2.stop();
          }
        }
      }, _callee2);
    }))();
  }
});

/***/ }),

/***/ "./resources/js/pages/auth/SigninPage.vue":
/*!************************************************!*\
  !*** ./resources/js/pages/auth/SigninPage.vue ***!
  \************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _SigninPage_vue_vue_type_template_id_1a6ff1df___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./SigninPage.vue?vue&type=template&id=1a6ff1df& */ "./resources/js/pages/auth/SigninPage.vue?vue&type=template&id=1a6ff1df&");
/* harmony import */ var _SigninPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./SigninPage.vue?vue&type=script&lang=js& */ "./resources/js/pages/auth/SigninPage.vue?vue&type=script&lang=js&");
/* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! !../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ "./node_modules/vue-loader/lib/runtime/componentNormalizer.js");





/* normalize component */
;
var component = (0,_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__.default)(
  _SigninPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__.default,
  _SigninPage_vue_vue_type_template_id_1a6ff1df___WEBPACK_IMPORTED_MODULE_0__.render,
  _SigninPage_vue_vue_type_template_id_1a6ff1df___WEBPACK_IMPORTED_MODULE_0__.staticRenderFns,
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
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_babel_loader_lib_index_js_clonedRuleSet_5_0_rules_0_use_0_node_modules_vue_loader_lib_index_js_vue_loader_options_SigninPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./SigninPage.vue?vue&type=script&lang=js& */ "./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/pages/auth/SigninPage.vue?vue&type=script&lang=js&");
 /* harmony default export */ __webpack_exports__["default"] = (_node_modules_babel_loader_lib_index_js_clonedRuleSet_5_0_rules_0_use_0_node_modules_vue_loader_lib_index_js_vue_loader_options_SigninPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__.default); 

/***/ }),

/***/ "./resources/js/pages/auth/SigninPage.vue?vue&type=template&id=1a6ff1df&":
/*!*******************************************************************************!*\
  !*** ./resources/js/pages/auth/SigninPage.vue?vue&type=template&id=1a6ff1df& ***!
  \*******************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "render": function() { return /* reexport safe */ _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_SigninPage_vue_vue_type_template_id_1a6ff1df___WEBPACK_IMPORTED_MODULE_0__.render; },
/* harmony export */   "staticRenderFns": function() { return /* reexport safe */ _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_SigninPage_vue_vue_type_template_id_1a6ff1df___WEBPACK_IMPORTED_MODULE_0__.staticRenderFns; }
/* harmony export */ });
/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_SigninPage_vue_vue_type_template_id_1a6ff1df___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./SigninPage.vue?vue&type=template&id=1a6ff1df& */ "./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/pages/auth/SigninPage.vue?vue&type=template&id=1a6ff1df&");


/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/pages/auth/SigninPage.vue?vue&type=template&id=1a6ff1df&":
/*!**********************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/pages/auth/SigninPage.vue?vue&type=template&id=1a6ff1df& ***!
  \**********************************************************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "render": function() { return /* binding */ render; },
/* harmony export */   "staticRenderFns": function() { return /* binding */ staticRenderFns; }
/* harmony export */ });
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
            _vm._v("Inicia Sesión")
          ]),
          _vm._v(" "),
          _c("v-card-subtitle", [
            _vm._v("Ingresa tu usuario y contraseña para iniciar sesión")
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
                      rules: _vm.emailRules,
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
                        return _vm.submit.apply(null, arguments)
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
                        return _vm.submit.apply(null, arguments)
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
                  _vm.errorProvider
                    ? _c("div", { staticClass: "error--text" }, [
                        _vm._v(_vm._s(_vm.errorProviderMessages))
                      ])
                    : _vm._e()
                ],
                1
              )
            ],
            1
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



/***/ })

}]);