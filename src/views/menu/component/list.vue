<template>
  <div>
  <!-- default-expand-all:是否展开所有行 -->
	<el-table 
		:data="menuArr"
		style="width: 100%;margin-bottom: 20px;"
		row-key="id"
		border
		:default-expand-all=false
		:tree-props="{children: 'children', hasChildren: 'hasChildren'}">
		<el-table-column
		prop="id"
		label="菜单编号"
		sortable
		width="180">
		</el-table-column>
		<el-table-column
		prop="title"
		label="菜单名称"
		sortable
		width="180">
		</el-table-column>
		<el-table-column prop="icon" label="菜单图标">
      <template slot-scope="scope">
       <i :class="scope.row.icon"></i>
      </template>
		</el-table-column>
	  <el-table-column
		prop="url"
		label="菜单地址">
		</el-table-column>    
	  <el-table-column prop="status" label="状态">
      <template slot-scope="scope">
        <el-button v-if="scope.row.status==1" type="success" disabled>启用</el-button>
        <el-button v-else type="warning" disabled>禁用</el-button>
      </template>
		</el-table-column>   
     <el-table-column label="操作">
     <template slot-scope="scope">
      <el-button type="success" @click="update(scope.row.id)">修改</el-button>
      <el-button type="danger" @click="deletes(scope.row.id)">删除</el-button>
     </template>
		</el-table-column>      
	</el-table>
  </div>
</template>

<script>
import { deleteMenu } from "../../../request/api";
export default {
  props:['menuArr'],
  data() {
    return {
      
    }
 },
 methods: {
  deletes(id){  //删除某一个菜单
      this.$confirm('确定要删除吗?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
              }).then(d=>{
                   deleteMenu({id}).then(d=>{
                      if(d.data.code == 200){
                        this.$message({
                          message: d.data.msg,
                          type: 'success'
                          });
                      }else{
                        this.$message({
                              message: d.data.msg,
                              type: 'warning'
                              });
                      }
                      //刷新列表中的数据：
                      this.$emit('refreshmenu');
                   }).catch(e=>{
                    console.log(`删除菜单接口调用失败`);
                   })
              })
  },
  update(id){
       this.$emit('updateMenu',id);
  }
 },
}
</script>

<style>

</style>