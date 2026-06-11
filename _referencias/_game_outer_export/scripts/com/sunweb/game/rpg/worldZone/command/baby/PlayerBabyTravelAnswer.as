package com.sunweb.game.rpg.worldZone.command.baby
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBabyTravelAnswer extends obf_O_8_1034
   {
      
      public var luckLand:int;
      
      public var travelLand:int;
      
      public var travelOver:int;
      
      public function PlayerBabyTravelAnswer()
      {
         super(CommandCodeBaby.PLAYER_BABY_TRAVEL_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["luckLand:ubyte","travelLand:byte","travelOver:int"];
      }
   }
}

