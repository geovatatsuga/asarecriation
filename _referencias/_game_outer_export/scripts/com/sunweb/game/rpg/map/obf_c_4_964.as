package com.sunweb.game.rpg.map
{
   import flash.geom.Point;
   
   public interface obf_c_4_964
   {
      
      function onObjectInSight(param1:MapInteractiveObject) : void;
      
      function onObjectOutSight(param1:MapInteractiveObject) : void;
      
      function onPlayerReachExit(param1:obf_6_H_3213) : void;
      
      function onMouseTracking(param1:MapInteractiveObject, param2:Point) : void;
   }
}

