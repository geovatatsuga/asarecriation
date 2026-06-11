package com.sunweb.game.rpg.worldZone.command.lottery
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class LotteryRequest extends obf_O_8_1034
   {
      
      public var ruleId:String;
      
      public var index:int;
      
      public function LotteryRequest()
      {
         super(CommandCodeLottery.LOTTERY_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["ruleId:string","index:byte"];
      }
   }
}

