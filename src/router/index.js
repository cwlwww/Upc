import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    component: ()=>import('../views/main/main.vue'),
    children:[
      {
        path: 'menu',  
        meta:{
          title:'菜单管理'
        },
        component: ()=>import('../views/menu/menu.vue')
      },   
      {
        path: 'role',  
        meta:{
          title:'角色管理'
        },
        component: ()=>import('../views/roles/roles.vue')
      },           
      {
        path: 'user',  
        meta:{
          title:'管理员管理'
        },
        component: ()=>import('../views/user/user.vue')
      },           
      {
        path: 'category',  
        meta:{
          title:'商品分类'
        },
        component: ()=>import('../views/cate/cate.vue')
      },           
      {
        path: 'specs',  
        meta:{
          title:'商品规格'
        },
        component: ()=>import('../views/spec/spec.vue')
      },           
      {
        path: 'goods',  
        meta:{
          title:'商品规格'
        },
        component: ()=>import('../views/goods/goods.vue')
      },           
    ]
  },    
  {
    path: '/login',
    component: ()=>import('../views/login/login.vue')
  },

]

const router = new VueRouter({
  routes
})

export default router
