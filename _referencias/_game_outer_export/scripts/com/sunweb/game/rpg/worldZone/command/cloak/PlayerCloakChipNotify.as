package com.sunweb.game.rpg.worldZone.command.cloak
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerCloakChipNotify extends obf_O_8_1034
   {
      
      public var attactChipMap:Object;
      
      public var defenseChipMap:Object;
      
      public function PlayerCloakChipNotify()
      {
         super(CommandCodePlayerCloak.PLAYER_CLOAK_CHIP_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["attactChipMap:map(ubyte,string)","defenseChipMap:map(ubyte,string)"];
      }
   }
}

