package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemoteLeaveMapNotify extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var roleName:String;
      
      public function RemoteLeaveMapNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_LEAVE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","roleName:string"];
      }
   }
}

