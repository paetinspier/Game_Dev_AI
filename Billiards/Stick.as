package {
	import flash.display.*;
	
	
	public class Stick extends MovieClip {
		public var startx: Number; //USED TO COMPUTE VELOCITY ALONG X AXIS
		public var starty: Number; //USED TO COMPUTE VELOCITY ALONG Y AXIS

		
		public function Stick() {
			startx = this.x;
			starty = this.y;
		}
	}
}