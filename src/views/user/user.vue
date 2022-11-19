<template>
  <div>
    <el-button @click="obj.isshow=true" type="primary">添加</el-button>
       <list @refreshmenu="refreshmenu" @menuInit="menuInit" @updateMenu="updateMenu" :menuArr="menuArr" :counts="counts"></list>
	     <forms @refreshmenu="refreshmenu" ref="forms" :obj="obj" :menuArr="menuArr"></forms>
  </div>
</template>

<script>
import list from "./component/list.vue";
import forms from "./component/form.vue";
import { getUserlist } from "../../request/api";

export default {
  mounted() {
    this.menuInit();
  },
  methods:{
    refreshmenu(){  //刷新菜单菜单
       this.menuInit();
    },
    updateMenu(uid){
       this.obj.isshow = true;
       this.$refs.forms.getUserinfo(uid);
    },
    menuInit(){  //菜单管理初始化：获取所有菜单数据
         getUserlist(this.counts).then(d=>{
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
      },
      counts:{size:5,page:1}
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