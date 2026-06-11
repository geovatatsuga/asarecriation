package com.sunweb.game.rpg.worldZone.command.starAdventure
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerStarsInfoNotify extends obf_O_8_1034
   {
      
      public var chartLevel:int;
      
      public var stars:int;
      
      public function PlayerStarsInfoNotify()
      {
         super(CommandCodePlayerStars.PLAYER_STARS_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["chartLevel:ubyte","stars:int"];
      }
   }
}

