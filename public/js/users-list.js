(self["webpackChunk"] = self["webpackChunk"] || []).push([["users-list"],{

/***/ "./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/components/common/CopyLabel.vue?vue&type=script&lang=js&":
/*!***********************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/components/common/CopyLabel.vue?vue&type=script&lang=js& ***!
  \***********************************************************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

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

/***/ "./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/pages/users/UsersPage.vue?vue&type=script&lang=js&":
/*!*****************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/pages/users/UsersPage.vue?vue&type=script&lang=js& ***!
  \*****************************************************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _babel_runtime_regenerator__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @babel/runtime/regenerator */ "./node_modules/@babel/runtime/regenerator/index.js");
/* harmony import */ var _babel_runtime_regenerator__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_babel_runtime_regenerator__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var _components_common_CopyLabel__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../components/common/CopyLabel */ "./resources/js/components/common/CopyLabel.vue");
/* harmony import */ var vue_custom_scrollbar__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! vue-custom-scrollbar */ "./node_modules/vue-custom-scrollbar/dist/vueScrollbar.umd.min.js");
/* harmony import */ var vue_custom_scrollbar__WEBPACK_IMPORTED_MODULE_2___default = /*#__PURE__*/__webpack_require__.n(vue_custom_scrollbar__WEBPACK_IMPORTED_MODULE_2__);
/* harmony import */ var vue_custom_scrollbar_dist_vueScrollbar_css__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! vue-custom-scrollbar/dist/vueScrollbar.css */ "./node_modules/vue-custom-scrollbar/dist/vueScrollbar.css");


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
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
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
    CopyLabel: _components_common_CopyLabel__WEBPACK_IMPORTED_MODULE_1__.default,
    vueCustomScrollbar: (vue_custom_scrollbar__WEBPACK_IMPORTED_MODULE_2___default())
  },
  data: function data() {
    return {
      //Style
      settings: {
        suppressScrollY: false,
        suppressScrollX: false,
        wheelPropagation: true
      },
      breadcrumbs: [{
        text: "Inicio",
        disabled: false,
        href: "#"
      }, {
        text: "Usuarios"
      }],
      //Loading
      loading: true,
      isLoading: false,
      isLoadingModal: false,
      deleteDialog: false,
      iduser: "",
      //Data Table options
      searchQuery: "",
      selectedUsers: [],
      headers: [{
        text: "Nombre y Apellidos",
        align: "left",
        value: "name"
      }, {
        text: "Email",
        value: "email"
      }, {
        text: "Edad",
        value: "birthdate"
      }, {
        text: "País",
        value: "birthplace"
      }, {
        text: "Género",
        value: "gender"
      }, {
        text: "Promocode",
        value: "code"
      }, {
        text: "Estado",
        value: "status"
      }, {
        text: "Verificado",
        value: "email_verified_at"
      }, {
        text: "Acciones",
        sortable: false,
        align: "right",
        value: "action"
      }],
      users: {
        data: [],
        total: 0
      },
      options: {},
      searchData: {},
      groupid: [],
      urltoreturn: "api/exportar",
      itemsperpage: 25,
      selectAll: false,
      page: 1,
      deleteDialogText: null
    };
  },
  created: function created() {},
  watch: {
    selectedUsers: function selectedUsers(val) {
      this.exportGroup(); //Get ids selected users into array

      this.groupid = this.selectedUsers.map(function (_ref) {
        var id = _ref.id;
        return id;
      });
    },
    options: function options(event) {
      this.itemsperpage = event.itemsPerPage;
      this.getlist(event.page, event.itemsPerPage);
    }
  },
  mounted: function mounted() {// var x = document.getElementsByClassName("v-input__slot");
    // x[0].style.background = "#2b2d33"
  },
  methods: {
    open: function open() {},
    scrollHanle: function scrollHanle(evt) {
      console.log(evt);
    },
    //DATA TABLE EVENTS
    selectAllToggle: function selectAllToggle(props) {
      this.selectAll = props.value;
    },
    disabledialog: function disabledialog(iduser, user) {
      this.deleteDialogText = user;
      this.iduser = iduser;
      this.deleteDialog = true;
    },
    searchUser: function searchUser() {
      this.searchData = {
        data: this.searchQuery
      };
      this.users.data = [];
      this.users.total = 0;
      this.users.from = 0;
      this.users.to = 0;
      this.getlist(1, this.itemsperpage);
    },
    researchUser: function researchUser() {
      if (this.searchQuery.length == 0) {
        this.getlist(1, this.itemsperpage);
      }
    },
    calculateAge: function calculateAge(bd) {
      if (bd != null) {
        var today = new Date();
        var birthDate = new Date(bd);
        var age = today.getFullYear() - birthDate.getFullYear();
        var m = today.getMonth() - birthDate.getMonth();

        if (m < 0 || m === 0 && today.getDate() < birthDate.getDate()) {
          age = age - 1;
        }

        return age;
      } else {
        return 0;
      }
    },
    //ACTIONS
    getlist: function getlist(page, perpage) {
      var _this = this;

      return _asyncToGenerator( /*#__PURE__*/_babel_runtime_regenerator__WEBPACK_IMPORTED_MODULE_0___default().mark(function _callee() {
        var response;
        return _babel_runtime_regenerator__WEBPACK_IMPORTED_MODULE_0___default().wrap(function _callee$(_context) {
          while (1) {
            switch (_context.prev = _context.next) {
              case 0:
                _this.users.data = [];
                _this.users.total = 0;
                _this.loading = true;
                _this.searchData = {
                  perpage: perpage,
                  data: _this.searchQuery
                };
                _context.prev = 4;
                _context.next = 7;
                return API.users.list(page, _this.searchData);

              case 7:
                response = _context.sent;
                _this.users = response.data;
                _this.page = response.data.current_page;
                _this.loading = false;
                _context.next = 17;
                break;

              case 13:
                _context.prev = 13;
                _context.t0 = _context["catch"](4);
                _this.loading = false;
                console.error(_context.t0.response.status);

              case 17:
              case "end":
                return _context.stop();
            }
          }
        }, _callee, null, [[4, 13]]);
      }))();
    },
    remove: function remove() {
      var _this2 = this;

      return _asyncToGenerator( /*#__PURE__*/_babel_runtime_regenerator__WEBPACK_IMPORTED_MODULE_0___default().mark(function _callee2() {
        var response;
        return _babel_runtime_regenerator__WEBPACK_IMPORTED_MODULE_0___default().wrap(function _callee2$(_context2) {
          while (1) {
            switch (_context2.prev = _context2.next) {
              case 0:
                _this2.isLoading = true;
                _context2.prev = 1;
                _context2.next = 4;
                return API.users.remove(_this2.iduser);

              case 4:
                response = _context2.sent;
                _this2.message = response;
                _this2.deleteDialog = false;

                _this2.getlist(1, _this2.itemsperpage);

                _this2.isLoading = false;
                _this2.isLoadingModal = false;
                _context2.next = 16;
                break;

              case 12:
                _context2.prev = 12;
                _context2.t0 = _context2["catch"](1);
                _this2.isLoading = false;
                console.error(_context2.t0.response.status);

              case 16:
              case "end":
                return _context2.stop();
            }
          }
        }, _callee2, null, [[1, 12]]);
      }))();
    },
    //GROUP ACTIONS
    verifygroup: function verifygroup() {
      var _this3 = this;

      return _asyncToGenerator( /*#__PURE__*/_babel_runtime_regenerator__WEBPACK_IMPORTED_MODULE_0___default().mark(function _callee3() {
        var response;
        return _babel_runtime_regenerator__WEBPACK_IMPORTED_MODULE_0___default().wrap(function _callee3$(_context3) {
          while (1) {
            switch (_context3.prev = _context3.next) {
              case 0:
                _this3.loading = true;
                _context3.prev = 1;
                _context3.next = 4;
                return API.users.verifygroup({
                  groupid: _this3.groupid,
                  selectAll: _this3.selectAll
                });

              case 4:
                response = _context3.sent;

                _this3.getlist(1, _this3.itemsperpage);

                _this3.selectedUsers = [];
                _context3.next = 13;
                break;

              case 9:
                _context3.prev = 9;
                _context3.t0 = _context3["catch"](1);
                _this3.loading = false;
                console.error(_context3.t0.response.status);

              case 13:
              case "end":
                return _context3.stop();
            }
          }
        }, _callee3, null, [[1, 9]]);
      }))();
    },
    destroygroup: function destroygroup() {
      var _this4 = this;

      return _asyncToGenerator( /*#__PURE__*/_babel_runtime_regenerator__WEBPACK_IMPORTED_MODULE_0___default().mark(function _callee4() {
        var response;
        return _babel_runtime_regenerator__WEBPACK_IMPORTED_MODULE_0___default().wrap(function _callee4$(_context4) {
          while (1) {
            switch (_context4.prev = _context4.next) {
              case 0:
                _this4.loading = true;
                _context4.prev = 1;
                _context4.next = 4;
                return API.users.destroygroup({
                  groupid: _this4.groupid,
                  selectAll: _this4.selectAll
                });

              case 4:
                response = _context4.sent;

                _this4.getlist(1, _this4.itemsperpage);

                _this4.selectedUsers = [];
                _context4.next = 13;
                break;

              case 9:
                _context4.prev = 9;
                _context4.t0 = _context4["catch"](1);
                _this4.loading = false;
                console.error(_context4.t0.response.status);

              case 13:
              case "end":
                return _context4.stop();
            }
          }
        }, _callee4, null, [[1, 9]]);
      }))();
    },
    disablegroup: function disablegroup(status) {
      var _this5 = this;

      return _asyncToGenerator( /*#__PURE__*/_babel_runtime_regenerator__WEBPACK_IMPORTED_MODULE_0___default().mark(function _callee5() {
        var response;
        return _babel_runtime_regenerator__WEBPACK_IMPORTED_MODULE_0___default().wrap(function _callee5$(_context5) {
          while (1) {
            switch (_context5.prev = _context5.next) {
              case 0:
                _this5.loading = true;
                _context5.prev = 1;
                _context5.next = 4;
                return API.users.disablegroup({
                  groupid: _this5.groupid,
                  status: status,
                  selectAll: _this5.selectAll
                });

              case 4:
                response = _context5.sent;

                _this5.getlist(1, _this5.itemsperpage);

                _this5.selectedUsers = [];
                _context5.next = 13;
                break;

              case 9:
                _context5.prev = 9;
                _context5.t0 = _context5["catch"](1);
                _this5.loading = false;
                console.error(_context5.t0.response.status);

              case 13:
              case "end":
                return _context5.stop();
            }
          }
        }, _callee5, null, [[1, 9]]);
      }))();
    },
    exportGroup: function exportGroup() {
      this.urltoreturn = "/api/exportbyusers/" + JSON.stringify({
        groupid: this.groupid,
        selectAll: this.selectAll
      });
    }
  }
});

