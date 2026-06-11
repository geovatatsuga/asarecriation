package com.sunweb.game.rpg.worldZone.command.baby
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBabyTravelFastRequest extends obf_O_8_1034
   {
      
      public function PlayerBabyTravelFastRequest()
      {
         super(CommandCodeBaby.PLAYER_BABY_TRAVEL_FAST_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

