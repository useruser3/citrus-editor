package objects.objectAnimations
{
	import objects.MyEnemy;
	import citrus.core.CitrusObject;
	import citrus.view.starlingview.AnimationSequence;
	import starling.textures.Texture;
	import gamecore.ALevel;
	/**
	 * ...
	 * @author useruser3
	 */
	public class HedgehogMonsterAnimations extends AnimationSequence
	{
		
		public function HedgehogMonsterAnimations() 
		{
			super(ALevel.braidAtlas,["monster-walking","monster-dying","monster-falling"], "monster-walking", 30,true);
		}
		
		public function initialize(object:CitrusObject):void
		
		{
			(object as MyEnemy).artCreated(this); //if your enemy's class is Enemy of course
		}
		
	}

}