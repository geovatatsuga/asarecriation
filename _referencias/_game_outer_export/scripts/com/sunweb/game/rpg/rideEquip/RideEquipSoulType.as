package com.sunweb.game.rpg.rideEquip
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   
   public class RideEquipSoulType
   {
      
      public static const obf_j_T_2675:int = 1;
      
      public static const obf_l_0_3791:int = 2;
      
      public static const obf_o_6_1202:int = 3;
      
      public static const obf_j_p_963:int = 4;
      
      public static const obf_A_q_1072:int = 5;
      
      public function RideEquipSoulType()
      {
         super();
      }
      
      public static function getSoulName(param1:int) : String
      {
         if(param1 == obf_j_T_2675)
         {
            return DiversityManager.getString("RideBoxUI","earth");
         }
         if(param1 == obf_l_0_3791)
         {
            return DiversityManager.getString("RideBoxUI","fire");
         }
         if(param1 == obf_o_6_1202)
         {
            return DiversityManager.getString("RideBoxUI","wind");
         }
         if(param1 == obf_j_p_963)
         {
            return DiversityManager.getString("RideBoxUI","water");
         }
         if(param1 == obf_A_q_1072)
         {
            return DiversityManager.getString("RideBoxUI","mine");
         }
         return "";
      }
   }
}

