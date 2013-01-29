package objects
{
	import citrus.core.IState;
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Hero;
	import citrus.physics.nape.NapeUtils;
	import citrus.view.starlingview.AnimationSequence;
	import flash.events.IOErrorEvent;
	import objects.objectAnimations.HeroAnimations;
	import nape.callbacks.InteractionCallback;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author useruser3
	 */
	public class MyHero extends Hero
	{
		protected var _maxHealth:uint = 5000;
		protected var _health:uint = 1000;
		protected var _invicible:Boolean = false;
		public var isDead:Boolean = false;
		
		public function MyHero(name:String, params:Object = null)
		{
			super(name, params);
			HeroAnimations;
			//how long the hero displays his hurt animation
			hurtDuration = 200;
		}
		
		override public function update(timeDelta:Number):void
		{
			
			//is the hero currently dead? this should be false by default
			if (isDead == true)
			{
				
				//animation to play if the hero is dead
				_animation = "dying";
				
				//if the dying animation has finished playing
				
				return;
			}
			
			if (_onGround)
			{
				//when hero is idle on the ground
				_animation = "idle";
				
				if (_ce.input.isDoing("up", inputChannel))
				{
					//animation to trigger when the up key is pressed while on the ground
					_animation = "looking_upward";
					
				}
				if (_ce.input.isDoing("down", inputChannel))
				{
					//animation to trigger when the down key is pressed while on the ground
					_animation = "looking_downward";
				}
			}
			//if the right key is pressed
			if (_ce.input.isDoing("right", inputChannel))
			{ //and the hero is on the ground
				if (_onGround)
					//animation to play while moving
					_animation = "running";
				//add a velocity of 143 to make the hero move right
				_body.velocity.x = 143;
				_inverted = false;
			}
			
			//if the left key is pressed
			if (_ce.input.isDoing("left", inputChannel))
			{
				//and the hero is on the ground
				if (_onGround)
					//animation to play while moving
					_animation = "running";
				//add a velocity of -143 to make the hero move left
				_body.velocity.x = -143;
				//set inverted to true to flip the image
				_inverted = true;
			}
			
			if (_ce.input.justDid("jump", inputChannel) && _onGround)
			{ //add a y velocity of 400 to the hero to make them move upwards
				_body.velocity.y -= 400;
				//animation to play when jumping
				_animation = "jump_prep_straight";
				//the hero is no longer on the ground
				_onGround = false;
			}
			//if the x velocity is greater than 20
			if (velocity.x > 20)
				velocity.x = 20;
			else if (velocity.x < -20)
				velocity.x = -20;
			
			//possibly needs changing: if the hero is not touching any other objects
			if (body.interactingBodies().length == 0)
				if (_body.velocity.y > 0)
					//animation to play when falling
					_animation = "falling_downward";
			
			if (_body.velocity.y > 1200 && isDead == true)
				//animation to play when falling while dead
				_animation = "dying_loop";
			
			if (_health == 0)
			{
				isDead = true;
				_invicible = true;
			}
		}
		
		override protected function updateAnimation():void
		{
		
		}
		
		override public function handleBeginContact(interactionCallback:InteractionCallback):void
		{
			
			//super.handleBeginContact(interactionCallback);
			var collider:NapePhysicsObject = NapeUtils.CollisionGetOther(this, interactionCallback);
			
			//if the list of arbiters has a length of greater than 0 and the record at index 0 is a collision arbiter
			if (interactionCallback.arbiters.length > 0 && interactionCallback.arbiters.at(0).collisionArbiter)
			{
				//get the normalised angle of that collision times it by 180 and divide it by PI
				var angle:Number = interactionCallback.arbiters.at(0).collisionArbiter.normal.angle * 180 / Math.PI;
				//if 45 is less than the angle of the collision and the angle of collision is less than 135 ???? to add up to 180?
				if ((45 < angle) && (angle < 135))
				{
					//the hero is on the ground
					_onGround = true;
					//if angle of collision is 90 and the collision is with an enemy then the hero has collided with the enemies head
					if (collider is MyEnemy)
					{
						//kill the enemy
						(collider as MyEnemy).killNow();
						_body.velocity.y -= 150;
					}
				}
				//if the enemy is not dead and the hero has collided with any part of the enemy other than on its head
				
			}
		
		}
		//when an animation finishes
		private function onAnimationOver(name:String):void
		{
			trace("the" + " " + _animation +" " + "animation" + " " + "just finished playing");
			if (_animation == "dying")
			{
				//TODO
				kill = true;
				trace("the hero is dead the level should restart");
			}
		}
		
		public function artCreated(art:*):void
		{
			if (art is AnimationSequence)
				(art as AnimationSequence).onAnimationComplete.add(onAnimationOver);
		}
	
		//deal damage to the hero (should be called from other classes)
	public function damage(value:uint = 0):void
	{
		if (!_invicible && isDead == false)
		{ 
			
			if (_health - value > 0)
			{
			_health -= value; 
			trace(_health);
			}
		else
		{
          _health = 0;
          isDead = true
		}
		}
	 
	}

	public function heal(value:uint = 0):void
	{
		if (_health < _maxHealth && isDead == false)
		{
			_health += value;
		}
		if (_health < _maxHealth)
		{
		trace(_health);
		}
		if (_health == _maxHealth)
		{
			trace("you are at full health");
		}
	}
	
		public function onError(e:IOErrorEvent):void
			{
				trace(e.text);
			}
	}

}