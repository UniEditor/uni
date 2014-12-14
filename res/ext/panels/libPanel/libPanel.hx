

this.id = "uni.lib";

this.onInit = function(){
	//this.forceOpenPanel();
}

function onItemClick(e) {
	//trace("onItemClick " + e.component.userData);
	Debug.getIns().log("onItemClick " + e.component.userData);
	
	Uni.getIns().createEmptyEdObj(e.component.userData);
}

function renderData(){
	trace("renderData");
	
	if(this.get_panel() == null){return;}
	var body = this.get_panel().body;
	
	var count = 0;
	for(one in Uni.getIns().mapType){
		trace(count +" : "+ one.name);
		
		var vbox = new VBox();
		
		var img = new Button();
		img.style.backgroundImage = one.icon;
		img.width = 50;
		img.height = 50;
		img.style.horizontalAlignment = "center";
		vbox.addChild(img);
		
		var text = new Text();
		text.text = one.name;
		//text.x = 50; 
		//text.y = 50; 
		text.style.borderColor = 0x996699;
		text.style.horizontalAlignment = "center";
		vbox.addChild(text);
		
		body.addChild(vbox);
		
		count = count+1;
		img.userData = one.name;
		
		//img.addEventListener("haxeui_click", onItemClick);
		img.onClick = onItemClick;
		//trace(img.hasEventListener("haxeui_click"));
	}
}

this.onPanelOpen = function(){
	trace("lib open");
	renderData();
}

this.onPanelClose = function(){
	
}