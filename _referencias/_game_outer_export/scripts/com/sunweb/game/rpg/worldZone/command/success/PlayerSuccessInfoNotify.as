package com.sunweb.game.rpg.worldZone.command.success
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.script.DynamicVars;
   import com.sunweb.game.rpg.success.SuccessRecorder;
   
   public class PlayerSuccessInfoNotify extends obf_O_8_1034
   {
      
      public var successRecorder:SuccessRecorder;
      
      public var killedMonstersOfSuccess:DynamicVars;
      
      public function PlayerSuccessInfoNotify()
      {
         super(CommandCodePlayerSuccess.PLAYER_SUCCESS_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["successRecorder:com.sunweb.game.rpg.success.SuccessRecorder","killedMonstersOfSuccess:com.sunweb.game.rpg.script.DynamicVars"];
      }
   }
}

