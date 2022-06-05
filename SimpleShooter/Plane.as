package  {
	import flash.display.MovieClip;
	
	public class Plane extends MovieClip{
		
		private const RIGHT_BOUNDRY:int = 1000;
		private const LEFT_BOUNDRY:int = -200;
		
		private var velocity: Number;
		private var travelDirection: String;
		public var isActive: Boolean;
		
		public function Plane(travelDirection:String, velocity:Number, altitude:Number):void {
			this.travelDirection = travelDirection;
			if(travelDirection == "left"){
				this.x = LEFT_BOUNDRY;
				this.velocity = velocity;
				this.scaleX = -1;
			}
			else if(travelDirection == "right"){
				this.x = RIGHT_BOUNDRY;
				this.velocity = -velocity;
			}
		
			this.y = altitude;
			this.isActive = true;
		}
	
		public function move():void{
			// task 1 update position by adding velocity
			this.x += velocity;
			
			// task 2 check if a plane has moved beyond its boundary
			
			if (travelDirection == "left" && this.x > RIGHT_BOUNDRY || travelDirection == "right" && this.x < LEFT_BOUNDRY){
				selfDelete();
			}
		
		}
	
		public function selfDelete():void{
			// set plane as in-active
			isActive = false;
			
			// remove the plane
			if(parent != null){
				parent.removeChild(this);
			}
		}

	}
	
}
