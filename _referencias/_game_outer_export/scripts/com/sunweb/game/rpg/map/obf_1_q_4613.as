package com.sunweb.game.rpg.map
{
   import obf_k_F_2870.MapPhysics;
   import obf_k_F_2870.obf_1_4637;
   import com.sunweb.game.rpg.map.pathfind.astar.AcorrsLineGrid;
   import com.sunweb.game.rpg.map.pathfind.astar.Grid;
   import com.sunweb.game.rpg.map.pathfind.astar.obf_1_Q_4434;
   import com.sunweb.game.rpg.map.pathfind.astar.obf_E_U_3120;
   import com.sunweb.game.rpg.map.pathfind.tileAstar.obf_V_P_953;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class obf_1_q_4613
   {
      
      private static var point00:Point = new Point(0,0);
      
      private static const pathfindMode:int = 0;
      
      private static var _p0_map:Map = null;
      
      private static var _p0_grid:Grid = null;
      
      private static var obf_N_q_1067:AcorrsLineGrid = null;
      
      public function obf_1_q_4613()
      {
         super();
      }
      
      public static function obf_Y_u_3116(param1:MapObject, param2:MapObject) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Point = null;
         var _loc8_:Object = null;
         var _loc9_:Object = null;
         var _loc10_:MapObject = null;
         var _loc11_:MapObject = null;
         var _loc12_:Point = null;
         var _loc13_:Object = null;
         var _loc14_:Point = null;
         if(param1 == null || param2 == null)
         {
            return false;
         }
         if(param1.zLevel != param2.zLevel)
         {
            return param1.zLevel > param2.zLevel;
         }
         if(param1.rootArea == null && param2.rootArea == null)
         {
            if(param1.rootY == param2.rootY)
            {
               if(!param1.rootPXYAvailable && !param2.rootPXYAvailable)
               {
                  return param1.rootX > param2.rootX;
               }
               if(param1.rootPXYAvailable)
               {
                  _loc3_ = param1.rootPX;
                  _loc4_ = param1.rootPY;
               }
               else
               {
                  _loc7_ = obf_1_q_4613.obf_0_3_l_190(new Point(param1.rootX,param1.rootY));
                  _loc3_ = _loc7_.x;
                  _loc4_ = _loc7_.y;
               }
               if(param2.rootPXYAvailable)
               {
                  _loc5_ = param2.rootPX;
                  _loc6_ = param2.rootPY;
               }
               else
               {
                  _loc7_ = obf_1_q_4613.obf_0_3_l_190(new Point(param2.rootX,param2.rootY));
                  _loc5_ = _loc7_.x;
                  _loc6_ = _loc7_.y;
               }
               if(_loc4_ == _loc6_)
               {
                  return _loc3_ > _loc5_;
               }
               return _loc4_ > _loc6_;
            }
            return param1.rootY > param2.rootY;
         }
         if(param1.rootArea != null && param2.rootArea != null)
         {
            _loc8_ = param1.rootArea[0];
            _loc9_ = param2.rootArea[0];
            if(_loc8_.y == _loc9_.y)
            {
               return _loc8_.x > _loc9_.x;
            }
            return _loc8_.y > _loc9_.y;
         }
         _loc10_ = param1.rootArea == null ? param1 : param2;
         _loc11_ = param1.rootArea == null ? param2 : param1;
         _loc12_ = new Point(_loc10_.rootX,_loc10_.rootY);
         _loc13_ = obf_w_7_2191(_loc11_.rootArea,_loc12_);
         if(_loc13_ != null)
         {
            return _loc10_ == param1 ? _loc12_.y > _loc13_.y : _loc12_.y <= _loc13_.y;
         }
         _loc13_ = obf_v_D_4584(_loc11_.rootArea,_loc12_);
         if(_loc13_ != null)
         {
            _loc14_ = new Point(_loc13_.x + (_loc12_.x > _loc13_.x ? 1 : -1),_loc13_.y);
            _loc13_ = obf_w_7_2191(_loc11_.rootArea,_loc14_);
            if(_loc13_ != null)
            {
               return _loc10_ == param1 ? _loc14_.y > _loc13_.y : _loc14_.y <= _loc13_.y;
            }
            _loc13_ = _loc11_.rootArea[0];
            return _loc10_ == param1 ? _loc12_.x > _loc13_.x : _loc12_.x <= _loc13_.x;
         }
         _loc13_ = _loc11_.rootArea[0];
         return _loc10_ == param1 ? _loc12_.y > _loc13_.y : _loc12_.y <= _loc13_.y;
      }
      
      private static function obf_w_7_2191(param1:Array, param2:Point) : Object
      {
         var _loc3_:Object = null;
         for each(_loc3_ in param1)
         {
            if(_loc3_.x == param2.x)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private static function obf_v_D_4584(param1:Array, param2:Point) : Object
      {
         var _loc3_:Object = null;
         for each(_loc3_ in param1)
         {
            if(_loc3_.y == param2.y)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public static function showEffect(param1:DisplayObject, param2:Array) : void
      {
         if(param2 == null || param2.length == 0)
         {
            return;
         }
         if(param2.indexOf("hf") > -1)
         {
            param1.scaleX = -param1.scaleX;
         }
         if(param2.indexOf("vf") > -1)
         {
            param1.scaleY = -param1.scaleY;
         }
      }
      
      public static function complexHitTestObject(param1:DisplayObject, param2:DisplayObject, param3:int = 1, param4:int = 1, param5:Number = 1) : Boolean
      {
         var _loc6_:Rectangle = obf_8_F_3053(param1,param2,param5);
         return _loc6_.width >= param3 && _loc6_.height >= param4;
      }
      
      public static function intersectionRectangle(param1:DisplayObject, param2:DisplayObject) : Rectangle
      {
         if(!param1.root || !param2.root || !param1.hitTestObject(param2))
         {
            return new Rectangle();
         }
         var _loc3_:Rectangle = param1.getBounds(param1.root);
         var _loc4_:Rectangle = param2.getBounds(param2.root);
         var _loc5_:Rectangle = new Rectangle();
         _loc5_.x = Math.max(_loc3_.x,_loc4_.x);
         _loc5_.y = Math.max(_loc3_.y,_loc4_.y);
         _loc5_.width = Math.min(_loc3_.x + _loc3_.width - _loc5_.x,_loc4_.x + _loc4_.width - _loc5_.x);
         _loc5_.height = Math.min(_loc3_.y + _loc3_.height - _loc5_.y,_loc4_.y + _loc4_.height - _loc5_.y);
         return _loc5_;
      }
      
      public static function obf_8_F_3053(param1:DisplayObject, param2:DisplayObject, param3:Number = 1) : Rectangle
      {
         if(param3 <= 0)
         {
            throw new Error("ArgumentError: Error #5001: Invalid value for accurracy",5001);
         }
         if(!param1.hitTestObject(param2))
         {
            return new Rectangle();
         }
         var _loc4_:Rectangle = intersectionRectangle(param1,param2);
         if(_loc4_.width * param3 < 1 || _loc4_.height * param3 < 1)
         {
            return new Rectangle();
         }
         var _loc5_:BitmapData = new BitmapData(_loc4_.width * param3,_loc4_.height * param3,false,0);
         _loc5_.draw(param1,getDrawMatrix(param1,_loc4_,param3),new ColorTransform(1,1,1,1,255,-255,-255,255));
         _loc5_.draw(param2,getDrawMatrix(param2,_loc4_,param3),new ColorTransform(1,1,1,1,255,255,255,255),BlendMode.DIFFERENCE);
         var _loc6_:Rectangle = _loc5_.getColorBoundsRect(4294967295,4278255615);
         _loc5_.dispose();
         if(param3 != 1)
         {
            _loc6_.x /= param3;
            _loc6_.y /= param3;
            _loc6_.width /= param3;
            _loc6_.height /= param3;
         }
         _loc6_.x += _loc4_.x;
         _loc6_.y += _loc4_.y;
         return _loc6_;
      }
      
      protected static function getDrawMatrix(param1:DisplayObject, param2:Rectangle, param3:Number) : Matrix
      {
         var _loc4_:Point = null;
         var _loc5_:Matrix = null;
         var _loc6_:Matrix = param1.root.transform.concatenatedMatrix;
         _loc4_ = param1.localToGlobal(new Point());
         _loc5_ = param1.transform.concatenatedMatrix;
         _loc5_.tx = _loc4_.x - param2.x;
         _loc5_.ty = _loc4_.y - param2.y;
         _loc5_.a /= _loc6_.a;
         _loc5_.d /= _loc6_.d;
         if(param3 != 1)
         {
            _loc5_.scale(param3,param3);
         }
         return _loc5_;
      }
      
      public static function hitTestXYSelf(param1:DisplayObject, param2:int, param3:int) : Boolean
      {
         if(param1 == null || param1.width == 0 && param1.height == 0)
         {
            return false;
         }
         var _loc4_:BitmapData = new BitmapData(1,1,true,0);
         _loc4_.draw(param1,new Matrix(1,0,0,1,-param2,-param3));
         var _loc5_:Boolean = _loc4_.hitTest(point00,51,point00);
         _loc4_.dispose();
         return _loc5_;
      }
      
      public static function hitTestPoint(param1:DisplayObject, param2:Point) : Boolean
      {
         if(param1.stage == null)
         {
            return false;
         }
         var _loc3_:Rectangle = param1.getRect(param1.stage);
         if(!_loc3_.containsPoint(param2))
         {
            return false;
         }
         var _loc4_:Point = param1.globalToLocal(param2);
         return hitTestXYSelf(param1,_loc4_.x,_loc4_.y);
      }
      
      public static function pathfindAuto(param1:Map, param2:Point, param3:Point) : Array
      {
         if(!param1.isBlocked(param2.x,param2.y,param3.x,param3.y))
         {
            return [param2.clone(),param3.clone()];
         }
         if(pathfindMode == 0)
         {
            return pathfind0(param1,param2,param3);
         }
         if(pathfindMode == 1)
         {
            return pathfind1(param1,param2,param3);
         }
         if(pathfindMode == 2)
         {
            return pathfind2(param1,param2,param3);
         }
         return null;
      }
      
      public static function pathfindReset() : void
      {
         if(pathfindMode == 0)
         {
            _p0_map = null;
            _p0_grid = null;
            obf_N_q_1067 = null;
         }
         else if(pathfindMode == 1)
         {
            obf_1_4637.reset();
         }
         else if(pathfindMode == 2)
         {
         }
      }
      
      public static function refinePath(param1:Map, param2:Array) : Array
      {
         var _loc8_:* = 0;
         var _loc9_:Point = null;
         var _loc10_:Boolean = false;
         var _loc3_:uint = param2.length;
         if(_loc3_ < 3)
         {
            return param2;
         }
         var _loc4_:Array = [];
         var _loc5_:Point = param2[0] as Point;
         var _loc6_:Point = param2[_loc3_ - 1] as Point;
         var _loc7_:uint = 0;
         _loc4_.push(_loc5_);
         while(_loc5_ != _loc6_)
         {
            _loc8_ = int(_loc3_ - 1);
            while(_loc8_ > _loc7_)
            {
               _loc9_ = param2[_loc8_] as Point;
               _loc10_ = Boolean(_loc8_ - _loc7_ == 1);
               if((_loc10_) || !param1.isBlocked(_loc5_.x,_loc5_.y,_loc9_.x,_loc9_.y))
               {
                  _loc5_ = _loc9_;
                  _loc7_ = _loc8_;
                  _loc4_.push(_loc9_);
                  break;
               }
               _loc8_--;
            }
         }
         return _loc4_;
      }
      
      private static function pathfind0(param1:Map, param2:Point, param3:Point) : Array
      {
         var path:Array = null;
         var pixelPath:Array = null;
         var pt:Point = null;
         var node:obf_E_U_3120 = null;
         var finalPath:Array = null;
         var t:int = 0;
         var nodes:Array = null;
         var x:int = 0;
         var y:int = 0;
         var map:Map = param1;
         var fromPt:Point = param2;
         var toPt:Point = param3;
         try
         {
            if(map != _p0_map || map.pathfindingMatrixChanged)
            {
               t = getTimer();
               _p0_grid = new Grid(map.mapWidthInPixel,map.mapHeightInPixel,map.mapWidth,map.mapHeight);
               _p0_grid.updata();
               obf_N_q_1067 = new AcorrsLineGrid(_p0_grid);
               obf_x_0_1295.obf_r_w_3556(">>>> init grid:" + (getTimer() - t));
               t = getTimer();
               nodes = _p0_grid.nodes;
               x = 0;
               while(x < map.mapWidth)
               {
                  y = 0;
                  while(y < map.mapHeight)
                  {
                     if(!map.obf_0_3_m_391(x,y))
                     {
                        obf_E_U_3120(nodes[y][x]).walkAble = false;
                     }
                     y++;
                  }
                  x++;
               }
               obf_x_0_1295.obf_r_w_3556(">>>> set walkable:" + (getTimer() - t));
               _p0_map = map;
               map.pathfindingMatrixChanged = false;
            }
            _p0_grid.startNode = _p0_grid.getNodeByXY(fromPt.x,fromPt.y) as obf_E_U_3120;
            _p0_grid.endNode = _p0_grid.getNodeByXY(toPt.x,toPt.y) as obf_E_U_3120;
            t = getTimer();
            _p0_grid.nodesRest();
            obf_1_Q_4434.obf_W_1_2845 = true;
            path = obf_1_Q_4434.obf_N_w_2712(_p0_grid);
            obf_x_0_1295.obf_r_w_3556(">>>> find path:" + (getTimer() - t));
            if(path == null || path.length == 0)
            {
               return null;
            }
            pixelPath = [];
            pt = new Point();
            for each(node in path)
            {
               pt.x = node.x;
               pt.y = node.y;
               pixelPath.push(obf_0_3_l_190(pt));
            }
            pixelPath[0] = fromPt;
            pixelPath[pixelPath.length - 1] = toPt;
            t = getTimer();
            finalPath = null;
            try
            {
               finalPath = refinePath(map,pixelPath);
            }
            catch(e:Error)
            {
            }
            obf_x_0_1295.obf_r_w_3556(">>>> refine path:" + (getTimer() - t));
            return finalPath == null ? pixelPath : finalPath;
         }
         catch(e:Error)
         {
         }
         return null;
      }
      
      private static function pathfind1(param1:Map, param2:Point, param3:Point) : Array
      {
         var path:Array = null;
         var map:Map = param1;
         var fromPt:Point = param2;
         var toPt:Point = param3;
         try
         {
            if(Point.distance(fromPt,toPt) < 100)
            {
               obf_1_4637.obf_0_7_F_183 = 6;
               obf_1_4637.getDis = 6;
               obf_1_4637.poiDis = 6;
               obf_1_4637.timeout = 100;
            }
            else
            {
               obf_1_4637.obf_0_7_F_183 = 16;
               obf_1_4637.getDis = 16;
               obf_1_4637.poiDis = 16;
               obf_1_4637.timeout = 500;
            }
            path = obf_1_4637.startFind(fromPt,toPt,new MapPhysics(map));
            return path;
         }
         catch(e:Error)
         {
         }
         return null;
      }
      
      private static function pathfind2(param1:Map, param2:Point, param3:Point) : Array
      {
         var _loc8_:Point = null;
         var _loc9_:Point = null;
         var _loc4_:Point = obf_0_7_i_369(param2);
         var _loc5_:Point = obf_0_7_i_369(param3);
         var _loc6_:obf_V_P_953 = new obf_V_P_953(param1);
         var _loc7_:Array = _loc6_.obf_u_g_1166(param2.x,param2.y,param3.x,param3.y);
         for each(_loc8_ in _loc7_)
         {
            _loc9_ = obf_0_3_l_190(_loc8_);
            _loc8_.x = _loc9_.x;
            _loc8_.y = _loc9_.y;
         }
         obf_x_0_1295.obf_r_w_3556("org:" + _loc7_.length);
         return _loc7_;
      }
      
      public static function obf_0_7_i_369(param1:Point) : Point
      {
         var _loc2_:Point = new Point();
         _loc2_.x = param1.x >> Map.obf_Z_7_3230;
         _loc2_.y = param1.y >> Map.obf_d_1_1185;
         return _loc2_;
      }
      
      public static function obf_0_3_l_190(param1:Point, param2:Point = null) : Point
      {
         if(param2 == null)
         {
            param2 = new Point(Map.obf_7_7_3297 / 2,Map.TILE_HEIGHT_IN_PIXEL / 2);
         }
         var _loc3_:Point = new Point();
         _loc3_.x = (param1.x << Map.obf_Z_7_3230) + param2.x;
         _loc3_.y = (param1.y << Map.obf_d_1_1185) + param2.y;
         return _loc3_;
      }
      
      public static function makePointKey(param1:int, param2:int) : String
      {
         return param1.toString(36) + "," + param2.toString(36);
      }
      
      public static function getManhattanDistance(param1:int, param2:int, param3:int, param4:int) : int
      {
         return Math.abs(param1 - param3) + Math.abs(param2 - param4);
      }
      
      public static function getLineDistance(param1:int, param2:int, param3:int, param4:int) : int
      {
         return Point.distance(new Point(param1,param2),new Point(param3,param4));
      }
      
      public static function drawTiles(param1:Sprite, param2:Array, param3:int, param4:Number = 1, param5:int = 0, param6:int = 0, param7:int = 0, param8:int = 0, param9:int = 0) : void
      {
         var _loc10_:Object = null;
         if(param1 == null || param2 == null || param2.length == 0)
         {
            return;
         }
         if(param8 <= 0)
         {
            param8 = Map.obf_7_7_3297;
         }
         if(param9 <= 0)
         {
            param9 = Map.TILE_HEIGHT_IN_PIXEL;
         }
         param1.graphics.beginFill(param3,param4);
         for each(_loc10_ in param2)
         {
            param1.graphics.drawRect(_loc10_.x * param8 - param6,_loc10_.y * param9 - param7,param8 - param5,param9 - param5);
         }
         param1.graphics.endFill();
      }
   }
}

