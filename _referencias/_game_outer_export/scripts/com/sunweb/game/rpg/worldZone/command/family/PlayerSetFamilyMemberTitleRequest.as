package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerSetFamilyMemberTitleRequest extends obf_O_8_1034
   {
      
      public var memberName:String;
      
      public var title:String;
      
      public function PlayerSetFamilyMemberTitleRequest()
      {
         super(CommandCodePlayerFamily.PLAYER_SET_FAMILY_MEMBER_TITLE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["memberName:string","title:string"];
      }
   }
}

