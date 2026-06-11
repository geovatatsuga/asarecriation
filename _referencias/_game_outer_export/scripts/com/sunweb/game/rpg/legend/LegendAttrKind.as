package com.sunweb.game.rpg.legend
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   
   public class LegendAttrKind
   {
      
      public static const LOT:int = 1;
      
      public static const LOA:int = 2;
      
      public static const LOH:int = 3;
      
      public function LegendAttrKind()
      {
         super();
      }
      
      public static function getViewKindString(param1:int) : String
      {
         var _loc2_:Object = new Object();
         _loc2_[LOT] = DiversityManager.getString("LegendUI","1");
         _loc2_[LOA] = DiversityManager.getString("LegendUI","2");
         _loc2_[LOH] = DiversityManager.getString("LegendUI","3");
         return _loc2_[param1];
      }
      
      public static function getTypeString(param1:int) : String
      {
         var _loc2_:Object = new Object();
         _loc2_[LOT] = DiversityManager.getString("LegendUI","11");
         _loc2_[LOA] = DiversityManager.getString("LegendUI","22");
         _loc2_[LOH] = DiversityManager.getString("LegendUI","33");
         return _loc2_[param1];
      }
   }
}

