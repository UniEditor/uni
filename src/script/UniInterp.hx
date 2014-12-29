package script;
import haxe.ui.toolkit.hscript.ScriptInterp;
import hscript.Expr;
import hscript.Interp;

/**
 * ...
 * @author GDB
 */
class UniInterp extends ScriptInterp
{
	
	public function new() 
	{
		super();
		
		#if haxe3
		locals = new Map();
		#else
		locals = new Hash();
		#end
		declared = new Array();
	}
	
	override public function execute(expr:Expr):Dynamic 
	{
		depth = 0;
		return exprReturn(expr);
	}
	
	
}