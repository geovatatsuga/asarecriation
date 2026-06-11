package com.sunweb.game.rpg.worldZone.command.baby
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.baby.BabyInfo;
   
   public class PlayerBabyInfoNotify extends obf_O_8_1034
   {
      
      public var babyInfo:BabyInfo;
      
      public function PlayerBabyInfoNotify()
      {
         super(CommandCodeBaby.PLAYER_BABY_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["babyInfo:com.sunweb.game.rpg.baby.BabyInfo"];
      }
   }
}

