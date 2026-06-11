package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerSetFamilyMemberPostRequest extends obf_O_8_1034
   {
      
      public var memberName:String;
      
      public var postLevel:int;
      
      public function PlayerSetFamilyMemberPostRequest()
      {
         super(CommandCodePlayerFamily.PLAYER_SET_FAMILY_MEMBER_POST_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["memberName:string","postLevel:ubyte"];
      }
   }
}

