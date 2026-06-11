package com.sunweb.game.rpg.world.map
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   import flash.geom.Point;
   
   public class MapPoint extends obf_2_M_853
   {
      
      public var x:int;
      
      public var y:int;
      
      public function MapPoint(param1:int = 0, param2:int = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
      }
      
      public static function MapPointToPoint(param1:MapPoint) : Point
      {
         return new Point(param1.x,param1.y);
      }
      
      public static function PointToMapPoint(param1:Point) : MapPoint
      {
         if(!param1)
         {
            return null;
         }
         return new MapPoint(param1.x,param1.y);
      }
      
      public static function MapArrayToPoint(param1:Array) : Array
      {
         var _loc3_:MapPoint = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in param1)
         {
            _loc2_.push(MapPointToPoint(_loc3_));
         }
         return _loc2_;
      }
      
      public static function PointArrayToMap(param1:Array) : Array
      {
         var _loc3_:Point = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in param1)
         {
            _loc2_.push(PointToMapPoint(_loc3_));
         }
         return _loc2_;
      }
      
      override public function getFieldList() : Array
      {
         return ["x:short","y:short"];
      }
   }
}

