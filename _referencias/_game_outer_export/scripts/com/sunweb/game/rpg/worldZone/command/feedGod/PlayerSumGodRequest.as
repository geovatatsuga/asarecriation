package com.sunweb.game.rpg.worldZone.command.feedGod
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerSumGodRequest extends obf_O_8_1034
   {
      
      public function PlayerSumGodRequest()
      {
         super(CommandCodePlayerFeedGod.PLAYER_SUM_GOD_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

