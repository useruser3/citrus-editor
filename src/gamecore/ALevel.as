package gamecore
{
	
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.math.MathVector;
	import citrus.objects.platformer.nape.Sensor;
	import citrus.physics.nape.Nape;
	import citrus.utils.objectmakers.ObjectMaker2D;
	import flash.display.MovieClip;
	import flash.events.IOErrorEvent;
	import flash.geom.Rectangle;
	import gamecore.Assets;
	import objects.MyEnemy;
	import objects.MyHero;
	import objects.Spikes
	import org.osflash.signals.Signal;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * ...
	 * @author useruser3
	 */
	public class ALevel extends StarlingState
	{
		public var lvlEnded:Signal;//sends the lvlEnded signal
		public var restartLevel:Signal;
		protected var _ce:CitrusEngine;
		protected var _level:MovieClip;//the level created in flash to be put into objectmaker2d
		public var _hero:MyHero //referance to the hero class
		public var itemsused:Array = [MyHero, MyEnemy, Spikes];//referance to items used
		public static var braidAtlas:TextureAtlas;
	
		
		public function ALevel(level:MovieClip = null)
		{
			super();
			_ce = CitrusEngine.getInstance();
			_level = level;
			
			lvlEnded = new Signal();//assigns lvlEnded as a new signal 
			restartLevel = new Signal();//assigns restartLevel as a new signal
		
		}
	
		override public function initialize():void
		{
			super.initialize();
			var nape:Nape = new Nape("nape"); //we are using nape
			//setup the atlas containing art
				if (!braidAtlas)
				
					{ //if the atlas doesnt exist create it
					braidAtlas = new TextureAtlas(Texture.fromBitmap(new Assets.braid()), new XML(new Assets.braidXML()));
					}
			nape.visible = true; //enable nape debug draw
			add(nape);
			
			
			view.loadManager.onLoadComplete.addOnce(_handleLoadComplete);
			ObjectMaker2D.FromMovieClip(_level); //create objects from flash pro
			//OBJECTS FROM FLASH
				//hero class
				_hero = MyHero(getFirstObjectByType(MyHero)); //set the first hero class object found as _hero
				//camera setup
				view.camera.setUp(_hero, new MathVector(320, 240), new Rectangle(0, 0, 1550, 450), new MathVector(.25, .05));
				//view.setupCamera(_hero, new MathVector(320, 240), new Rectangle(0, 0, 1550, 450), new MathVector(.25, .05)); //set camera to follow the hero pre 3.1.3
			
		}
		
		public function setUpSensors():void
		{
			var endLevel:Sensor;
			//TODO
		}
		
		protected function _handleLoadComplete():void
		{
			//TODO
			trace("load complete");	
			
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			var percentLoaded:uint = view.loadManager.bytesLoaded / view.loadManager.bytesTotal * 100;
			if (percentLoaded >= 99)
			{
				trace(percentLoaded);
				
			}
	
		}
		

		override public function destroy():void
		{
			super.destroy();
		
		}
		
		public function onError(e:IOErrorEvent):void
		{
				trace(e.text);
		}
	}
}