package com.sunweb.game.rpg.worldZone.command.starAdventure
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerStarsAdventureRequest extends obf_O_8_1034
   {
      
      public function PlayerStarsAdventureRequest()
      {
         super(CommandCodePlayerStars.PLAYER_STARS_ADVENTURE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

