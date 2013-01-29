package gamecore
{
	import citrus.utils.AGameData;
	import Levels.Level1;
	
	/**
	 * ...
	 * @author useruser3
	 */
	public class MyGameData extends AGameData
	{
		
		public function MyGameData()
		{
			//public var pathToLevels:String = 
			super();
			_levels = [[Level1, "levels/A1/leveleditor.swf"]];
		}
		
		public function get levels():Array
		{
			return _levels
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
	
	}

}