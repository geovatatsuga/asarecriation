package com.sunweb.game.rpg.worldZone.command.lottery
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class GambleStartAnswer extends obf_O_8_1034
   {
      
      public var gambleItemList:Array;
      
      public var resultItemList:Array;
      
      public function GambleStartAnswer()
      {
         super(CommandCodeLottery.GAMBLE_START_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["gambleItemList:array(string)","resultItemList:array(com.sunweb.game.rpg.gameItem.GameItemBriefInfo)"];
      }
   }
}

