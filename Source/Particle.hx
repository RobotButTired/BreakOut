package;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;

class Particle extends  Sprite  // Класс частиц
{
    var dx:Float; 
    var dy:Float; // скорость чатиц по координатам
    var g:Float;  // скорость притяжения частиц
    public var TTL:Int;
    public function new(name:String)
    {
        super();    
        var bmp = new Bitmap(Assets.getBitmapData("assets/"+name+".png"));
        bmp.x = -bmp.width/2;
        bmp.y = -bmp.height/2;
        addChild(bmp);
        if(name == "particle2")
            {
                var angle = 2.0* Math.random() * Math.PI;
                var speed = 2.0 + 5.0* Math.random();
                dx =speed * Math.cos(angle);
                dy =speed * Math.sin(angle);
                rotation = Math.random() * 360;
                g = 0.3;
                TTL = 30;
            }
        if(name == "particle")
            {
                var angle = 2.0* Math.random() * Math.PI;
                var speed = 0.2* Math.random();
                dx =speed * Math.cos(angle);
                dy =speed * Math.sin(angle);
                g=0;
                rotation = Math.random() * 360;
                TTL = 15;
            }

    }

    public function update()
    {
        x+= dx;
        y+= dy;  
        dy += g;
        TTL--;  
        alpha *= 0.964;
    }
    public function set_dy(value:Float)
    {
        dy = value;    
    }
}