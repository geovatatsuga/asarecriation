package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.animal.AnimalInfo;
   
   public class PlayerCallTrainerNotify extends obf_O_8_1034
   {
      
      public var animal:AnimalInfo;
      
      public function PlayerCallTrainerNotify()
      {
         super(CommandCodePlayer.PLAYER_CALL_TRAINER_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["animal:com.sunweb.game.rpg.animal.AnimalInfo"];
      }
   }
}

