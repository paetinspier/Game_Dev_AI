package {
	import flash.events.*;
	import flash.display.*;
	import flash.utils.*;

	public class CarDrivingGame extends MovieClip {
		//GAME ELEMENTS
		private var car:Car;
		private var lastTimeStamp:uint;
		private var speedometer: Speedometer;
		private var sensorH: int;
		private var sensorW: int;
		private var sensorLeft: Sensor;
		private var sensorRight: Sensor;
		private var toRadians: Number = Math.PI / 180;

		public function CarDrivingGame() {
			//TASK 1: ADD THE CAR TO THE STAGE
			car = new Car(track.x, track.y); // 500, 400
			addChild(car);
			
			speedometer = new Speedometer();
			speedometer.x = 130;
			speedometer.y = 470;
			addChild(speedometer);

			// TASK 2: REGISTER KEYBOARD EVENTS FOR KEY DOWN
			// NOTE: USING BOTH EVENTS, USERS CAN TURN AND ACCELERATE SIMULTANEUSLY
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownFunction);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyUpFunction);
			
			//TASK 3: REGISTER LISTENER EVENT FOR THE GAME LOOP
			lastTimeStamp = getTimer();
			addEventListener(Event.ENTER_FRAME,updateCameraAngle);

			//TASK B: APPLY THE TWO SENSORS
			car.rotation = 0;
			var rotateAngleRadians:Number = car.rotation * toRadians;
			
			//2. COMPUTE  DISTANCE FROM CAR CENTER TO ANTENNA CENTER
			var carHyp:Number = Math.sqrt(15*15 + 30*30);
            car.cornerDist = carHyp + 10;
			
			//3. COMPUTE THETA: ANGLE DEFINED FROM CENTER OF CAR TO ANTENNA
			var thetaRadians = Math.atan2(60.0/2, 30.0/2);
			car.thetaRadians = thetaRadians;
			
			//4. COMPUTE ALPHA IN RADIANS, THE CAR RORTATES ALPHA
			var alphaDegrees = -1*car.rotation;
			var alphaRadians:Number = alphaDegrees * 3.14159/180;
			
			//5. COMPUTE XY POSITION THE RIGHT ANTENNA AND CREATE THE ANTENNA
			var xPos = car.x + car.cornerDist*Math.cos(thetaRadians + alphaRadians);
			var yPos = car.y - car.cornerDist*Math.sin(thetaRadians + alphaRadians);
			sensorRight = new Sensor(xPos, yPos);
			addChild(sensorRight);
			
			//6. COMPUTE XY POSITION THE LEFT ANTENNA AND CREATE THE ANTENNA
			xPos = car.x + car.cornerDist*Math.cos(Math.PI - thetaRadians + alphaRadians);
			yPos = car.y - car.cornerDist*Math.sin(Math.PI - thetaRadians + alphaRadians);
			sensorLeft = new Sensor(xPos, yPos);
			addChild(sensorLeft);
			
			// CAR IS ALWAYS MOVING
			car.isMovingForward = true;
			
		}

		public function updateCameraAngle(event:Event) {
			//TASK 1: COMPUTE ELAPSED TIME
			var elapsedTime:int = getTimer() - lastTimeStamp;
			lastTimeStamp += elapsedTime;

			// TASK 2: CHANGE THE CAMERA ANGLE
			var toRadians:Number = Math.PI / 180;
			track.x +=  car.velocity * Math.sin(car.rotation * toRadians) * elapsedTime / 100;
			track.y -=  car.velocity * Math.cos(car.rotation * toRadians) * elapsedTime / 100;
			
			// SENSOR
			var sensorDistance: Number = Math.sqrt((car.width * car.width) + (car.height * car.height));
			var theta: Number = Math.atan(car.height / car.width) * toRadians;
			
			// ATTEMPT
			var rotateAngleRadians:Number = car.rotation * toRadians;
			
			//2. COMPUTE  DISTANCE FROM CAR CENTER TO ANTENNA CENTER
			var carHyp:Number = Math.sqrt(15*15 + 30*30);
            car.cornerDist = carHyp + 10;
			
			//3. COMPUTE THETA: ANGLE DEFINED FROM CENTER OF CAR TO ANTENNA
			var thetaRadians = Math.atan2(60.0/2, 30.0/2);
			car.thetaRadians = thetaRadians;
			
			//4. COMPUTE ALPHA IN RADIANS, THE CAR RORTATES ALPHA
			var alphaDegrees = -1*car.rotation;
			var alphaRadians:Number = alphaDegrees * 3.14159/180;
			
			//5. COMPUTE XY POSITION THE RIGHT ANTENNA AND CREATE THE ANTENNA
			var xPos = car.x + car.cornerDist*Math.cos(thetaRadians + alphaRadians);
			var yPos = car.y - car.cornerDist*Math.sin(thetaRadians + alphaRadians);
			sensorRight.x = xPos;
			sensorRight.y = yPos
			
			//6. COMPUTE XY POSITION THE LEFT ANTENNA AND CREATE THE ANTENNA
			xPos = car.x + car.cornerDist*Math.cos(Math.PI - thetaRadians + alphaRadians);
			yPos = car.y - car.cornerDist*Math.sin(Math.PI - thetaRadians + alphaRadians);
			sensorLeft.x = xPos;
			sensorLeft.y = yPos;
			
			if (track.hitTestPoint(car.x, car.y, true)){
				car.collisionUpdate();
			}
		
			speedometer.needle.rotation = car.velocity *3 * -1;
		
			if (track.hitTestPoint(sensorLeft.x, sensorLeft.y, true)){ // hitting left
				car.isTurningLeft = false;
				car.isTurningRight = true;
			} else if (track.hitTestPoint(sensorRight.x, sensorRight.y, true)){ // hitting right
				car.isTurningRight = false;
				car.isTurningLeft = true;
			} 
		
			// if its not hitting any of the sensors
			else if (!track.hitTestPoint(sensorLeft.x, sensorLeft.y, true) && !track.hitTestPoint(sensorRight.x, sensorRight.y, true)){
				car.isTurningRight = false;
				car.isTurningLeft = false;
			}
			
		}

		//****************** KEYBOARD EVENT METHODS ********************************
		public function keyDownFunction(event:KeyboardEvent) {
			//FINITE STATES ACCELERATION, REVERSE, TURNING, BRAKING
			switch (event.keyCode) {
				case Game.UPARROW :
					car.isMovingForward = true;
					break;
				case Game.DOWNARROW :
					car.isMovingReverse = true;
					break;
				case Game.LEFTARROW :
					car.isTurningLeft = true;
					break;
				case Game.RIGHTARROW :
					car.isTurningRight = true;
					break;
				case Game.SPACEBAR :
					car.isBraking = true;
			}
		}

		public function keyUpFunction(event:KeyboardEvent) {
			switch (event.keyCode) {
				case Game.UPARROW :
					car.isMovingForward = false;
					break;
				case Game.DOWNARROW :
					car.isMovingReverse = false;
					break;
				case Game.LEFTARROW :
					car.isTurningLeft = false;
					break;
				case Game.RIGHTARROW :
					car.isTurningRight = false;
					break;
				case Game.SPACEBAR :
					car.isBraking = false;	
			}
		}
	}
}