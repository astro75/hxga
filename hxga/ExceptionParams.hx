package hxga;


class ExceptionParams extends BaseParams, implements IParamsTyped
{
	
	public var description:String = null;
	public var isFatal:Null<Bool> = null;

	public function new(description:String, isFatal:Bool = true) 
	{
		this.description = description;
		this.isFatal = isFatal;
	}
	
	override public function generateString():String
	{
		var params:String = '';
		params += getStringParam('exd', description, 150);
		params += getBoolParam('exf', isFatal);
		return params;
	}
	
	public function getHitType():String { return 'exception'; }
	
}