/***/ }),

/***/ "./node_modules/css-loader/dist/cjs.js??clonedRuleSet-12[0].rules[0].use[1]!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-12[0].rules[0].use[2]!./node_modules/sass-loader/dist/cjs.js??clonedRuleSet-12[0].rules[0].use[3]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/pages/users/UsersPage.vue?vue&type=style&index=0&id=652b1a12&lang=scss&scoped=true&":
/*!********************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/css-loader/dist/cjs.js??clonedRuleSet-12[0].rules[0].use[1]!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-12[0].rules[0].use[2]!./node_modules/sass-loader/dist/cjs.js??clonedRuleSet-12[0].rules[0].use[3]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/pages/users/UsersPage.vue?vue&type=style&index=0&id=652b1a12&lang=scss&scoped=true& ***!
  \********************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************/
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../../../node_modules/css-loader/dist/runtime/api.js */ "./node_modules/css-loader/dist/runtime/api.js");
/* harmony import */ var _node_modules_css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_node_modules_css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_0__);
// Imports

var ___CSS_LOADER_EXPORT___ = _node_modules_css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_0___default()(function(i){return i[1]});
// Module
___CSS_LOADER_EXPORT___.push([module.id, ".slide-fade-enter-active[data-v-652b1a12] {\n  transition: all 0.3s ease;\n}\n.slide-fade-leave-active[data-v-652b1a12] {\n  transition: all 0.3s cubic-bezier(1, 0.5, 0.8, 1);\n}\n.slide-fade-enter[data-v-652b1a12],\n.slide-fade-leave-to[data-v-652b1a12] {\n  transform: translateX(10px);\n  opacity: 0;\n}\n.v-input__slot[data-v-652b1a12] {\n  background: red;\n}", ""]);
// Exports
/* harmony default export */ __webpack_exports__["default"] = (___CSS_LOADER_EXPORT___);


/***/ }),

/***/ "./node_modules/css-loader/dist/cjs.js??clonedRuleSet-9[0].rules[0].use[1]!./node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-9[0].rules[0].use[2]!./node_modules/vue-custom-scrollbar/dist/vueScrollbar.css":
/*!*************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/css-loader/dist/cjs.js??clonedRuleSet-9[0].rules[0].use[1]!./node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-9[0].rules[0].use[2]!./node_modules/vue-custom-scrollbar/dist/vueScrollbar.css ***!
  \*************************************************************************************************************************************************************************************************************************/
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../css-loader/dist/runtime/api.js */ "./node_modules/css-loader/dist/runtime/api.js");
/* harmony import */ var _css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_0__);
// Imports

var ___CSS_LOADER_EXPORT___ = _css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_0___default()(function(i){return i[1]});
// Module
___CSS_LOADER_EXPORT___.push([module.id, ".ps{overflow:hidden!important;overflow-anchor:none;-ms-overflow-style:none;touch-action:auto;-ms-touch-action:auto}.ps__rail-x{height:15px;bottom:0}.ps__rail-x,.ps__rail-y{display:none;opacity:0;transition:background-color .2s linear,opacity .2s linear;-webkit-transition:background-color .2s linear,opacity .2s linear;position:absolute}.ps__rail-y{width:15px;right:0}.ps--active-x>.ps__rail-x,.ps--active-y>.ps__rail-y{display:block;background-color:transparent}.ps--focus>.ps__rail-x,.ps--focus>.ps__rail-y,.ps--scrolling-x>.ps__rail-x,.ps--scrolling-y>.ps__rail-y,.ps:hover>.ps__rail-x,.ps:hover>.ps__rail-y{opacity:.6}.ps .ps__rail-x.ps--clicking,.ps .ps__rail-x:focus,.ps .ps__rail-x:hover,.ps .ps__rail-y.ps--clicking,.ps .ps__rail-y:focus,.ps .ps__rail-y:hover{background-color:#eee;opacity:.9}.ps__thumb-x{transition:background-color .2s linear,height .2s ease-in-out;-webkit-transition:background-color .2s linear,height .2s ease-in-out;height:6px;bottom:2px}.ps__thumb-x,.ps__thumb-y{background-color:#aaa;border-radius:6px;position:absolute}.ps__thumb-y{transition:background-color .2s linear,width .2s ease-in-out;-webkit-transition:background-color .2s linear,width .2s ease-in-out;width:6px;right:2px}.ps__rail-x.ps--clicking .ps__thumb-x,.ps__rail-x:focus>.ps__thumb-x,.ps__rail-x:hover>.ps__thumb-x{background-color:#999;height:11px}.ps__rail-y.ps--clicking .ps__thumb-y,.ps__rail-y:focus>.ps__thumb-y,.ps__rail-y:hover>.ps__thumb-y{background-color:#999;width:11px}@supports (-ms-overflow-style:none){.ps{overflow:auto!important}}@media (-ms-high-contrast:none),screen and (-ms-high-contrast:active){.ps{overflow:auto!important}}.ps-container{position:relative}", ""]);
// Exports
/* harmony default export */ __webpack_exports__["default"] = (___CSS_LOADER_EXPORT___);


/***/ }),

/***/ "./node_modules/css-loader/dist/cjs.js??clonedRuleSet-9[0].rules[0].use[1]!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-9[0].rules[0].use[2]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/components/common/CopyLabel.vue?vue&type=style&index=0&id=da7723f4&scoped=true&lang=css&":
/*!*******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/css-loader/dist/cjs.js??clonedRuleSet-9[0].rules[0].use[1]!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-9[0].rules[0].use[2]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/components/common/CopyLabel.vue?vue&type=style&index=0&id=da7723f4&scoped=true&lang=css& ***!
  \*******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************/
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../../../node_modules/css-loader/dist/runtime/api.js */ "./node_modules/css-loader/dist/runtime/api.js");
/* harmony import */ var _node_modules_css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_node_modules_css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_0__);
// Imports

var ___CSS_LOADER_EXPORT___ = _node_modules_css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_0___default()(function(i){return i[1]});
// Module
___CSS_LOADER_EXPORT___.push([module.id, "\n.copylabel[data-v-da7723f4] {\r\n  cursor: pointer;\r\n  display: inline-block;\r\n  border-bottom: 1px dashed;\n}\r\n", ""]);
// Exports
/* harmony default export */ __webpack_exports__["default"] = (___CSS_LOADER_EXPORT___);


/***/ }),

/***/ "./node_modules/style-loader/dist/cjs.js!./node_modules/css-loader/dist/cjs.js??clonedRuleSet-12[0].rules[0].use[1]!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-12[0].rules[0].use[2]!./node_modules/sass-loader/dist/cjs.js??clonedRuleSet-12[0].rules[0].use[3]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/pages/users/UsersPage.vue?vue&type=style&index=0&id=652b1a12&lang=scss&scoped=true&":
/*!************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/style-loader/dist/cjs.js!./node_modules/css-loader/dist/cjs.js??clonedRuleSet-12[0].rules[0].use[1]!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-12[0].rules[0].use[2]!./node_modules/sass-loader/dist/cjs.js??clonedRuleSet-12[0].rules[0].use[3]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/pages/users/UsersPage.vue?vue&type=style&index=0&id=652b1a12&lang=scss&scoped=true& ***!
  \************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_style_loader_dist_runtime_injectStylesIntoStyleTag_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! !../../../../node_modules/style-loader/dist/runtime/injectStylesIntoStyleTag.js */ "./node_modules/style-loader/dist/runtime/injectStylesIntoStyleTag.js");
/* harmony import */ var _node_modules_style_loader_dist_runtime_injectStylesIntoStyleTag_js__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_node_modules_style_loader_dist_runtime_injectStylesIntoStyleTag_js__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var _node_modules_css_loader_dist_cjs_js_clonedRuleSet_12_0_rules_0_use_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_postcss_loader_dist_cjs_js_clonedRuleSet_12_0_rules_0_use_2_node_modules_sass_loader_dist_cjs_js_clonedRuleSet_12_0_rules_0_use_3_node_modules_vue_loader_lib_index_js_vue_loader_options_UsersPage_vue_vue_type_style_index_0_id_652b1a12_lang_scss_scoped_true___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! !!../../../../node_modules/css-loader/dist/cjs.js??clonedRuleSet-12[0].rules[0].use[1]!../../../../node_modules/vue-loader/lib/loaders/stylePostLoader.js!../../../../node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-12[0].rules[0].use[2]!../../../../node_modules/sass-loader/dist/cjs.js??clonedRuleSet-12[0].rules[0].use[3]!../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./UsersPage.vue?vue&type=style&index=0&id=652b1a12&lang=scss&scoped=true& */ "./node_modules/css-loader/dist/cjs.js??clonedRuleSet-12[0].rules[0].use[1]!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-12[0].rules[0].use[2]!./node_modules/sass-loader/dist/cjs.js??clonedRuleSet-12[0].rules[0].use[3]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/pages/users/UsersPage.vue?vue&type=style&index=0&id=652b1a12&lang=scss&scoped=true&");

            

