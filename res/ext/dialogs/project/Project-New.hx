this.id = "project.new";

var selectedPath = "./project.xml";

this.onInit = function(){
}

function doSelPath() {
	trace("do sel!");
	
	var path = Dialogs.folder("New project", "Please select dir to as project base folder:");
	trace("path=" + path);
	if (path == null) {
		path = "./project.xml";
	}
	selectedPath = path;
	renderData();
}

function doCreateNewProject() {
	trace("doCreateNewProject!"+selectedPath);
	
	ProjectManager.getIns().createNewProject(selectedPath, "testProject");
	Debug.getIns().log("Create Project success at: " + selectedPath);
}

function renderData() {
	
	if(this.get_panel() == null){return;}
	var body = this.get_panel().body;
	
	var txt_path = body.findChild("txt_path", null, true);
	txt_path.text = selectedPath;
}


this.onPanelOpen = function(){
	trace("lib open");
	renderData();
	
	if(this.get_panel() == null){return;}
	var body = this.get_panel().body;
	
	var btn_changePath = body.findChild("btn_changePath", null, true);
	btn_changePath.onClick = doSelPath;
	
	var btn_create = body.findChild("btn_create", null, true);
	btn_create.onClick = doCreateNewProject;
}