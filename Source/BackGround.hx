package;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;

class BackGround extends Sprite  // Класс для загрузки бэкграундов
{
    var bmp:Bitmap;
    public function new(name:String)
    {
        super();    
        bmp = new Bitmap(Assets.getBitmapData("assets/"+name+".png"));
        if(name != "startScreen")
        bmp.x = -100;
        this.addChild(bmp);
    }
}