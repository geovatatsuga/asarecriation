package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemoteDragonCheckNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var dragonLevel:int;
      
      public function RemoteDragonCheckNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_DRAGON_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","dragonLevel:ubyte"];
      }
   }
}

