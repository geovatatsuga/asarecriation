package com.sunweb.game.rpg.worldZone.command.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerRollItemAnswer extends obf_O_8_1034
   {
      
      public var itemId:String;
      
      public var rollResult:int;
      
      public function PlayerRollItemAnswer()
      {
         super(CommandCodeTeam.PLAYER_ROLL_ITEM_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemId:string","rollResult:byte"];
      }
   }
}

