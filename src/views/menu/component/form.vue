<template>
  <div>
    <!-- ElementUI:对话框 -->
    <el-dialog
      :title="curid == '' ? '添加菜单' : '修改菜单'"
      :visible.sync="obj.isshow"
    >
      <el-form :model="form">
        <el-form-item label="菜单名称" :label-width="formLabelWidth">
          <el-input v-model="form.title" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="上级菜单" :label-width="formLabelWidth">
          <el-select v-model="form.pid" placeholder="请选择上级菜单">
            <el-option label="根目录" value="0">
            </el-option>
            <el-option
              :key="item.id"
              v-for="item in menuArr"
              :label="item.title"
              :value="item.id"
              >{{ item.title }}</el-option
            >
          </el-select>
        </el-form-item>
        <el-form-item label="菜单类型" :label-width="formLabelWidth">
          <el-radio v-model="form.type" label="1" value="1">目录</el-radio>
          <el-radio v-model="form.type" label="2" value="2">菜单</el-radio>
        </el-form-item>
        <el-form-item label="菜单地址" :label-width="formLabelWidth">
          <el-input v-model="form.url" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item
          label="菜单图标"
          v-show="form.type == 1"
          :label-width="formLabelWidth"
        >
          <el-select v-model="form.icon" placeholder="请选择菜单图标">
            <el-option :key="item" v-for="item in iconArr" :value="item">
              <template>
                <i :class="item"></i>
              </template>
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item
          label="菜单地址"
          v-show="form.type == 2"
          :label-width="formLabelWidth"
        >
          <el-input v-model="form.url" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="状态" :label-width="formLabelWidth">
          <!-- 
				active-value:switch打开时的值
                inactive-value:switch关闭时的值
			 -->
          <el-switch
            active-color="#13ce66"
            inactive-color="#ff4949"
            active-value="1"
            inactive-value="2"
            v-model="form.status + ''"
          >
          </el-switch>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="obj.isshow = false">取 消</el-button>
        <el-button v-if="curid == ''" type="primary" @click="addmenu"
          >添加</el-button
        >
        <el-button v-else type="primary" @click="modifymenu">修改</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { successMsg, failMsg } from "../../../tools/tools";
import { addMenu, getOneMenus, modifyMenu } from "../../../request/api";
import common from "../../../mixin/index";

export default {
  props: ["obj", "menuArr"],
  mixins: [common],
  data() {
    return {
      curid: "", //要修改的菜单id
      //菜单字体图标
      iconArr: [
        "el-icon-location",
        "el-icon-menu",
        "el-icon-document",
        "el-icon-setting",
      ],
      // formLabelWidth: '120px',
      form: {
        pid: "", //上级菜单id
        title: "", //菜单名称
        icon: "", //菜单图标
        type: "1", //菜单类型 1为目录 2为菜单
        url: "", //菜单地址
        status: "1", //状态   1正常 2禁用
      },
    };
  },
  methods: {
    empty() {
      //3.重置表单数据
      this.curid = "";
      this.form = {
        pid: "", //上级菜单id
        title: "", //菜单名称
        icon: "", //菜单图标
        type: "1", //菜单类型 1为目录 2为菜单
        url: "", //菜单地址
        status: "1", //状态   1正常 2禁用
      };
    },
    modifymenu() {
      //修改菜单
      let obj = {
        ...this.form,
        id: this.curid,
      };

      modifyMenu(obj)
        .then((d) => {
          //1.修改提示信息
          if (d.data.code == 200) {
            //修改成功
            successMsg(d.data.msg);
          } else {
            //修改失败
            failMsg(d.data.msg);
          }
          //2.关闭弹窗
          this.obj.isshow = false;
          //3.重置表单数据
          this.empty();
          // this.curid = '';
          // 	this.form={
          // 	pid:'',//上级菜单id
          // 	title:'',//菜单名称
          // 	icon:'',//菜单图标
          // 	type:'1',//菜单类型 1为目录 2为菜单
          // 	url:'', //菜单地址
          // 	status:'1',//状态   1正常 2禁用
          // }
          //4.刷新列表中的菜单数据：
          this.$emit("refreshmenu");
        })
        .catch((e) => {
          console.log("修改菜单接口调用失败");
        });
    },
    getOneMenuInfo(id) {
      this.curid = id;
      //根据要修改的菜单id查询菜单数据
      getOneMenus({ id })
        .then((d) => {
          if (d.data.code == 200) {
            this.form = d.data.list;
            console.log(this.form, 8888);
          }
        })
        .catch((e) => {
          console.log("根据id查询菜单数据接口调用失败");
        });
    },
    addmenu() {
      //添加菜单
      addMenu(this.form)
        .then((d) => {
          //1.提示用户
          if (d.data.code == 200) {
            //添加成功
            successMsg(d.data.msg);
            // this.$message({
            // 	message: d.data.msg,
            // 	type: 'success'
            // 	});
          } else {
            // this.$message({
            // 		message: d.data.msg,
            // 		type: 'warning'
            // 		});
            failMsg(d.data.msg);
          }

          //2.关闭添加弹窗
          this.obj.isshow = false;

          //3.重置表单数据
          this.empty();
          //    this.curid = '';
          //   this.form={
          // 	pid:'',//上级菜单id
          // 	title:'',//菜单名称
          // 	icon:'',//菜单图标
          // 	type:'1',//菜单类型 1为目录 2为菜单
          // 	url:'', //菜单地址
          // 	status:'1',//状态   1正常 2禁用
          //   }
          //4.刷新列表中的菜单数据：
          this.$emit("refreshmenu");
        })
        .catch((e) => {
          console.log(`添加菜单接口调用失败`);
        });
    },
  },
};
</script>

<style>
</style>