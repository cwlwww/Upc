<template>
  <div>
    <!-- ElementUI:布局容器 -->
	<el-container>
	<el-aside width="200px">
	    <!-- ElementUI:导航菜单 
		   unique-opened:是否保持某一个子菜单展开
		   router:是否使用vue-router路由
		-->
		<el-row>
		<el-col>
			<el-menu :unique-opened=true
			default-active="0"  :router=true
			class="el-menu-vertical-demo"
			background-color="#545c64"
			text-color="#fff"
			active-text-color="#ffd04b">
			<el-menu-item index="/">
				<i class="el-icon-menu"></i>
				<span slot="title">首页</span>
			</el-menu-item>	
			<el-submenu v-for="(item,ind) in menuArr" :key="ind" :index="ind+1">
				<template slot="title">
				<i class="el-icon-location"></i>
				<span>{{item.title}}</span>
				</template>
				<el-menu-item v-for="(menu,index) in item.children" :key="index" :index="menu.url">{{menu.title}}</el-menu-item>
			</el-submenu>
			</el-menu>
			
		</el-col>
		</el-row>	
	</el-aside>
	<el-container>
		<el-header>
		  <p>欢迎您：{{uname}}回来！  单击这里<a href="javascript:;" @click="logout">退出系统</a></p>
		</el-header>
		<el-main>
		     <!-- ElementUI:面包屑 -->
		   <el-breadcrumb separator-class="el-icon-arrow-right">
			<el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
			<el-breadcrumb-item>{{$route.meta.title}}</el-breadcrumb-item>
			</el-breadcrumb>
		   <!-- 设置路由出口 -->
		   <router-view></router-view>
		</el-main>
	</el-container>
	</el-container>  
  </div>
</template>

<script>
import {successMsg,failMsg} from '../../tools/tools'

export default {
  data() {
	return {
		menuArr:[],//已登录用户所分配的菜单数据
		uname:''//已登录用户的帐号名
	}
  },
  methods: {
	logout(){  //退出用户登录
       //清除sessionStorage中的用户登录数据：
	   sessionStorage.removeItem('managerInfo');
	   //跳转到用户登录界面： 
	   this.$router.push('/login');
	},
	getCurUserInfo(){  //获取已登录的用户信息：
         let managerInfoObj =  sessionStorage['managerInfo']?JSON.parse(sessionStorage['managerInfo']):'';
		 if(managerInfoObj == ''){  //未登录
              failMsg('请先登录');
			  this.$router.push('/login');
		 }else{  //已登录
             this.uname = managerInfoObj.username;//已登录的帐号名
			 //已登录用户所分配的菜单数据
			 this.menuArr = managerInfoObj.menus; 
		 }
	}
  },
  mounted() {
	this.getCurUserInfo();
  },
}
</script>

<style scoped>
.el-aside{
	height: 100vh;
	background-color: #545C64;
}

.el-header{
	height: 100px;
	background-color: #B3C0D1;
}

.el-breadcrumb{
	margin-bottom: 10px;
}
</style>