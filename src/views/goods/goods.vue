<template>
  <div>
    <el-button @click="obj.isshow=true" type="primary">添加</el-button>
       <list></list>
	     <forms :obj='obj'></forms>
  </div>
</template>

<script>
import list from "./component/list.vue";
import forms from "./component/form.vue";

export default {
  mounted() {
    // 调用仓库的方法,获取商品列表数据
    this.$store.dispatch('getGoods');
  },
  methods:{
    updateMenu(uid){
       this.obj.isshow = true;
       this.$refs.forms.getUserinfo(uid);
    },
  },
   data() {
    return {
      obj:{
        isshow:false
      },
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