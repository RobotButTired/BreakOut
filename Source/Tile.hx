package;


import openfl.geom.Matrix;
import openfl.display.Sprite;

class Tile extends Sprite  // Класс "Плитка"(Кирпич)
{
    var isDestructible:Bool;  // разрушаем ли кирпич?
     public function new(index:Int) 
    {
        super();
        if(index == 1)
            {
                isDestructible = false;
            }
        else 
            isDestructible = true;

    }

    public function createTile(color:Int, widthTile:Float, heightTile:Float)
        {
           this.graphics.beginFill(color);
           
            this.graphics.drawRect(0.5-widthTile/2,0.5-heightTile/2,widthTile-1.0, heightTile-1.0);

            this.graphics.endFill();
            this.graphics.lineStyle(2,0x000000,0.8);
            this.graphics.drawRect(0.5-widthTile/2,0.5-heightTile/2,widthTile-1.0, heightTile-1.0);
            this.graphics.endFill();


        }
    public function get_isDestructible():Bool
    {
        return isDestructible;    
    }    
}