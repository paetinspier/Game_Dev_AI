package {
	import flash.events.*;
	import flash.display.*;
	public class Billiards extends MovieClip {
		public var redB: Ball;
		public var greenB: Ball;
		public function Billiards() {
			// constructor code
			redB = new Ball(100, 100);
			redB.setColor(100, 255, 255);
			redB.vx = 80;
			redB.vy = 90;
			addChild(redB);
			greenB = new Ball(300, 100);
			greenB.setColor(255, 100, 255);
			greenB.vx = -250;
			greenB.vy = -150;
			addChild(greenB);
			addEventListener(Event.ENTER_FRAME, moveBalls);
		}
	
		public function moveBalls(event: Event) {
			redB.movePosition();
			greenB.movePosition();
			checkCollision(redB, greenB);
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