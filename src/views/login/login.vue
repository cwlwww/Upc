<template>
  <div class="main">
     <div class="forms">
		<el-form :model="ruleForm" status-icon :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
		<el-form-item label="帐号" prop="username">
			<el-input type="text" v-model="ruleForm.username" autocomplete="off"></el-input>
		</el-form-item>
		<el-form-item label="密码" prop="password">
			<el-input type="password" v-model="ruleForm.password" autocomplete="off"></el-input>
		</el-form-item>
		<el-form-item>
			<el-button type="primary" @click="login('ruleForm')">登录</el-button>
			<el-button @click="resetForm('ruleForm')">重置</el-button>
		</el-form-item>
		</el-form>	 
	 </div>
  </div>
</template>

<script>
import {userLogin} from '../../request/api'
import {successMsg,failMsg} from '../../tools/tools'

export default {
 data() {
      // var checkAge = (rule, value, callback) => {
      //   if (!value) {
      //     return callback(new Error('年龄不能为空'));
      //   }
      //   setTimeout(() => {
      //     if (!Number.isInteger(value)) {
      //       callback(new Error('请输入数字值'));
      //     } else {
      //       if (value < 18) {
      //         callback(new Error('必须年满18岁'));
      //       } else {
      //         callback();
      //       }
      //     }
      //   }, 1000);
      // };
      var validateUsername = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请输入帐号'));
        } else {
          let userReg = /^[a-zA-Z]\w{3,11}$/;
          if(!userReg.test(value)){
              callback(new Error('帐号格式不正确！'));
          }else{
             callback();
          }
        }
      };
      var validatePass2 = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请输入密码'));
        } else {
          callback();
        }
      };
      return {
        ruleForm: {
          // pass: '',
          username:'',
          password: '',
        },
        rules: {
          username: [
            { validator: validateUsername, trigger: 'blur' }
          ],
          password: [
            { validator: validatePass2, trigger: 'blur' }
          ]
        }
      };
    },
    methods: {
      login(formName) {
        this.$refs[formName].validate((valid) => {
          if (valid) {  //帐号及密码的格式校验通过了
            // console.log(this.ruleForm);    
             userLogin(this.ruleForm).then(d=>{
              console.log(d,88888);
                if(d.data.code == 200){  //登录成功
                    successMsg(d.data.msg);
                        
                    //将登录成功后的帐号信息保存到sessionStorage中：
                    sessionStorage['managerInfo'] = JSON.stringify(d.data.list)

                    //登录成功后跳转到管理后台的主界面
                    this.$router.push('/');
                }else{
                    failMsg(d.data.msg);
                }
             }).catch(e=>{
              console.log(`登录接口调用失败`);
             })
          } else {
            console.log('error submit!!');
            return false;
          }
        });
      },
      resetForm(formName) {
        this.$refs[formName].resetFields();
      }
    }
}
</script>

<style scoped>
.main{
	width: 100vw;
	height: 100vh;
	background: linear-gradient(to right,#553443,#2F3D5F) !important;
}

.forms{
  padding: 10px;
	width:  300px;
	height: 200px;
	position: absolute;
	left: 50%;
	top:50%;
	background-color: aliceblue;
	transform: translate(-50%,-50%);
}

.el-input{
  width: 180px;
}
</style>