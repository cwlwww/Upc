<template>
  <div>
    <!-- ElementUI:对话框 -->
    <el-dialog
      :title="curid == '' ? '添加商品' : '修改商品信息'"
      :visible.sync="obj.isshow"
    >
      <el-form :model="form">
        <el-form-item label="一级目录" :label-width="formLabelWidth">
          <el-select v-model="form.first_cateid" placeholder="请选择">
            <el-option
              v-for="(item, ind) in this.$store.state.cate"
              :key="ind"
              :label="item.catename"
              :value="item.id"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="二级目录" :label-width="formLabelWidth">
          <el-select v-model="form.second_cateid" placeholder="请选择">
            <el-option
              v-for="(item, ind) in form.first_cateid != ''
                ? this.$store.state.cate[form.first_cateid].children
                : []"
              :key="ind"
              :label="item.catename"
              :value="item.id"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="商品名称" :label-width="formLabelWidth">
          <el-input v-model="form.goodsname" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="价格" :label-width="formLabelWidth">
          <el-input v-model="form.price" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="市场价格" :label-width="formLabelWidth">
          <el-input v-model="form.market_price" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="上传图片" :label-width="formLabelWidth">
          <el-upload
            :auto-upload="false"
            class="avatar-uploader"
            action="#"
            :on-change="uploadfile"
            :show-file-list="false"
          >
            <img v-if="imagePath" :src="imagePath" class="avatar" />
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </el-form-item>
        <el-form-item label="规格属性" :label-width="formLabelWidth">
          <el-select v-model="spec" placeholder="请选择" >
            <el-option
              v-for="(item, ind) in this.$store.state.spec"
              :key="ind"
              :label="item.id"
              :value="{specsid:item.id, specsattr: item.attrs}">
              <el-tag v-for="(it, index) in item.attrs" :key="index">{{ it }}</el-tag>
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item
          label="是否新品"
          prop="isnew"
          :label-width="formLabelWidth"
        >
          <el-radio-group v-model="form.isnew">
            <el-radio label="1">是</el-radio>
            <el-radio label="2">否</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item
          label="是否热品"
          prop="ishot"
          :label-width="formLabelWidth"
        >
          <el-radio-group v-model="form.ishot">
            <el-radio label="1">是</el-radio>
            <el-radio label="2">否</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="状态" :label-width="formLabelWidth">
          <el-switch
            active-color="#13ce66"
            inactive-color="#ff4949"
            active-value="1"
            inactive-value="2"
            v-model="form.status"
          >
          </el-switch>
        </el-form-item>
        <el-form-item
          label="商品描述"
          prop="description"
          :label-width="formLabelWidth"
        >
          <el-input type="textarea" v-model="form.description"></el-input>
        </el-form-item>

      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="obj.isshow = false">取 消</el-button>
        <el-button v-if="curid == ''" type="primary" @click="addGoods"
          >添加</el-button
        >
        <el-button v-else type="primary" @click="getUseredit">修改</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  props: ["obj"],
  data() {
    return {
      defaultProps: {
        children: "children",
        label: "title",
      },
      imagePath: "",
      cateone: [],
      curid: "", //要修改的菜单id
      formLabelWidth: "120px",
      form: {
        first_cateid: "", //一级目录
        second_cateid: "", //一级目录
        goodsname: "", //商品名称
        price: "", //商品价格
        market_price: "", //市场价格
        img: "", //商品图片
        isnew: "", //是否新品
        ishot: "", //是否热品
        description: "", //商品描述
        status: "",
      },
      spec: {
        specsid: "",
        specattrs: [],
      },
    };
  },
  mounted() {
    this.$store.dispatch("getCateList");
    this.$store.dispatch("getGoodsSpec");
  },
  methods: {
    uploadfile(file) {
      this.imagePath = URL.createObjectURL(file.raw);
      this.form.img = file.raw;
    },
    addGoods() {
      let obj = {
        ...this.form,
        ...this.spec,
      };
      console.log(obj);
      this.$store.dispatch("addGoods", obj);
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