package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFamilyMemberRemovedNotify extends obf_O_8_1034
   {
      
      public var memberName:String;
      
      public function PlayerFamilyMemberRemovedNotify()
      {
         super(CommandCodePlayerFamily.PLAYER_FAMILY_MEMBER_REMOVED_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["memberName:string"];
      }
   }
}

