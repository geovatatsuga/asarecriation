package com.sunweb.game.rpg.rideEquip
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   
   public class RideEquipPartType
   {
      
      public static const obf_l_8_2275:int = 1;
      
      public static const obf_K_Q_3300:int = 2;
      
      public static const obf_Z_m_880:int = 3;
      
      public static const obf_6_4676:int = 4;
      
      public function RideEquipPartType()
      {
         super();
      }
      
      public static function getPartType(param1:String) : int
      {
         if(param1 == "part1")
         {
            return obf_l_8_2275;
         }
         if(param1 == "part2")
         {
            return obf_K_Q_3300;
         }
         if(param1 == "part3")
         {
            return obf_Z_m_880;
         }
         if(param1 == "part4")
         {
            return obf_6_4676;
         }
         return -1;
      }
      
      public static function getPartName(param1:int) : String
      {
         if(param1 == obf_l_8_2275)
         {
            return DiversityManager.getString("RideBoxUI","head");
         }
         if(param1 == obf_K_Q_3300)
         {
            return DiversityManager.getString("RideBoxUI","bosom");
         }
         if(param1 == obf_Z_m_880)
         {
            return DiversityManager.getString("RideBoxUI","leg");
         }
         if(param1 == obf_6_4676)
         {
            return DiversityManager.getString("RideBoxUI","shoes");
         }
         return "";
      }
   }
}

