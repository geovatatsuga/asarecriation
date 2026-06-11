package com.sunweb.game.rpg.playerUI.playerInfo
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   
   public class obf_W_l_2992
   {
      
      public static const obf_C_X_4367:int = 1;
      
      public static const obf_0_3_N_708:int = 2;
      
      public static const obf_i_q_2098:int = 3;
      
      public function obf_W_l_2992()
      {
         super();
      }
      
      public static function getSoulName(param1:int) : String
      {
         return DiversityManager.getString("MindBox",param1 + "");
      }
   }
}

