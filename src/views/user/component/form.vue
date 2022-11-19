<template>
  <div>
    <!-- ElementUI:对话框 -->
    <el-dialog
      :title="curid == '' ? '添加管理员' : '修改管理员'"
      :visible.sync="obj.isshow"
    >
      <el-form :model="form">
        <el-form-item label="所属角色" :label-width="formLabelWidth">
          <el-select v-model="form.roleid" placeholder="请选择">
            <el-option
              v-for="(item, ind) in data"
              :key="ind"
              :label="item.rolename"
              :value="item.id"
              porp="data"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="用户名" :label-width="formLabelWidth">
          <el-input v-model="form.username" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="密码" :label-width="formLabelWidth">
          <el-input
            v-model="form.password"
            autocomplete="off"
            type="password"
          ></el-input>
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
        <el-button v-if="curid == ''" type="primary" @click="adduser"
          >添加</el-button
        >
        <el-button v-else type="primary" @click="getUseredit">修改</el-button>
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
  getRole,
  getUserinfo,
  getUseredit,
  getUseradd,
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
        uid: "",
        roleid: "",
        rolename: "",
        username: "", //角色名称//权限id
        password: "",
        status: 1, //状态   1正常 2禁用
      },
    };
  },
  mounted() {
    this.allRole();
  },
  methods: {
    allRole() {
      getRole()
        .then((d) => {
          if (d.data.code == 200) {
            this.data = d.data.list;
            console.log(data);
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
        uid: "",
        roleid: "",
        rolename: "",
        username: "", //角色名称//权限id
        password: "",
        status: 1, //状态   1正常 2禁用//状态   1正常 2禁用
      };
    },
    getUseredit() {
      getUseredit(this.form)
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
            id: "",
            uid: "",
            roleid: "",
            rolename: "",
            username: "", //角色名称//权限id
            password: "",
            status: 1,
          };
          //4.刷新列表中的菜单数据：
          this.$emit("refreshmenu");
        })
        .catch((e) => {
          console.log("修改菜单接口调用失败");
        });
    },
    getUserinfo(uid) {
      this.curid = uid;
      //根据要修改的菜单id查询菜单数据
      getUserinfo({ uid })
        .then((d) => {
          if (d.data.code == 200) {
            this.form = d.data.list;
            this.form.uid = uid;
            console.log(this.form, 8888);
          }
        })
        .catch((e) => {
          console.log("根据id查询菜单数据接口调用失败");
        });
    },
    adduser() {
      //添加用户名
      //获取用户选中的权限id:
      getUseradd(this.form)
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