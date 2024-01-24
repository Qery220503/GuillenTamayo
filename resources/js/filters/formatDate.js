import Vue from 'vue'
import moment from 'moment-timezone'
import store from '../store'

moment.locale('es');
Vue.filter('formatDate', (value, filterFormat) => {
  const { zone, format } = store.state.app.time

  if (value) {
    return moment(value).tz(zone).format(filterFormat || format || 'lll')
  }

  return ''
});

Vue.filter('formatDateShort', (value, filterFormat) => {
  const { zone, format } = store.state.app.time

  if (value) {
    return moment(value).tz(zone).format('L')
  }

  return ''
})

Vue.filter('formatDateTime', (value, filterFormat) => {
  const { zone, format } = store.state.app.time

  if (value) {
    return moment(value).tz(zone).format('L LT')
  }

  return ''
})

Vue.filter('formatTime', (value, filterFormat) => {
  const { zone, format } = store.state.app.time

  if (value) {
    return moment(value).tz(zone).format('LT')
  }

  return ''
})

Vue.filter('formatDateGeneral', function(value) {
  if (value) {
    return moment(String(value)).format('DD/MM/YY');
  }
})
