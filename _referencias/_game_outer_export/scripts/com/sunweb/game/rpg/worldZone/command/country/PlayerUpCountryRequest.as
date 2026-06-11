package com.sunweb.game.rpg.worldZone.command.country
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerUpCountryRequest extends obf_O_8_1034
   {
      
      public function PlayerUpCountryRequest()
      {
         super(CommandCodePlayerCountry.PLAYER_UP_COUNTRY_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

