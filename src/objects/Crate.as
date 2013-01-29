package objects
{
	import citrus.objects.NapePhysicsObject;
	/**
	 * ...
	 * @author useruser3
	 */
	
	 /**
	  * the Crate class is a simple pushable box that obeys gravity
	  * 
	  * 
	  */
	public class Crate extends NapePhysicsObject
	{

		public function Crate(name:String, params:Object = null) 
		{
			super(name, params);
			
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