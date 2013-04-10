package hxga;

class CustomParams extends BaseParams
{
	private var dimensions:IntHash<String>;
	private var metrics:IntHash<Int>;

	public function new() 
	{
		dimensions = new IntHash<String>();
		metrics = new IntHash<Int>();
	}
	
	public function setDimension(index:Int, value:String)
	{
		if (index < 1) return;
		dimensions.set(index, value);
	}
	
	public function setMetric(index:Int, value:Int)
	{
		if (index < 1) return;
		metrics.set(index, value);
	}
	
	override public function generateString():String
	{
		var params:String = '';
		for (key in dimensions.keys()) {
			params += getStringParam(Std.string(key), dimensions.get(key), 150);
		}
		for (key in metrics.keys()) {
			params += getIntParam(Std.string(key), metrics.get(key));
		}
		return params;
	}
	
}