(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["dashboard"],{

/***/ "./node_modules/babel-loader/lib/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/components/common/TrendPercent.vue?vue&type=script&lang=js&":
/*!******************************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib??ref--4-0!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/components/common/TrendPercent.vue?vue&type=script&lang=js& ***!
  \******************************************************************************************************************************************************************************/
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

/*
|---------------------------------------------------------------------
| Trend Percent Component
|---------------------------------------------------------------------
|
| Shows and up or down arrow with green or red color presenting the
| trend of the given value
|
*/
/* harmony default export */ __webpack_exports__["default"] = ({
  props: {
    value: {
      type: Number,
      "default": 0
    }
  }
});

/***/ }),

/***/ "./node_modules/babel-loader/lib/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/components/dashboard/SalesCard.vue?vue&type=script&lang=js&":
/*!******************************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib??ref--4-0!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/components/dashboard/SalesCard.vue?vue&type=script&lang=js& ***!
  \******************************************************************************************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var moment__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! moment */ "./node_modules/moment/moment.js");
/* harmony import */ var moment__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(moment__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var vue_apexcharts__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! vue-apexcharts */ "./node_modules/vue-apexcharts/dist/vue-apexcharts.js");
/* harmony import */ var vue_apexcharts__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(vue_apexcharts__WEBPACK_IMPORTED_MODULE_1__);
/* harmony import */ var _common_TrendPercent__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../common/TrendPercent */ "./resources/js/components/common/TrendPercent.vue");
function ownKeys(object, enumerableOnly) { var keys = Object.keys(object); if (Object.getOwnPropertySymbols) { var symbols = Object.getOwnPropertySymbols(object); if (enumerableOnly) symbols = symbols.filter(function (sym) { return Object.getOwnPropertyDescriptor(object, sym).enumerable; }); keys.push.apply(keys, symbols); } return keys; }

function _objectSpread(target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i] != null ? arguments[i] : {}; if (i % 2) { ownKeys(Object(source), true).forEach(function (key) { _defineProperty(target, key, source[key]); }); } else if (Object.getOwnPropertyDescriptors) { Object.defineProperties(target, Object.getOwnPropertyDescriptors(source)); } else { ownKeys(Object(source)).forEach(function (key) { Object.defineProperty(target, key, Object.getOwnPropertyDescriptor(source, key)); }); } } return target; }

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//




function formatDate(date) {
  return date ? moment__WEBPACK_IMPORTED_MODULE_0___default()(date).format('D MMM') : '';
}
/*
|---------------------------------------------------------------------
| DEMO Dashboard Card Component
|---------------------------------------------------------------------
|
| Demo card component to be used to gather some ideas on how to build
| your own dashboard component
|
*/


/* harmony default export */ __webpack_exports__["default"] = ({
  components: {
    TrendPercent: _common_TrendPercent__WEBPACK_IMPORTED_MODULE_2__["default"]
  },
  props: {
    value: {
      type: Number,
      "default": 0
    },
    percentage: {
      type: Number,
      "default": 0
    },
    percentageLabel: {
      type: String,
      "default": 'vs. last week'
    },
    series: {
      type: Array,
      "default": function _default() {
        return [{
          name: 'Sales',
          data: [11, 32, 45, 32, 34, 52, 41]
        }];
      }
    },
    xaxis: {
      type: Object,
      "default": function _default() {
        return {
          type: 'datetime',
          categories: ['2018-09-19T00:00:00.000Z', '2018-09-20T00:00:00.000Z', '2018-09-21T00:00:00.000Z', '2018-09-22T00:00:00.000Z', '2018-09-23T00:00:00.000Z', '2018-09-24T00:00:00.000Z', '2018-09-25T00:00:00.000Z']
        };
      }
    },
    label: {
      type: String,
      "default": 'dashboard.sales'
    },
    actionLabel: {
      type: String,
      "default": 'View Report'
    },
    options: {
      type: Object,
      "default": function _default() {
        return {};
      }
    },
    loading: {
      type: Boolean,
      "default": false
    }
  },
  computed: {
    chartOptions: function chartOptions() {
      var primaryColor = this.$vuetify.theme.isDark ? this.$vuetify.theme.themes.dark.primary : this.$vuetify.theme.themes.light.primary;
      return _objectSpread({
        chart: {
          height: 120,
          type: 'area',
          sparkline: {
            enabled: true
          },
          animations: {
            speed: 400
          }
        },
        colors: [primaryColor],
        fill: {
          type: 'solid',
          colors: [primaryColor],
          opacity: 0.15
        },
        stroke: {
          curve: 'smooth',
          width: 2
        },
        xaxis: this.xaxis,
        tooltip: {
          followCursor: true,
          theme: 'dark',
          custom: function custom(_ref) {
            var ctx = _ref.ctx,
                series = _ref.series,
                seriesIndex = _ref.seriesIndex,
                dataPointIndex = _ref.dataPointIndex,
                w = _ref.w;
            var seriesName = w.config.series[seriesIndex].name;
            return "<div class=\"rounded-lg pa-1 caption\">\n              <div class=\"font-weight-bold\">".concat(formatDate(w.globals.labels[dataPointIndex]), "</div>\n              <div>").concat(series[seriesIndex][dataPointIndex], " ").concat(seriesName, "</div>\n            </div>");
          }
        }
      }, this.options);
    }
  }
});

