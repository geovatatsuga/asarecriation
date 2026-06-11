package com.sunweb.game.rpg.worldZone.command.runningMan
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerRunAwardRequest extends obf_O_8_1034
   {
      
      public var awardId:String;
      
      public function PlayerRunAwardRequest()
      {
         super(CommandCodePlayerRunConfig.PLAYER_RUN_AWARD_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["awardId:string"];
      }
   }
}

