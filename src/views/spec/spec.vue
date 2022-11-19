<template>
  <div>
    <el-button @click="obj.isshow=true" type="primary">添加</el-button>
       <list @refreshspac="refreshspac" @updateSpac="updateSpac" :spacArr="spacArr"></list>
	     <forms @refreshspac="refreshspac" ref="forms" :obj="obj" :spacArr="spacArr"></forms>
  </div>
</template>

<script>
import list from "./component/list.vue";
import forms from "./component/form.vue";
import { getGoodsSpec } from "../../request/api";

export default {
  mounted() {
    this.spacInit();
  },
  methods:{
    refreshspac(){  //刷新菜单菜单
       this.spacInit();
    },
    updateSpac(mid){
       this.obj.isshow = true;
       this.$refs.forms.getOnespecsone(mid);
    },
    spacInit(){  //菜单管理初始化：获取所有菜单数据
         getGoodsSpec().then(d=>{
            if(d.data.code == 200){
              this.spacArr = d.data.list
            }
         }).catch(e=>{
          console.log(`查询所有菜单接口调用失败`);
         })
    }
  },
   data() {
    return {
      spacArr:[],//所有菜单数据
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