package com.sunweb.game.rpg.gameItem
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   
   public class GameItemType
   {
      
      public static const ALL:int = 16777215;
      
      public static const EXPENDABLE:int = 1;
      
      public static const COLLECTION:int = 2;
      
      public static const EQUIPMENT:int = 4;
      
      public static const PET:int = 8;
      
      public static const RIDE:int = 16;
      
      public static const obf_N_v_4048:int = 32;
      
      public static const obf_y_n_2092:int = 128;
      
      public static const SKILL:int = 1048576;
      
      public static const MOTION:int = 2097152;
      
      public function GameItemType()
      {
         super();
      }
      
      public static function getTypeName(param1:int) : String
      {
         var _loc2_:Object = {
            (ALL + ""):DiversityManager.getString("ItemTypeName","all"),
            (EXPENDABLE + ""):DiversityManager.getString("ItemTypeName","expendable"),
            (COLLECTION + ""):DiversityManager.getString("ItemTypeName","collection"),
            (EQUIPMENT + ""):DiversityManager.getString("ItemTypeName","equipment"),
            (PET + ""):DiversityManager.getString("ItemTypeName","pet"),
            (RIDE + ""):DiversityManager.getString("ItemTypeName","ride"),
            (obf_N_v_4048 + ""):DiversityManager.getString("ItemTypeName","genie"),
            (obf_y_n_2092 + ""):DiversityManager.getString("ItemTypeName","devil")
         };
         return _loc2_[param1 + ""] || "";
      }
      
      public static function contrastType(param1:int, param2:int) : Boolean
      {
         return (param1 & param2) != 0;
      }
   }
}