var options = {};

options.insert = "head";
options.singleton = false;

var update = _node_modules_style_loader_dist_runtime_injectStylesIntoStyleTag_js__WEBPACK_IMPORTED_MODULE_0___default()(_node_modules_css_loader_dist_cjs_js_clonedRuleSet_12_0_rules_0_use_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_postcss_loader_dist_cjs_js_clonedRuleSet_12_0_rules_0_use_2_node_modules_sass_loader_dist_cjs_js_clonedRuleSet_12_0_rules_0_use_3_node_modules_vue_loader_lib_index_js_vue_loader_options_UsersPage_vue_vue_type_style_index_0_id_652b1a12_lang_scss_scoped_true___WEBPACK_IMPORTED_MODULE_1__.default, options);



/* harmony default export */ __webpack_exports__["default"] = (_node_modules_css_loader_dist_cjs_js_clonedRuleSet_12_0_rules_0_use_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_postcss_loader_dist_cjs_js_clonedRuleSet_12_0_rules_0_use_2_node_modules_sass_loader_dist_cjs_js_clonedRuleSet_12_0_rules_0_use_3_node_modules_vue_loader_lib_index_js_vue_loader_options_UsersPage_vue_vue_type_style_index_0_id_652b1a12_lang_scss_scoped_true___WEBPACK_IMPORTED_MODULE_1__.default.locals || {});

/***/ }),

/***/ "./node_modules/vue-custom-scrollbar/dist/vueScrollbar.css":
/*!*****************************************************************!*\
  !*** ./node_modules/vue-custom-scrollbar/dist/vueScrollbar.css ***!
  \*****************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _style_loader_dist_runtime_injectStylesIntoStyleTag_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! !../../style-loader/dist/runtime/injectStylesIntoStyleTag.js */ "./node_modules/style-loader/dist/runtime/injectStylesIntoStyleTag.js");
/* harmony import */ var _style_loader_dist_runtime_injectStylesIntoStyleTag_js__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_style_loader_dist_runtime_injectStylesIntoStyleTag_js__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var _css_loader_dist_cjs_js_clonedRuleSet_9_0_rules_0_use_1_postcss_loader_dist_cjs_js_clonedRuleSet_9_0_rules_0_use_2_vueScrollbar_css__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! !!../../css-loader/dist/cjs.js??clonedRuleSet-9[0].rules[0].use[1]!../../postcss-loader/dist/cjs.js??clonedRuleSet-9[0].rules[0].use[2]!./vueScrollbar.css */ "./node_modules/css-loader/dist/cjs.js??clonedRuleSet-9[0].rules[0].use[1]!./node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-9[0].rules[0].use[2]!./node_modules/vue-custom-scrollbar/dist/vueScrollbar.css");

            

var options = {};

options.insert = "head";
options.singleton = false;

var update = _style_loader_dist_runtime_injectStylesIntoStyleTag_js__WEBPACK_IMPORTED_MODULE_0___default()(_css_loader_dist_cjs_js_clonedRuleSet_9_0_rules_0_use_1_postcss_loader_dist_cjs_js_clonedRuleSet_9_0_rules_0_use_2_vueScrollbar_css__WEBPACK_IMPORTED_MODULE_1__.default, options);



/* harmony default export */ __webpack_exports__["default"] = (_css_loader_dist_cjs_js_clonedRuleSet_9_0_rules_0_use_1_postcss_loader_dist_cjs_js_clonedRuleSet_9_0_rules_0_use_2_vueScrollbar_css__WEBPACK_IMPORTED_MODULE_1__.default.locals || {});

/***/ }),

/***/ "./node_modules/style-loader/dist/cjs.js!./node_modules/css-loader/dist/cjs.js??clonedRuleSet-9[0].rules[0].use[1]!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-9[0].rules[0].use[2]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/components/common/CopyLabel.vue?vue&type=style&index=0&id=da7723f4&scoped=true&lang=css&":
/*!***********************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/style-loader/dist/cjs.js!./node_modules/css-loader/dist/cjs.js??clonedRuleSet-9[0].rules[0].use[1]!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-9[0].rules[0].use[2]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/components/common/CopyLabel.vue?vue&type=style&index=0&id=da7723f4&scoped=true&lang=css& ***!
  \***********************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_style_loader_dist_runtime_injectStylesIntoStyleTag_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! !../../../../node_modules/style-loader/dist/runtime/injectStylesIntoStyleTag.js */ "./node_modules/style-loader/dist/runtime/injectStylesIntoStyleTag.js");
/* harmony import */ var _node_modules_style_loader_dist_runtime_injectStylesIntoStyleTag_js__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_node_modules_style_loader_dist_runtime_injectStylesIntoStyleTag_js__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var _node_modules_css_loader_dist_cjs_js_clonedRuleSet_9_0_rules_0_use_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_postcss_loader_dist_cjs_js_clonedRuleSet_9_0_rules_0_use_2_node_modules_vue_loader_lib_index_js_vue_loader_options_CopyLabel_vue_vue_type_style_index_0_id_da7723f4_scoped_true_lang_css___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! !!../../../../node_modules/css-loader/dist/cjs.js??clonedRuleSet-9[0].rules[0].use[1]!../../../../node_modules/vue-loader/lib/loaders/stylePostLoader.js!../../../../node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-9[0].rules[0].use[2]!../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./CopyLabel.vue?vue&type=style&index=0&id=da7723f4&scoped=true&lang=css& */ "./node_modules/css-loader/dist/cjs.js??clonedRuleSet-9[0].rules[0].use[1]!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-9[0].rules[0].use[2]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/components/common/CopyLabel.vue?vue&type=style&index=0&id=da7723f4&scoped=true&lang=css&");

            

var options = {};

options.insert = "head";
options.singleton = false;

var update = _node_modules_style_loader_dist_runtime_injectStylesIntoStyleTag_js__WEBPACK_IMPORTED_MODULE_0___default()(_node_modules_css_loader_dist_cjs_js_clonedRuleSet_9_0_rules_0_use_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_postcss_loader_dist_cjs_js_clonedRuleSet_9_0_rules_0_use_2_node_modules_vue_loader_lib_index_js_vue_loader_options_CopyLabel_vue_vue_type_style_index_0_id_da7723f4_scoped_true_lang_css___WEBPACK_IMPORTED_MODULE_1__.default, options);



/* harmony default export */ __webpack_exports__["default"] = (_node_modules_css_loader_dist_cjs_js_clonedRuleSet_9_0_rules_0_use_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_postcss_loader_dist_cjs_js_clonedRuleSet_9_0_rules_0_use_2_node_modules_vue_loader_lib_index_js_vue_loader_options_CopyLabel_vue_vue_type_style_index_0_id_da7723f4_scoped_true_lang_css___WEBPACK_IMPORTED_MODULE_1__.default.locals || {});

/***/ }),

/***/ "./node_modules/vue-custom-scrollbar/dist/vueScrollbar.umd.min.js":
/*!************************************************************************!*\
  !*** ./node_modules/vue-custom-scrollbar/dist/vueScrollbar.umd.min.js ***!
  \************************************************************************/
