/**
 *
 */
function checkInput(){
	loginForm = document.getElementById("loginFormId");

	var user_code = document.getElementById('userID').value;
	var password = document.getElementById('password').value;

	var userFormat = /^[a-zA-Z0-9_-]+$/
	var pwsFormat=/^[a-zA-Z0-9]+$/;

	if(user_code.length==0){
		alert('ユーザIDを入力してください');
		return false;
	}else if(user_code.length < 4 || user_code.length > 20){
		alert("ユーザIDを8～20文字で入力してください");
		return false;
	}else if(!userFormat.test(user_code)){
		alert("ユーザIDは[a-z]、[A-Z]、[0-9]、「_」、「-」のみで入力してください");
		return false;
	}

	if(password.length==0){
		alert('パスワードを入力してください');
		return false;
	}else if(password.length < 4 || password.length > 15){
		alert("パスワードは8～15文字で入力してください");
		return false;
	}else if(!pwsFormat.test(password)){
		alert("ユーザIDを[a-z]、[A-z]、[0-9]で入力してください");
		return false;
	}
	return true;
}
