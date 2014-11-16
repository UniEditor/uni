package modules.basic;
import data.EditableObject;
import data.pro.ProGroup;

/**
 * ...
 * @author 
 */
class UniSprite extends EditableObject
{
	
	
	
	public function new() 
	{
		super();
		
		proGroups.push(new ProGroupTransformation());
	}
	
	@:getter(transformation)
	public function get_transformation() {
		return null;
	}
	
}