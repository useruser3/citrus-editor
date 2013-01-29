package gamecore
{
	import flash.events.IOErrorEvent;
	
	public class Assets 
	
	{	
		[Embed(source="../../bin/embed/assets/Braid.png")]
		public static const braid:Class;
		
		[Embed(source="../../bin/embed/assets/Braid.xml",mimeType="application/octet-stream")]
		public static const braidXML:Class;
	/**
	 * 
	 * @param	e
	 */	
		public function onError(e:IOErrorEvent):void
			{
				trace(e.text);
			}

	}
	
		
}