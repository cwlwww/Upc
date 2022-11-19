<template>
  <div>
    <!-- default-expand-all:是否展开所有行 -->
    <el-table
      :data="$store.state.goodsArr"
      style="width: 100%; margin-bottom: 20px"
      row-key="id"
      border
      :default-expand-all="false"
      :tree-props="{ children: 'children', hasChildren: 'hasChildren' }"
    >
      <el-table-column prop="id" label="商品编号" sortable width="80">
      </el-table-column>
      <el-table-column prop="goodsname" label="商品名称" sortable>
      </el-table-column>
      <el-table-column prop="price" label="商品价格" sortable>
      </el-table-column>
      <el-table-column prop="market_price" label="市场价格" sortable>
      </el-table-column>
      <el-table-column prop="icon" label="分类图片">
        <template slot-scope="scope">
          <img
            style="height: 100px"
            :src="scope.row.img != '' ? imgHost + scope.row.img : ''"
          />
        </template>
      </el-table-column>
      <el-table-column prop="isnew" label="是否新品">
        <template slot-scope="scope">
          <el-button v-if="scope.row.isnew == 1" type="success"
            >是</el-button
          >
          <el-button v-else type="warning">否</el-button>
        </template>
      </el-table-column>
      <el-table-column prop="ishot" label="是否热卖">
        <template slot-scope="scope">
          <el-button v-if="scope.row.isnew == 1" type="success"
            >是</el-button
          >
          <el-button v-else type="warning">否</el-button>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="300">
        <template slot-scope="scope">
          <el-button type="success" @click="1"
            >修改</el-button
          >
          <el-button type="danger" @click="delgoods(scope.row.id)"
            >删除</el-button
          >
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
      layout="prev, pager, next"
      :total="totals * 10"
      @current-change="getlist"
      :current-page.sync="page"
    >
    </el-pagination>
  </div>
</template>

<script>
import { getUserdelete, getUsercount, getUserlist } from "../../../request/api";
export default {
  methods: {
    delgoods(id){
      this.$store.dispatch('delGoods',id);
      this.$store.dispatch('getGoods');
    }
   }
};
</script>

<style>
</style>