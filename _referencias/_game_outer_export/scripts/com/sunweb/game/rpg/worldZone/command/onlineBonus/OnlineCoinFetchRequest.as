package com.sunweb.game.rpg.worldZone.command.onlineBonus
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class OnlineCoinFetchRequest extends obf_O_8_1034
   {
      
      public function OnlineCoinFetchRequest()
      {
         super(CommandCodeOnlineBonus.ONLINE_COIN_FETCH_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

