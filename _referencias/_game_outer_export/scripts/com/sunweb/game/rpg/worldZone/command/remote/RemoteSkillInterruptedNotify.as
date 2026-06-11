package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemoteSkillInterruptedNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var skillSn:int;
      
      public function RemoteSkillInterruptedNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_SKILL_INTERRUPTED_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","skillSn:ushort"];
      }
   }
}

