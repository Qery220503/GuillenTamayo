(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["users-edit"],{

/***/ "./node_modules/babel-loader/lib/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/components/common/CopyLabel.vue?vue&type=script&lang=js&":
/*!***************************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib??ref--4-0!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/components/common/CopyLabel.vue?vue&type=script&lang=js& ***!
  \***************************************************************************************************************************************************************************/
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

/*
|---------------------------------------------------------------------
| Copy Label Component
|---------------------------------------------------------------------
|
| Copy to clipboard with the plugin clipboard `this.$clipboard`
|
*/
/* harmony default export */ __webpack_exports__["default"] = ({
  props: {
    // Text to copy to clipboard
    text: {
      type: String,
      "default": ''
    },
    // Text to show on toast
    toastText: {
      type: String,
      "default": 'Copied to clipboard!'
    },

    /**
     * CSS animation with animate.css
     * https://animate.style/
     */
    animation: {
      type: String,
      "default": 'heartBeat'
    }
  },
  data: function data() {
    return {
      tooltip: 'Copy',
      timeout: null
    };
  },
  beforeDestroy: function beforeDestroy() {
    if (this.timeout) clearTimeout(this.timeout);
  },
  methods: {
    copy: function copy() {
      var _this = this;

      this.$animate(this.$refs.copylabel, this.animation);
      this.$clipboard(this.text, this.toastText);
      this.tooltip = 'Copied!';
      this.timeout = setTimeout(function () {
        _this.tooltip = 'Copy';
      }, 2000);
    }
  }
});

/***/ }),

/***/ "./node_modules/babel-loader/lib/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/users/EditUser/AccountTab.vue?vue&type=script&lang=js&":
/*!*******************************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib??ref--4-0!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/pages/users/EditUser/AccountTab.vue?vue&type=script&lang=js& ***!
  \*******************************************************************************************************************************************************************************/
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
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
/* harmony default export */ __webpack_exports__["default"] = ({
  props: {
    user: {
      type: Object,
      "default": function _default() {
        return {};
      }
    }
  },
  data: function data() {
    return {
      panel: [1],
      deleteDialog: false,
      disableDialog: false
    };
  }
});

/***/ }),

/***/ "./node_modules/babel-loader/lib/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/users/EditUser/InformationTab.vue?vue&type=script&lang=js&":
/*!***********************************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib??ref--4-0!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/pages/users/EditUser/InformationTab.vue?vue&type=script&lang=js& ***!
  \***********************************************************************************************************************************************************************************/
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
/* harmony default export */ __webpack_exports__["default"] = ({
  data: function data() {
    return {
      date: '1990-10-09',
      menu: false,
      gender: 'male'
    };
  },
  watch: {
    menu: function menu(val) {
      var _this = this;

      val && setTimeout(function () {
        return _this.$refs.picker.activePicker = 'YEAR';
      });
    }
  },
  methods: {
    save: function save(date) {
      this.$refs.menu.save(date);
    }
  }
});

/***/ }),

/***/ "./node_modules/babel-loader/lib/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/users/EditUserPage.vue?vue&type=script&lang=js&":
/*!************************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib??ref--4-0!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/pages/users/EditUserPage.vue?vue&type=script&lang=js& ***!
  \************************************************************************************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _components_common_CopyLabel__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../components/common/CopyLabel */ "./resources/js/components/common/CopyLabel.vue");
/* harmony import */ var _EditUser_AccountTab__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./EditUser/AccountTab */ "./resources/js/pages/users/EditUser/AccountTab.vue");
/* harmony import */ var _EditUser_InformationTab__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./EditUser/InformationTab */ "./resources/js/pages/users/EditUser/InformationTab.vue");
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//



/* harmony default export */ __webpack_exports__["default"] = ({
  components: {
    CopyLabel: _components_common_CopyLabel__WEBPACK_IMPORTED_MODULE_0__["default"],
    AccountTab: _EditUser_AccountTab__WEBPACK_IMPORTED_MODULE_1__["default"],
    InformationTab: _EditUser_InformationTab__WEBPACK_IMPORTED_MODULE_2__["default"]
  },
  data: function data() {
    return {
      user: {
        'id': 32,
        'email': 'bfitchew0@ezinearticles.com',
        'name': 'Bartel Fitchew',
        'verified': false,
        'created': '2019-08-09T03:14:12Z',
        'lastSignIn': '2019-08-14T20:00:53Z',
        'disabled': true,
        'role': 'ADMIN',
        'avatar': '/images/avatars/avatar1.svg'
      },
      tab: null,
      breadcrumbs: [{
        text: 'Users',
        to: '/users/list',
        exact: true
      }, {
        text: 'Edit User'
      }]
    };
  }
});

/***/ }),

/***/ "./node_modules/css-loader/dist/cjs.js?!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/postcss-loader/src/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/components/common/CopyLabel.vue?vue&type=style&index=0&id=da7723f4&scoped=true&lang=css&":
/*!**********************************************************************************************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/css-loader/dist/cjs.js??ref--6-1!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/postcss-loader/src??ref--6-2!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/components/common/CopyLabel.vue?vue&type=style&index=0&id=da7723f4&scoped=true&lang=css& ***!
  \**********************************************************************************************************************************************************************************************************************************************************************************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

// Imports
var ___CSS_LOADER_API_IMPORT___ = __webpack_require__(/*! ../../../../node_modules/css-loader/dist/runtime/api.js */ "./node_modules/css-loader/dist/runtime/api.js");
exports = ___CSS_LOADER_API_IMPORT___(false);
// Module
exports.push([module.i, "\n.copylabel[data-v-da7723f4] {\n  cursor: pointer;\n  display: inline-block;\n  border-bottom: 1px dashed;\n}\n", ""]);
// Exports
module.exports = exports;


/***/ }),

