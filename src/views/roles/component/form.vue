<template>
  <div>
    <!-- ElementUI:对话框 -->
    <el-dialog
      :title="curid == '' ? '添加角色' : '修改角色'"
      :visible.sync="obj.isshow"
    >
      <el-form :model="form">
        <el-form-item label="角色名称" :label-width="formLabelWidth">
          <el-input v-model="form.rolename" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="角色权限" :label-width="formLabelWidth">
          <!-- elementUI:树形控件 -->
          <el-tree
            :data="data"
            show-checkbox
            node-key="id"
            ref="tree"
            :default-expand-all="true"
            :props="defaultProps"
          >
          </el-tree>
        </el-form-item>
        <el-form-item label="状态" :label-width="formLabelWidth">
          <!-- 
				active-value:switch打开时的值
                 inactive-value:switch关闭时的值
			 -->
          <el-switch
            active-color="#13ce66"
            inactive-color="#ff4949"
            :active-value="1"
            :inactive-value="2"
            v-model="form.status"
          >
          </el-switch>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="quit">取 消</el-button>
        <el-button v-if="curid == ''" type="primary" @click="addroles"
          >添加</el-button
        >
        <el-button v-else type="primary" @click="getRoleedit">修改</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {
  addMenu,
  getOneMenus,
  modifyMenu,
  getAllMenu,
  addRole,
  getRoleinfo,
  getRoleedit,
} from "../../../request/api";

export default {
  props: ["obj", "menuArr"],
  data() {
    return {
      defaultProps: {
        children: "children",
        label: "title",
      },
      data: [],
      curid: "", //要修改的菜单id
      formLabelWidth: "120px",
      form: {
        id: "",
        rolename: "", //角色名称//权限id
        menus: [],
        status: 1, //状态   1正常 2禁用
      },
    };
  },
  mounted() {
    this.allMenu();
  },
  methods: {
    allMenu() {
      //查询所有菜单
      getAllMenu()
        .then((d) => {
          if (d.data.code == 200) {
            this.data = d.data.list;
          }
        })
        .catch((e) => {
          console.log(`获取所有菜单接口调用失败`);
        });
    },
    quit() {
      this.obj.isshow = false;
      this.form = {
        id: "",
        rolename: "", //角色名称//权限id
        menus: [],
        status: 1, //状态   1正常 2禁用
      };
    },
    getRoleedit() {
      let keyArr = this.$refs.tree.getCheckedKeys();
      this.form.menus = JSON.stringify(keyArr);
      getRoleedit(this.form)
        .then((d) => {
          //1.修改提示信息
          if (d.data.code == 200) {
            //修改成功
            this.$message({
              message: d.data.msg,
              type: "success",
            });
          } else {
            //修改失败
            this.$message({
              message: d.data.msg,
              type: "warning",
            });
          }
          //2.关闭弹窗
          this.obj.isshow = false;
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
          //4.刷新列表中的菜单数据：
          this.$emit("refreshmenu");
        })
        .catch((e) => {
          console.log("修改菜单接口调用失败");
        });
    },
    getOneRoleInfo(id) {
      this.curid = id;
      //根据要修改的菜单id查询菜单数据
      getRoleinfo({ id })
        .then((d) => {
          if (d.data.code == 200) {
            this.form = d.data.list;
            this.form.id = id;
            console.log(this.form, 8888);
          }
        })
        .catch((e) => {
          console.log("根据id查询菜单数据接口调用失败");
        });
    },
    addroles() {
      //添加角色
      //获取用户选中的权限id:
      let keyArr = this.$refs.tree.getCheckedKeys();
      this.form.menus = JSON.stringify(keyArr);
      addRole(this.form)
        .then((d) => {
          //1.提示用户
          if (d.data.code == 200) {
            //添加成功
            this.$message({
              message: d.data.msg,
              type: "success",
            });
          } else {
            //添加失败
            this.$message({
              message: d.data.msg,
              type: "warning",
            });
          }

          //2.重置表单数据：
          this.form = {
            rolename: "", //角色名称
            menus: [], //权限id
            status: 1, //状态   1正常 2禁用
          };
          //3.关闭弹窗
          this.obj.isshow = false;
          //4.刷新列表中的数据：【子传父】
        })
        .catch((e) => {
          console.log(`添加角色接口调用失败`);
        });
      location.reload();
    },
  },
};
</script>

<style>
</style>