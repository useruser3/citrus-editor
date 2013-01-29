package objects 
{
	import citrus.objects.NapePhysicsObject;
	import citrus.view.starlingview.AnimationSequence;
	import objects.objectAnimations.SpikesAnimations;
	/**
	 * ...
	 * @author useruser3
	 */
	public class Spikes extends NapePhysicsObject
	{
		
		public function Spikes(name:String, params:Object = null) 
		{
			super(name, params);
			SpikesAnimations;
			//_animation = "monster-dying"
		}
		
		public function artCreated(art:*):void
		{
			if (art is AnimationSequence)
				(art as AnimationSequence).onAnimationComplete.add(onAnimationOver);
		}
		
		private function onAnimationOver(name:String):void
		{
			
		}
		
		override public function update(timeDelta:Number):void 
		{
		 
		}
		override protected function createBody():void 
		{
			super.createBody();
			_body.isBullet = false;
		}
		override protected function createMaterial():void 
		{
			super.createMaterial();
			_material.density = 0.1;
			_material.elasticity = 0;
	
		}
		
	}

}