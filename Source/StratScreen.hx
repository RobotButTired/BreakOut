package;



import openfl.events.Event;
import openfl.Lib;
import openfl.text.TextField;
import openfl.display.Sprite;

class StartScreen extends Sprite
{
    var text:TextField;   //текст на стартовом экране
    var screen:BackGround;  // фон на староттовом экране
    var up:Bool = true;  // переменная для анимации текста
    public function new()
    {
        super();
        screen = new BackGround("startScreen");
        this.addChild(screen);
        text = new TextField();
        text.text = "Press Space \nto start game...";
        text.scaleX = 7.0;
        text.scaleY = 7.0;
        text.textColor = 0xFFFF00;
        text.mouseEnabled = false;
        
        text.x = screen.width/4;
        text.y = screen.height/4;
        this.addChild(text);
        addEventListener(Event.ENTER_FRAME, onFrame);

    }

    public function onFrame(e:Event)
    {
        var speed = 0.05;

        if(up)
            {
                text.scaleX += speed;
                text.scaleY += speed;
                if(text.scaleX >= 7.5)
                    up = false;
            }
        else if(!up)
            {
                text.scaleX -= speed;
                text.scaleY -= speed;
                if(text.scaleX <= 6.5)
                    up = true;
            }
        text.alpha = Math.sin(2*(text.scaleX-6.5));
        if(text.alpha<=0.2)
            text.alpha = 0.2;

    }
}