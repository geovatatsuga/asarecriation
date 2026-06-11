package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemoteHonorLevelCheckNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var honorLevel:int;
      
      public function RemoteHonorLevelCheckNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_HONOR_LEVEL_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","honorLevel:byte"];
      }
   }
}

