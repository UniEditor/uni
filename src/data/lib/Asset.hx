package data.lib ;
import openfl.display.BitmapData;

/**
 * Asset might just be the raw file data
 * or could be a setting of things (like the setting of tilemap clipping)
 * @author GDB
 */

class Asset
{
	
	public var assType:String;
	public var path:String;//full path with fileName
	public var iconPath:String;
	
	public var fileName:String;
	public var bitmapData:BitmapData;

	public function new() 
	{
		
	}
	
}