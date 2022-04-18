import Vue from 'vue'
import App from './App.vue'
import './assets/css/global.less'
import './assets/css/fonts.css'
import './assets/css/base.less'
import store from './store/store.js'

import vSelect from 'vue-select'

Vue.component('v-select', vSelect)

require('buffer')


// For crypto library and browserify
global.Buffer = global.Buffer || require("buffer").Buffer; 

// I dunno
Vue.config.productionTip = false

// //Routing
// const routes = [
//   { path: '/', component: Principal },
//   { path: '/legal', component: Legal }
// ]

// const router = new VueRouter({
//   routes
// })

//Init with index.html
new Vue({
  render: h => h(App),
  store
  // router,
}).$mount('#app')
