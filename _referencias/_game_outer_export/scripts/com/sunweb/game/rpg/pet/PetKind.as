package com.sunweb.game.rpg.pet
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   
   public class PetKind
   {
      
      public static const PHYSICAL_ATTACK:int = 0;
      
      public static const MAGIC_ATTACK:int = 1;
      
      public static const obf_Z_1_3152:int = 2;
      
      public static const obf_v_T_2058:int = 3;
      
      public static const ASSISTANT:int = 4;
      
      public static const obf_7_y_2321:int = 5;
      
      public function PetKind()
      {
         super();
      }
      
      public static function getKindName(param1:int) : String
      {
         return DiversityManager.getString("PetKind",param1 + "");
      }
   }
}

