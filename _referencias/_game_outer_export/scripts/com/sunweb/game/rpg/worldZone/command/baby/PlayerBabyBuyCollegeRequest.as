package com.sunweb.game.rpg.worldZone.command.baby
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBabyBuyCollegeRequest extends obf_O_8_1034
   {
      
      public function PlayerBabyBuyCollegeRequest()
      {
         super(CommandCodeBaby.PLAYER_BABY_BUY_COLLEGE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

