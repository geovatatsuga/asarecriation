package com.sunweb.game.rpg.role
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   
   public class obf_0_5_V_226
   {
      
      private static var pkModeName:Object = {
         (PKMode.PEACE_MODE + ""):DiversityManager.getString("PKMode","peace"),
         (PKMode.obf_N_W_2421 + ""):DiversityManager.getString("PKMode","slay"),
         (PKMode.obf_F_J_1081 + ""):DiversityManager.getString("PKMode","justice"),
         (PKMode.obf_9_P_3540 + ""):DiversityManager.getString("PKMode","team"),
         (PKMode.obf_f_U_3730 + ""):DiversityManager.getString("PKMode","family")
      };
      
      public function obf_0_5_V_226()
      {
         super();
      }
      
      public static function getModeName(param1:int) : String
      {
         return pkModeName[param1 + ""] || "";
      }
   }
}

