package com.sunweb.game.rpg.worldZone.command.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerRollItemRequest extends obf_O_8_1034
   {
      
      public var itemId:String;
      
      public var isGiveUp:Boolean;
      
      public function PlayerRollItemRequest()
      {
         super(CommandCodeTeam.PLAYER_ROLL_ITEM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemId:string","isGiveUp:boolean"];
      }
   }
}

