package objects.objectAnimations
{
	import objects.MyHero;
	import citrus.core.CitrusObject;
	import citrus.view.starlingview.AnimationSequence;
	import citrus.view.starlingview.StarlingArt;
	import starling.textures.Texture;
	import gamecore.ALevel;
	/**
	 * ...
	 * @author useruser3
	 */

	public class HeroAnimations extends AnimationSequence
	{

		public function HeroAnimations() 
		{
				super(ALevel.braidAtlas, ["idle", "jump_prep_straight", "running", "fidget", "falling_downward", "looking_downward", "looking_upward", "dying", "dying_loop"], "idle", 30, false);
				
				StarlingArt.setLoopAnimations(["idle", "running"]);
				
		}
		public function initialize(object:CitrusObject):void
		
		{
			(object as MyHero).artCreated(this); //if your hero's class is Hero of course
		}
		
		
		
		
	
	}
		
	}
