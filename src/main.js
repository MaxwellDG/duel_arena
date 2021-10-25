import Vue from 'vue'
import VueRouter from 'vue-router'
import App from './App.vue'
import './assets/css/global.css'
require('buffer')

import Principal from './screens/Principal.vue'
import Legal from './screens/Legal.vue'

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
  // router,
}).$mount('#app')
