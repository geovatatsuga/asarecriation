package com.sunweb.game.rpg.worldZone.command.reGrow
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerInOutExpRequest extends obf_O_8_1034
   {
      
      public var type:int;
      
      public function PlayerInOutExpRequest()
      {
         super(CommandCodePlayerReGrow.PLAYER_IN_OUT_EXP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte"];
      }
   }
}

