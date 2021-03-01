package;


import openfl.display.Sprite;

class Ball extends Sprite  
{
    var radius:Float;  //радиус шара
    var speed:Float;  // скорость шара
    //var direction:Float;
    var stuck:Bool;   // переменная, для определения состояния шара
    var sizeWidth:Int;
    var sizeHeight:Int;  // размеры игрового поля
    var dx:Float;
    var dy:Float;  // скорость шара по координатам
    var isFall:Bool;  // переменная, определяющая падение шара(если упал, то проигрыш или обновление уровня сначала)

    public function new(width:Int, height:Int)
    {
        super();
        sizeWidth = width;
        sizeHeight = height;
        radius = sizeWidth/ 60;
        graphics.beginFill(0xfb7000);
        graphics.drawCircle(0,0,radius);
        graphics.endFill();
        graphics.lineStyle(1,0x000000);
        graphics.drawCircle(0,0,radius);
        graphics.endFill();
        stuck = true;
        speed = 0.0;
        isFall = false;
       


    }

    public function move(player:Paddle)
    {
       
        if(stuck)
            {
                x = player.x;
            }
        else 
            {
                if(this.x-radius <= 0)
                    {
                        dx = Math.abs(dx);
                       this.x = radius+1;
                    }
                if(x+radius >= sizeWidth)
                    {
                        dx = -Math.abs(dx);
                        x = sizeWidth - radius-1;
                    }
                if(y-radius <= 0)
                    {
                        dy = Math.abs(dy);
                        y = radius+1;
                    }
                if(y + radius >= sizeHeight)
                         isFall = true;    
                if(x<= player.x+player.width/2 && x >= player.x - player.width/2)
                    if(y+radius >= player.y - player.height/2)
                        {
                            var distance = x - player.x;
                            var percentage = distance/(player.width/2.0);
                            var strength = 2.0;
                            dx = 10.0 * percentage * strength;
                            dy = -Math.abs(dy);
                        }
                x += dx;
                y += dy;
            }
    }
    public function reset(player:Paddle)
    {
        x = sizeWidth/2;
        y = sizeHeight-radius-player.height;
        speed =0.0;
        dx =0.0;
        dy=0.0;
        stuck = true;
        isFall = false;
    }

    public function get_isFall():Bool 
    {
        return isFall;
    } 

    public function get_radius():Float
    {
        return radius;    
    }
    public function get_stuck():Bool
    {
        return stuck;    
    }
    public function set_stuck(value:Bool)
    {
        stuck = value;    
    }
    public function set_speed(value:Float)
    {
        speed = value;  
        //dx = speed/Math.sqrt(2.0);
        dy = -speed/Math.sqrt(2.0);  
    }
    public function set_dy(value:Float)
    {
        dy = value;    
    }
    public function get_dy():Float
    {
        return dy;    
    }
    public function set_dx(value:Float)
        {
            dx = value;    
        }
        public function get_dx():Float
        {
            return dx;    
        }
}