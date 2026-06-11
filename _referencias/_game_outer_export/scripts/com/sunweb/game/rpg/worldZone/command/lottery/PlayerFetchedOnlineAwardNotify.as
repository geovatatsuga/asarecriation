package com.sunweb.game.rpg.worldZone.command.lottery
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFetchedOnlineAwardNotify extends obf_O_8_1034
   {
      
      public var fetchedItem:String;
      
      public function PlayerFetchedOnlineAwardNotify()
      {
         super(CommandCodeLottery.PLAYER_FETCHED_ONLINEAWARD_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["fetchedItem:string"];
      }
   }
}