/***/ }),

/***/ "./node_modules/babel-loader/lib/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/dashboard/DashboardPage.vue?vue&type=script&lang=js&":
/*!*****************************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib??ref--4-0!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/pages/dashboard/DashboardPage.vue?vue&type=script&lang=js& ***!
  \*****************************************************************************************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _components_dashboard_SalesCard__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../components/dashboard/SalesCard */ "./resources/js/components/dashboard/SalesCard.vue");
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// DEMO Cards for dashboard

/* harmony default export */ __webpack_exports__["default"] = ({
  components: {
    SalesCard: _components_dashboard_SalesCard__WEBPACK_IMPORTED_MODULE_0__["default"]
  },
  data: function data() {
    return {
      loadingInterval: null,
      isLoading1: true
    };
  },
  mounted: function mounted() {
    var _this = this;

    var count = 0; // DEMO delay for loading graphics

    this.loadingInterval = setInterval(function () {
      _this["isLoading".concat(count++)] = false;
      if (count === 4) _this.clear();
    }, 400);
  },
  beforeDestroy: function beforeDestroy() {
    this.clear();
  },
  methods: {
    clear: function clear() {
      clearInterval(this.loadingInterval);
    }
  }
});

/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/components/common/TrendPercent.vue?vue&type=template&id=6f6641b1&":
/*!**********************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/components/common/TrendPercent.vue?vue&type=template&id=6f6641b1& ***!
  \**********************************************************************************************************************************************************************************************************************/
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
  return _c("span", [
    _vm.value === 0
      ? _c("span", [_vm._v("\n    " + _vm._s(_vm.value) + "%\n  ")])
      : _vm.value > 0
      ? _c(
          "span",
          { staticClass: "success--text" },
          [
            _c("v-icon", { attrs: { small: "", color: "success" } }, [
              _vm._v("mdi-arrow-top-right")
            ]),
            _vm._v(" " + _vm._s(_vm.value) + "%\n  ")
          ],
          1
        )
      : _c(
          "span",
          { staticClass: "error--text" },
          [
            _c("v-icon", { attrs: { small: "", color: "error" } }, [
              _vm._v("mdi-arrow-bottom-right")
            ]),
            _vm._v(" " + _vm._s(Math.abs(_vm.value)) + "%\n  ")
          ],
          1
        )
  ])
}
var staticRenderFns = []
render._withStripped = true



