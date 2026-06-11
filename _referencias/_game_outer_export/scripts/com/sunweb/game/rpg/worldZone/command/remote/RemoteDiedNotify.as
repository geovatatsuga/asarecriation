package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemoteDiedNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var mapId:String;
      
      public var x:int;
      
      public var y:int;
      
      public function RemoteDiedNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_DIED_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","mapId:string","x:short","y:short"];
      }
   }
}

