package
{
	import citrus.core.IState;
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.utils.LevelManager;
	import flash.events.UncaughtErrorEvent;
	import gamecore.ALevel;
	import gamecore.MyGameData;
	
	public class Main extends StarlingCitrusEngine
	{
		public function Main()
		{

			setUpStarling(true);
			gameData = new MyGameData;
			loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onError)
			levelManager = new LevelManager(ALevel)
			
			levelManager.onLevelChanged.add(_onLevelChanged); //when the level has changed fire 
			levelManager.levels = gameData.levels;
			levelManager.gotoLevel();
		
		}
		
		private function _onLevelChanged(lvl:ALevel):void
		{
			state = lvl;
			lvl.lvlEnded.add(_nextLevel);
			lvl.restartLevel.add(_restartLevel);
		}
		
		private function _nextLevel():void
		{
			levelManager.nextLevel();
		}
		
		public function _restartLevel():void
		{
			state = levelManager.currentLevel as IState;
		}
		
		public function onError(e:UncaughtErrorEvent):void
		{
			//Trolling myself
			trace(e.error + " Numb Nuts");	
		}
	
	}
}
