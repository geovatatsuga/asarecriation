package com.sunweb.game.rpg.map
{
   import flash.geom.Rectangle;
   
   public class obf_S_R_4599 extends Rectangle
   {
      
      public var obf_h_Y_4498:String;
      
      public function obf_S_R_4599(param1:Object)
      {
         super();
         this.obf_h_Y_4498 = param1.id;
         var _loc2_:Array = (param1.rect as String).split(",");
         this.x = int(_loc2_[0]) * Map.obf_7_7_3297;
         this.y = int(_loc2_[1]) * Map.TILE_HEIGHT_IN_PIXEL;
         this.width = int(_loc2_[2]) * Map.obf_7_7_3297;
         this.height = int(_loc2_[3]) * Map.TILE_HEIGHT_IN_PIXEL;
      }
   }
}

