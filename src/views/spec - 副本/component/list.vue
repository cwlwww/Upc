<template>
  <div>
  <!-- default-expand-all:是否展开所有行 -->
	<el-table 
		:data="spacArr"
		style="width: 100%;margin-bottom: 20px;"
		row-key="id"
		border
		:default-expand-all=false
		:tree-props="{children: 'children', hasChildren: 'hasChildren'}">
		<el-table-column
		prop="id"
		label="规格编号"
		sortable
		width="180">
		</el-table-column>
		<el-table-column
		prop="specsname"
		label="规格名称"
		sortable
		width="180">
		</el-table-column>
	  <el-table-column
		prop="attrs"
		label="规格属性">
    <template slot-scope="scope">
      <span style="background:green;color:#fff;padding:10px;margin:5px;display:inline-block" :key="ind" v-for="(item,ind) in scope.row.attrs">{{item}}</span>
    </template>
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
import { getSpecdelete } from "../../../request/api";
export default {
  props:['spacArr'],
  data() {
    return {
      
    }
 },
 methods: {
  deletes(id){  //删除某一个规格
      this.$confirm('确定要删除吗?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
              }).then(d=>{
                   getSpecdelete({id}).then(d=>{
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
                      this.$emit('refreshspac');
                   }).catch(e=>{
                    console.log(`删除规格接口调用失败`);
                   })
              })
  },
  update(id){
       this.$emit('updateSpac',id);
  }
 },
}
</script>

<style>

</style>