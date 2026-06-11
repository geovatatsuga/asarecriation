package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerViewFamilyPostRequest extends obf_O_8_1034
   {
      
      public function PlayerViewFamilyPostRequest()
      {
         super(CommandCodePlayerFamily.PLAYER_VIEW_FAMILY_POST_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

