﻿package  {
	
	public class Game {

		//DRIVING CONSTANTS
		public static var MAX_VELOCITY:Number = -15;  		// MAXIMUM VELOCITY OF THE CAR
		public static var MIN_VELOCITY:Number = 0;    		//MINIMUM VELOCITY OF THE CAR
		public static var ACCELERATION:Number = -1;   		//ACCELERATION OF THE CAR
		public static var DECELERATION:Number = 0.98; 		//THE DECELERATION OF THE CAR WHEN NOT ACCELERATING
		public static var BRAKE:Number = .5;          		//THE DECELERATION OF THE CAR WHEN BRAKING
		public static var REVERSE:Number = 0.4;       		//THE ACCELERATION OF THE CAR WHEN IN REVERSE
		public static var MAX_REVERSE_VELOCITY:Number = 3;	//THE MAXIMUM SPEED OF THE CAR WHEN IN REVERSE
		public static var TURN:Number = 6;            		//THE AMOUNT OF ROTATION THE CAR TURNS
		public static var SLOW:Number = -0.85;   			//THE RATE AT WHICH THE CAR SLOWS DOWN IF IT LEAVES THE TRACK

		//KEYBOARD ARROW KEYS
		public static var UPARROW:int = 38;
		public static var DOWNARROW:int = 40;
		public static var LEFTARROW:int = 37;
		public static var RIGHTARROW:int = 39;
		public static var SPACEBAR:int = 32;
		public static var AI_CAR:int = 70;

	}
	
}
