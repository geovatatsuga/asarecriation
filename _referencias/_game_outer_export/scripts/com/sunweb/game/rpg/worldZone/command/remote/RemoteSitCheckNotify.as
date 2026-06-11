package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemoteSitCheckNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var isSitting:Boolean;
      
      public function RemoteSitCheckNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_SIT_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","isSitting:boolean"];
      }
   }
}

