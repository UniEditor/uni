package editor;

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
	
	public function scanFolderForAssetRawFiles(fullPath:String, finalRes:Map<String, Asset>):Void {
		
		var res:Array<String> = FileSystem.readDirectory(fullPath);
		if (res == null) { return;	}
		
		for (s in res) {
			var childItemPath:String = fullPath + "/" + s;
			var isFolder:Bool = FileSystem.isDirectory(childItemPath); 
			
			if (isFolder == true) {
				scanFolderForAssetRawFiles(childItemPath,finalRes);
			}else {
				var endFix:String = Utils.getEndfix(s);
				if (endFix == "png" || endFix == "bmp" || endFix == "jpg") {
					var ass:Asset = new Asset();
					ass.assType = "image";
					ass.path = childItemPath;
					ass.fileName = s;
					
					//trace("ASSET LOAD0 : " + childItemPath);
					var bytes:Bytes = File.getBytes(childItemPath);
					//trace("ASSET LOAD1 : " + bytes);
					if (bytes != null) {
						
						var ba:ByteArray = ByteConverter.fromHaxeBytes(bytes);
						//trace("ASSET LOAD2 : " + ba);
						
						var loader:Loader = new Loader();
						loader.loadBytes(ba);
						//trace("ASSET LOAD3 : " + loader.content);
						if (loader.content != null) {
							ass.bitmapData = cast(loader.content, Bitmap).bitmapData;
						}
					} 
					
					
					finalRes[childItemPath] = ass;
				}
			}
		}
	}
	
	public function genEdObjId():String{
		var res:String = "";
		
		var now:Date = Date.now();
		var year:Int = now.getFullYear() - 2010;
		var month:Int = now.getMonth();
		var date:Int = now.getDate();
		var hour:Int = now.getHours();
		var min:Int = now.getMinutes();
		var sec:Int = now.getSeconds();
		var msec:Int = Lib.getTimer() % 1000;
		
		var bigInt1:Int = year * 500 + month * 32 + date;
		var bigInt2:Int = hour * 3600 + min * 60 + sec;
		res = res + StringTools.hex(bigInt1) +  StringTools.hex(bigInt2) + StringTools.hex(msec);
		return res;
	}
	
}