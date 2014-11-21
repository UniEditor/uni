

this.id = "uni.lib";

this.onInit = function(){
	//this.forceOpenPanel();
}

function onItemClick(e) {
	trace("onItemClick ");// + e.component.userData
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
		//img.style.paddingBottom = 50;
		vbox.addChild(img);
		
		var text = new Text();
		text.text = one.name;
		//text.x = 50; 
		//text.y = 50; 
		text.style.borderColor = 0x996699;
		vbox.addChild(text);
		
		body.addChild(vbox);
		
		count=count+1;
		//vbox.userData = count;
		img.userData = count;
		
		img.addEventListener(UIEvent.CLICK, onItemClick);
		//vbox.addEventListener(UIEvent.CLICK, onItemClick);
	}
}

this.onPanelOpen = function(){
	trace("lib open");
	renderData();
}

this.onPanelClose = function(){
	
}