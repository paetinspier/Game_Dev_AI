package {
	import flash.display.*;

	public class Toy extends MovieClip {

		//DATA MEMBERS AND CONSTANTS
		private var velocity: Number;
		private const LEFT: Number = 50;
		private const RIGHT: Number = 1024;
		
		
		//DEFAULT CONSTRUCTOR
		public function Toy() {
			velocity = 2;
			this.x = 10;
			this.y = 200;
		}

		//FUNCTIONALITY: MOVEMENT
		public function move(): void {
			//TASK 1: MOVE THE TOY HORIZONTALLY USING A FIXED VELOCIY
			this.x += velocity;

			//TASK 2: CHECK IF THE TOY HAS COLLIDED WITH THE WALL BOUNDARY.  REVERSE ITS DIRECTION IN THIS CASE
			if (this.x > RIGHT - this.width) {
				velocity *= -1;
				this.x = RIGHT - this.width;
			} else if (this.x < LEFT) {
				velocity *= -1;
				this.x = LEFT;
			}
		}

	}

}