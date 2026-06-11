package com.sunweb.game.rpg.worldZone.command.lottery
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class LotteryAnswer extends obf_O_8_1034
   {
      
      public var items:Array;
      
      public function LotteryAnswer()
      {
         super(CommandCodeLottery.LOTTERY_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["items:array(com.sunweb.game.rpg.gameItem.GameItemBriefInfo)"];
      }
   }
}

