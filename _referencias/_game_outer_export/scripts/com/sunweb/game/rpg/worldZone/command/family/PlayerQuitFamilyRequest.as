package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerQuitFamilyRequest extends obf_O_8_1034
   {
      
      public function PlayerQuitFamilyRequest()
      {
         super(CommandCodePlayerFamily.PLAYER_QUIT_FAMILY_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

