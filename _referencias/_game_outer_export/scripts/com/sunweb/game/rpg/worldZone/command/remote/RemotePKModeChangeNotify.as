package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemotePKModeChangeNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var pkMode:int;
      
      public function RemotePKModeChangeNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_PK_MODE_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","pkMode:byte"];
      }
   }
}

