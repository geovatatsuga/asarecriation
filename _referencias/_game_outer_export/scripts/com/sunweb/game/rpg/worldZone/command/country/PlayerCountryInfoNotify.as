package com.sunweb.game.rpg.worldZone.command.country
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerCountryInfoNotify extends obf_O_8_1034
   {
      
      public var countryLevel:int;
      
      public var landsLevel:Object;
      
      public var wills:int;
      
      public var creatures:Number;
      
      public var origins:int;
      
      public function PlayerCountryInfoNotify()
      {
         super(CommandCodePlayerCountry.PLAYER_COUNTRY_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["countryLevel:ubyte","landsLevel:map(string,ubyte)","wills:int","creatures:uint","origins:int"];
      }
   }
}

