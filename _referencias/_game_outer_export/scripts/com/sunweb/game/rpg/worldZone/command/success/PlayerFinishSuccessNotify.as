package com.sunweb.game.rpg.worldZone.command.success
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFinishSuccessNotify extends obf_O_8_1034
   {
      
      public var successId:int;
      
      public function PlayerFinishSuccessNotify()
      {
         super(CommandCodePlayerSuccess.PLAYER_FINISH_SUCCESS_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["successId:ushort"];
      }
   }
}

