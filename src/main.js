import { createApp } from 'vue'
import VueToast from 'vue-toast-notification'
import App from './App.vue'
import './assets/css/global.less'
import './assets/css/fonts.css'
import './assets/css/base.less'
import store from './store/store.js'

import vSelect from 'vue-select';
import 'vue-select/dist/vue-select.css';


const app = createApp(App)

// For crypto and browserify
require('buffer')
global.Buffer = global.Buffer || require("buffer").Buffer; 

app.config.productionTip = false

app.component('v-select', vSelect)
app.use(store)
// app.use(VueToast, {
//   position: 'bottom'
// })

app.mount('#app');

