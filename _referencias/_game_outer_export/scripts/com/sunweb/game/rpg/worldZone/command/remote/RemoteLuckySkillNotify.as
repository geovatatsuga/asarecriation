package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemoteLuckySkillNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var skillSn:int;
      
      public function RemoteLuckySkillNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_LUCKY_SKILL_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","skillSn:ushort"];
      }
   }
}

