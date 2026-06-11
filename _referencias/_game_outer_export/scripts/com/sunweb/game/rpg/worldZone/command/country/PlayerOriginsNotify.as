package com.sunweb.game.rpg.worldZone.command.country
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerOriginsNotify extends obf_O_8_1034
   {
      
      public var origins:int;
      
      public function PlayerOriginsNotify()
      {
         super(CommandCodePlayerCountry.PLAYER_ORIGINS_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["origins:int"];
      }
   }
}

