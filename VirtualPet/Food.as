package  {
	import flash.display.MovieClip;
	
	public class Food extends MovieClip{
		
		var eaten: Boolean;

		public function Food() {
			this.y = Math.random() * 100 + 600;
			this.x = Math.random() * 800 + 150;
			eaten = false;
		}

	}
	
}