/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/components/dashboard/SalesCard.vue?vue&type=template&id=269e3434&":
/*!**********************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/components/dashboard/SalesCard.vue?vue&type=template&id=269e3434& ***!
  \**********************************************************************************************************************************************************************************************************************/
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
    { staticClass: "d-flex flex-grow-1 primary darken-4", attrs: { dark: "" } },
    [
      _vm.loading
        ? _c(
            "div",
            { staticClass: "d-flex flex-grow-1 align-center justify-center" },
            [
              _c("v-progress-circular", {
                attrs: { indeterminate: "", color: "primary" }
              })
            ],
            1
          )
        : _c(
            "div",
            { staticClass: "d-flex flex-column flex-grow-1" },
            [
              _c(
                "v-card-title",
                [
                  _c("div", [_vm._v(_vm._s(_vm.$t(_vm.label)))]),
                  _vm._v(" "),
                  _c("v-spacer"),
                  _vm._v(" "),
                  _c(
                    "v-btn",
                    {
                      attrs: { text: "", color: "primary" },
                      on: {
                        click: function($event) {
                          return _vm.$emit("action-clicked")
                        }
                      }
                    },
                    [_vm._v(_vm._s(_vm.actionLabel))]
                  )
                ],
                1
              ),
              _vm._v(" "),
              _c(
                "div",
                { staticClass: "d-flex flex-column flex-grow-1" },
                [
                  _c("div", { staticClass: "pa-2" }, [
                    _c("div", { staticClass: "text-h4" }, [
                      _vm._v(
                        "\n          " +
                          _vm._s(_vm._f("formatCurrency")(26358.49)) +
                          "\n        "
                      )
                    ]),
                    _vm._v(" "),
                    _c(
                      "div",
                      { staticClass: "primary--text text--lighten-1 mt-1" },
                      [
                        _vm._v(
                          "\n          " +
                            _vm._s(_vm._f("formatCurrency")(7123.21)) +
                            " " +
                            _vm._s(_vm.$t("dashboard.lastweek")) +
                            "\n        "
                        )
                      ]
                    )
                  ]),
                  _vm._v(" "),
                  _c("v-spacer"),
                  _vm._v(" "),
                  _c("div", { staticClass: "px-2 pb-2" }, [
                    _c("div", { staticClass: "title mb-1" }, [
                      _vm._v(_vm._s(_vm.$t("dashboard.weeklySales")))
                    ]),
                    _vm._v(" "),
                    _c(
                      "div",
                      { staticClass: "d-flex align-center" },
                      [
                        _c("div", { staticClass: "text-h4" }, [
                          _vm._v(
                            "\n            " +
                              _vm._s(_vm._f("formatCurrency")(_vm.value)) +
                              "\n          "
                          )
                        ]),
                        _vm._v(" "),
                        _c("v-spacer"),
                        _vm._v(" "),
                        _c(
                          "div",
                          { staticClass: "d-flex flex-column text-right" },
                          [
                            _c(
                              "div",
                              { staticClass: "font-weight-bold" },
                              [
                                _c("trend-percent", {
                                  attrs: { value: _vm.percentage }
                                })
                              ],
                              1
                            ),
                            _vm._v(" "),
                            _c("div", { staticClass: "caption" }, [
                              _vm._v(_vm._s(_vm.percentageLabel))
                            ])
                          ]
                        )
                      ],
                      1
                    )
                  ])
                ],
                1
              ),
              _vm._v(" "),
              _c("apexchart", {
                attrs: {
                  type: "area",
                  height: "120",
                  options: _vm.chartOptions,
                  series: _vm.series
                }
              })
            ],
            1
          )
    ]
  )
}
var staticRenderFns = []
render._withStripped = true



/***/ }),

/***/ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/dashboard/DashboardPage.vue?vue&type=template&id=0fc7bce2&":
/*!*********************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/vue-loader/lib??vue-loader-options!./resources/js/pages/dashboard/DashboardPage.vue?vue&type=template&id=0fc7bce2& ***!
  \*********************************************************************************************************************************************************************************************************************/
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
    { staticClass: "d-flex flex-grow-1 flex-column" },
    [
      _c(
        "v-row",
        { staticClass: "flex-grow-0", attrs: { dense: "" } },
        [
          _c(
            "v-col",
            { attrs: { cols: "12" } },
            [
              _c("sales-card", {
                staticClass: "h-full",
                staticStyle: { "min-height": "380px" },
                attrs: {
                  value: 1837.32,
                  percentage: 3.2,
                  loading: _vm.isLoading1,
                  "percentage-label": _vm.$t("dashboard.lastweek"),
                  "action-label": _vm.$t("dashboard.viewReport")
                }
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

/***/ "./resources/js/components/common/TrendPercent.vue":
/*!*********************************************************!*\
  !*** ./resources/js/components/common/TrendPercent.vue ***!
  \*********************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _TrendPercent_vue_vue_type_template_id_6f6641b1___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./TrendPercent.vue?vue&type=template&id=6f6641b1& */ "./resources/js/components/common/TrendPercent.vue?vue&type=template&id=6f6641b1&");
/* harmony import */ var _TrendPercent_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./TrendPercent.vue?vue&type=script&lang=js& */ "./resources/js/components/common/TrendPercent.vue?vue&type=script&lang=js&");
/* empty/unused harmony star reexport *//* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ "./node_modules/vue-loader/lib/runtime/componentNormalizer.js");





/* normalize component */

var component = Object(_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__["default"])(
  _TrendPercent_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__["default"],
  _TrendPercent_vue_vue_type_template_id_6f6641b1___WEBPACK_IMPORTED_MODULE_0__["render"],
  _TrendPercent_vue_vue_type_template_id_6f6641b1___WEBPACK_IMPORTED_MODULE_0__["staticRenderFns"],
  false,
  null,
  null,
  null
  
)

/* hot reload */
if (false) { var api; }
component.options.__file = "resources/js/components/common/TrendPercent.vue"
/* harmony default export */ __webpack_exports__["default"] = (component.exports);

/***/ }),

/***/ "./resources/js/components/common/TrendPercent.vue?vue&type=script&lang=js&":
/*!**********************************************************************************!*\
  !*** ./resources/js/components/common/TrendPercent.vue?vue&type=script&lang=js& ***!
  \**********************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_babel_loader_lib_index_js_ref_4_0_node_modules_vue_loader_lib_index_js_vue_loader_options_TrendPercent_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/babel-loader/lib??ref--4-0!../../../../node_modules/vue-loader/lib??vue-loader-options!./TrendPercent.vue?vue&type=script&lang=js& */ "./node_modules/babel-loader/lib/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/components/common/TrendPercent.vue?vue&type=script&lang=js&");
/* empty/unused harmony star reexport */ /* harmony default export */ __webpack_exports__["default"] = (_node_modules_babel_loader_lib_index_js_ref_4_0_node_modules_vue_loader_lib_index_js_vue_loader_options_TrendPercent_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__["default"]); 

/***/ }),

