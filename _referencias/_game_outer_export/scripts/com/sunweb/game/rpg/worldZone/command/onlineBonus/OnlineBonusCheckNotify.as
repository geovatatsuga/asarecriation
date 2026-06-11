package com.sunweb.game.rpg.worldZone.command.onlineBonus
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class OnlineBonusCheckNotify extends obf_O_8_1034
   {
      
      public var bonusIndex:int;
      
      public var afterTimeInSec:int;
      
      public function OnlineBonusCheckNotify()
      {
         super(CommandCodeOnlineBonus.ONLINE_BONUS_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["bonusIndex:byte","afterTimeInSec:int"];
      }
   }
}

