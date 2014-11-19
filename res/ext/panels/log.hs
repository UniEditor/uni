
this.id = "uni.log";

this.onInit = function(){
	trace("log.hs onInit force openPanel");
	this.forceOpenPanel();
}

var onLog = function(e){
	trace("onLog" + e);
}

trace("EventManager.getIns()" + EventManager.getIns());
trace("UniEvent" + UniEvent);

EventManager.getIns().addEventListener(UniEvent.LOG_ADD, onLog);


//on panel init (before first time open)

//on panel open (reg functions)

//on panel close

//on global log msg