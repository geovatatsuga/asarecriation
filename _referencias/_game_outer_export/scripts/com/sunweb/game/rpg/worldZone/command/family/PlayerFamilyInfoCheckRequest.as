package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFamilyInfoCheckRequest extends obf_O_8_1034
   {
      
      public function PlayerFamilyInfoCheckRequest()
      {
         super(CommandCodePlayerFamily.PLAYER_FAMILY_INFO_CHECK_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

