package com.sunweb.game.rpg.worldZone.command.cloak
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerCloakGetUpAnswer extends obf_O_8_1034
   {
      
      public var attactCloaks:int;
      
      public var defenseCloaks:int;
      
      public function PlayerCloakGetUpAnswer()
      {
         super(CommandCodePlayerCloak.PLAYER_CLOAK_GET_UP_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["attactCloaks:ubyte","defenseCloaks:ubyte"];
      }
   }
}

