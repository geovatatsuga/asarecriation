package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemoteChangeModelNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var modelCode:String;
      
      public function RemoteChangeModelNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_CHANGE_MODEL_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","modelCode:string"];
      }
   }
}