/***/ (function(module) {

(function(t,e){ true?module.exports=e():0})("undefined"!==typeof self?self:this,(function(){return function(t){var e={};function n(i){if(e[i])return e[i].exports;var r=e[i]={i:i,l:!1,exports:{}};return t[i].call(r.exports,r,r.exports,n),r.l=!0,r.exports}return n.m=t,n.c=e,n.d=function(t,e,i){n.o(t,e)||Object.defineProperty(t,e,{enumerable:!0,get:i})},n.r=function(t){"undefined"!==typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(t,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(t,"__esModule",{value:!0})},n.t=function(t,e){if(1&e&&(t=n(t)),8&e)return t;if(4&e&&"object"===typeof t&&t&&t.__esModule)return t;var i=Object.create(null);if(n.r(i),Object.defineProperty(i,"default",{enumerable:!0,value:t}),2&e&&"string"!=typeof t)for(var r in t)n.d(i,r,function(e){return t[e]}.bind(null,r));return i},n.n=function(t){var e=t&&t.__esModule?function(){return t["default"]}:function(){return t};return n.d(e,"a",e),e},n.o=function(t,e){return Object.prototype.hasOwnProperty.call(t,e)},n.p="",n(n.s="fb15")}({"3ae1":function(t,e,n){"use strict";n("e386")},8875:function(t,e,n){var i,r,l;(function(n,o){r=[],i=o,l="function"===typeof i?i.apply(e,r):i,void 0===l||(t.exports=l)})("undefined"!==typeof self&&self,(function(){function t(){var e=Object.getOwnPropertyDescriptor(document,"currentScript");if(!e&&"currentScript"in document&&document.currentScript)return document.currentScript;if(e&&e.get!==t&&document.currentScript)return document.currentScript;try{throw new Error}catch(f){var n,i,r,l=/.*at [^(]*\((.*):(.+):(.+)\)$/gi,o=/@([^@]*):(\d+):(\d+)\s*$/gi,s=l.exec(f.stack)||o.exec(f.stack),a=s&&s[1]||!1,c=s&&s[2]||!1,h=document.location.href.replace(document.location.hash,""),u=document.getElementsByTagName("script");a===h&&(n=document.documentElement.outerHTML,i=new RegExp("(?:[^\\n]+?\\n){0,"+(c-2)+"}[^<]*<script>([\\d\\D]*?)<\\/script>[\\d\\D]*","i"),r=n.replace(i,"$1").trim());for(var d=0;d<u.length;d++){if("interactive"===u[d].readyState)return u[d];if(u[d].src===a)return u[d];if(a===h&&u[d].innerHTML&&u[d].innerHTML.trim()===r)return u[d]}return null}}return t}))},e386:function(t,e,n){},fb15:function(t,e,n){"use strict";if(n.r(e),"undefined"!==typeof window){var i=window.document.currentScript,r=n("8875");i=r(),"currentScript"in document||Object.defineProperty(document,"currentScript",{get:r});var l=i&&i.src.match(/(.+\/)[^/]+\.js(\?.*)?$/);l&&(n.p=l[1])}var o=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n(t.$props.tagname,{tag:"section",staticClass:"ps-container",on:{"ps-scroll-y":t.scrollHandle,"ps-scroll-x":t.scrollHandle,"ps-scroll-up":t.scrollHandle,"ps-scroll-down":t.scrollHandle,"ps-scroll-left":t.scrollHandle,"ps-scroll-right":t.scrollHandle,"ps-y-reach-start":t.scrollHandle,"ps-y-reach-end":t.scrollHandle,"ps-x-reach-start":t.scrollHandle,"ps-x-reach-end":t.scrollHandle}},[t._t("default")],2)},s=[];
/*!
 * perfect-scrollbar v1.5.0
 * Copyright 2020 Hyunje Jun, MDBootstrap and Contributors
 * Licensed under MIT
 */
function a(t){return getComputedStyle(t)}function c(t,e){for(var n in e){var i=e[n];"number"===typeof i&&(i+="px"),t.style[n]=i}return t}function h(t){var e=document.createElement("div");return e.className=t,e}var u="undefined"!==typeof Element&&(Element.prototype.matches||Element.prototype.webkitMatchesSelector||Element.prototype.mozMatchesSelector||Element.prototype.msMatchesSelector);function d(t,e){if(!u)throw new Error("No element matching method supported");return u.call(t,e)}function f(t){t.remove?t.remove():t.parentNode&&t.parentNode.removeChild(t)}function p(t,e){return Array.prototype.filter.call(t.children,(function(t){return d(t,e)}))}var b={main:"ps",rtl:"ps__rtl",element:{thumb:function(t){return"ps__thumb-"+t},rail:function(t){return"ps__rail-"+t},consuming:"ps__child--consume"},state:{focus:"ps--focus",clicking:"ps--clicking",active:function(t){return"ps--active-"+t},scrolling:function(t){return"ps--scrolling-"+t}}},g={x:null,y:null};function v(t,e){var n=t.element.classList,i=b.state.scrolling(e);n.contains(i)?clearTimeout(g[e]):n.add(i)}function m(t,e){g[e]=setTimeout((function(){return t.isAlive&&t.element.classList.remove(b.state.scrolling(e))}),t.settings.scrollingThreshold)}function y(t,e){v(t,e),m(t,e)}var w=function(t){this.element=t,this.handlers={}},Y={isEmpty:{configurable:!0}};w.prototype.bind=function(t,e){"undefined"===typeof this.handlers[t]&&(this.handlers[t]=[]),this.handlers[t].push(e),this.element.addEventListener(t,e,!1)},w.prototype.unbind=function(t,e){var n=this;this.handlers[t]=this.handlers[t].filter((function(i){return!(!e||i===e)||(n.element.removeEventListener(t,i,!1),!1)}))},w.prototype.unbindAll=function(){for(var t in this.handlers)this.unbind(t)},Y.isEmpty.get=function(){var t=this;return Object.keys(this.handlers).every((function(e){return 0===t.handlers[e].length}))},Object.defineProperties(w.prototype,Y);var X=function(){this.eventElements=[]};function W(t){if("function"===typeof window.CustomEvent)return new CustomEvent(t);var e=document.createEvent("CustomEvent");return e.initCustomEvent(t,!1,!1,void 0),e}function S(t,e,n,i,r){var l;if(void 0===i&&(i=!0),void 0===r&&(r=!1),"top"===e)l=["contentHeight","containerHeight","scrollTop","y","up","down"];else{if("left"!==e)throw new Error("A proper axis should be provided");l=["contentWidth","containerWidth","scrollLeft","x","left","right"]}L(t,n,l,i,r)}function L(t,e,n,i,r){var l=n[0],o=n[1],s=n[2],a=n[3],c=n[4],h=n[5];void 0===i&&(i=!0),void 0===r&&(r=!1);var u=t.element;t.reach[a]=null,u[s]<1&&(t.reach[a]="start"),u[s]>t[l]-t[o]-1&&(t.reach[a]="end"),e&&(u.dispatchEvent(W("ps-scroll-"+a)),e<0?u.dispatchEvent(W("ps-scroll-"+c)):e>0&&u.dispatchEvent(W("ps-scroll-"+h)),i&&y(t,a)),t.reach[a]&&(e||r)&&u.dispatchEvent(W("ps-"+a+"-reach-"+t.reach[a]))}function T(t){return parseInt(t,10)||0}function H(t){return d(t,"input,[contenteditable]")||d(t,"select,[contenteditable]")||d(t,"textarea,[contenteditable]")||d(t,"button,[contenteditable]")}function R(t){var e=a(t);return T(e.width)+T(e.paddingLeft)+T(e.paddingRight)+T(e.borderLeftWidth)+T(e.borderRightWidth)}X.prototype.eventElement=function(t){var e=this.eventElements.filter((function(e){return e.element===t}))[0];return e||(e=new w(t),this.eventElements.push(e)),e},X.prototype.bind=function(t,e,n){this.eventElement(t).bind(e,n)},X.prototype.unbind=function(t,e,n){var i=this.eventElement(t);i.unbind(e,n),i.isEmpty&&this.eventElements.splice(this.eventElements.indexOf(i),1)},X.prototype.unbindAll=function(){this.eventElements.forEach((function(t){return t.unbindAll()})),this.eventElements=[]},X.prototype.once=function(t,e,n){var i=this.eventElement(t),r=function(t){i.unbind(e,r),n(t)};i.bind(e,r)};var _={isWebKit:"undefined"!==typeof document&&"WebkitAppearance"in document.documentElement.style,supportsTouch:"undefined"!==typeof window&&("ontouchstart"in window||"maxTouchPoints"in window.navigator&&window.navigator.maxTouchPoints>0||window.DocumentTouch&&document instanceof window.DocumentTouch),supportsIePointer:"undefined"!==typeof navigator&&navigator.msMaxTouchPoints,isChrome:"undefined"!==typeof navigator&&/Chrome/i.test(navigator&&navigator.userAgent)};function E(t){var e=t.element,n=Math.floor(e.scrollTop),i=e.getBoundingClientRect();t.containerWidth=Math.ceil(i.width),t.containerHeight=Math.ceil(i.height),t.contentWidth=e.scrollWidth,t.contentHeight=e.scrollHeight,e.contains(t.scrollbarXRail)||(p(e,b.element.rail("x")).forEach((function(t){return f(t)})),e.appendChild(t.scrollbarXRail)),e.contains(t.scrollbarYRail)||(p(e,b.element.rail("y")).forEach((function(t){return f(t)})),e.appendChild(t.scrollbarYRail)),!t.settings.suppressScrollX&&t.containerWidth+t.settings.scrollXMarginOffset<t.contentWidth?(t.scrollbarXActive=!0,t.railXWidth=t.containerWidth-t.railXMarginWidth,t.railXRatio=t.containerWidth/t.railXWidth,t.scrollbarXWidth=x(t,T(t.railXWidth*t.containerWidth/t.contentWidth)),t.scrollbarXLeft=T((t.negativeScrollAdjustment+e.scrollLeft)*(t.railXWidth-t.scrollbarXWidth)/(t.contentWidth-t.containerWidth))):t.scrollbarXActive=!1,!t.settings.suppressScrollY&&t.containerHeight+t.settings.scrollYMarginOffset<t.contentHeight?(t.scrollbarYActive=!0,t.railYHeight=t.containerHeight-t.railYMarginHeight,t.railYRatio=t.containerHeight/t.railYHeight,t.scrollbarYHeight=x(t,T(t.railYHeight*t.containerHeight/t.contentHeight)),t.scrollbarYTop=T(n*(t.railYHeight-t.scrollbarYHeight)/(t.contentHeight-t.containerHeight))):t.scrollbarYActive=!1,t.scrollbarXLeft>=t.railXWidth-t.scrollbarXWidth&&(t.scrollbarXLeft=t.railXWidth-t.scrollbarXWidth),t.scrollbarYTop>=t.railYHeight-t.scrollbarYHeight&&(t.scrollbarYTop=t.railYHeight-t.scrollbarYHeight),M(e,t),t.scrollbarXActive?e.classList.add(b.state.active("x")):(e.classList.remove(b.state.active("x")),t.scrollbarXWidth=0,t.scrollbarXLeft=0,e.scrollLeft=!0===t.isRtl?t.contentWidth:0),t.scrollbarYActive?e.classList.add(b.state.active("y")):(e.classList.remove(b.state.active("y")),t.scrollbarYHeight=0,t.scrollbarYTop=0,e.scrollTop=0)}function x(t,e){return t.settings.minScrollbarLength&&(e=Math.max(e,t.settings.minScrollbarLength)),t.settings.maxScrollbarLength&&(e=Math.min(e,t.settings.maxScrollbarLength)),e}function M(t,e){var n={width:e.railXWidth},i=Math.floor(t.scrollTop);e.isRtl?n.left=e.negativeScrollAdjustment+t.scrollLeft+e.containerWidth-e.contentWidth:n.left=t.scrollLeft,e.isScrollbarXUsingBottom?n.bottom=e.scrollbarXBottom-i:n.top=e.scrollbarXTop+i,c(e.scrollbarXRail,n);var r={top:i,height:e.railYHeight};e.isScrollbarYUsingRight?e.isRtl?r.right=e.contentWidth-(e.negativeScrollAdjustment+t.scrollLeft)-e.scrollbarYRight-e.scrollbarYOuterWidth-9:r.right=e.scrollbarYRight-t.scrollLeft:e.isRtl?r.left=e.negativeScrollAdjustment+t.scrollLeft+2*e.containerWidth-e.contentWidth-e.scrollbarYLeft-e.scrollbarYOuterWidth:r.left=e.scrollbarYLeft+t.scrollLeft,c(e.scrollbarYRail,r),c(e.scrollbarX,{left:e.scrollbarXLeft,width:e.scrollbarXWidth-e.railBorderXWidth}),c(e.scrollbarY,{top:e.scrollbarYTop,height:e.scrollbarYHeight-e.railBorderYWidth})}function A(t){t.element;t.event.bind(t.scrollbarY,"mousedown",(function(t){return t.stopPropagation()})),t.event.bind(t.scrollbarYRail,"mousedown",(function(e){var n=e.pageY-window.pageYOffset-t.scrollbarYRail.getBoundingClientRect().top,i=n>t.scrollbarYTop?1:-1;t.element.scrollTop+=i*t.containerHeight,E(t),e.stopPropagation()})),t.event.bind(t.scrollbarX,"mousedown",(function(t){return t.stopPropagation()})),t.event.bind(t.scrollbarXRail,"mousedown",(function(e){var n=e.pageX-window.pageXOffset-t.scrollbarXRail.getBoundingClientRect().left,i=n>t.scrollbarXLeft?1:-1;t.element.scrollLeft+=i*t.containerWidth,E(t),e.stopPropagation()}))}function P(t){C(t,["containerWidth","contentWidth","pageX","railXWidth","scrollbarX","scrollbarXWidth","scrollLeft","x","scrollbarXRail"]),C(t,["containerHeight","contentHeight","pageY","railYHeight","scrollbarY","scrollbarYHeight","scrollTop","y","scrollbarYRail"])}function C(t,e){var n=e[0],i=e[1],r=e[2],l=e[3],o=e[4],s=e[5],a=e[6],c=e[7],h=e[8],u=t.element,d=null,f=null,p=null;function g(e){e.touches&&e.touches[0]&&(e[r]=e.touches[0].pageY),u[a]=d+p*(e[r]-f),v(t,c),E(t),e.stopPropagation(),e.preventDefault()}function y(){m(t,c),t[h].classList.remove(b.state.clicking),t.event.unbind(t.ownerDocument,"mousemove",g)}function w(e,o){d=u[a],o&&e.touches&&(e[r]=e.touches[0].pageY),f=e[r],p=(t[i]-t[n])/(t[l]-t[s]),o?t.event.bind(t.ownerDocument,"touchmove",g):(t.event.bind(t.ownerDocument,"mousemove",g),t.event.once(t.ownerDocument,"mouseup",y),e.preventDefault()),t[h].classList.add(b.state.clicking),e.stopPropagation()}t.event.bind(t[o],"mousedown",(function(t){w(t)})),t.event.bind(t[o],"touchstart",(function(t){w(t,!0)}))}function k(t){var e=t.element,n=function(){return d(e,":hover")},i=function(){return d(t.scrollbarX,":focus")||d(t.scrollbarY,":focus")};function r(n,i){var r=Math.floor(e.scrollTop);if(0===n){if(!t.scrollbarYActive)return!1;if(0===r&&i>0||r>=t.contentHeight-t.containerHeight&&i<0)return!t.settings.wheelPropagation}var l=e.scrollLeft;if(0===i){if(!t.scrollbarXActive)return!1;if(0===l&&n<0||l>=t.contentWidth-t.containerWidth&&n>0)return!t.settings.wheelPropagation}return!0}t.event.bind(t.ownerDocument,"keydown",(function(l){if(!(l.isDefaultPrevented&&l.isDefaultPrevented()||l.defaultPrevented)&&(n()||i())){var o=document.activeElement?document.activeElement:t.ownerDocument.activeElement;if(o){if("IFRAME"===o.tagName)o=o.contentDocument.activeElement;else while(o.shadowRoot)o=o.shadowRoot.activeElement;if(H(o))return}var s=0,a=0;switch(l.which){case 37:s=l.metaKey?-t.contentWidth:l.altKey?-t.containerWidth:-30;break;case 38:a=l.metaKey?t.contentHeight:l.altKey?t.containerHeight:30;break;case 39:s=l.metaKey?t.contentWidth:l.altKey?t.containerWidth:30;break;case 40:a=l.metaKey?-t.contentHeight:l.altKey?-t.containerHeight:-30;break;case 32:a=l.shiftKey?t.containerHeight:-t.containerHeight;break;case 33:a=t.containerHeight;break;case 34:a=-t.containerHeight;break;case 36:a=t.contentHeight;break;case 35:a=-t.contentHeight;break;default:return}t.settings.suppressScrollX&&0!==s||t.settings.suppressScrollY&&0!==a||(e.scrollTop-=a,e.scrollLeft+=s,E(t),r(s,a)&&l.preventDefault())}}))}function D(t){var e=t.element;function n(n,i){var r,l=Math.floor(e.scrollTop),o=0===e.scrollTop,s=l+e.offsetHeight===e.scrollHeight,a=0===e.scrollLeft,c=e.scrollLeft+e.offsetWidth===e.scrollWidth;return r=Math.abs(i)>Math.abs(n)?o||s:a||c,!r||!t.settings.wheelPropagation}function i(t){var e=t.deltaX,n=-1*t.deltaY;return"undefined"!==typeof e&&"undefined"!==typeof n||(e=-1*t.wheelDeltaX/6,n=t.wheelDeltaY/6),t.deltaMode&&1===t.deltaMode&&(e*=10,n*=10),e!==e&&n!==n&&(e=0,n=t.wheelDelta),t.shiftKey?[-n,-e]:[e,n]}function r(t,n,i){if(!_.isWebKit&&e.querySelector("select:focus"))return!0;if(!e.contains(t))return!1;var r=t;while(r&&r!==e){if(r.classList.contains(b.element.consuming))return!0;var l=a(r);if(i&&l.overflowY.match(/(scroll|auto)/)){var o=r.scrollHeight-r.clientHeight;if(o>0&&(r.scrollTop>0&&i<0||r.scrollTop<o&&i>0))return!0}if(n&&l.overflowX.match(/(scroll|auto)/)){var s=r.scrollWidth-r.clientWidth;if(s>0&&(r.scrollLeft>0&&n<0||r.scrollLeft<s&&n>0))return!0}r=r.parentNode}return!1}function l(l){var o=i(l),s=o[0],a=o[1];if(!r(l.target,s,a)){var c=!1;t.settings.useBothWheelAxes?t.scrollbarYActive&&!t.scrollbarXActive?(a?e.scrollTop-=a*t.settings.wheelSpeed:e.scrollTop+=s*t.settings.wheelSpeed,c=!0):t.scrollbarXActive&&!t.scrollbarYActive&&(s?e.scrollLeft+=s*t.settings.wheelSpeed:e.scrollLeft-=a*t.settings.wheelSpeed,c=!0):(e.scrollTop-=a*t.settings.wheelSpeed,e.scrollLeft+=s*t.settings.wheelSpeed),E(t),c=c||n(s,a),c&&!l.ctrlKey&&(l.stopPropagation(),l.preventDefault())}}"undefined"!==typeof window.onwheel?t.event.bind(e,"wheel",l):"undefined"!==typeof window.onmousewheel&&t.event.bind(e,"mousewheel",l)}function O(t){if(_.supportsTouch||_.supportsIePointer){var e=t.element,n={},i=0,r={},l=null;_.supportsTouch?(t.event.bind(e,"touchstart",u),t.event.bind(e,"touchmove",f),t.event.bind(e,"touchend",p)):_.supportsIePointer&&(window.PointerEvent?(t.event.bind(e,"pointerdown",u),t.event.bind(e,"pointermove",f),t.event.bind(e,"pointerup",p)):window.MSPointerEvent&&(t.event.bind(e,"MSPointerDown",u),t.event.bind(e,"MSPointerMove",f),t.event.bind(e,"MSPointerUp",p)))}function o(n,i){var r=Math.floor(e.scrollTop),l=e.scrollLeft,o=Math.abs(n),s=Math.abs(i);if(s>o){if(i<0&&r===t.contentHeight-t.containerHeight||i>0&&0===r)return 0===window.scrollY&&i>0&&_.isChrome}else if(o>s&&(n<0&&l===t.contentWidth-t.containerWidth||n>0&&0===l))return!0;return!0}function s(n,i){e.scrollTop-=i,e.scrollLeft-=n,E(t)}function c(t){return t.targetTouches?t.targetTouches[0]:t}function h(t){return(!t.pointerType||"pen"!==t.pointerType||0!==t.buttons)&&(!(!t.targetTouches||1!==t.targetTouches.length)||!(!t.pointerType||"mouse"===t.pointerType||t.pointerType===t.MSPOINTER_TYPE_MOUSE))}function u(t){if(h(t)){var e=c(t);n.pageX=e.pageX,n.pageY=e.pageY,i=(new Date).getTime(),null!==l&&clearInterval(l)}}function d(t,n,i){if(!e.contains(t))return!1;var r=t;while(r&&r!==e){if(r.classList.contains(b.element.consuming))return!0;var l=a(r);if(i&&l.overflowY.match(/(scroll|auto)/)){var o=r.scrollHeight-r.clientHeight;if(o>0&&(r.scrollTop>0&&i<0||r.scrollTop<o&&i>0))return!0}if(n&&l.overflowX.match(/(scroll|auto)/)){var s=r.scrollWidth-r.clientWidth;if(s>0&&(r.scrollLeft>0&&n<0||r.scrollLeft<s&&n>0))return!0}r=r.parentNode}return!1}function f(t){if(h(t)){var e=c(t),l={pageX:e.pageX,pageY:e.pageY},a=l.pageX-n.pageX,u=l.pageY-n.pageY;if(d(t.target,a,u))return;s(a,u),n=l;var f=(new Date).getTime(),p=f-i;p>0&&(r.x=a/p,r.y=u/p,i=f),o(a,u)&&t.preventDefault()}}function p(){t.settings.swipeEasing&&(clearInterval(l),l=setInterval((function(){t.isInitialized?clearInterval(l):r.x||r.y?Math.abs(r.x)<.01&&Math.abs(r.y)<.01?clearInterval(l):(s(30*r.x,30*r.y),r.x*=.8,r.y*=.8):clearInterval(l)}),10))}}var j=function(){return{handlers:["click-rail","drag-thumb","keyboard","wheel","touch"],maxScrollbarLength:null,minScrollbarLength:null,scrollingThreshold:1e3,scrollXMarginOffset:0,scrollYMarginOffset:0,suppressScrollX:!1,suppressScrollY:!1,swipeEasing:!0,useBothWheelAxes:!1,wheelPropagation:!0,wheelSpeed:1}},N={"click-rail":A,"drag-thumb":P,keyboard:k,wheel:D,touch:O},B=function(t,e){var n=this;if(void 0===e&&(e={}),"string"===typeof t&&(t=document.querySelector(t)),!t||!t.nodeName)throw new Error("no element is specified to initialize PerfectScrollbar");for(var i in this.element=t,t.classList.add(b.main),this.settings=j(),e)this.settings[i]=e[i];this.containerWidth=null,this.containerHeight=null,this.contentWidth=null,this.contentHeight=null;var r=function(){return t.classList.add(b.state.focus)},l=function(){return t.classList.remove(b.state.focus)};this.isRtl="rtl"===a(t).direction,!0===this.isRtl&&t.classList.add(b.rtl),this.isNegativeScroll=function(){var e=t.scrollLeft,n=null;return t.scrollLeft=-1,n=t.scrollLeft<0,t.scrollLeft=e,n}(),this.negativeScrollAdjustment=this.isNegativeScroll?t.scrollWidth-t.clientWidth:0,this.event=new X,this.ownerDocument=t.ownerDocument||document,this.scrollbarXRail=h(b.element.rail("x")),t.appendChild(this.scrollbarXRail),this.scrollbarX=h(b.element.thumb("x")),this.scrollbarXRail.appendChild(this.scrollbarX),this.scrollbarX.setAttribute("tabindex",0),this.event.bind(this.scrollbarX,"focus",r),this.event.bind(this.scrollbarX,"blur",l),this.scrollbarXActive=null,this.scrollbarXWidth=null,this.scrollbarXLeft=null;var o=a(this.scrollbarXRail);this.scrollbarXBottom=parseInt(o.bottom,10),isNaN(this.scrollbarXBottom)?(this.isScrollbarXUsingBottom=!1,this.scrollbarXTop=T(o.top)):this.isScrollbarXUsingBottom=!0,this.railBorderXWidth=T(o.borderLeftWidth)+T(o.borderRightWidth),c(this.scrollbarXRail,{display:"block"}),this.railXMarginWidth=T(o.marginLeft)+T(o.marginRight),c(this.scrollbarXRail,{display:""}),this.railXWidth=null,this.railXRatio=null,this.scrollbarYRail=h(b.element.rail("y")),t.appendChild(this.scrollbarYRail),this.scrollbarY=h(b.element.thumb("y")),this.scrollbarYRail.appendChild(this.scrollbarY),this.scrollbarY.setAttribute("tabindex",0),this.event.bind(this.scrollbarY,"focus",r),this.event.bind(this.scrollbarY,"blur",l),this.scrollbarYActive=null,this.scrollbarYHeight=null,this.scrollbarYTop=null;var s=a(this.scrollbarYRail);this.scrollbarYRight=parseInt(s.right,10),isNaN(this.scrollbarYRight)?(this.isScrollbarYUsingRight=!1,this.scrollbarYLeft=T(s.left)):this.isScrollbarYUsingRight=!0,this.scrollbarYOuterWidth=this.isRtl?R(this.scrollbarY):null,this.railBorderYWidth=T(s.borderTopWidth)+T(s.borderBottomWidth),c(this.scrollbarYRail,{display:"block"}),this.railYMarginHeight=T(s.marginTop)+T(s.marginBottom),c(this.scrollbarYRail,{display:""}),this.railYHeight=null,this.railYRatio=null,this.reach={x:t.scrollLeft<=0?"start":t.scrollLeft>=this.contentWidth-this.containerWidth?"end":null,y:t.scrollTop<=0?"start":t.scrollTop>=this.contentHeight-this.containerHeight?"end":null},this.isAlive=!0,this.settings.handlers.forEach((function(t){return N[t](n)})),this.lastScrollTop=Math.floor(t.scrollTop),this.lastScrollLeft=t.scrollLeft,this.event.bind(this.element,"scroll",(function(t){return n.onScroll(t)})),E(this)};B.prototype.update=function(){this.isAlive&&(this.negativeScrollAdjustment=this.isNegativeScroll?this.element.scrollWidth-this.element.clientWidth:0,c(this.scrollbarXRail,{display:"block"}),c(this.scrollbarYRail,{display:"block"}),this.railXMarginWidth=T(a(this.scrollbarXRail).marginLeft)+T(a(this.scrollbarXRail).marginRight),this.railYMarginHeight=T(a(this.scrollbarYRail).marginTop)+T(a(this.scrollbarYRail).marginBottom),c(this.scrollbarXRail,{display:"none"}),c(this.scrollbarYRail,{display:"none"}),E(this),S(this,"top",0,!1,!0),S(this,"left",0,!1,!0),c(this.scrollbarXRail,{display:""}),c(this.scrollbarYRail,{display:""}))},B.prototype.onScroll=function(t){this.isAlive&&(E(this),S(this,"top",this.element.scrollTop-this.lastScrollTop),S(this,"left",this.element.scrollLeft-this.lastScrollLeft),this.lastScrollTop=Math.floor(this.element.scrollTop),this.lastScrollLeft=this.element.scrollLeft)},B.prototype.destroy=function(){this.isAlive&&(this.event.unbindAll(),f(this.scrollbarX),f(this.scrollbarY),f(this.scrollbarXRail),f(this.scrollbarYRail),this.removePsClasses(),this.element=null,this.scrollbarX=null,this.scrollbarY=null,this.scrollbarXRail=null,this.scrollbarYRail=null,this.isAlive=!1)},B.prototype.removePsClasses=function(){this.element.className=this.element.className.split(" ").filter((function(t){return!t.match(/^ps([-_].+|)$/)})).join(" ")};var $=B,I={name:"vue-custom-scrollbar",props:{settings:{default:null},swicher:{type:Boolean,default:!0},tagname:{type:String,default:"section"}},data:function(){return{ps:null}},methods:{scrollHandle:function(t){this.$emit(t.type,t)},update:function(){this.ps&&this.ps.update()},__init:function(){this.swicher&&(this._ps_inited?this.ps.update():(this._ps_inited=!0,this.ps=new $(this.$el,this.settings)))},__uninit:function(){this.ps&&(this.ps.destroy(),this.ps=null,this._ps_inited=!1)}},watch:{swicher:function(t){t&&!this._ps_inited&&this.__init(),!t&&this._ps_inited&&this.__uninit()},settings:{deep:!0,handler:function(){this.__uninit(),this.__init()}},$route:function(){this.update()}},mounted:function(){this.$isServer||this.__init()},updated:function(){this.$nextTick(this.update)},activated:function(){this.__init()},deactivated:function(){this.__uninit()},beforeDestroy:function(){this.__uninit()}},K=I;n("3ae1");function U(t,e,n,i,r,l,o,s){var a,c="function"===typeof t?t.options:t;if(e&&(c.render=e,c.staticRenderFns=n,c._compiled=!0),i&&(c.functional=!0),l&&(c._scopeId="data-v-"+l),o?(a=function(t){t=t||this.$vnode&&this.$vnode.ssrContext||this.parent&&this.parent.$vnode&&this.parent.$vnode.ssrContext,t||"undefined"===typeof __VUE_SSR_CONTEXT__||(t=__VUE_SSR_CONTEXT__),r&&r.call(this,t),t&&t._registeredComponents&&t._registeredComponents.add(o)},c._ssrRegister=a):r&&(a=s?function(){r.call(this,(c.functional?this.parent:this).$root.$options.shadowRoot)}:r),a)if(c.functional){c._injectStyles=a;var h=c.render;c.render=function(t,e){return a.call(e),h(t,e)}}else{var u=c.beforeCreate;c.beforeCreate=u?[].concat(u,a):[a]}return{exports:t,options:c}}var z=U(K,o,s,!1,null,null,null),q=z.exports;e["default"]=q}})["default"]}));
//# sourceMappingURL=vueScrollbar.umd.min.js.map

/***/ }),

/***/ "./resources/js/components/common/CopyLabel.vue":
/*!******************************************************!*\
  !*** ./resources/js/components/common/CopyLabel.vue ***!
  \******************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _CopyLabel_vue_vue_type_template_id_da7723f4_scoped_true___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./CopyLabel.vue?vue&type=template&id=da7723f4&scoped=true& */ "./resources/js/components/common/CopyLabel.vue?vue&type=template&id=da7723f4&scoped=true&");