/***/ "./node_modules/style-loader/index.js!./node_modules/css-loader/dist/cjs.js?!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/postcss-loader/src/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/components/common/CopyLabel.vue?vue&type=style&index=0&id=da7723f4&scoped=true&lang=css&":
/*!**************************************************************************************************************************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/style-loader!./node_modules/css-loader/dist/cjs.js??ref--6-1!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/postcss-loader/src??ref--6-2!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/components/common/CopyLabel.vue?vue&type=style&index=0&id=da7723f4&scoped=true&lang=css& ***!
  \**************************************************************************************************************************************************************************************************************************************************************************************************************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {


var content = __webpack_require__(/*! !../../../../node_modules/css-loader/dist/cjs.js??ref--6-1!../../../../node_modules/vue-loader/lib/loaders/stylePostLoader.js!../../../../node_modules/postcss-loader/src??ref--6-2!../../../../node_modules/vue-loader/lib??vue-loader-options!./CopyLabel.vue?vue&type=style&index=0&id=da7723f4&scoped=true&lang=css& */ "./node_modules/css-loader/dist/cjs.js?!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/postcss-loader/src/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/components/common/CopyLabel.vue?vue&type=style&index=0&id=da7723f4&scoped=true&lang=css&");

if(typeof content === 'string') content = [[module.i, content, '']];

var transform;
var insertInto;



var options = {"hmr":true}

options.transform = transform
options.insertInto = undefined;

var update = __webpack_require__(/*! ../../../../node_modules/style-loader/lib/addStyles.js */ "./node_modules/style-loader/lib/addStyles.js")(content, options);

if(content.locals) module.exports = content.locals;

if(false) {}

/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/components/common/CopyLabel.vue?vue&type=template&id=da7723f4&scoped=true&":
/*!*******************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/components/common/CopyLabel.vue?vue&type=template&id=da7723f4&scoped=true& ***!
  \*******************************************************************************************************************************************************************************************************************************/
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
    "v-tooltip",
    {
      attrs: { bottom: "" },
      scopedSlots: _vm._u([
        {
          key: "activator",
          fn: function(ref) {
            var on = ref.on
            return [
              _c(
                "div",
                _vm._g(
                  {
                    ref: "copylabel",
                    staticClass: "copylabel animate__faster",
                    on: {
                      click: function($event) {
                        $event.stopPropagation()
                        $event.preventDefault()
                        return _vm.copy($event)
                      }
                    }
                  },
                  on
                ),
                [_vm._v(_vm._s(_vm.text))]
              )
            ]
          }
        }
      ])
    },
    [_vm._v(" "), _c("span", [_vm._v(_vm._s(_vm.tooltip))])]
  )
}
var staticRenderFns = []
render._withStripped = true



