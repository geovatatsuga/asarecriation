package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemoteLevelUpNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var newLevel:int;
      
      public function RemoteLevelUpNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_LEVEL_UP_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","newLevel:short"];
      }
   }
}