/* harmony import */ var _CopyLabel_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./CopyLabel.vue?vue&type=script&lang=js& */ "./resources/js/components/common/CopyLabel.vue?vue&type=script&lang=js&");
/* harmony import */ var _CopyLabel_vue_vue_type_style_index_0_id_da7723f4_scoped_true_lang_css___WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./CopyLabel.vue?vue&type=style&index=0&id=da7723f4&scoped=true&lang=css& */ "./resources/js/components/common/CopyLabel.vue?vue&type=style&index=0&id=da7723f4&scoped=true&lang=css&");
/* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! !../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ "./node_modules/vue-loader/lib/runtime/componentNormalizer.js");



;


/* normalize component */

var component = (0,_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_3__.default)(
  _CopyLabel_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__.default,
  _CopyLabel_vue_vue_type_template_id_da7723f4_scoped_true___WEBPACK_IMPORTED_MODULE_0__.render,
  _CopyLabel_vue_vue_type_template_id_da7723f4_scoped_true___WEBPACK_IMPORTED_MODULE_0__.staticRenderFns,
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

/***/ "./resources/js/pages/users/UsersPage.vue":
/*!************************************************!*\
  !*** ./resources/js/pages/users/UsersPage.vue ***!
  \************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _UsersPage_vue_vue_type_template_id_652b1a12_scoped_true___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./UsersPage.vue?vue&type=template&id=652b1a12&scoped=true& */ "./resources/js/pages/users/UsersPage.vue?vue&type=template&id=652b1a12&scoped=true&");
