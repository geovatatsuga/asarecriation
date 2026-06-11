package com.sunweb.game.rpg.worldZone.command.onlineBonus
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class OfflineBonusCheckNotify extends obf_O_8_1034
   {
      
      public var offlineHours:int;
      
      public var exp:int;
      
      public function OfflineBonusCheckNotify()
      {
         super(CommandCodeOnlineBonus.OFFLINE_BONUS_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["offlineHours:short","exp:int"];
      }
   }
}

