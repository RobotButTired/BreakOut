package;

import openfl.display.Sprite;

class GameLevel  // Класс , который содержит все необходимое для генерации уровня
{
    var sizeWidth:Int;
    var sizeHeigth:Int;  // размеры игрового поля
    public  var tiles:Array<Tile> =[];  //массив кирпичей
    var indexes:Array<Array<Int>> = [];  // массив индексов кирпичей(индексы определяют цвет и разрушаемость кирпича, или указывают, что кирпича вовсе нет)
    var spritesAmountHor:Int;  // переменная (кол-во элементов по горизонтали), необходимая для расчета ширины кирпича
    var spritesAmountVert:Int;  // переменная (кол-во элементов по вертикали), необходимая для расчета высоты кирпича
    var widthTile:Float;        
    var heightTile:Float;  // высота и ширина кирпича
    var indestrucTiles:Int = 0 ;  // кол-во неразрушаемых кирпичей(нужна, чтобы определить когда уровень пройден)
    public var backGround:BackGround;
    
    public function new(game:Game, width:Int, height:Int, lvl:Int )
    {

        this.sizeWidth = width;
        this.sizeHeigth = height;
        

        var lvl_1 =     [[1,1,1,1,1,1],
                         [2,2,0,0,2,2],
                         [3,3,4,4,3,3]];

        var lvl_2 =     [[1,2,2,2,2,2,2,2,2,1],
                        [2,3,2,3,2,3,2,3,2,3],
                         [2,1,1,1,5,5,1,1,1,2],
                         [3,3,3,4,4,1,4,4,3,3],
                         [5,5,5,5,5,5,5,5,5,5],
                         [4,1,1,4,4,4,4,1,1,4]];

        var lvl_3 = [[0,0,0,0,0,0,0,0,0,0,0,0,0],
                     [0,0,2,0,0,0,0,0,0,0,2,0,0],
                      [0,0,0,2,0,0,0,0,0,2,0,0,0],
                      [0,0,0,5,5,5,5,5,5,5,0,0,0],
                      [0,0,5,5,0,5,5,5,0,5,5,0,0],
                      [0,5,5,5,5,5,5,5,5,5,5,5,0],
                      [0,3,0,1,1,1,1,1,1,1,0,3,0],
                      [0,3,0,3,0,0,0,0,0,3,0,3,0],
                       [0,0,0,0,4,4,0,4,4,0,0,0,0]];

        var lvl_4 = [[1,2,1,2,1,2,1,2,1,2,1,2,1],
                        [2,2,2,2,2,2,2,2,2,2,2,2,2],
                         [2,1,3,1,4,1,5,1,4,1,3,1,2],
                         [2,3,3,4,4,5,5,5,4,4,3,3,2,],
                         [2,1,3,1,4,1,5,1,4,1,3,1,2],
                         [2,2,3,3,4,4,5,4,4,3,3,2,2]]; // расположение кирпичей 
        var lvl_0 = [[0,1],[1,0]];                            

        switch(lvl)
        {
            case 1:
            indexes = lvl_1;
            backGround = new BackGround("backGround1");
            case 2:
            indexes = lvl_2;
            backGround = new BackGround("backGround2");
            case 3:
                indexes = lvl_3;
                backGround = new BackGround("backGround3");
                case 4:
                    indexes = lvl_4;
                    backGround = new BackGround("backGround4");
                    case 5:
                    indexes = lvl_0;
                    backGround = new BackGround("backGround4");
        }
        spritesAmountHor = indexes[0].length;
        spritesAmountVert = indexes.length;
       // trace(indexes.length);
        
        

         widthTile = sizeWidth/spritesAmountHor; // расчитываем ширину и высоту кирпича
         heightTile = sizeHeigth/(spritesAmountVert * 2);
        var i =0;
        var j =0;
        //trace(indexes.length);
        //trace(indexes[1].length);
        while(i < indexes.length)
            {
            while(j < indexes[i].length)
                {
                    if(indexes[i][j] == 0)
                        trace(indexes[i][j]);
                        //tiles.push(null);
                    else
                        {
                        tiles.push(createTiles(indexes[i][j],i,j));  //загружаем кирпичи
                        if(indexes[i][j] == 1)
                            indestrucTiles++;
                        }
                    j++;
                }
                j=0;
                i++;
            }
      //  trace(tiles);
        addToGame(game);
        trace(indestrucTiles);


    }

    public function createTiles(index:Int, i:Int, j:Int):Tile
    {
        var tile = new Tile(index);
        switch (index)
            {
                case 1: 
                tile.createTile(0xCCCCCC, widthTile,heightTile);
                tile.x = (j)*widthTile +  widthTile/2;
                tile.y = (i)* heightTile +  heightTile/2;
                
                case 2: 
                    tile.createTile(0xFF0000, widthTile,heightTile);
                    tile.x = (j)*widthTile +  widthTile/2;
                    tile.y = (i)* heightTile +  heightTile/2;
                case 3: 
                    tile.createTile(0x00FF00, widthTile,heightTile);
                tile.x = (j)*widthTile +  widthTile/2;
                tile.y = (i)* heightTile +  heightTile/2;
                case 4: 
                    tile.createTile(0x0000FF, widthTile,heightTile);
                tile.x = (j)*widthTile +  widthTile/2;
                tile.y = (i)* heightTile +  heightTile/2;
                case 5: 
                    tile.createTile(0x00FFFF, widthTile,heightTile);
                tile.x = (j)*widthTile +  widthTile/2;
                tile.y = (i)* heightTile +  heightTile/2;

            }
            return tile;
    }

   /* public function drawTile(tile:Sprite,color:Int) 
    {
        tile.graphics.beginFill(color);
                tile.graphics.drawRect(2.5-widthTile/2,2.5-heightTile/2,widthTile-5, heightTile-5);
                tile.graphics.endFill();
    }*/
    public function addToGame(game:Game)
    {
        game.addChild(backGround);
        for(i in tiles)
            if( i != null)
            game.addChild(i);
    }

    public function removeFromGame(game:Game)
    {
        game.removeChild(backGround);    
        for(i in tiles)
            if( i != null)
                game.removeChild(i);
    }
    public function isCompleted():Bool
    {
      return (indestrucTiles == tiles.length)? true : false; 
    }
    public function get_indestrucTiles() :Int
    {
        return indestrucTiles;    
    }
}