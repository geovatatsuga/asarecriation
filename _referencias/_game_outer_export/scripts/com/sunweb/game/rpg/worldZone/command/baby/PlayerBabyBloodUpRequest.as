package com.sunweb.game.rpg.worldZone.command.baby
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBabyBloodUpRequest extends obf_O_8_1034
   {
      
      public function PlayerBabyBloodUpRequest()
      {
         super(CommandCodeBaby.PLAYER_BABY_BLOOD_UP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

