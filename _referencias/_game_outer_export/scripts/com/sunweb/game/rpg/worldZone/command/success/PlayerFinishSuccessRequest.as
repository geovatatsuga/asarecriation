package com.sunweb.game.rpg.worldZone.command.success
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFinishSuccessRequest extends obf_O_8_1034
   {
      
      public var successId:int;
      
      public function PlayerFinishSuccessRequest()
      {
         super(CommandCodePlayerSuccess.PLAYER_FINISH_SUCCESS_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["successId:ushort"];
      }
      
      override public function getDigestKey() : int
      {
         return 63239;
      }
   }
}

