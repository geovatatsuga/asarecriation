package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerJoinFamilyRequest extends obf_O_8_1034
   {
      
      public var familyName:String;
      
      public var msg:String;
      
      public function PlayerJoinFamilyRequest()
      {
         super(CommandCodePlayerFamily.PLAYER_JOIN_FAMILY_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["familyName:string","msg:string"];
      }
   }
}

