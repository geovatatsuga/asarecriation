package com.sunweb.game.rpg.misc
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.worldZone.command.misc.CommandCodeMisc;
   import com.sunweb.game.rpg.worldZone.command.misc.UseGiftCdkeyAnswer;
   import com.sunweb.game.rpg.worldZone.command.misc.UseGiftCdkeyRequest;
   import com.sunweb.game.utils.obf_L_l_4100;
   
   public class obf_0_5_9_486
   {
      
      public function obf_0_5_9_486()
      {
         super();
      }
      
      public static function confirmUseGiftCDKEY(param1:Object) : void
      {
         var _loc2_:UseGiftCdkeyRequest = null;
         if(!obf_L_l_4100.isEmpty(param1.content))
         {
            _loc2_ = new UseGiftCdkeyRequest();
            _loc2_.cdkey = param1.content;
            GameContext.worldClient.sendCommand(_loc2_);
         }
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeMisc.USE_GIFT_CDKEY_ANSWER)
         {
            obf_0_6_f_59(param1 as UseGiftCdkeyAnswer);
         }
      }
      
      private static function obf_0_6_f_59(param1:UseGiftCdkeyAnswer) : void
      {
         var _loc2_:Object = {
            "1":DiversityManager.getString("MiscPrompt","useDone"),
            "0":DiversityManager.getString("MiscPrompt","error_wasUsed"),
            "-1":DiversityManager.getString("MiscPrompt","error_participated"),
            "-2":DiversityManager.getString("MiscPrompt","error_badKey"),
            "-3":DiversityManager.getString("MiscPrompt","error_unavailable"),
            "-4":DiversityManager.getString("ServerPrompt","unkown_error"),
            "-5":DiversityManager.getString("ServerPrompt","unkown_error")
         };
         obf_6_D_3816.print(_loc2_[param1.resultCode]);
      }
   }
}

