package  {
	
	import flash.display.*;
	import flash.events.*;
	import flash.display.MovieClip;
	
	public class BilliardGame extends MovieClip{
		
		private var cueBall: WhiteBall;
		private var blackBall: BlackBall;
		private var blueBall: BlueBall;
		private var greenBall: GreenBall;
		private var purpleBall: PurpleBall;
		private var redBall: RedBall;
		private var yellowBall: YellowBall;
		
		private var stick: Stick;

		public function BilliardGame () {
			// constructor code
			cueBall = new WhiteBall(300, 200);
			cueBall.vx = 0;
			cueBall.vy = 0;
			addChild(cueBall);
			
			blackBall = new BlackBall(400, 120);
			blackBall.vx = 0;
			blackBall.vy = 0;
			addChild(blackBall);
			
			blueBall = new BlueBall(400, 140);
			blueBall.vx = 0;
			blueBall.vy = 0;
			addChild(blueBall);
			
			greenBall = new GreenBall(400, 160);
			greenBall.vx = 0;
			greenBall.vy = 0;
			addChild(greenBall);
			
			purpleBall = new PurpleBall(400, 180);
			purpleBall.vx = 0;
			purpleBall.vy = 0;
			addChild(purpleBall);
			
			redBall = new RedBall(400, 200);
			redBall.vx = 0;
			redBall.vy = 0;
			addChild(redBall);
			
			yellowBall = new YellowBall(400, 220);
			yellowBall.vx = 0;
			yellowBall.vy = 0;
			addChild(yellowBall);
			
			stick = new Stick();
			stick.x = mouseX;
			stick.y = mouseY;
			addChild(stick);
			
			addEventListener(Event.ENTER_FRAME, updateObjects);
			stick.addEventListener(MouseEvent.MOUSE_DOWN, startToShoot);
			
		}
	
		public function updateObjects(event: Event){
			cueBall.movePosition();
			blackBall.movePosition();
			redBall.movePosition();
			greenBall.movePosition();
			blueBall.movePosition();
			purpleBall.movePosition();
			yellowBall.movePosition();
			
			var dx: Number = cueBall.x - mouseX;
			var dy: Number = cueBall.y - mouseY;
			var angle: Number = Math.atan2(dy, dx);
			stick.rotation = angle * 180 / Math.PI;
			
			stick.x = mouseX;
			stick.y = mouseY;
			checkCollision(cueBall, blackBall);
			checkCollision(cueBall, blueBall);
			checkCollision(cueBall, greenBall);
			checkCollision(cueBall, redBall);
			checkCollision(cueBall, yellowBall);
			checkCollision(cueBall, purpleBall);
			
			checkCollision(blackBall, redBall);
			checkCollision(blackBall, blueBall);
			checkCollision(blackBall, purpleBall);
			checkCollision(blackBall, yellowBall);
			checkCollision(blackBall, greenBall);
			
			checkCollision(redBall, blueBall);
			checkCollision(redBall, purpleBall);
			checkCollision(redBall, greenBall);
			checkCollision(redBall, yellowBall);
			
			checkCollision(blueBall, purpleBall);
			checkCollision(blueBall, greenBall);
			checkCollision(blueBall, yellowBall);
			
			checkCollision(purpleBall, greenBall);
			checkCollision(purpleBall, yellowBall);
			
			checkCollision(greenBall, yellowBall);
			
		}
	
		public function startToShoot(event: MouseEvent){
			trace('startToShoot');
			var dx: Number = cueBall.x - mouseX;
			var dy: Number = cueBall.y - mouseY;
			var dist: Number = Math.sqrt(dx * dx + dy * dy);
			
			if (dist > 110){
				stick.startx = stick.x;
				stick.starty = stick.y;
				stick.addEventListener(MouseEvent.MOUSE_UP, finishShoot);
			}
		}
	
		public function finishShoot(event: Event) {
			
			cueBall.vx = (stick.x - stick.startx)*.5;
			cueBall.vy = (stick.y - stick.starty)*.5;
			trace('Cue Ball vx: '+ cueBall.vx);
			trace('Cue Ball vy: '+ cueBall.vy);
			stick.removeEventListener(MouseEvent.MOUSE_UP, finishShoot);
		}
	
		public function checkCollision(ball1, ball2): void {
			var dx: Number = ball1.x - ball2.x;
			var dy: Number = ball1.y - ball2.y;
			var dist: Number = Math.sqrt(dx * dx + dy * dy);
			if (dist < Game.DIAMETER) {
				var angle = Math.atan2(dy, dx);
				var cosa = Math.cos(angle);
				var sina = Math.sin(angle);
				ball1.x = ball2.x + cosa * Game.DIAMETER;
				ball1.y = ball2.y + sina * Game.DIAMETER;
				var vx2 = cosa * ball1.vx + sina * ball1.vy;
				var vy1 = cosa * ball1.vy - sina * ball1.vx;
				var vx1 = cosa * ball2.vx + sina * ball2.vy;
				var vy2 = cosa * ball2.vy - sina * ball2.vx;
				ball1.vx = cosa * vx1 - sina * vy1;
				ball1.vy = cosa * vy1 + sina * vx1;
				ball2.vx = cosa * vx2 - sina * vy2;
				ball2.vy = cosa * vy2 + sina * vx2;
			}

		}

	}
	
}
