<template>
  <div>
    <el-button @click="obj.isshow=true" type="primary">添加</el-button>
       <list @refreshmenu="refreshmenu" @updateMenu="updateMenu" :menuArr="menuArr"></list>
	     <forms @refreshmenu="refreshmenu" ref="forms" :obj="obj" :menuArr="menuArr"></forms>
  </div>
</template>

<script>
import list from "./component/list.vue";
import forms from "./component/form.vue";
import { getRole } from "../../request/api";

export default {
  mounted() {
    this.menuInit();
  },
  methods:{
    refreshmenu(){  //刷新菜单菜单
       this.menuInit();
    },
    updateMenu(mid){
       this.obj.isshow = true;
       this.$refs.forms.getOneRoleInfo(mid);
    },
    menuInit(){  //菜单管理初始化：获取所有菜单数据
         getRole().then(d=>{
            if(d.data.code == 200){
              this.menuArr = d.data.list
              console.log(d.data.list);
            }
         }).catch(e=>{
          console.log(`查询所有菜单接口调用失败`);
         })
    }
  },
   data() {
    return {
      menuArr:[],//所有菜单数据
      obj:{
        isshow:false
      }
    }
   },
   components:{
    list,
    forms
   },
}
</script>

<style>

</style>