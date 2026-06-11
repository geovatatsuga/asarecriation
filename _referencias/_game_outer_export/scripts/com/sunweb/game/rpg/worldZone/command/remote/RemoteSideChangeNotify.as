package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemoteSideChangeNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var side:int;
      
      public function RemoteSideChangeNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_SIDE_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","side:byte"];
      }
   }
}

