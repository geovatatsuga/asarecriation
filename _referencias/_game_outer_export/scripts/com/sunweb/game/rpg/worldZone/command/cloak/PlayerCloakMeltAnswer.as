package com.sunweb.game.rpg.worldZone.command.cloak
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerCloakMeltAnswer extends obf_O_8_1034
   {
      
      public var isSuccess:Boolean;
      
      public function PlayerCloakMeltAnswer()
      {
         super(CommandCodePlayerCloak.PLAYER_CLOAK_MELT_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["isSuccess:boolean"];
      }
   }
}

