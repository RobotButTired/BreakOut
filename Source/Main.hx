package;

import openfl.geom.Rectangle;
import StratScreen;
import openfl.events.Event;
import openfl.Lib;
import openfl.events.KeyboardEvent;
import openfl.display.Sprite;
class Main extends Sprite
{
	var game:Game;  // Экземпляр класса игры
	var startScreen:StartScreen;  // Стартовый экран
	var gameIsActive:Bool; // Состояние игры
	var rect:Rectangle;  // ()
	var sizeWidth = 800;
	var sizeHeight = 600;  // размеры игрового поля
	public function new()
	{
		super();
		 
		rect = new Rectangle(0,0,sizeWidth, sizeHeight);
		
		//addChild(rect);
		startScreen = new StartScreen();
		this.scrollRect = rect;
		addChild(startScreen);
		gameIsActive = false;
		
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN,startGame);
		Lib.current.stage.addEventListener(Event.ENTER_FRAME,onFrame);
	}

	public function startGame(e:KeyboardEvent)
	{
		if(e.keyCode == 32 && !gameIsActive)
			{
				game = new Game(sizeWidth, sizeHeight);
				this.addChild(game);
				game.scrollRect = rect;
				this.removeChild(startScreen);
				gameIsActive = true;
				trace("start");
			}
	}
	public function onFrame(e:Event)
	{
		if(gameIsActive && game.get_gameLVL() > 4)
			{
				startScreen = new StartScreen();
				addChild(startScreen);
				removeChild(game);
				gameIsActive = false;
			}
	}
}
