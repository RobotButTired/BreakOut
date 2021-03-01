package;

import openfl.display.Sprite;

class Paddle extends Sprite  //Класс ракетки, управляемой игроком
{
    //var speed:Float;
    var isLeft:Bool;
    var isRight:Bool;  // переменные для определения направления длвижения ракетки
    var paddleWidth:Float; 
    var paddleHeight:Float;  // ширина и высота ракетки
    var sizeWidth:Int;
    var sizeHeight:Int; // размеры игрового поля

    public function new(width:Int, height:Int)
    {
        super();
        sizeWidth = width;
        sizeHeight = height;
        paddleWidth = width/6;
        paddleHeight = height / 30;
        graphics.beginFill(0xFCBDA9);
        graphics.drawRoundRect(-paddleWidth/2,-paddleHeight/2,paddleWidth,paddleHeight , 15.0);
        graphics.endFill();
        this.graphics.lineStyle(2,0x000000,1.0);
        this.graphics.drawRoundRect(-paddleWidth/2,-paddleHeight/2,paddleWidth,paddleHeight , 15.0);
        this.graphics.endFill();
        reset();

        
    }
    public function set_isLeft(value:Bool)
    {
        isLeft = value;
    }
    public function get_isLeft():Bool
    {
            return isLeft;
    }
    public function set_isRight(value:Bool)
    {
            isRight = value;
    }
        public function get_isRight():Bool
    {
                return isRight;
    }

    public function move(speed:Float)
    {
        if(isLeft && x-paddleWidth/2 >=0)
                x -= speed;
        if(isRight && x+paddleWidth/2 <=sizeWidth)
            x += speed;
    }
    public function reset() 
    {
        x = sizeWidth /2;
        y =sizeHeight - paddleHeight/2;
    }
        

}