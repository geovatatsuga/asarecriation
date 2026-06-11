package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemoteBoothCheckNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var isBooth:Boolean;
      
      public var boothTitle:String;
      
      public function RemoteBoothCheckNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_BOOTH_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","isBooth:boolean","boothTitle:string"];
      }
   }
}

