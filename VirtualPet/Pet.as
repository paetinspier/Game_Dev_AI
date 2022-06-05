package  {
	import flash.display.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Pet extends MovieClip{
		private var myState: int;
		private var timer: Timer;
		// possible pet states
		private const isPLAYING:int = 1;
		private const isLOOKING_FOR_FOOD:int = 2;
		private const isEATING:int = 3;
		
		private var stomachCapacity: int;
		private var currentStomachLevel:int;
		private const EMPTY: int = 0;
		
		private var easingVelocity:int;
		
		
		public function Pet() {
			// constructor code
			stomachCapacity = Math.random()* 100 + 150;
			currentStomachLevel = stomachCapacity;
			myState = isPLAYING;
			
			
			this.width = Math.random() * 45 + 45;
			this.height = this.width + 20;
			easingVelocity = Math.random() * 45 + 15;
			this.x = Math.random() * 600 + 200;
			this.y = Math.random() * 200 + 200;
			
			timer = new Timer(5);
			timer.start();
		}
	
		public function move(toy: Toy, foodArray: Array):void{
			
			switch(myState){
				case isPLAYING:
					currentStomachLevel--;
					locateTarget(toy.x,toy.y);
					if(currentStomachLevel < EMPTY){
						myState = isLOOKING_FOR_FOOD;
					}
					break;
				case isLOOKING_FOR_FOOD:
				
					if(foodArray.length == 0 && timer.currentCount >= 30){
						locateTarget(100,650);
						if(timer.currentCount >= 1000){
							if(parent != null){
								parent.removeChild(this);
								timer.stop();
							}
						}
						break;
					}
				
				
					
					//if(foodArray.length == 0 && timer.currentCount >)
					for(var i: int = 0; i < foodArray.length; i++){
						if(!foodArray[i].eaten){
							locateTarget(foodArray[i].x,foodArray[i].y);
							if(foodArray[i].hitTestPoint(this.x,this.y,true)){
								myState = isEATING;
								parent.removeChild(foodArray[i]);
								foodArray.removeAt(i);
							}
							break;
						}

					}
					break;
				case isEATING:
					currentStomachLevel++;
					if(currentStomachLevel >= stomachCapacity){
						timer.reset();
						myState = isPLAYING;
					}
					timer.reset();
					timer.start();
					break;
					
			}
		}
	
		public function locateTarget(xTarget: Number, yTarget: Number):void{
			var xDist: Number = xTarget - this.x;
			var yDist: Number = yTarget - this.y;
			var angle: Number = Math.atan2(yDist, xDist);
			this.rotation = angle *180/Math.PI + 90;
			
			this.x += (xTarget - this.x) / easingVelocity;
			this.y += (yTarget - this.y) / easingVelocity;
			
		}
	

	}
	
}
