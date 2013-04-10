package hxga;


class TimingParams extends BaseParams, implements IParamsTyped
{
	
	public var category:String = null;
	public var time:Null<Int> = null;
	public var variableName:String = null;
	public var label:String = null;

	public function new(?category:String, ?variableName:String, ?time:Int, ?label:String) 
	{
		this.category = category;
		this.variableName = variableName;
		this.time = time;
		this.label = label;
	}
	
	override public function generateString():String
	{
		var params:String = '';
		params += getStringParam('utc', category, 150);
		params += getStringParam('utv', variableName, 500);
		params += getIntParam('utt', time);
		params += getStringParam('utl', label, 500);
		return params;
	}
	
	public function getHitType():String { return 'timing'; }
	
}