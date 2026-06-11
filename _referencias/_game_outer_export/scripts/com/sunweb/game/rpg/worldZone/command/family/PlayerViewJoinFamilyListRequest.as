package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerViewJoinFamilyListRequest extends obf_O_8_1034
   {
      
      public function PlayerViewJoinFamilyListRequest()
      {
         super(CommandCodePlayerFamily.PLAYER_VIEW_JOIN_FAMILY_LIST_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

