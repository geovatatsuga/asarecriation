package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemoteHairStyleChangeNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var hairStyleIndex:int;
      
      public function RemoteHairStyleChangeNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_HAIR_STYLE_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","hairStyleIndex:ubyte"];
      }
   }
}

