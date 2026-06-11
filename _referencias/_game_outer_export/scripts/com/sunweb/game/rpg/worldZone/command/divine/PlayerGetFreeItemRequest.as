package com.sunweb.game.rpg.worldZone.command.divine
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerGetFreeItemRequest extends obf_O_8_1034
   {
      
      public function PlayerGetFreeItemRequest()
      {
         super(CommandCodePlayerDivine.PLAYER_GET_FREE_ITEM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

