package com.sunweb.game.rpg.worldZone.command.baby
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBabyBloodUpAnswer extends obf_O_8_1034
   {
      
      public var bloodLevel:int;
      
      public var bloodExp:int;
      
      public function PlayerBabyBloodUpAnswer()
      {
         super(CommandCodeBaby.PLAYER_BABY_BLOOD_UP_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["bloodLevel:ubyte","bloodExp:ushort"];
      }
   }
}

