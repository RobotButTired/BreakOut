package;

import openfl.geom.Point;
import haxe.Timer;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.KeyboardEvent;
import openfl.events.Event;




class Game extends Sprite  
{
    var sizeWidth:Int;
    var sizeHeight:Int;  // Размеры игрового поля
    var gameLevel:GameLevel; // экземпляр класса,  содержащий все необходимое для генерации уровня
    var dx:Float = 15.0; // скорость движения ракетки
    var player:Paddle;  // игрок
    var timeFlag:Float; // временной флаг для ограничения частоты кадров
    var ball:Ball;   // шар
    var shiftDistance:Float;  //смещение шар , необходимое для обработки столкновений
    var gameLVL:Int; // уровень
    var collisionParticles:Array<Particle>;  //массив частиц для эффекта столкновения
    var ballParticles:Array<Particle>; // массив частиц за шаром
    var spentBallParticles:Array<Particle>;  // массив использованных частиц за шаром
    var spentCollisionParticles:Array<Particle>; // Массив использованных чатиц столкновений

    public function new(width:Int, height:Int)
    {
        super();
        this.sizeWidth = width;
        this.sizeHeight = height;
        gameLVL =1;
        gameLevel = new GameLevel(this, sizeWidth, sizeHeight,gameLVL);
        player = new Paddle(sizeWidth,sizeHeight);
        timeFlag = Timer.stamp();
      
        addChild(player);

        ball = new Ball(sizeWidth, sizeHeight);
       ball.reset(player);
        addChild(ball);

        collisionParticles = [];
        ballParticles = [];
        spentBallParticles = [];
        spentCollisionParticles = [];

        Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onDown);
        Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onUp);
        

        this.addEventListener(Event.ENTER_FRAME, update);
    }

    public function update(e:Event)
    {
        if(Timer.stamp()-timeFlag >= 1.0/60.0)
            {
                trace(spentCollisionParticles.length+"  "+collisionParticles.length);
                if(gameLVL <= 4)
                    {
                        if(gameLevel.isCompleted())
                            {
                                this.gameLVL++;
                                gameReset();
                            }
                        if(ball.get_isFall())
                            {
                            gameReset();
                            }
                        player.move(15.0);
                        ball.move(player);
                        backGroundMove();
                        checkCollisions();
                        for(i in 0...5)
                            {
                                if(spentBallParticles.length > 0)
                                    {
                                        //trace("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                                    addBallParticle(resetParticle(spentBallParticles.pop(), "ball"),(Math.random()-0.5)*ball.get_radius()+ball.x, (Math.random()-0.5)*ball.get_radius()+ball.y);
                                    }
                                else
                                    addBallParticle(new Particle("particle"),(Math.random()-0.5)*ball.get_radius()+ball.x, (Math.random()-0.5)*ball.get_radius()+ball.y);
                            }
                        if(ballParticles.length>0)
                            {
                                var p = 0;
                                while(p < ballParticles.length)
                                    {
                                        ballParticles[p].update();
                                        if(ballParticles[p].TTL < 0)
                                            {
                                                removeChild(ballParticles[p]);
                                                spentBallParticles.push(ballParticles[p]);
                                                ballParticles.remove(ballParticles[p]);
                                            }
                                        else
                                            p++;
                                    }
                            }
                        if(collisionParticles.length>0)
                            {
                                var p =0;
                                while(p<collisionParticles.length)
                                    {
                                        collisionParticles[p].update();
                                        if(collisionParticles[p].TTL < 0)
                                            {
                                                removeChild(collisionParticles[p]);
                                                spentCollisionParticles.push(collisionParticles[p]);
                                                collisionParticles.remove(collisionParticles[p]);
                                            }
                                        else 
                                            p++;
                                    }
                            }

                        timeFlag = Timer.stamp();
                    }
            }
    }

    public function onDown(e:KeyboardEvent)
    {
        if(e.keyCode == 37)
            player.set_isLeft(true);
        if(e.keyCode == 39)
            player.set_isRight(true);
        if(e.keyCode == 38 && ball.get_stuck())
            {
                ball.set_stuck(false);
                ball.set_speed(8.0);
                
            }
    }
    public function onUp(e:KeyboardEvent)
        {
            if(e.keyCode == 37)
                player.set_isLeft(false);
            if(e.keyCode == 39)
                player.set_isRight(false);
        }
   

    public function gameReset()
    {
        gameLevel.removeFromGame(this);
        gameLevel = new GameLevel(this, sizeWidth, sizeHeight,gameLVL);
        gameLevel.addToGame(this);
        this.addChild(player);
        this.addChild(ball);
        player.reset();
        ball.reset(player);
    }

    public function checkCollisions():Bool
    {
        var i=0;
        var isCollision = false;
        while(i < gameLevel.tiles.length)
            {
                if(checkCollision(gameLevel.tiles[i]))
                    isCollision =  true;
                i++;
            }
            return isCollision;
    }

    public function checkCollision(tile:Tile):Bool
    {
        var center = new Point(ball.x, ball.y);      // Сначала вычисляем точку центра окружности 

        var aabb_half_extands = new Point(tile.width/2, tile.height/2);
        var aabb_center = new Point(tile.x, tile.y);      // Вычисляем информацию по AABB (координаты центра, и половинки длин сторон)

        var difference = new Point(center.x - aabb_center.x, center.y - aabb_center.y);     // Получаем вектор разности между центром окружности и центром AABB
        var clamped = new Point(clamp(difference.x, -aabb_half_extands.x, aabb_half_extands.x),clamp(difference.y, -aabb_half_extands.y, aabb_half_extands.y));
            // Добавляя переменную clamped к AABB_center, мы получим ближайшую к окружности точку, лежащую на стороне AABB
        var closest = new Point(aabb_center.x + clamped.x, aabb_center.y + clamped.y);
       // closestPointOfCollision = closest;
            // Получаем вектор между центром окружности и ближайшей к ней точкой AABB, и проверяем, чтобы длина этого вектора была меньше радиуса окружности
        difference = new Point(closest.x - center.x, closest.y - center.y);
        var zero = new Point(0,0);

        var dist =Math.abs(Point.distance(difference, zero));
        shiftDistance = dist;
        //trace(dist +" "+ball.get_radius());
        if(dist < ball.get_radius())
            {
                doCollision(tile);
                if(tile.get_isDestructible())
                    {
                       this.removeChild(tile);
                        gameLevel.tiles.remove(tile);
                        for(i in 0...40)
                            {
                                if(spentCollisionParticles.length > 0)
                                    addCollisionParticle(resetParticle(spentCollisionParticles.pop(), "collision"),closest.x, closest.y);
                                else
                                    addCollisionParticle(new Particle("particle2"),closest.x, closest.y);
                            }
                        trace(gameLevel.get_indestrucTiles()+" "+gameLevel.tiles.length);
                    }
                return true;
            }
        else return false;
    }

    public function doCollision(tile:Tile)
    {
        if(vectorDirection(tile).x == 0.0 && vectorDirection(tile).y == 1.0)  //обработка смещения и отражения шара вверх
            {
                ball.y -= ball.get_radius()-shiftDistance;
                ball.set_dy(-ball.get_dy());
            }
        if(vectorDirection(tile).x == 0.0 && vectorDirection(tile).y == -1.0)  //обработка смещения и отражения шара вниз
            {
                 ball.y += ball.get_radius()-shiftDistance;
                 ball.set_dy(-ball.get_dy());
            }
        if(vectorDirection(tile).x == 1.0 && vectorDirection(tile).y == 0.0)  //обработка смещения и отражения шара вправо
            {
                 ball.x -= ball.get_radius()-shiftDistance;
                 ball.set_dx(-ball.get_dx());
            }
       if(vectorDirection(tile).x == -1.0 && vectorDirection(tile).y == 0.0)  //обработка смещения и отражения шара влево
            {
                 ball.x += ball.get_radius()-shiftDistance;
                 ball.set_dx(-ball.get_dx());
            }
    }

    public function clamp(value:Float, min:Float, max:Float):Float
    {
        return Math.max(min,Math.min(max,value));
    }

    public function vectorDirection(tile:Tile):Point
    {
        var directions:Array<Point> = [new Point(0.0,1.0), //UP
                                        new Point(1.0,0.0), //RIGHT
                                        new Point(0.0,-1.0), //DOWN
                                        new Point(-1.0,0.0)];//LEFT

        var collisionDirection  = new Point(tile.x - ball.x, tile.y - ball.y);
        var i =0;
        var max=0.0;
        var index = 0;
        for(i in 0...4)
            {
                var cosTheta = collisionDirection.x * directions[i].x + collisionDirection.y * directions[i].y;
                if(max < cosTheta)
                    {
                        max = cosTheta;
                        index = i;
                    }
            }
            return directions[index];                                 
    }
    public function get_gameLVL():Int
    {
        return gameLVL;     
    }

    public function addCollisionParticle( p:Particle, x:Float, y:Float)
        {
            collisionParticles.push(p);
            p.x = x;
            p.y = y;
            addChild(p);
        }

        public function addBallParticle( p:Particle, x:Float, y:Float)
            {
                ballParticles.push(p);
                p.x = x;
                p.y = y;
                addChild(p);
            }
    
    public function resetParticle(p:Particle, name:String):Particle
    {
        if(name == "ball")
             p.TTL = 15;
        if(name == "collision")
            {
                p.TTL = 30;
                var angle = 2.0* Math.random() * Math.PI;
                var speed = 2.0 + 5.0* Math.random();
                p.set_dy(speed * Math.sin(angle));
            }
        p.rotation = Math.random() * 360;
        p.alpha = 1.0;
        return p;
    }
    public function backGroundMove()
    {
        gameLevel.backGround.x = (player.x-sizeWidth/2)* 0.25;
    }

}