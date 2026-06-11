package com.sunweb.game.rpg.worldZone.command.starAdventure
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerStarsAdventureAnswer extends obf_O_8_1034
   {
      
      public var items:Object;
      
      public function PlayerStarsAdventureAnswer()
      {
         super(CommandCodePlayerStars.PLAYER_STARS_ADVENTURE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["items:map(string,ubyte)"];
      }
   }
}

