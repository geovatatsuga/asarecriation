package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemoteVipCheckNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var vipLevel:int;
      
      public function RemoteVipCheckNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_VIP_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","vipLevel:byte"];
      }
   }
}

