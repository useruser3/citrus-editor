package objects 
{
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Enemy;
	import citrus.physics.nape.NapeUtils;
	import citrus.view.starlingview.AnimationSequence;
	import flash.events.IOErrorEvent;
	import nape.callbacks.InteractionCallback;
	import nape.dynamics.InteractionFilter;
	import nape.geom.Vec2;
	import citrus.physics.PhysicsCollisionCategories;
	import objects.objectAnimations.HedgehogMonsterAnimations;
	/**
	 * ...
	 * @author useruser3
	 */
	public class MyEnemy  extends Enemy
	{
		public var isDead:Boolean = false;
		
		public function MyEnemy(name:String, params:Object = null) 
		{
			super(name, params);
			HedgehogMonsterAnimations;
		}
		
		override public function update(timeDelta:Number):void
		{			
			var position:Vec2 = _body.position;
			//Turn around when they pass their left/right bounds
			if ((!_inverted && position.x < leftBound) || (_inverted && position.x > rightBound))
				turnAround();
			
			var velocity:Vec2 = _body.velocity;
			
			if (!_hurt && isDead == false)
				velocity.x = _inverted ? speed : -speed;
			else
				velocity.x = 0;
			
			_body.velocity = velocity;
		if (isDead)
			{
				_animation = "monster-dying";
			}
		
		}

		override protected function updateAnimation():void 
		{	
		}
		
		public function killNow():void
		{
			isDead = true;
			
			
			
			_body.velocity.y -= 150;
			//_body.allowRotation = true;
			//_body.angularVel = 0.4;
			
		}
		//when an animation finishes
		private function onAnimationOver(name:String):void
		{
			if (_animation == "monster-dying")
			{
				kill = true;
			}
		}
		public function artCreated(art:*):void
		{
			if (art is AnimationSequence)
				(art as AnimationSequence).onAnimationComplete.add(onAnimationOver);
		}

		override public function handleBeginContact(interactionCallback:InteractionCallback):void 
		{
			super.handleBeginContact(interactionCallback);
			var collider:NapePhysicsObject = NapeUtils.CollisionGetOther(this, interactionCallback);
			
			//if the list of arbiters has a length of greater than 0 and the record at index 0 is a collision arbiter
			if (interactionCallback.arbiters.length > 0 && interactionCallback.arbiters.at(0).collisionArbiter)
			{
				if (collider is MyHero && isDead == false)
				{
					//(collider as myHero).damage(100);
					(collider as MyHero).damage(100);
				}
			}

		}
		override protected function createFilter():void 
		{
			_body.setShapeFilters(new InteractionFilter(PhysicsCollisionCategories.Get("BadGuys"), PhysicsCollisionCategories.GetAllExcept("BadGuys")));
		}
		
				public function onError(e:IOErrorEvent):void
			{
				trace(e.text);
			}
	}

}