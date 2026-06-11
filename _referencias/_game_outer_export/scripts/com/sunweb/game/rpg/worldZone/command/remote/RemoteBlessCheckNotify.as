package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemoteBlessCheckNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var isBless:Boolean;
      
      public var blessCode:String;
      
      public var blessLevel:int;
      
      public function RemoteBlessCheckNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_BLESS_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","isBless:boolean","blessCode:string","blessLevel:byte"];
      }
   }
}

