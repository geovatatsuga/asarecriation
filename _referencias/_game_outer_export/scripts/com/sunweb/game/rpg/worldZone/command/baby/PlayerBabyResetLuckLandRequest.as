package com.sunweb.game.rpg.worldZone.command.baby
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBabyResetLuckLandRequest extends obf_O_8_1034
   {
      
      public function PlayerBabyResetLuckLandRequest()
      {
         super(CommandCodeBaby.PLAYER_BABY_RESET_LUCK_LAND_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

