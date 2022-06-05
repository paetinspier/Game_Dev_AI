package {
	import flash.display.*;
	import flash.events.*;
	public class virtualpet extends MovieClip {

		//GAME ELEMENTS
		private var petList: Array;
		private var foodList: Array;
		private var food: Food;
		private var toy: Toy;
		private var foodBowl: FoodDispenser;
		


		public function virtualpet() { //ADD TOY, PET, AND FOOD
			//TASK 1: CREATE A PET LIST TO STORE ALL AI PETS
			//        CREATE FOOD
			petList = new Array();
			foodList = new Array();
			foodBowl = new FoodDispenser();
			food = new Food();

			//TASK 2: CREATE THE TOY THAT ALL PETS WILL PLAY WITH
			toy = new Toy();
			addChild(toy);
			addChild(foodBowl)
			//TASK 3: REGISTER EVENT LISTENERS: NEW PET ARRIVES WHEN TOY IS CLICKED
			foodBowl.addEventListener(MouseEvent.CLICK, addFood);
			toy.addEventListener(MouseEvent.CLICK, addPet);
			addEventListener(Event.ENTER_FRAME, updateEnvironment);
		}


		//*******************************************************************
		public function updateEnvironment(event: Event) {
			//TASK 1:  MOVE AND TWIRL THE TOY
			toy.move();
			toy.twirl.rotation = (toy.twirl.rotation + 1) % 360;

			//TASK 2: PROVIDE EACH PET WITH INFORMATION ABOUT THE ENVIRONMENT
			for (var i = 0; i < petList.length; i++) {
				petList[i].move(toy, foodList);
			}
		}
		// HANDLER RESPONDING TO MOUSE CLICK: ADD NEWEST PET
		public function addPet(event: MouseEvent) {
			var pet: Pet = new Pet();
			addChild(pet);
			petList.push(pet);
		}
		
		public function addFood(event: MouseEvent){
			var food: Food = new Food;
			addChild(food);
			foodList.push(food);
		}

	}
}