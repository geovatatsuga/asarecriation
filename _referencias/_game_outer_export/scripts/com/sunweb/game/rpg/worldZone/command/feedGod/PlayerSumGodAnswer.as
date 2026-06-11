package com.sunweb.game.rpg.worldZone.command.feedGod
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerSumGodAnswer extends obf_O_8_1034
   {
      
      public var sumGodLevel:int;
      
      public function PlayerSumGodAnswer()
      {
         super(CommandCodePlayerFeedGod.PLAYER_SUM_GOD_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["sumGodLevel:ubyte"];
      }
   }
}

