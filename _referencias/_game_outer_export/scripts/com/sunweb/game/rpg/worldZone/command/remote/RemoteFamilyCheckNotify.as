package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemoteFamilyCheckNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var familyName:String;
      
      public var postLevel:int;
      
      public var postName:String;
      
      public function RemoteFamilyCheckNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_FAMILY_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","familyName:string","postLevel:ubyte","postName:string"];
      }
   }
}

