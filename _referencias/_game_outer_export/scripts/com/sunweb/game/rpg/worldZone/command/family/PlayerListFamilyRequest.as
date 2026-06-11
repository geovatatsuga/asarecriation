package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerListFamilyRequest extends obf_O_8_1034
   {
      
      public function PlayerListFamilyRequest()
      {
         super(CommandCodePlayerFamily.PLAYER_LIST_FAMILY_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