/* harmony import */ var _UsersPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./UsersPage.vue?vue&type=script&lang=js& */ "./resources/js/pages/users/UsersPage.vue?vue&type=script&lang=js&");
/* harmony import */ var _UsersPage_vue_vue_type_style_index_0_id_652b1a12_lang_scss_scoped_true___WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./UsersPage.vue?vue&type=style&index=0&id=652b1a12&lang=scss&scoped=true& */ "./resources/js/pages/users/UsersPage.vue?vue&type=style&index=0&id=652b1a12&lang=scss&scoped=true&");
/* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! !../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ "./node_modules/vue-loader/lib/runtime/componentNormalizer.js");



;


/* normalize component */

var component = (0,_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_3__.default)(
  _UsersPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__.default,
  _UsersPage_vue_vue_type_template_id_652b1a12_scoped_true___WEBPACK_IMPORTED_MODULE_0__.render,
  _UsersPage_vue_vue_type_template_id_652b1a12_scoped_true___WEBPACK_IMPORTED_MODULE_0__.staticRenderFns,
  false,
  null,
  "652b1a12",
  null
  
)

/* hot reload */
if (false) { var api; }
component.options.__file = "resources/js/pages/users/UsersPage.vue"
/* harmony default export */ __webpack_exports__["default"] = (component.exports);

