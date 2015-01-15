this.id = "project.load";

this.onInit = function(){
}

this.onCommandCall = function() {
	
	var filter = { count: 2
			, descriptions: ["Xml Files","Project Files"]
			, extensions: ["*.xml","*.unip"]			
			};
	
	var path = Dialogs.openFile("Load project", "Please select project file to load:", filter, false);
	trace("PATH:" + path);
	
	if (path != null && path.length > 0) {
		ProjectManager.getIns().loadProject(path[0]);
	}
	
}