/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/users/EditUser/AccountTab.vue?vue&type=template&id=1d3e3e62&":
/*!***********************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/pages/users/EditUser/AccountTab.vue?vue&type=template&id=1d3e3e62& ***!
  \***********************************************************************************************************************************************************************************************************************/
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
    { staticClass: "my-2" },
    [
      _c(
        "div",
        [
          _vm.user.disabled
            ? _c(
                "v-card",
                { staticClass: "warning mb-4", attrs: { light: "" } },
                [
                  _c("v-card-title", [_vm._v("User Disabled")]),
                  _vm._v(" "),
                  _c("v-card-subtitle", [
                    _vm._v(
                      "This user has been disabled! Login accesss has been revoked."
                    )
                  ]),
                  _vm._v(" "),
                  _c(
                    "v-card-text",
                    [
                      _c(
                        "v-btn",
                        {
                          attrs: { dark: "" },
                          on: {
                            click: function($event) {
                              _vm.user.disabled = false
                            }
                          }
                        },
                        [
                          _c("v-icon", { attrs: { left: "", small: "" } }, [
                            _vm._v("mdi-account-check")
                          ]),
                          _vm._v("Enable User\n        ")
                        ],
                        1
                      )
                    ],
                    1
                  )
                ],
                1
              )
            : _vm._e(),
          _vm._v(" "),
          _c(
            "v-card",
            [
              _c("v-card-title", [_vm._v("Basic Information")]),
              _vm._v(" "),
              _c("v-card-text", [
                _c("div", { staticClass: "d-flex flex-column flex-sm-row" }, [
                  _c(
                    "div",
                    [
                      _c("v-img", {
                        staticClass: "blue-grey lighten-4 rounded elevation-3",
                        attrs: {
                          src: _vm.user.avatar,
                          "aspect-ratio": "1",
                          "max-width": "90",
                          "max-height": "90"
                        }
                      }),
                      _vm._v(" "),
                      _c(
                        "v-btn",
                        { staticClass: "mt-1", attrs: { small: "" } },
                        [_vm._v("Edit Avatar")]
                      )
                    ],
                    1
                  ),
                  _vm._v(" "),
                  _c(
                    "div",
                    { staticClass: "flex-grow-1 pt-2 pa-sm-2" },
                    [
                      _c("v-text-field", {
                        attrs: { label: "Display name", placeholder: "name" },
                        model: {
                          value: _vm.user.name,
                          callback: function($$v) {
                            _vm.$set(_vm.user, "name", $$v)
                          },
                          expression: "user.name"
                        }
                      }),
                      _vm._v(" "),
                      _c("v-text-field", {
                        attrs: { label: "Email", "hide-details": "" },
                        model: {
                          value: _vm.user.email,
                          callback: function($$v) {
                            _vm.$set(_vm.user, "email", $$v)
                          },
                          expression: "user.email"
                        }
                      }),
                      _vm._v(" "),
                      _c(
                        "div",
                        { staticClass: "d-flex flex-column" },
                        [
                          _c("v-checkbox", {
                            attrs: { dense: "", label: "Email Verified" },
                            model: {
                              value: _vm.user.verified,
                              callback: function($$v) {
                                _vm.$set(_vm.user, "verified", $$v)
                              },
                              expression: "user.verified"
                            }
                          }),
                          _vm._v(" "),
                          _c(
                            "div",
                            [
                              !_vm.user.verified
                                ? _c(
                                    "v-btn",
                                    [
                                      _c(
                                        "v-icon",
                                        { attrs: { left: "", small: "" } },
                                        [_vm._v("mdi-email")]
                                      ),
                                      _vm._v(
                                        "Send Verification Email\n                "
                                      )
                                    ],
                                    1
                                  )
                                : _vm._e()
                            ],
                            1
                          )
                        ],
                        1
                      ),
                      _vm._v(" "),
                      _c(
                        "div",
                        { staticClass: "mt-2" },
                        [
                          _c(
                            "v-btn",
                            {
                              attrs: { color: "primary" },
                              on: { click: function($event) {} }
                            },
                            [_vm._v("Save")]
                          )
                        ],
                        1
                      )
                    ],
                    1
                  )
                ])
              ])
            ],
            1
          ),
          _vm._v(" "),
          _c(
            "v-expansion-panels",
            {
              staticClass: "mt-3",
              attrs: { multiple: "" },
              model: {
                value: _vm.panel,
                callback: function($$v) {
                  _vm.panel = $$v
                },
                expression: "panel"
              }
            },
            [
              _c(
                "v-expansion-panel",
                [
                  _c("v-expansion-panel-header", { staticClass: "title" }, [
                    _vm._v("Actions")
                  ]),
                  _vm._v(" "),
                  _c(
                    "v-expansion-panel-content",
                    [
                      _c(
                        "div",
                        { staticClass: "mb-2" },
                        [
                          _c("div", { staticClass: "title" }, [
                            _vm._v("Reset User Password")
                          ]),
                          _vm._v(" "),
                          _c("div", { staticClass: "subtitle mb-2" }, [
                            _vm._v("Sends a reset password email to the user.")
                          ]),
                          _vm._v(" "),
                          _c(
                            "v-btn",
                            {
                              staticClass: "mb-2",
                              on: { click: function($event) {} }
                            },
                            [
                              _c("v-icon", { attrs: { left: "", small: "" } }, [
                                _vm._v("mdi-email")
                              ]),
                              _vm._v("Send Reset Password Email\n            ")
                            ],
                            1
                          )
                        ],
                        1
                      ),
                      _vm._v(" "),
                      _c("v-divider"),
                      _vm._v(" "),
                      _c(
                        "div",
                        { staticClass: "my-2" },
                        [
                          _c("div", { staticClass: "title" }, [
                            _vm._v("Export Account Data")
                          ]),
                          _vm._v(" "),
                          _c("div", { staticClass: "subtitle mb-2" }, [
                            _vm._v(
                              "Export all the platform metadata for this user."
                            )
                          ]),
                          _vm._v(" "),
                          _c(
                            "v-btn",
                            { staticClass: "mb-2" },
                            [
                              _c("v-icon", { attrs: { left: "", small: "" } }, [
                                _vm._v("mdi-clipboard-account")
                              ]),
                              _vm._v("Export User Data\n            ")
                            ],
                            1
                          )
                        ],
                        1
                      ),
                      _vm._v(" "),
                      _c("v-divider"),
                      _vm._v(" "),
                      _c(
                        "div",
                        { staticClass: "my-2" },
                        [
                          _c("div", { staticClass: "error--text title" }, [
                            _vm._v("Danger Zone")
                          ]),
                          _vm._v(" "),
                          _c("div", { staticClass: "subtitle mb-2" }, [
                            _vm._v(
                              "Full administrator with access to this dashboard."
                            )
                          ]),
                          _vm._v(" "),
                          _c(
                            "div",
                            { staticClass: "my-2" },
                            [
                              _vm.user.role === "ADMIN"
                                ? _c(
                                    "v-btn",
                                    {
                                      attrs: { color: "primary" },
                                      on: {
                                        click: function($event) {
                                          _vm.user.role = "USER"
                                        }
                                      }
                                    },
                                    [
                                      _c(
                                        "v-icon",
                                        { attrs: { left: "", small: "" } },
                                        [_vm._v("mdi-security")]
                                      ),
                                      _vm._v(
                                        "Remove admin access\n              "
                                      )
                                    ],
                                    1
                                  )
                                : _c(
                                    "v-btn",
                                    {
                                      attrs: { color: "primary" },
                                      on: {
                                        click: function($event) {
                                          _vm.user.role = "ADMIN"
                                        }
                                      }
                                    },
                                    [
                                      _c(
                                        "v-icon",
                                        { attrs: { left: "", small: "" } },
                                        [_vm._v("mdi-security")]
                                      ),
                                      _vm._v(
                                        "Set User as Admin\n              "
                                      )
                                    ],
                                    1
                                  )
                            ],
                            1
                          ),
                          _vm._v(" "),
                          _c("v-divider"),
                          _vm._v(" "),
                          _c("div", { staticClass: "subtitle mt-3 mb-2" }, [
                            _vm._v(
                              "Prevent the user from signing in on the platform."
                            )
                          ]),
                          _vm._v(" "),
                          _c(
                            "div",
                            { staticClass: "my-2" },
                            [
                              _vm.user.disabled
                                ? _c(
                                    "v-btn",
                                    {
                                      attrs: { color: "warning" },
                                      on: {
                                        click: function($event) {
                                          _vm.user.disabled = false
                                        }
                                      }
                                    },
                                    [
                                      _c(
                                        "v-icon",
                                        { attrs: { left: "", small: "" } },
                                        [_vm._v("mdi-account-check")]
                                      ),
                                      _vm._v("Enable User\n              ")
                                    ],
                                    1
                                  )
                                : _c(
                                    "v-btn",
                                    {
                                      attrs: { color: "warning" },
                                      on: {
                                        click: function($event) {
                                          _vm.disableDialog = true
                                        }
                                      }
                                    },
                                    [
                                      _c(
                                        "v-icon",
                                        { attrs: { left: "", small: "" } },
                                        [_vm._v("mdi-cancel")]
                                      ),
                                      _vm._v("Disable User\n              ")
                                    ],
                                    1
                                  )
                            ],
                            1
                          ),
                          _vm._v(" "),
                          _c("v-divider"),
                          _vm._v(" "),
                          _c("div", { staticClass: "subtitle mt-3 mb-2" }, [
                            _vm._v(
                              "To delete the user please transfer ownership or delete user's subscriptions."
                            )
                          ]),
                          _vm._v(" "),
                          _c(
                            "v-btn",
                            {
                              attrs: { color: "error" },
                              on: {
                                click: function($event) {
                                  _vm.deleteDialog = true
                                }
                              }
                            },
                            [
                              _c("v-icon", { attrs: { left: "", small: "" } }, [
                                _vm._v("mdi-delete")
                              ]),
                              _vm._v("Delete User\n            ")
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
              ),
              _vm._v(" "),
              _c(
                "v-expansion-panel",
                [
                  _c("v-expansion-panel-header", { staticClass: "title" }, [
                    _vm._v("Metadata")
                  ]),
                  _vm._v(" "),
                  _c("v-expansion-panel-content", { staticClass: "body-2" }, [
                    _c("span", { staticClass: "font-weight-bold" }, [
                      _vm._v("Created")
                    ]),
                    _vm._v(
                      "\n          " +
                        _vm._s(_vm._f("formatDate")(_vm.user.created, "lll")) +
                        "\n          "
                    ),
                    _c("br"),
                    _vm._v(" "),
                    _c("span", { staticClass: "font-weight-bold" }, [
                      _vm._v("Last Sign In")
                    ]),
                    _vm._v(
                      "\n          " +
                        _vm._s(
                          _vm._f("formatDate")(_vm.user.lastSignIn, "lll")
                        ) +
                        "\n        "
                    )
                  ])
                ],
                1
              ),
              _vm._v(" "),
              _c(
                "v-expansion-panel",
                [
                  _c("v-expansion-panel-header", { staticClass: "title" }, [
                    _vm._v("Raw Data")
                  ]),
                  _vm._v(" "),
                  _c("v-expansion-panel-content", [
                    _c("pre", { staticClass: "body-2" }, [
                      _vm._v(_vm._s(_vm.user))
                    ])
                  ])
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
        "v-dialog",
        {
          attrs: { "max-width": "290" },
          model: {
            value: _vm.disableDialog,
            callback: function($$v) {
              _vm.disableDialog = $$v
            },
            expression: "disableDialog"
          }
        },
        [
          _c(
            "v-card",
            [
              _c("v-card-title", { staticClass: "headline" }, [
                _vm._v("Disable User")
              ]),
              _vm._v(" "),
              _c("v-card-text", [
                _vm._v("Are you sure you want to disable this user?")
              ]),
              _vm._v(" "),
              _c(
                "v-card-actions",
                [
                  _c("v-spacer"),
                  _vm._v(" "),
                  _c(
                    "v-btn",
                    {
                      on: {
                        click: function($event) {
                          _vm.disableDialog = false
                        }
                      }
                    },
                    [_vm._v("Cancel")]
                  ),
                  _vm._v(" "),
                  _c(
                    "v-btn",
                    {
                      attrs: { color: "warning" },
                      on: {
                        click: function($event) {
                          _vm.user.disabled = true
                          _vm.disableDialog = false
                        }
                      }
                    },
                    [_vm._v("Disable")]
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
        "v-dialog",
        {
          attrs: { "max-width": "290" },
          model: {
            value: _vm.deleteDialog,
            callback: function($$v) {
              _vm.deleteDialog = $$v
            },
            expression: "deleteDialog"
          }
        },
        [
          _c(
            "v-card",
            [
              _c("v-card-title", { staticClass: "headline" }, [
                _vm._v("Delete User")
              ]),
              _vm._v(" "),
              _c("v-card-text", [
                _vm._v("Are you sure you want to delete this user?")
              ]),
              _vm._v(" "),
              _c(
                "v-card-actions",
                [
                  _c("v-spacer"),
                  _vm._v(" "),
                  _c(
                    "v-btn",
                    {
                      on: {
                        click: function($event) {
                          _vm.deleteDialog = false
                        }
                      }
                    },
                    [_vm._v("Cancel")]
                  ),
                  _vm._v(" "),
                  _c(
                    "v-btn",
                    {
                      attrs: { color: "error" },
                      on: {
                        click: function($event) {
                          _vm.deleteDialog = false
                        }
                      }
                    },
                    [_vm._v("Delete")]
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
    ],
    1
  )
}
var staticRenderFns = []
render._withStripped = true



/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/users/EditUser/InformationTab.vue?vue&type=template&id=6d782583&":
/*!***************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/pages/users/EditUser/InformationTab.vue?vue&type=template&id=6d782583& ***!
  \***************************************************************************************************************************************************************************************************************************/
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
    { staticClass: "my-2" },
    [
      _c("v-card-title", [_vm._v("User Information")]),
      _vm._v(" "),
      _c(
        "v-card-text",
        [
          _c(
            "v-form",
            [
              _c(
                "v-row",
                [
                  _c(
                    "v-col",
                    { attrs: { cols: "12", md: "6" } },
                    [
                      _c("v-text-field", {
                        attrs: {
                          value: "First and two on el street",
                          label: "Address Line 1"
                        }
                      }),
                      _vm._v(" "),
                      _c("v-text-field", {
                        attrs: { value: "", label: "Address Line 2" }
                      }),
                      _vm._v(" "),
                      _c("v-text-field", {
                        attrs: { value: "1231", label: "Zip Code" }
                      }),
                      _vm._v(" "),
                      _c("v-text-field", {
                        attrs: { value: "Los Angeles", label: "City" }
                      }),
                      _vm._v(" "),
                      _c("v-text-field", {
                        attrs: { value: "California", label: "State" }
                      }),
                      _vm._v(" "),
                      _c("v-text-field", {
                        attrs: { value: "United States", label: "Country" }
                      })
                    ],
                    1
                  ),
                  _vm._v(" "),
                  _c(
                    "v-col",
                    { attrs: { cols: "12", md: "6" } },
                    [
                      _c("v-text-field", {
                        attrs: { value: "+8484548112", label: "Phone" }
                      }),
                      _vm._v(" "),
                      _c(
                        "v-menu",
                        {
                          ref: "menu",
                          attrs: {
                            "close-on-content-click": false,
                            transition: "scale-transition",
                            "offset-y": "",
                            "min-width": "290px"
                          },
                          scopedSlots: _vm._u([
                            {
                              key: "activator",
                              fn: function(ref) {
                                var on = ref.on
                                var attrs = ref.attrs
                                return [
                                  _c(
                                    "v-text-field",
                                    _vm._g(
                                      _vm._b(
                                        {
                                          attrs: {
                                            label: "Birthday date",
                                            readonly: ""
                                          },
                                          model: {
                                            value: _vm.date,
                                            callback: function($$v) {
                                              _vm.date = $$v
                                            },
                                            expression: "date"
                                          }
                                        },
                                        "v-text-field",
                                        attrs,
                                        false
                                      ),
                                      on
                                    )
                                  )
                                ]
                              }
                            }
                          ]),
                          model: {
                            value: _vm.menu,
                            callback: function($$v) {
                              _vm.menu = $$v
                            },
                            expression: "menu"
                          }
                        },
                        [
                          _vm._v(" "),
                          _c("v-date-picker", {
                            ref: "picker",
                            attrs: {
                              max: new Date().toISOString().substr(0, 10),
                              min: "1950-01-01"
                            },
                            on: { change: _vm.save },
                            model: {
                              value: _vm.date,
                              callback: function($$v) {
                                _vm.date = $$v
                              },
                              expression: "date"
                            }
                          })
                        ],
                        1
                      ),
                      _vm._v(" "),
                      _c("v-text-field", {
                        attrs: { value: "https://", label: "Website" }
                      }),
                      _vm._v(" "),
                      _c(
                        "v-radio-group",
                        {
                          attrs: { label: "Gender" },
                          model: {
                            value: _vm.gender,
                            callback: function($$v) {
                              _vm.gender = $$v
                            },
                            expression: "gender"
                          }
                        },
                        [
                          _c("v-radio", {
                            attrs: { label: "Male", value: "male" }
                          }),
                          _vm._v(" "),
                          _c("v-radio", {
                            attrs: { label: "Female", value: "female" }
                          }),
                          _vm._v(" "),
                          _c("v-radio", {
                            attrs: { label: "Other", value: "other" }
                          })
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
                { staticClass: "d-flex" },
                [
                  _c("v-btn", [_vm._v("Reset")]),
                  _vm._v(" "),
                  _c("v-spacer"),
                  _vm._v(" "),
                  _c("v-btn", { attrs: { color: "primary" } }, [_vm._v("Save")])
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



/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/users/EditUserPage.vue?vue&type=template&id=0c7a0994&":
/*!****************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/pages/users/EditUserPage.vue?vue&type=template&id=0c7a0994& ***!
  \****************************************************************************************************************************************************************************************************************/
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
    { staticClass: "flex-grow-1" },
    [
      _c(
        "div",
        { staticClass: "d-flex align-center py-3" },
        [
          _c(
            "div",
            [
              _c("div", { staticClass: "display-1" }, [
                _vm._v(
                  "Edit User " + _vm._s(_vm.user.name && "- " + _vm.user.name)
                )
              ]),
              _vm._v(" "),
              _c("v-breadcrumbs", {
                staticClass: "pa-0 py-2",
                attrs: { items: _vm.breadcrumbs }
              })
            ],
            1
          ),
          _vm._v(" "),
          _c("v-spacer"),
          _vm._v(" "),
          _c(
            "v-btn",
            { attrs: { icon: "" }, on: { click: function($event) {} } },
            [_c("v-icon", [_vm._v("mdi-refresh")])],
            1
          )
        ],
        1
      ),
      _vm._v(" "),
      _vm.user.role === "ADMIN"
        ? _c(
            "div",
            {
              staticClass:
                "d-flex align-center font-weight-bold primary--text my-2"
            },
            [
              _c("v-icon", { attrs: { small: "", color: "primary" } }, [
                _vm._v("mdi-security")
              ]),
              _vm._v(" "),
              _c("span", { staticClass: "ma-1" }, [_vm._v("Administrator")])
            ],
            1
          )
        : _vm._e(),
      _vm._v(" "),
      _c("div", { staticClass: "mb-4" }, [
        _c("div", { staticClass: "d-flex" }, [
          _c("span", { staticClass: "font-weight-bold" }, [_vm._v("Email")]),
          _vm._v(" "),
          _c(
            "span",
            { staticClass: "mx-1" },
            [_c("copy-label", { attrs: { text: _vm.user.email } })],
            1
          )
        ]),
        _vm._v(" "),
        _c("div", { staticClass: "d-flex" }, [
          _c("span", { staticClass: "font-weight-bold" }, [_vm._v("ID")]),
          _vm._v(" "),
          _c(
            "span",
            { staticClass: "mx-1" },
            [_c("copy-label", { attrs: { text: _vm.user.id + "" } })],
            1
          )
        ])
      ]),
      _vm._v(" "),
      _c(
        "v-tabs",
        {
          attrs: { "show-arrows": false, "background-color": "transparent" },
          model: {
            value: _vm.tab,
            callback: function($$v) {
              _vm.tab = $$v
            },
            expression: "tab"
          }
        },
        [
          _c("v-tab", { attrs: { to: "#tabs-account" } }, [_vm._v("Account")]),
          _vm._v(" "),
          _c("v-tab", { attrs: { to: "#tabs-information" } }, [
            _vm._v("Information")
          ])
        ],
        1
      ),
      _vm._v(" "),
      _c(
        "v-tabs-items",
        {
          model: {
            value: _vm.tab,
            callback: function($$v) {
              _vm.tab = $$v
            },
            expression: "tab"
          }
        },
        [
          _c(
            "v-tab-item",
            { attrs: { value: "tabs-account" } },
            [
              _c("account-tab", {
                ref: "tabs-account",
                attrs: { user: _vm.user }
              })
            ],
            1
          ),
          _vm._v(" "),
          _c(
            "v-tab-item",
            { attrs: { value: "tabs-information" } },
            [
              _c("information-tab", {
                ref: "tabs-information",
                attrs: { user: _vm.user }
              })
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



/***/ }),

/***/ "./resources/js/components/common/CopyLabel.vue":
/*!******************************************************!*\
  !*** ./resources/js/components/common/CopyLabel.vue ***!
  \******************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _CopyLabel_vue_vue_type_template_id_da7723f4_scoped_true___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./CopyLabel.vue?vue&type=template&id=da7723f4&scoped=true& */ "./resources/js/components/common/CopyLabel.vue?vue&type=template&id=da7723f4&scoped=true&");
/* harmony import */ var _CopyLabel_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./CopyLabel.vue?vue&type=script&lang=js& */ "./resources/js/components/common/CopyLabel.vue?vue&type=script&lang=js&");
/* empty/unused harmony star reexport *//* harmony import */ var _CopyLabel_vue_vue_type_style_index_0_id_da7723f4_scoped_true_lang_css___WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./CopyLabel.vue?vue&type=style&index=0&id=da7723f4&scoped=true&lang=css& */ "./resources/js/components/common/CopyLabel.vue?vue&type=style&index=0&id=da7723f4&scoped=true&lang=css&");
/* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ "./node_modules/vue-loader/lib/runtime/componentNormalizer.js");






/* normalize component */

var component = Object(_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_3__["default"])(
  _CopyLabel_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__["default"],
  _CopyLabel_vue_vue_type_template_id_da7723f4_scoped_true___WEBPACK_IMPORTED_MODULE_0__["render"],
  _CopyLabel_vue_vue_type_template_id_da7723f4_scoped_true___WEBPACK_IMPORTED_MODULE_0__["staticRenderFns"],
  false,
  null,
  "da7723f4",
  null
  
)

/* hot reload */
if (false) { var api; }
component.options.__file = "resources/js/components/common/CopyLabel.vue"
/* harmony default export */ __webpack_exports__["default"] = (component.exports);

/***/ }),

/***/ "./resources/js/components/common/CopyLabel.vue?vue&type=script&lang=js&":
/*!*******************************************************************************!*\
  !*** ./resources/js/components/common/CopyLabel.vue?vue&type=script&lang=js& ***!
  \*******************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_babel_loader_lib_index_js_ref_4_0_node_modules_vue_loader_lib_index_js_vue_loader_options_CopyLabel_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/babel-loader/lib??ref--4-0!../../../../node_modules/vue-loader/lib??vue-loader-options!./CopyLabel.vue?vue&type=script&lang=js& */ "./node_modules/babel-loader/lib/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/components/common/CopyLabel.vue?vue&type=script&lang=js&");
/* empty/unused harmony star reexport */ /* harmony default export */ __webpack_exports__["default"] = (_node_modules_babel_loader_lib_index_js_ref_4_0_node_modules_vue_loader_lib_index_js_vue_loader_options_CopyLabel_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__["default"]); 

/***/ }),

/***/ "./resources/js/components/common/CopyLabel.vue?vue&type=style&index=0&id=da7723f4&scoped=true&lang=css&":
/*!***************************************************************************************************************!*\
  !*** ./resources/js/components/common/CopyLabel.vue?vue&type=style&index=0&id=da7723f4&scoped=true&lang=css& ***!
  \***************************************************************************************************************/
/*! no static exports found */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_style_loader_index_js_node_modules_css_loader_dist_cjs_js_ref_6_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_postcss_loader_src_index_js_ref_6_2_node_modules_vue_loader_lib_index_js_vue_loader_options_CopyLabel_vue_vue_type_style_index_0_id_da7723f4_scoped_true_lang_css___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/style-loader!../../../../node_modules/css-loader/dist/cjs.js??ref--6-1!../../../../node_modules/vue-loader/lib/loaders/stylePostLoader.js!../../../../node_modules/postcss-loader/src??ref--6-2!../../../../node_modules/vue-loader/lib??vue-loader-options!./CopyLabel.vue?vue&type=style&index=0&id=da7723f4&scoped=true&lang=css& */ "./node_modules/style-loader/index.js!./node_modules/css-loader/dist/cjs.js?!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/postcss-loader/src/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/components/common/CopyLabel.vue?vue&type=style&index=0&id=da7723f4&scoped=true&lang=css&");
/* harmony import */ var _node_modules_style_loader_index_js_node_modules_css_loader_dist_cjs_js_ref_6_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_postcss_loader_src_index_js_ref_6_2_node_modules_vue_loader_lib_index_js_vue_loader_options_CopyLabel_vue_vue_type_style_index_0_id_da7723f4_scoped_true_lang_css___WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_node_modules_style_loader_index_js_node_modules_css_loader_dist_cjs_js_ref_6_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_postcss_loader_src_index_js_ref_6_2_node_modules_vue_loader_lib_index_js_vue_loader_options_CopyLabel_vue_vue_type_style_index_0_id_da7723f4_scoped_true_lang_css___WEBPACK_IMPORTED_MODULE_0__);
/* harmony reexport (unknown) */ for(var __WEBPACK_IMPORT_KEY__ in _node_modules_style_loader_index_js_node_modules_css_loader_dist_cjs_js_ref_6_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_postcss_loader_src_index_js_ref_6_2_node_modules_vue_loader_lib_index_js_vue_loader_options_CopyLabel_vue_vue_type_style_index_0_id_da7723f4_scoped_true_lang_css___WEBPACK_IMPORTED_MODULE_0__) if(["default"].indexOf(__WEBPACK_IMPORT_KEY__) < 0) (function(key) { __webpack_require__.d(__webpack_exports__, key, function() { return _node_modules_style_loader_index_js_node_modules_css_loader_dist_cjs_js_ref_6_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_postcss_loader_src_index_js_ref_6_2_node_modules_vue_loader_lib_index_js_vue_loader_options_CopyLabel_vue_vue_type_style_index_0_id_da7723f4_scoped_true_lang_css___WEBPACK_IMPORTED_MODULE_0__[key]; }) }(__WEBPACK_IMPORT_KEY__));


/***/ }),

/***/ "./resources/js/components/common/CopyLabel.vue?vue&type=template&id=da7723f4&scoped=true&":
/*!*************************************************************************************************!*\
  !*** ./resources/js/components/common/CopyLabel.vue?vue&type=template&id=da7723f4&scoped=true& ***!
  \*************************************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_CopyLabel_vue_vue_type_template_id_da7723f4_scoped_true___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../node_modules/vue-loader/lib??vue-loader-options!./CopyLabel.vue?vue&type=template&id=da7723f4&scoped=true& */ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/components/common/CopyLabel.vue?vue&type=template&id=da7723f4&scoped=true&");
/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "render", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_CopyLabel_vue_vue_type_template_id_da7723f4_scoped_true___WEBPACK_IMPORTED_MODULE_0__["render"]; });

/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "staticRenderFns", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_CopyLabel_vue_vue_type_template_id_da7723f4_scoped_true___WEBPACK_IMPORTED_MODULE_0__["staticRenderFns"]; });



/***/ }),

/***/ "./resources/js/pages/users/EditUser/AccountTab.vue":
/*!**********************************************************!*\
  !*** ./resources/js/pages/users/EditUser/AccountTab.vue ***!
  \**********************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _AccountTab_vue_vue_type_template_id_1d3e3e62___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./AccountTab.vue?vue&type=template&id=1d3e3e62& */ "./resources/js/pages/users/EditUser/AccountTab.vue?vue&type=template&id=1d3e3e62&");
/* harmony import */ var _AccountTab_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./AccountTab.vue?vue&type=script&lang=js& */ "./resources/js/pages/users/EditUser/AccountTab.vue?vue&type=script&lang=js&");
/* empty/unused harmony star reexport *//* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ "./node_modules/vue-loader/lib/runtime/componentNormalizer.js");





/* normalize component */

var component = Object(_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__["default"])(
  _AccountTab_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__["default"],
  _AccountTab_vue_vue_type_template_id_1d3e3e62___WEBPACK_IMPORTED_MODULE_0__["render"],
  _AccountTab_vue_vue_type_template_id_1d3e3e62___WEBPACK_IMPORTED_MODULE_0__["staticRenderFns"],
  false,
  null,
  null,
  null
  
)

/* hot reload */
if (false) { var api; }
component.options.__file = "resources/js/pages/users/EditUser/AccountTab.vue"
/* harmony default export */ __webpack_exports__["default"] = (component.exports);

/***/ }),

/***/ "./resources/js/pages/users/EditUser/AccountTab.vue?vue&type=script&lang=js&":
/*!***********************************************************************************!*\
  !*** ./resources/js/pages/users/EditUser/AccountTab.vue?vue&type=script&lang=js& ***!
  \***********************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_babel_loader_lib_index_js_ref_4_0_node_modules_vue_loader_lib_index_js_vue_loader_options_AccountTab_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../../node_modules/babel-loader/lib??ref--4-0!../../../../../node_modules/vue-loader/lib??vue-loader-options!./AccountTab.vue?vue&type=script&lang=js& */ "./node_modules/babel-loader/lib/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/users/EditUser/AccountTab.vue?vue&type=script&lang=js&");
/* empty/unused harmony star reexport */ /* harmony default export */ __webpack_exports__["default"] = (_node_modules_babel_loader_lib_index_js_ref_4_0_node_modules_vue_loader_lib_index_js_vue_loader_options_AccountTab_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__["default"]); 

/***/ }),

/***/ "./resources/js/pages/users/EditUser/AccountTab.vue?vue&type=template&id=1d3e3e62&":
/*!*****************************************************************************************!*\
  !*** ./resources/js/pages/users/EditUser/AccountTab.vue?vue&type=template&id=1d3e3e62& ***!
  \*****************************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_AccountTab_vue_vue_type_template_id_1d3e3e62___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../../node_modules/vue-loader/lib??vue-loader-options!./AccountTab.vue?vue&type=template&id=1d3e3e62& */ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/users/EditUser/AccountTab.vue?vue&type=template&id=1d3e3e62&");
/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "render", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_AccountTab_vue_vue_type_template_id_1d3e3e62___WEBPACK_IMPORTED_MODULE_0__["render"]; });

/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "staticRenderFns", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_AccountTab_vue_vue_type_template_id_1d3e3e62___WEBPACK_IMPORTED_MODULE_0__["staticRenderFns"]; });



/***/ }),

/***/ "./resources/js/pages/users/EditUser/InformationTab.vue":
/*!**************************************************************!*\
  !*** ./resources/js/pages/users/EditUser/InformationTab.vue ***!
  \**************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _InformationTab_vue_vue_type_template_id_6d782583___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./InformationTab.vue?vue&type=template&id=6d782583& */ "./resources/js/pages/users/EditUser/InformationTab.vue?vue&type=template&id=6d782583&");
/* harmony import */ var _InformationTab_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./InformationTab.vue?vue&type=script&lang=js& */ "./resources/js/pages/users/EditUser/InformationTab.vue?vue&type=script&lang=js&");
/* empty/unused harmony star reexport *//* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ "./node_modules/vue-loader/lib/runtime/componentNormalizer.js");





/* normalize component */

var component = Object(_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__["default"])(
  _InformationTab_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__["default"],
  _InformationTab_vue_vue_type_template_id_6d782583___WEBPACK_IMPORTED_MODULE_0__["render"],
  _InformationTab_vue_vue_type_template_id_6d782583___WEBPACK_IMPORTED_MODULE_0__["staticRenderFns"],
  false,
  null,
  null,
  null
  
)

/* hot reload */
if (false) { var api; }
component.options.__file = "resources/js/pages/users/EditUser/InformationTab.vue"
/* harmony default export */ __webpack_exports__["default"] = (component.exports);

/***/ }),

/***/ "./resources/js/pages/users/EditUser/InformationTab.vue?vue&type=script&lang=js&":
/*!***************************************************************************************!*\
  !*** ./resources/js/pages/users/EditUser/InformationTab.vue?vue&type=script&lang=js& ***!
  \***************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_babel_loader_lib_index_js_ref_4_0_node_modules_vue_loader_lib_index_js_vue_loader_options_InformationTab_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../../node_modules/babel-loader/lib??ref--4-0!../../../../../node_modules/vue-loader/lib??vue-loader-options!./InformationTab.vue?vue&type=script&lang=js& */ "./node_modules/babel-loader/lib/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/users/EditUser/InformationTab.vue?vue&type=script&lang=js&");
/* empty/unused harmony star reexport */ /* harmony default export */ __webpack_exports__["default"] = (_node_modules_babel_loader_lib_index_js_ref_4_0_node_modules_vue_loader_lib_index_js_vue_loader_options_InformationTab_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__["default"]); 

/***/ }),

