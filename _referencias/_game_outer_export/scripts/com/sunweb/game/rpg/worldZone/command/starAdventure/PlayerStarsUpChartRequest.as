package com.sunweb.game.rpg.worldZone.command.starAdventure
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerStarsUpChartRequest extends obf_O_8_1034
   {
      
      public function PlayerStarsUpChartRequest()
      {
         super(CommandCodePlayerStars.PLAYER_STARS_UP_CHART_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

