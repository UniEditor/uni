
this.id = "uni.log";

this.onInit = function(){
	trace("log.hs onInit force openPanel");
	this.forceOpenPanel();
}

this.onPanelOpen = function(){
	trace("log onPanelOpen");
	
	if(this.get_panel() != null){
		trace("body " +  this.get_panel().body);
		this.get_panel().body.text = Debug.getIns().logs.join("\n");
	}
}

this.onPanelClose = function(){
	trace("log onPanelClose");
}

var onLog = function(e){
	trace("onLog" + e);
	
	if(this.get_panel() != null){
		trace("body " +  this.get_panel().body);
		this.get_panel().body.text = Debug.getIns().logs.join("\n");
	}
}

trace("EventManager.getIns()" + EventManager.getIns());
trace("UniEvent" + UniEvent);

EventManager.getIns().addEventListener(UniEvent.LOG_ADD, onLog);


//on panel init (before first time open)

//on panel open (reg functions)

//on panel close

//on global log msg