<template>
  <div>
    <!-- ElementUI:对话框 -->
    <el-dialog
      :title="curid == '' ? '添加商品规格' : '修改商品规格'"
      :visible.sync="obj.isshow"
    >
      <el-form :model="form">
        <el-form-item label="规格名称" :label-width="formLabelWidth">
          <el-input v-model="form.specsname" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item
          label="规格属性"
          :key="ind"
          v-for="(item, ind) in specAttr"
          :label-width="formLabelWidth"
        >
          <el-input
            size="small"
            v-model="item.attr"
            autocomplete="off"
          ></el-input
          >&nbsp;
          <p>{{ form.attrs }}{{ specAttr }}</p>
          <el-button v-if="ind == 0" type="primary" @click="addspec"
            >新增规格属性</el-button
          >
          <el-button v-else type="danger" @click="del(ind)">删除</el-button>
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
            v-model="form.status"
          >
          </el-switch>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="obj.isshow = false">取 消</el-button>
        <el-button v-if="curid == ''" type="primary" @click="addgoodspec"
          >添加</el-button
        >
        <el-button v-else type="primary" @click="specsEdit">修改</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { successMsg, failMsg } from "../../../tools/tools";
import {
  addMenu,
  getOnespecsone,
  specsEdit,
  addGoodsSpec,
} from "../../../request/api";
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
      specAttr: [{ attr: "" }], //存放所有的规格属性值
      form: {
        specsname: "", //商品规格名称
        attrs: "", //商品规格属性值
        status: "1", //状态   1正常 2禁用
      },
    };
  },
  methods: {
    addgoodspec() {
      let arr = [];
      this.specAttr.forEach((item) => {
        arr.push(item.attr);
      });
      //将用户输入的所有规格属性值放到form.attrs中:
      this.form.attrs = arr.join();
      //console.log(this.form);
      addGoodsSpec(this.form).then().catch();
    },
    del(index) {
      //删除某一个规格属性值
      this.specAttr.splice(index, 1);
    },
    addspec() {
      //新增规格属性值
      this.specAttr.push({ attr: "" });
    },
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
    specsEdit() {
      //修改菜单
	  let arr = [];
      this.specAttr.forEach((item) => {
        arr.push(item.attr);
      });
      this.form.attrs = arr.join();
      let obj = {
        ...this.form,
        id: this.curid,
      };
      console.log(this.form);
      specsEdit(obj)
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
    getOnespecsone(id) {
      this.curid = id;
      //根据要修改的菜单id查询菜单数据
      getOnespecsone({ id })
        .then((d) => {
          if (d.data.code == 200) {
            this.form.specsname = d.data.list[0].specsname;
            let arr = [];
            for (let obj of d.data.list[0].attrs) {
              arr.push({ attr: obj });
            }
            this.specAttr = arr;
            console.log(arr, 8888);
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

<style scoped>
.el-input {
  width: 300px;
}
</style>