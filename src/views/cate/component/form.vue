<template>
  <div>
    <!-- ElementUI:对话框 -->
    <el-dialog
      :title="curid == '' ? '添加商品' : '修改商品'"
      :visible.sync="obj.isshow"
    >
      <el-form :model="form">
        <el-form-item label="一级分类" :label-width="formLabelWidth">
          <el-select v-model="form.pid" placeholder="请选择">
            <el-option label="根目录" :value="0"></el-option>
            <el-option
              :key="item.id"
              v-for="item in goodsCateArr"
              :label="item.catename"
              :value="item.id"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="分类名称" :label-width="formLabelWidth">
          <el-input v-model="form.catename"></el-input>
        </el-form-item>
        <el-form-item label="上传头像" :label-width="formLabelWidth">
          <el-upload  :auto-upload=false
				class="avatar-uploader"
				action="#" :on-change="uploadfile"
				:show-file-list="false">
				<img v-if="imagePath" :src="imagePath" class="avatar">
				<i v-else class="el-icon-plus avatar-uploader-icon"></i>
				</el-upload>			   
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
        <el-button v-if="curid == ''" type="primary" @click="addmenu"
          >添加</el-button
        >
        <el-button v-else type="primary" @click="cateEdit">修改</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { successMsg, failMsg } from "../../../tools/tools";
import {
  addMenu,
  cateEdit,
  goodsCateList,
  addGoodsCate,
  getOnecateinfo
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
      secondCateArr: [], //商品二级分类
      goodsCateArr: [], //商品分类(一级分类及对应的二级分类)
      imagePath: "", //上传图片的路径
      form: {
        pid: "",
        img: "",
        catename: "",
        status: "1", //状态   1正常 2禁用
      },
    };
  },
  mounted() {
    this.getAllGoodsCate();
  },
  methods: {
    uploadfile(file) {
      this.imagePath = URL.createObjectURL(file.raw);
      this.form.img = file.raw;
    },
    getAllGoodsCate() {
      //查询所有商品分类信息
      goodsCateList()
        .then((d) => {
          if (d.data.code == 200) {
            this.goodsCateArr = d.data.list;
          }
        })
        .catch((e) => {
          console.log("获取所有商品分类接口调用失败");
        });
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
    cateEdit() {
      //修改菜单
      let obj = {
        id: this.curid,
        ...this.form,
      };

      cateEdit(obj)
        .then((d) => {
          console.log(obj);
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
          this.$emit("refreshmenu");
        })
        .catch((e) => {
          console.log("修改菜单接口调用失败");
        });
    },
    getOnecateinfo(id) {
      this.curid = id;
      //根据要修改的菜单id查询菜单数据
      getOnecateinfo({ id })
        .then((d) => {
          if (d.data.code == 200) {
            this.form = d.data.list;
            this.form.img = ''
            console.log(this.form, 8888);
          }
        })
        .catch((e) => {
          console.log("根据id查询菜单数据接口调用失败");
        });
    },
    addmenu() {
      //添加菜单
      addGoodsCate(this.form)
        .then((d) => {
          console.log(this.form);
          //1.提示用户
          if (d.data.code == 200) {
            console.log(d.data);
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

<style lang="less" scoped>
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409eff;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}
.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>