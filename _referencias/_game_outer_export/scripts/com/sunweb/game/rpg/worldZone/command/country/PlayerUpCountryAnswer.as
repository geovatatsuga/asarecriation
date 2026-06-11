package com.sunweb.game.rpg.worldZone.command.country
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerUpCountryAnswer extends obf_O_8_1034
   {
      
      public var countryLevel:int;
      
      public var wills:int;
      
      public function PlayerUpCountryAnswer()
      {
         super(CommandCodePlayerCountry.PLAYER_UP_COUNTRY_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["countryLevel:ubyte","wills:int"];
      }
   }
}

