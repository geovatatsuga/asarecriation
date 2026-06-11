package com.sunweb.game.rpg.worldZone.command.cloak
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerCloakInChipRequest extends obf_O_8_1034
   {
      
      public var type:int;
      
      public var index:int;
      
      public function PlayerCloakInChipRequest()
      {
         super(CommandCodePlayerCloak.PLAYER_CLOAK_IN_CHIP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte","index:ubyte"];
      }
   }
}

