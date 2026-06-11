package com.sunweb.game.rpg.worldZone.command.lottery
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class LotteryLogNotify extends obf_O_8_1034
   {
      
      public var logs:Array;
      
      public function LotteryLogNotify()
      {
         super(CommandCodeLottery.LOTTERY_LOG_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["logs:array(string)"];
      }
   }
}

