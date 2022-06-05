package  {
	import flash.display.MovieClip;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.ColorTransform;
	import flash.utils.*;
	
	public class WhiteBall extends MovieClip {
		public var vx: Number;
		public var vy: Number;
		private var lastTimeStamp: uint;

		public function WhiteBall(mx: Number, my: Number) {
			// constructor code
			this.x = mx;
			this.y = my;
			lastTimeStamp = getTimer();
		}
	
		public function movePosition (): void {
			
			if (vx != 0 && vy != 0){
				var elapsedTime: int = getTimer() - lastTimeStamp;
				lastTimeStamp += elapsedTime;
				
				vx *= Game.FRICTION;
				vy *= Game.FRICTION;
				
				this.x += this.vx * elapsedTime / 100;
				this.y += this.vy * elapsedTime / 100;
				
				var speedVecotr: Number = Math.sqrt(vx * vx + vy * vy);
				if (speedVecotr < Game.MINSPEED){
					vx = 0;
					vy = 0;
				}
			
				checkWall();
				checkPocket();
			}
			
		}
	
		public function checkPocket():void{
			// pocket 1
			if(this.x >= 140 && this.x <= 150){
				if(this.y >= 100 && this.y <= 110){
					this.x = 300;
					this.y = 200;
				}
			}
			// pocket 2
			if(this.x >= 590 && this.x <= 600){
				if(this.y >= 100 && this.y <= 110){
					this.x = 300;
					this.y = 200;
				}
			}
			// pocket 3
			if(this.x >= 140 && this.x <= 150){
				if(this.y >= 330 && this.y <= 340){
					this.x = 300;
					this.y = 200;
				}
			}
			// pocket 4
			if(this.x >= 590 && this.x <= 600){
				if(this.y >= 330 && this.y <= 340){
					this.x = 300;
					this.y = 200;
				}
			}
		}
	
		public function checkWall(): void {
			// LEFT OR RIGHT BORDERS
			if (this.x < Game.LEFTBORDER){
				this.vx *= Game.REVERSE;
				this.x = Game.LEFTBORDER;
			} else if (this.x > Game.RIGHTBORDER){
				this.vx *= Game.REVERSE;
				this.x = Game.RIGHTBORDER;
			} 
		
		
			// TOP AND BOTTOM BORDERS
			if (this.y < Game.TOPBORDER){
				this.vy *= Game.REVERSE;
				this.y = Game.TOPBORDER;
			} else if (this.y > Game.BOTTOMBORDER){
				this.vy *= Game.REVERSE;
				this.y = Game.BOTTOMBORDER;
			}
		}

	}
	
}