/***/ "./resources/js/pages/users/EditUser/InformationTab.vue?vue&type=template&id=6d782583&":
/*!*********************************************************************************************!*\
  !*** ./resources/js/pages/users/EditUser/InformationTab.vue?vue&type=template&id=6d782583& ***!
  \*********************************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_InformationTab_vue_vue_type_template_id_6d782583___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../../node_modules/vue-loader/lib??vue-loader-options!./InformationTab.vue?vue&type=template&id=6d782583& */ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/users/EditUser/InformationTab.vue?vue&type=template&id=6d782583&");
/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "render", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_InformationTab_vue_vue_type_template_id_6d782583___WEBPACK_IMPORTED_MODULE_0__["render"]; });

/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "staticRenderFns", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_InformationTab_vue_vue_type_template_id_6d782583___WEBPACK_IMPORTED_MODULE_0__["staticRenderFns"]; });



/***/ }),

/***/ "./resources/js/pages/users/EditUserPage.vue":
/*!***************************************************!*\
  !*** ./resources/js/pages/users/EditUserPage.vue ***!
  \***************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _EditUserPage_vue_vue_type_template_id_0c7a0994___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./EditUserPage.vue?vue&type=template&id=0c7a0994& */ "./resources/js/pages/users/EditUserPage.vue?vue&type=template&id=0c7a0994&");
