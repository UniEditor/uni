trace("this is from hs START");

this.sayHello();

var func_afterInit = function(){
	
	trace("func_afterInit called!");
	
}

this.regFunc_afterInit(func_afterInit);

trace("this is from hs END");