/***/ "./resources/js/components/common/TrendPercent.vue?vue&type=template&id=6f6641b1&":
/*!****************************************************************************************!*\
  !*** ./resources/js/components/common/TrendPercent.vue?vue&type=template&id=6f6641b1& ***!
  \****************************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_TrendPercent_vue_vue_type_template_id_6f6641b1___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../node_modules/vue-loader/lib??vue-loader-options!./TrendPercent.vue?vue&type=template&id=6f6641b1& */ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/components/common/TrendPercent.vue?vue&type=template&id=6f6641b1&");
/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "render", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_TrendPercent_vue_vue_type_template_id_6f6641b1___WEBPACK_IMPORTED_MODULE_0__["render"]; });

/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "staticRenderFns", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_TrendPercent_vue_vue_type_template_id_6f6641b1___WEBPACK_IMPORTED_MODULE_0__["staticRenderFns"]; });



/***/ }),

/***/ "./resources/js/components/dashboard/SalesCard.vue":
/*!*********************************************************!*\
  !*** ./resources/js/components/dashboard/SalesCard.vue ***!
  \*********************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _SalesCard_vue_vue_type_template_id_269e3434___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./SalesCard.vue?vue&type=template&id=269e3434& */ "./resources/js/components/dashboard/SalesCard.vue?vue&type=template&id=269e3434&");
/* harmony import */ var _SalesCard_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./SalesCard.vue?vue&type=script&lang=js& */ "./resources/js/components/dashboard/SalesCard.vue?vue&type=script&lang=js&");
/* empty/unused harmony star reexport *//* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ "./node_modules/vue-loader/lib/runtime/componentNormalizer.js");





/* normalize component */

var component = Object(_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__["default"])(
  _SalesCard_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__["default"],
  _SalesCard_vue_vue_type_template_id_269e3434___WEBPACK_IMPORTED_MODULE_0__["render"],
  _SalesCard_vue_vue_type_template_id_269e3434___WEBPACK_IMPORTED_MODULE_0__["staticRenderFns"],
  false,
  null,
  null,
  null
  
)

/* hot reload */
if (false) { var api; }
component.options.__file = "resources/js/components/dashboard/SalesCard.vue"
/* harmony default export */ __webpack_exports__["default"] = (component.exports);

/***/ }),

/***/ "./resources/js/components/dashboard/SalesCard.vue?vue&type=script&lang=js&":
/*!**********************************************************************************!*\
  !*** ./resources/js/components/dashboard/SalesCard.vue?vue&type=script&lang=js& ***!
  \**********************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_babel_loader_lib_index_js_ref_4_0_node_modules_vue_loader_lib_index_js_vue_loader_options_SalesCard_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/babel-loader/lib??ref--4-0!../../../../node_modules/vue-loader/lib??vue-loader-options!./SalesCard.vue?vue&type=script&lang=js& */ "./node_modules/babel-loader/lib/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/components/dashboard/SalesCard.vue?vue&type=script&lang=js&");
/* empty/unused harmony star reexport */ /* harmony default export */ __webpack_exports__["default"] = (_node_modules_babel_loader_lib_index_js_ref_4_0_node_modules_vue_loader_lib_index_js_vue_loader_options_SalesCard_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__["default"]); 

/***/ }),

