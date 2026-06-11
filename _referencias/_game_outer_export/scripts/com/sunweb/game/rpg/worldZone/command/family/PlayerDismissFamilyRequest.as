package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerDismissFamilyRequest extends obf_O_8_1034
   {
      
      public function PlayerDismissFamilyRequest()
      {
         super(CommandCodePlayerFamily.PLAYER_DISMISS_FAMILY_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