/* harmony import */ var _EditUserPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./EditUserPage.vue?vue&type=script&lang=js& */ "./resources/js/pages/users/EditUserPage.vue?vue&type=script&lang=js&");
/* empty/unused harmony star reexport *//* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ "./node_modules/vue-loader/lib/runtime/componentNormalizer.js");





/* normalize component */

var component = Object(_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__["default"])(
  _EditUserPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__["default"],
  _EditUserPage_vue_vue_type_template_id_0c7a0994___WEBPACK_IMPORTED_MODULE_0__["render"],
  _EditUserPage_vue_vue_type_template_id_0c7a0994___WEBPACK_IMPORTED_MODULE_0__["staticRenderFns"],
  false,
  null,
  null,
  null
  
)

/* hot reload */
if (false) { var api; }
component.options.__file = "resources/js/pages/users/EditUserPage.vue"
/* harmony default export */ __webpack_exports__["default"] = (component.exports);

/***/ }),

/***/ "./resources/js/pages/users/EditUserPage.vue?vue&type=script&lang=js&":
/*!****************************************************************************!*\
  !*** ./resources/js/pages/users/EditUserPage.vue?vue&type=script&lang=js& ***!
  \****************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_babel_loader_lib_index_js_ref_4_0_node_modules_vue_loader_lib_index_js_vue_loader_options_EditUserPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/babel-loader/lib??ref--4-0!../../../../node_modules/vue-loader/lib??vue-loader-options!./EditUserPage.vue?vue&type=script&lang=js& */ "./node_modules/babel-loader/lib/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/users/EditUserPage.vue?vue&type=script&lang=js&");
/* empty/unused harmony star reexport */ /* harmony default export */ __webpack_exports__["default"] = (_node_modules_babel_loader_lib_index_js_ref_4_0_node_modules_vue_loader_lib_index_js_vue_loader_options_EditUserPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__["default"]); 

/***/ }),

/***/ "./resources/js/pages/users/EditUserPage.vue?vue&type=template&id=0c7a0994&":
/*!**********************************************************************************!*\
  !*** ./resources/js/pages/users/EditUserPage.vue?vue&type=template&id=0c7a0994& ***!
  \**********************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_EditUserPage_vue_vue_type_template_id_0c7a0994___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../node_modules/vue-loader/lib??vue-loader-options!./EditUserPage.vue?vue&type=template&id=0c7a0994& */ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/users/EditUserPage.vue?vue&type=template&id=0c7a0994&");
/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "render", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_EditUserPage_vue_vue_type_template_id_0c7a0994___WEBPACK_IMPORTED_MODULE_0__["render"]; });

/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "staticRenderFns", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_EditUserPage_vue_vue_type_template_id_0c7a0994___WEBPACK_IMPORTED_MODULE_0__["staticRenderFns"]; });



/***/ })

}]);