package com.sunweb.game.rpg.worldZone.command.onlineBonus
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class OnlineBonusFetchRequest extends obf_O_8_1034
   {
      
      public function OnlineBonusFetchRequest()
      {
         super(CommandCodeOnlineBonus.ONLINE_BONUS_FETCH_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

