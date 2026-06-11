package com.sunweb.game.rpg.worldZone.command.lottery
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFetchOnlineAwardRequest extends obf_O_8_1034
   {
      
      public function PlayerFetchOnlineAwardRequest()
      {
         super(CommandCodeLottery.PLAYER_FETCH_ONLINEAWARD_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