/***/ }),

/***/ "./resources/js/components/common/CopyLabel.vue?vue&type=script&lang=js&":
/*!*******************************************************************************!*\
  !*** ./resources/js/components/common/CopyLabel.vue?vue&type=script&lang=js& ***!
  \*******************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_babel_loader_lib_index_js_clonedRuleSet_5_0_rules_0_use_0_node_modules_vue_loader_lib_index_js_vue_loader_options_CopyLabel_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./CopyLabel.vue?vue&type=script&lang=js& */ "./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/components/common/CopyLabel.vue?vue&type=script&lang=js&");
 /* harmony default export */ __webpack_exports__["default"] = (_node_modules_babel_loader_lib_index_js_clonedRuleSet_5_0_rules_0_use_0_node_modules_vue_loader_lib_index_js_vue_loader_options_CopyLabel_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__.default); 

/***/ }),

/***/ "./resources/js/pages/users/UsersPage.vue?vue&type=script&lang=js&":
/*!*************************************************************************!*\
  !*** ./resources/js/pages/users/UsersPage.vue?vue&type=script&lang=js& ***!
  \*************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_babel_loader_lib_index_js_clonedRuleSet_5_0_rules_0_use_0_node_modules_vue_loader_lib_index_js_vue_loader_options_UsersPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./UsersPage.vue?vue&type=script&lang=js& */ "./node_modules/babel-loader/lib/index.js??clonedRuleSet-5[0].rules[0].use[0]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/pages/users/UsersPage.vue?vue&type=script&lang=js&");
 /* harmony default export */ __webpack_exports__["default"] = (_node_modules_babel_loader_lib_index_js_clonedRuleSet_5_0_rules_0_use_0_node_modules_vue_loader_lib_index_js_vue_loader_options_UsersPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__.default); 

/***/ }),

/***/ "./resources/js/pages/users/UsersPage.vue?vue&type=style&index=0&id=652b1a12&lang=scss&scoped=true&":
/*!**********************************************************************************************************!*\
  !*** ./resources/js/pages/users/UsersPage.vue?vue&type=style&index=0&id=652b1a12&lang=scss&scoped=true& ***!
  \**********************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_style_loader_dist_cjs_js_node_modules_css_loader_dist_cjs_js_clonedRuleSet_12_0_rules_0_use_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_postcss_loader_dist_cjs_js_clonedRuleSet_12_0_rules_0_use_2_node_modules_sass_loader_dist_cjs_js_clonedRuleSet_12_0_rules_0_use_3_node_modules_vue_loader_lib_index_js_vue_loader_options_UsersPage_vue_vue_type_style_index_0_id_652b1a12_lang_scss_scoped_true___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/style-loader/dist/cjs.js!../../../../node_modules/css-loader/dist/cjs.js??clonedRuleSet-12[0].rules[0].use[1]!../../../../node_modules/vue-loader/lib/loaders/stylePostLoader.js!../../../../node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-12[0].rules[0].use[2]!../../../../node_modules/sass-loader/dist/cjs.js??clonedRuleSet-12[0].rules[0].use[3]!../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./UsersPage.vue?vue&type=style&index=0&id=652b1a12&lang=scss&scoped=true& */ "./node_modules/style-loader/dist/cjs.js!./node_modules/css-loader/dist/cjs.js??clonedRuleSet-12[0].rules[0].use[1]!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-12[0].rules[0].use[2]!./node_modules/sass-loader/dist/cjs.js??clonedRuleSet-12[0].rules[0].use[3]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/pages/users/UsersPage.vue?vue&type=style&index=0&id=652b1a12&lang=scss&scoped=true&");


/***/ }),

/***/ "./resources/js/components/common/CopyLabel.vue?vue&type=style&index=0&id=da7723f4&scoped=true&lang=css&":
/*!***************************************************************************************************************!*\
  !*** ./resources/js/components/common/CopyLabel.vue?vue&type=style&index=0&id=da7723f4&scoped=true&lang=css& ***!
  \***************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_style_loader_dist_cjs_js_node_modules_css_loader_dist_cjs_js_clonedRuleSet_9_0_rules_0_use_1_node_modules_vue_loader_lib_loaders_stylePostLoader_js_node_modules_postcss_loader_dist_cjs_js_clonedRuleSet_9_0_rules_0_use_2_node_modules_vue_loader_lib_index_js_vue_loader_options_CopyLabel_vue_vue_type_style_index_0_id_da7723f4_scoped_true_lang_css___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/style-loader/dist/cjs.js!../../../../node_modules/css-loader/dist/cjs.js??clonedRuleSet-9[0].rules[0].use[1]!../../../../node_modules/vue-loader/lib/loaders/stylePostLoader.js!../../../../node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-9[0].rules[0].use[2]!../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./CopyLabel.vue?vue&type=style&index=0&id=da7723f4&scoped=true&lang=css& */ "./node_modules/style-loader/dist/cjs.js!./node_modules/css-loader/dist/cjs.js??clonedRuleSet-9[0].rules[0].use[1]!./node_modules/vue-loader/lib/loaders/stylePostLoader.js!./node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-9[0].rules[0].use[2]!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/components/common/CopyLabel.vue?vue&type=style&index=0&id=da7723f4&scoped=true&lang=css&");


/***/ }),

/***/ "./resources/js/components/common/CopyLabel.vue?vue&type=template&id=da7723f4&scoped=true&":
/*!*************************************************************************************************!*\
  !*** ./resources/js/components/common/CopyLabel.vue?vue&type=template&id=da7723f4&scoped=true& ***!
  \*************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "render": function() { return /* reexport safe */ _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_CopyLabel_vue_vue_type_template_id_da7723f4_scoped_true___WEBPACK_IMPORTED_MODULE_0__.render; },
/* harmony export */   "staticRenderFns": function() { return /* reexport safe */ _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_CopyLabel_vue_vue_type_template_id_da7723f4_scoped_true___WEBPACK_IMPORTED_MODULE_0__.staticRenderFns; }
/* harmony export */ });
/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_CopyLabel_vue_vue_type_template_id_da7723f4_scoped_true___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./CopyLabel.vue?vue&type=template&id=da7723f4&scoped=true& */ "./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/components/common/CopyLabel.vue?vue&type=template&id=da7723f4&scoped=true&");


/***/ }),

/***/ "./resources/js/pages/users/UsersPage.vue?vue&type=template&id=652b1a12&scoped=true&":
/*!*******************************************************************************************!*\
  !*** ./resources/js/pages/users/UsersPage.vue?vue&type=template&id=652b1a12&scoped=true& ***!
  \*******************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "render": function() { return /* reexport safe */ _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_UsersPage_vue_vue_type_template_id_652b1a12_scoped_true___WEBPACK_IMPORTED_MODULE_0__.render; },
/* harmony export */   "staticRenderFns": function() { return /* reexport safe */ _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_UsersPage_vue_vue_type_template_id_652b1a12_scoped_true___WEBPACK_IMPORTED_MODULE_0__.staticRenderFns; }
/* harmony export */ });
/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_UsersPage_vue_vue_type_template_id_652b1a12_scoped_true___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../node_modules/vue-loader/lib/index.js??vue-loader-options!./UsersPage.vue?vue&type=template&id=652b1a12&scoped=true& */ "./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/pages/users/UsersPage.vue?vue&type=template&id=652b1a12&scoped=true&");


