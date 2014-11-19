
this.sayHello();

var func_afterInit = function(){
	trace("func_afterInit called!");
}

this.regFunc_afterInit(func_afterInit);

this.onInit = function(){
	Debug.getIns().log("log from test.hd");
}