package editor;
import data.TypeInfo;
import sys.FileSystem;
import sys.io.File;

/**
 * Doing dirty works for uni
 * These functions are useless to users and modders
 * @author 
 */
class UniTools
{

	public function new() 
	{
		
	}
	
	public function loadTypeList():Void {
		
		var filePath:String = "./res/config/TypeList.xml";
		
		if (FileSystem.exists(filePath)){
			
			var content:String = File.getContent(filePath);
			//trace("content:" + content);
			
			var xml:Xml = Xml.parse(content);
			var xmlData:Xml = null;
			for (one in xml.elementsNamed("data") ) {
				xmlData = one; break;
			}
			if (xmlData == null) return;
			
			for (one in xmlData.elementsNamed("item") ) {
				//trace("got item");
				
				var name:String = one.get("name");
				var reflect:String = one.get("reflect");
				var icon:String = one.get("icon");
				
				//TODO should safe all these things
				
				var typeInfo:TypeInfo = new TypeInfo();
				typeInfo.name = name;
				typeInfo.reflect = reflect;
				typeInfo.icon = icon;
				
				Uni.getIns().mapType[name] = typeInfo;				
			}
		}else {
			trace("ERROR: can not load TypeList.xml!");
		}
	}
	
}