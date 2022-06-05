package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class StreetFighter extends MovieClip{
		var karin; Karin;
		public function StreetFighter() {
			// add karin the streetfighter
			karin = new Karin();
			addChild(karin);
			// register keyboard event for key up
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpFunction);
		}
	
		public function keyUpFunction(event:KeyboardEvent){
			switch (event.keyCode){
				case Game.UPARROW:
					karin.kicks();
					break;
				case Game.DOWNARROW:
					karin.punches();
					break;
				case Game.RIGHTARROW:
					karin.movesForward();
					break;
				case Game.LEFTARROW:
					karin.movesBackward();
					break;
			}
		}
	}

}
