this.id = "exporter.test";

this.onInit = function(){
	//this.forceOpenPanel();
}

var selectedPath = "./project.xml";

function doSelPath() {
	trace("do sel!");
	
	var path = Dialogs.saveFile("Export", "Please select dir to export:", selectedPath);
	trace(path);
	
	selectedPath = path;
	renderData();
}

function doExport() {
	trace("do exp!");

	//var res = this.genXML();
	
	var xmlDoc = Xml.createElement("data");
	var xmlStageData = Xml.createElement("stageData");
	xmlDoc.addChild(xmlStageData);
	
	for (one in Uni.getIns().mapEdObj) {
		var oneXml = Xml.createElement("obj");
		oneXml.set("type", one.typeInfoID);
		oneXml.set("id", one.id);
		
		var transform = one.get("transform");
		oneXml.set("x", transform.x);
		oneXml.set("y", transform.y);			
		xmlStageData.addChild(oneXml);
	}
	
	var res = xmlDoc.toString();
	
	trace(res);
	this.saveStringToPath(selectedPath, res);
	
	Debug.getIns().log("Export success to: " + selectedPath);
}

function renderData() {
	
	if(this.get_panel() == null){return;}
	var body = this.get_panel().body;
	
	var txt_path = body.findChild("txt_path", null, true);
	txt_path.text = selectedPath;
	
	var btn_changePath = body.findChild("btn_changePath", null, true);
	btn_changePath.onClick = doSelPath;
	
	var btn_export = body.findChild("btn_export", null, true);
	btn_export.onClick = doExport;
}


this.onPanelOpen = function(){
	trace("lib open");
	renderData();
}