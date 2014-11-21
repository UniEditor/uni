

this.id = "uni.lib";

this.onInit = function(){
	//this.forceOpenPanel();
}

function renderData(){
	trace("renderData");
	
	if(this.get_panel() == null){return;}
	var body = this.get_panel().body;

	for(one in Uni.getIns().mapType){
		trace(one);
		trace(one.name);
		
		/*var text = new Text();
		text.text = one.name;
		text.width = 100;
		text.height = 100;
		
		body.addChild(text);*/
		
		var img = new Image();
		img.resource = one.icon;
		img.width = 50;
		img.height = 50;
		body.addChild(img);
		
	}
}

this.onPanelOpen = function(){
	trace("lib open");
	renderData();
}

this.onPanelClose = function(){
	
}