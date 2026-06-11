package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.role.RemotePlayerInfo;
   
   public class RemoteEnterMapNotify extends obf_O_8_1034
   {
      
      public var role:RemotePlayerInfo;
      
      public function RemoteEnterMapNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_ENTER_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["role:com.sunweb.game.rpg.role.RemotePlayerInfo"];
      }
   }
}

