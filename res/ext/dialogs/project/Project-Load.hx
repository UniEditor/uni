this.id = "project.load";

this.onInit = function(){
}

this.onCommandCall = function() {
	trace("onCommandCall");
	
	var filter = { count: 2
			, descriptions: ["Text files", "JPEG files"]
			, extensions: ["*.txt","*.jpg;*.jpeg"]			
			};
	
	var path = Dialogs.openFile("Load project", "Please select project file to load:",filter, false);
	
	trace("PATH:" + path);
	
	if (path != null) {
		ProjectManager.getIns().loadProject(path);
	}
	
}

