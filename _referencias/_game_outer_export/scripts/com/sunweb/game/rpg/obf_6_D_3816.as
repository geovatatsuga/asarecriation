package com.sunweb.game.rpg
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_0_3_0_538;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   
   public class obf_6_D_3816
   {
      
      public function obf_6_D_3816()
      {
         super();
      }
      
      public static function print(param1:String) : void
      {
         obf_K_e_3075.obf_e_H_1407.receiveMsg("<font color=\'#" + obf_0_3_0_538.obf_R_9_4372.toString(16) + "\'>" + param1 + "</font>",DiversityManager.getString("CommonPrompt","system"));
      }
      
      public static function obf_0_5_O_723(param1:String) : void
      {
         trace(param1);
      }
      
      public static function obf_A_3_3662(param1:String) : void
      {
         obf_K_e_3075.showTipInfo(param1);
      }
   }
}

