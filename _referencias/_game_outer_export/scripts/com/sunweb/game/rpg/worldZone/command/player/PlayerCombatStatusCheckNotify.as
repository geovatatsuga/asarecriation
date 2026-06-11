package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerCombatStatusCheckNotify extends obf_O_8_1034
   {
      
      public var isInCombat:Boolean;
      
      public function PlayerCombatStatusCheckNotify()
      {
         super(CommandCodePlayer.PLAYER_COMBAT_STATUS_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["isInCombat:boolean"];
      }
   }
}

