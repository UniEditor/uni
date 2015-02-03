this.id = "scene.save";

this.onInit = function(){
}

this.onCommandCall = function() {
	trace("Save Scene");
	
	if (Uni.getIns().curScene != null) {
		trace("Save Scene"+Uni.getIns().curScene.sceneName);
		
		Uni.getIns().curScene.saveSelf();
	}
}

