package editor.project;
import sys.FileSystem;
import sys.io.File;

/**
 * ...
 * @author GDB
 */
class ProjectManager
{
	
	//singleton
	private static var instance:ProjectManager;
	public static function getIns():ProjectManager {
		if (instance == null) {
			instance = new ProjectManager();
		}
		return instance;
	}
	
	
	public var currentPoject:ProjectFile;
	
	public function new() 
	{
		
	}
	
	public function createNewProject(basePath:String, projectName:String):Void {
		trace("createNewProject" + basePath + "=" + projectName);
		
		//check if exist (ask if create)
		var isExist:Bool = FileSystem.exists(basePath);
		trace("isExist:" + isExist);
		
		if (isExist == false) return;
		
		if (FileSystem.isDirectory(basePath) == false) {
			return;
		}
		
		//check if empty folder (ask if continue)
		
		var fileInside:Array<String> = FileSystem.readDirectory(basePath);
		if (fileInside.length > 0) {
			//not empty
			trace("not empty!");
			return;
		}
		
		//copy files to target place
		
		var defaultTemplatePath:String = "./res/templates/default";
		copyFileAndFolder(defaultTemplatePath, basePath);
		
		//rename project file
		
		
		loadProject(basePath + "/Project.xml");
	}
	
	
	public function loadProject(projectXmlPath:String):Void {
		trace("LOAD PROJECT: " + projectXmlPath);
		
		//to do ask for what to do is currently have a project open
		
		//check file exist
		if (FileSystem.exists(projectXmlPath) == false) {
			trace("Path Not Exist");
			return;
		}
		
		if (FileSystem.isDirectory(projectXmlPath) == true) {
			trace("Path is dir");
			return;
		}
		
		var projectXmlStr:String = File.getContent(projectXmlPath);
		
		trace("projectXmlStr" + projectXmlStr);
		
		
		currentPoject = new ProjectFile();
		currentPoject.load(projectXmlStr);
	}
	
	public function closeProject():Void {
		
		
		
	}
	
	
	//tools
	
	public function copyFileAndFolder(srcPath:String, destPath:String):Void {
		trace("copyFileAndFolder: " + srcPath + " > " + destPath);
		
		FileSystem.createDirectory(destPath);
		var childFiles:Array<String> = FileSystem.readDirectory(srcPath);
		for (one in childFiles) {
			
			var childItemPath:String = srcPath + "/" + one;
			var isFolder:Bool = FileSystem.isDirectory(childItemPath); 
			
			if (isFolder) {
				copyFileAndFolder(childItemPath, destPath+ "/" + one);
			}else {
				File.copy(childItemPath, destPath + "/" + one);
			}
		}
	}
	
}