import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store/index'

//引入全局reset.css样式文件：
import './assets/css/reset.css'

//引入ElementUI框架并使用：
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
Vue.use(ElementUI);

Vue.config.productionTip = false

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
