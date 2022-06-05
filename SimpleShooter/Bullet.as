package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Bullet extends MovieClip {
		
		private const UPPER_BOUNDARY:int = 2000;
		private var velocity:Number;
		public var isActive: Boolean;
		
		public function Bullet(velocity:Number) {
			this.x = 500;
			this.y = 450;
			this.isActive = true;
			this.velocity = velocity;
		}
	
		public function move(event:Event){
			// task 1 update position by adding velocity
			this.y += velocity;
			
			// task 2 check if a plane has moved beyond its boundary
			
			if (this.y > UPPER_BOUNDARY){
				selfDelete();
			}
			else{
				for(var i:Number = 0; i < SimpleShooter.planeList.length; i++){
					if(this.y >= SimpleShooter.planeList[i].y - 50 && this.y <= SimpleShooter.planeList[i].y + 50){
						if(this.x >= SimpleShooter.planeList[i].x - 50 && this.x <= SimpleShooter.planeList[i].x + 50){
							trace("hit");
							parent.removeChild(this);
							SimpleShooter.planeList[i].selfDelete();
						}
					}
				}
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
