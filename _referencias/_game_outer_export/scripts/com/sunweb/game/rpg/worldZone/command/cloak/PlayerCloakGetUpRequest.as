package com.sunweb.game.rpg.worldZone.command.cloak
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerCloakGetUpRequest extends obf_O_8_1034
   {
      
      public var type:int;
      
      public function PlayerCloakGetUpRequest()
      {
         super(CommandCodePlayerCloak.PLAYER_CLOAK_GET_UP_REQEUST);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte"];
      }
   }
}

