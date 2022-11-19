import Vue from 'vue';
const vm = new Vue();

//成功时的提示信息：
export let  successMsg=(msg)=>{
	vm.$message({
		message: msg,
		type: 'success'
		});
}

//失败时的提示信息：
export let failMsg=(message)=>{
	vm.$message({
		message,
		type: 'warning'
		});	
}