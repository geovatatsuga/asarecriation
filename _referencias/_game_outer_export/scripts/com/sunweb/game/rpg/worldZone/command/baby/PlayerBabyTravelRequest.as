package com.sunweb.game.rpg.worldZone.command.baby
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBabyTravelRequest extends obf_O_8_1034
   {
      
      public function PlayerBabyTravelRequest()
      {
         super(CommandCodeBaby.PLYAER_BABY_TRAVEL_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