/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/components/common/CopyLabel.vue?vue&type=template&id=da7723f4&scoped=true&":
/*!****************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/components/common/CopyLabel.vue?vue&type=template&id=da7723f4&scoped=true& ***!
  \****************************************************************************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
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
                        return _vm.copy.apply(null, arguments)
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

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/pages/users/UsersPage.vue?vue&type=template&id=652b1a12&scoped=true&":
/*!**********************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib/index.js??vue-loader-options!./resources/js/pages/users/UsersPage.vue?vue&type=template&id=652b1a12&scoped=true& ***!
  \**********************************************************************************************************************************************************************************************************************************/
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
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
    { staticClass: "d-flex flex-column flex-grow-1" },
    [
      _c(
        "div",
        { staticClass: "d-flex align-center py-1" },
        [
          _c(
            "div",
            [
              _c("div", { staticClass: "display-1" }, [_vm._v("Usuarios")]),
              _vm._v(" "),
              _c("v-breadcrumbs", {
                staticClass: "pa-0 py-1",
                attrs: { items: _vm.breadcrumbs }
              })
            ],
            1
          ),
          _vm._v(" "),
          _c("v-spacer")
        ],
        1
      ),
      _vm._v(" "),
      _c(
        "v-card",
        [
          _c(
            "v-row",
            { staticClass: "pa-2 align-center", attrs: { dense: "" } },
            [
              _c(
                "v-col",
                { attrs: { cols: "6" } },
                [
                  _c(
                    "v-menu",
                    {
                      attrs: { "offset-y": "", left: "" },
                      scopedSlots: _vm._u([
                        {
                          key: "activator",
                          fn: function(ref) {
                            var on = ref.on
                            return [
                              _c(
                                "transition",
                                {
                                  attrs: { name: "slide-fade", mode: "out-in" }
                                },
                                [
                                  _c(
                                    "v-btn",
                                    _vm._g(
                                      {
                                        directives: [
                                          {
                                            name: "show",
                                            rawName: "v-show",
                                            value: _vm.selectedUsers.length > 0,
                                            expression:
                                              "selectedUsers.length > 0"
                                          }
                                        ],
                                        attrs: { color: "secondary" }
                                      },
                                      on
                                    ),
                                    [
                                      _vm._v(
                                        "\n                  Acciones\n                  "
                                      ),
                                      _c("v-icon", { attrs: { right: "" } }, [
                                        _vm._v("mdi-menu-down")
                                      ])
                                    ],
                                    1
                                  )
                                ],
                                1
                              )
                            ]
                          }
                        }
                      ])
                    },
                    [
                      _vm._v(" "),
                      _c(
                        "v-list",
                        { attrs: { dense: "" } },
                        [
                          _c(
                            "v-list-item",
                            { attrs: { href: _vm.urltoreturn } },
                            [
                              _c("v-list-item-title", [
                                _vm._v("Exportar(.xlsx)")
                              ])
                            ],
                            1
                          ),
                          _vm._v(" "),
                          _c(
                            "v-list-item",
                            { on: { click: _vm.verifygroup } },
                            [
                              _c("v-list-item-title", [
                                _vm._v("Verificar Email")
                              ])
                            ],
                            1
                          ),
                          _vm._v(" "),
                          _c(
                            "v-list-item",
                            {
                              on: {
                                click: function($event) {
                                  return _vm.disablegroup("disabled")
                                }
                              }
                            },
                            [_c("v-list-item-title", [_vm._v("Deshabilitar")])],
                            1
                          ),
                          _vm._v(" "),
                          _c(
                            "v-list-item",
                            {
                              on: {
                                click: function($event) {
                                  return _vm.disablegroup("enable")
                                }
                              }
                            },
                            [_c("v-list-item-title", [_vm._v("Habilitar")])],
                            1
                          ),
                          _vm._v(" "),
                          _c(
                            "v-list-item",
                            { on: { click: _vm.destroygroup } },
                            [_c("v-list-item-title", [_vm._v("Eliminar")])],
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
                "v-col",
                {
                  staticClass: "d-flex text-right align-center",
                  attrs: { cols: "6" }
                },
                [
                  _c(
                    "v-btn",
                    {
                      staticClass: "mr-2",
                      attrs: { color: "primary", to: "/users/create" }
                    },
                    [
                      _vm._v("\n            Añadir Usuario\n            "),
                      _c("v-icon", [_vm._v("mdi-plus")])
                    ],
                    1
                  ),
                  _vm._v(" "),
                  _c("v-text-field", {
                    staticClass: "flex-grow-1 mr-1",
                    attrs: {
                      "append-icon": "mdi-magnify",
                      solo: "",
                      "hide-details": "",
                      dense: "",
                      light: "",
                      clearable: "",
                      placeholder: "Buscar por email, nombre …"
                    },
                    on: {
                      keyup: [
                        function($event) {
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
                          return _vm.searchUser(_vm.searchQuery)
                        },
                        function($event) {
                          if (
                            !$event.type.indexOf("key") &&
                            _vm._k(
                              $event.keyCode,
                              "delete",
                              [8, 46],
                              $event.key,
                              ["Backspace", "Delete", "Del"]
                            )
                          ) {
                            return null
                          }
                          return _vm.researchUser(_vm.searchQuery)
                        }
                      ]
                    },
                    model: {
                      value: _vm.searchQuery,
                      callback: function($$v) {
                        _vm.searchQuery = $$v
                      },
                      expression: "searchQuery"
                    }
                  })
                ],
                1
              )
            ],
            1
          ),
          _vm._v(" "),
          _c("v-data-table", {
            staticClass: "flex-grow-1 scroll-me",
            attrs: {
              light: "",
              "show-select": "",
              headers: _vm.headers,
              items: _vm.users.data,
              search: _vm.searchQuery,
              loading: _vm.loading,
              options: _vm.options,
              "items-per-page": _vm.itemsperpage,
              "footer-props": {
                itemsPerPageOptions: [25, 50, 100, 1000]
              },
              "server-items-length": _vm.users.total,
              page: _vm.page
            },
            on: {
              "update:options": function($event) {
                _vm.options = $event
              },
              "toggle-select-all": _vm.selectAllToggle
            },
            scopedSlots: _vm._u([
              {
                key: "item.name",
                fn: function(ref) {
                  var item = ref.item
                  return [
                    _c("div", [
                      _vm._v(
                        "\n            " +
                          _vm._s(_vm._f("capitalize")(item.name)) +
                          " " +
                          _vm._s(_vm._f("capitalize")(item.lastname)) +
                          "\n          "
                      )
                    ])
                  ]
                }
              },
              {
                key: "item.birthplace",
                fn: function(ref) {
                  var item = ref.item
                  return [
                    _c("div", [
                      _vm._v(_vm._s(_vm._f("capitalize")(item.birthplace)))
                    ])
                  ]
                }
              },
              {
                key: "item.gender",
                fn: function(ref) {
                  var item = ref.item
                  return [
                    _c("div", [
                      _vm._v(_vm._s(_vm._f("capitalize")(item.gender)))
                    ])
                  ]
                }
              },
              {
                key: "item.email",
                fn: function(ref) {
                  var item = ref.item
                  return [
                    _c("div", { staticClass: "d-flex align-center py-1" }, [
                      _c(
                        "div",
                        { staticClass: "ml-1 caption font-weight-bold" },
                        [_c("copy-label", { attrs: { text: item.email } })],
                        1
                      )
                    ])
                  ]
                }
              },
              {
                key: "item.birthdate",
                fn: function(ref) {
                  var item = ref.item
                  return [
                    _c("div", [
                      _vm._v(_vm._s(_vm.calculateAge(item.birthdate)))
                    ])
                  ]
                }
              },
              {
                key: "item.email_verified_at",
                fn: function(ref) {
                  var item = ref.item
                  return [
                    _c(
                      "div",
                      { staticClass: "text-center" },
                      [
                        item.email_verified_at != null
                          ? _c(
                              "v-icon",
                              { attrs: { color: "primary", small: "" } },
                              [
                                _vm._v(
                                  "\n            mdi-checkbox-marked\n          "
                                )
                              ]
                            )
                          : _c("v-icon", { attrs: { small: "" } }, [
                              _vm._v(" mdi-checkbox-blank-outline ")
                            ])
                      ],
                      1
                    )
                  ]
                }
              },
              {
                key: "item.status",
                fn: function(ref) {
                  var item = ref.item
                  return [
                    item.status == "enabled" || item.status == "new"
                      ? _c(
                          "v-chip",
                          {
                            staticClass: "font-weight-bold",
                            attrs: { label: "", small: "", color: "primary" }
                          },
                          [_vm._v(_vm._s("Enable"))]
                        )
                      : _vm._e(),
                    _vm._v(" "),
                    item.status == "disabled"
                      ? _c(
                          "v-chip",
                          {
                            staticClass: "font-weight-bold",
                            attrs: { label: "", small: "", color: "undefined" }
                          },
                          [_vm._v(_vm._s("Disabled"))]
                        )
                      : _vm._e()
                  ]
                }
              },
              {
                key: "item.action",
                fn: function(ref) {
                  var item = ref.item
                  return [
                    _c(
                      "div",
                      { staticClass: "actions d-flex justify-content-between" },
                      [
                        _c(
                          "v-btn",
                          { attrs: { icon: "", to: "/users/edit/" + item.id } },
                          [_c("v-icon", [_vm._v("mdi-border-color")])],
                          1
                        ),
                        _vm._v(" "),
                        _c(
                          "v-btn",
                          {
                            attrs: {
                              loading: _vm.isLoading && _vm.iduser == item.id,
                              icon: ""
                            },
                            on: {
                              click: function($event) {
                                return _vm.disabledialog(
                                  item.id,
                                  item.name + " " + item.lastname
                                )
                              }
                            }
                          },
                          [_c("v-icon", [_vm._v("mdi-delete")])],
                          1
                        )
                      ],
                      1
                    )
                  ]
                }
              }
            ]),
            model: {
              value: _vm.selectedUsers,
              callback: function($$v) {
                _vm.selectedUsers = $$v
              },
              expression: "selectedUsers"
            }
          })
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
                _vm._v("Eliminar Usuario")
              ]),
              _vm._v(" "),
              _c("v-card-text", [
                _vm._v("¿Está seguro de que desea eliminar a "),
                _c("strong", [_vm._v(_vm._s(_vm.deleteDialogText))]),
                _vm._v("?")
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
                    [_vm._v("Cancelar")]
                  ),
                  _vm._v(" "),
                  _c(
                    "v-btn",
                    {
                      attrs: { color: "error", loading: _vm.isLoadingModal },
                      on: {
                        click: function($event) {
                          _vm.remove()
                          _vm.isLoadingModal = true
                        }
                      }
                    },
                    [_vm._v("Eliminar")]
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



/***/ })

}]);