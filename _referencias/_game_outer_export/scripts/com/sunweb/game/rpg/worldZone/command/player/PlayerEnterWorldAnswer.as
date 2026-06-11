package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.role.LocalPlayerInfo;
   import com.sunweb.game.rpg.script.DynamicVars;
   import com.sunweb.game.rpg.task.TaskRecorder;
   
   public class PlayerEnterWorldAnswer extends obf_O_8_1034
   {
      
      public var role:LocalPlayerInfo;
      
      public var clientConfig:String;
      
      public var vars:DynamicVars;
      
      public var killedMonsters:DynamicVars;
      
      public var taskRecorder:TaskRecorder;
      
      public var friendList:Array;
      
      public var isWaiting:Boolean;
      
      public var waitingTotal:int;
      
      public var waitingIndex:int;
      
      public var failureReason:String;
      
      public var sysVars:DynamicVars;
      
      public function PlayerEnterWorldAnswer()
      {
         super(CommandCodePlayer.PLAYER_ENTER_WORLD_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["role:com.sunweb.game.rpg.role.LocalPlayerInfo","clientConfig:string","vars:com.sunweb.game.rpg.script.DynamicVars","killedMonsters:com.sunweb.game.rpg.script.DynamicVars","taskRecorder:com.sunweb.game.rpg.task.TaskRecorder","friendList:array(com.sunweb.game.rpg.social.FriendInfo)","isWaiting:boolean","waitingTotal:short","waitingIndex:short","failureReason:string","sysVars:com.sunweb.game.rpg.script.DynamicVars"];
      }
   }
}

