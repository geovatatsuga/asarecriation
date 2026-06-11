package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.misc.CommandCodeMisc;
   import com.sunweb.game.rpg.worldZone.command.pis.CommandCodePIS;
   
   public class MiscEvent
   {
      
      public static const USE_GIFT_CDKEY_ANSWER:String = CommandCodeMisc.USE_GIFT_CDKEY_ANSWER.toString(16);
      
      public static const PIS_CHECK_NOTIFY:String = CommandCodePIS.PIS_CHECK_NOTIFY.toString(16);
      
      public function MiscEvent()
      {
         super();
      }
   }
}

