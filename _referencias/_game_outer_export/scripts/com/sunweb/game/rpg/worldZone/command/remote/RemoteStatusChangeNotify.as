package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemoteStatusChangeNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var statusFlags:int;
      
      public function RemoteStatusChangeNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_STATUS_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","statusFlags:int"];
      }
   }
}

