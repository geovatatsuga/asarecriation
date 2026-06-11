package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerLeaveWorldAnswer extends obf_O_8_1034
   {
      
      public var isDone:Boolean;
      
      public var failureReason:String;
      
      public function PlayerLeaveWorldAnswer()
      {
         super(CommandCodePlayer.PLAYER_LEAVE_WORLD_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["isDone:boolean","failureReason:string"];
      }
   }
}

