package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemoteBuffChangeNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var buffsAdded:Array;
      
      public var buffsRemoved:Array;
      
      public function RemoteBuffChangeNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_BUFF_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","buffsAdded:array(com.sunweb.game.rpg.buff.BuffInfo)","buffsRemoved:array(ushort)"];
      }
   }
}

