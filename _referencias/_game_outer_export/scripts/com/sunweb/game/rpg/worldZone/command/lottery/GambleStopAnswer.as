package com.sunweb.game.rpg.worldZone.command.lottery
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class GambleStopAnswer extends obf_O_8_1034
   {
      
      public var ruleId:String;
      
      public function GambleStopAnswer()
      {
         super(CommandCodeLottery.GAMBLE_STOP_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["ruleId:string"];
      }
   }
}

