import Vue from 'vue'
import moment from 'moment-timezone'
import store from '../store'

Vue.filter('formatTime', (value, filterFormat) => {
  const { zone, format } = store.state.app.time

  if (value) {
    return moment(String(value)).format('LT')
 }

  return ''
});