/***/ "./resources/js/components/dashboard/SalesCard.vue?vue&type=template&id=269e3434&":
/*!****************************************************************************************!*\
  !*** ./resources/js/components/dashboard/SalesCard.vue?vue&type=template&id=269e3434& ***!
  \****************************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_SalesCard_vue_vue_type_template_id_269e3434___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../node_modules/vue-loader/lib??vue-loader-options!./SalesCard.vue?vue&type=template&id=269e3434& */ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/components/dashboard/SalesCard.vue?vue&type=template&id=269e3434&");
/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "render", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_SalesCard_vue_vue_type_template_id_269e3434___WEBPACK_IMPORTED_MODULE_0__["render"]; });

/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "staticRenderFns", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_SalesCard_vue_vue_type_template_id_269e3434___WEBPACK_IMPORTED_MODULE_0__["staticRenderFns"]; });



/***/ }),

/***/ "./resources/js/pages/dashboard/DashboardPage.vue":
/*!********************************************************!*\
  !*** ./resources/js/pages/dashboard/DashboardPage.vue ***!
  \********************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _DashboardPage_vue_vue_type_template_id_0fc7bce2___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./DashboardPage.vue?vue&type=template&id=0fc7bce2& */ "./resources/js/pages/dashboard/DashboardPage.vue?vue&type=template&id=0fc7bce2&");
/* harmony import */ var _DashboardPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./DashboardPage.vue?vue&type=script&lang=js& */ "./resources/js/pages/dashboard/DashboardPage.vue?vue&type=script&lang=js&");
/* empty/unused harmony star reexport *//* harmony import */ var _node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../../node_modules/vue-loader/lib/runtime/componentNormalizer.js */ "./node_modules/vue-loader/lib/runtime/componentNormalizer.js");





/* normalize component */

var component = Object(_node_modules_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__["default"])(
  _DashboardPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_1__["default"],
  _DashboardPage_vue_vue_type_template_id_0fc7bce2___WEBPACK_IMPORTED_MODULE_0__["render"],
  _DashboardPage_vue_vue_type_template_id_0fc7bce2___WEBPACK_IMPORTED_MODULE_0__["staticRenderFns"],
  false,
  null,
  null,
  null
  
)

/* hot reload */
if (false) { var api; }
component.options.__file = "resources/js/pages/dashboard/DashboardPage.vue"
/* harmony default export */ __webpack_exports__["default"] = (component.exports);

/***/ }),

/***/ "./resources/js/pages/dashboard/DashboardPage.vue?vue&type=script&lang=js&":
/*!*********************************************************************************!*\
  !*** ./resources/js/pages/dashboard/DashboardPage.vue?vue&type=script&lang=js& ***!
  \*********************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_babel_loader_lib_index_js_ref_4_0_node_modules_vue_loader_lib_index_js_vue_loader_options_DashboardPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/babel-loader/lib??ref--4-0!../../../../node_modules/vue-loader/lib??vue-loader-options!./DashboardPage.vue?vue&type=script&lang=js& */ "./node_modules/babel-loader/lib/index.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/dashboard/DashboardPage.vue?vue&type=script&lang=js&");
/* empty/unused harmony star reexport */ /* harmony default export */ __webpack_exports__["default"] = (_node_modules_babel_loader_lib_index_js_ref_4_0_node_modules_vue_loader_lib_index_js_vue_loader_options_DashboardPage_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__["default"]); 

/***/ }),

/***/ "./resources/js/pages/dashboard/DashboardPage.vue?vue&type=template&id=0fc7bce2&":
/*!***************************************************************************************!*\
  !*** ./resources/js/pages/dashboard/DashboardPage.vue?vue&type=template&id=0fc7bce2& ***!
  \***************************************************************************************/
/*! exports provided: render, staticRenderFns */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_DashboardPage_vue_vue_type_template_id_0fc7bce2___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../node_modules/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../node_modules/vue-loader/lib??vue-loader-options!./DashboardPage.vue?vue&type=template&id=0fc7bce2& */ "./node_modules/vue-loader/lib/loaders/templateLoader.js?!./node_modules/vue-loader/lib/index.js?!./resources/js/pages/dashboard/DashboardPage.vue?vue&type=template&id=0fc7bce2&");
/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "render", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_DashboardPage_vue_vue_type_template_id_0fc7bce2___WEBPACK_IMPORTED_MODULE_0__["render"]; });

/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "staticRenderFns", function() { return _node_modules_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_node_modules_vue_loader_lib_index_js_vue_loader_options_DashboardPage_vue_vue_type_template_id_0fc7bce2___WEBPACK_IMPORTED_MODULE_0__["staticRenderFns"]; });



/***/ })

}]);