package editor.project;
import data.lib.Asset;
import data.TypeInfo;
import haxe.io.Bytes;
import haxe.Resource;
import haxe.ui.toolkit.util.ByteConverter;
import openfl.display.Bitmap;
import openfl.display.Loader;
import openfl.Lib;
import sys.FileSystem;
import sys.io.File;
import utils.Utils;
import openfl.utils.ByteArray;


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
	
	public var sceneMap:Map<String, SceneFile>; //Use PATH because 1 naturally unique 2 no need to load
	public var currentPoject:ProjectFile;
	//assets
	public var mapAsset:Map<String, Asset>;
	
	public function new() 
	{
		sceneMap = new Map<String, SceneFile>();
		mapAsset = new Map<String, Asset>();
	}
	
	public function createNewProject(basePath:String, projectName:String):Void {
		trace("createNewProject" + basePath + "=" + projectName);
		
		//check if exist (ask if create)
		var isExist:Bool = FileSystem.exists(basePath);
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
		
		//to / slash
		projectXmlPath = Utils.toForwardSlash(projectXmlPath);
		
		//check if path is valid(end with .xml)
		
		
		
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
		var projectBastPath:String = Utils.getBasePath(projectXmlPath);
		
		trace("projectXmlStr" + projectXmlStr);
		
		currentPoject = new ProjectFile();
		currentPoject.load(projectXmlStr);
		
		Uni.getIns().curProject = currentPoject;
		
		//load assets
		var fullAssetPath:String = projectBastPath + currentPoject.assetPath;
		scanAssetFiles(fullAssetPath, mapAsset);
		trace("mapAsset" + mapAsset);
		for (one in mapAsset) {
				trace(one);
		}
		
		
		//try open the last opened scene
		trace("lastOpenScene"+currentPoject.lastOpenScene);
		if (currentPoject.lastOpenScene != "" && mapAsset.exists(currentPoject.lastOpenScene)) {
			var lastSceneFile:SceneFile = cast mapAsset[currentPoject.lastOpenScene];
			openScene(lastSceneFile);
		}
		
		//send event project loaded
		
	}
	
	public function closeProject():Void {
		
		
		
	}
	
	public function openScene(sceneFile:SceneFile):Void {
		trace("open last scene: "+ sceneFile.path);
		
		sceneFile.loadSelf();
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
	

	
	public function genDefaultSceneName():String {
		
		var testNum:Int = Utils.getMapCount(sceneMap) + 1;
		var testName:String = "New Project" + testNum;
		while (sceneMap.exists(testName)) {
			testNum++;
			testName = "New Project" + testNum;
		}
		return testName;
	}
	
	
	public function scanAssetFiles(fullPath:String, finalRes:Map<String, Asset>):Void {
		trace("scanAssetFiles: " + fullPath);
		
		var res:Array<String> = FileSystem.readDirectory(fullPath);
		if (res == null) { trace("ERROR scanAssetFiles -1");  return;	}
		
		for (s in res) {
			var childItemPath:String = fullPath + "/" + s;
			var isFolder:Bool = FileSystem.isDirectory(childItemPath); 
			
			if (isFolder == true) {
				scanAssetFiles(childItemPath,finalRes);
			}else {
				var endFix:String = Utils.getEndfix(s);
				
				if (endFix == "png" || endFix == "bmp" || endFix == "jpg") {
					
					var ass:Asset = new Asset();
					ass.assType = "image";
					ass.path = childItemPath;
					ass.fileName = s;
					
					var bytes:Bytes = File.getBytes(childItemPath);
					if (bytes != null) {
						var ba:ByteArray = ByteConverter.fromHaxeBytes(bytes);
						var loader:Loader = new Loader();
						loader.loadBytes(ba);
						if (loader.content != null) {
							ass.bitmapData = cast(loader.content, Bitmap).bitmapData;
						}
					} 
					
					finalRes[childItemPath] = ass;
					
				}else if (endFix == "scene") {
					
					var sceneFile:SceneFile = new SceneFile();
					sceneFile.path = childItemPath;
					sceneFile.fileName = s;
					
					sceneMap[childItemPath] = sceneFile;//the two sceneFIles is linked?
					finalRes[childItemPath] = sceneFile;
				}
			}
		}
	}
	
}