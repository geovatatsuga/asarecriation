package com.sunweb.game.rpg.worldZone.command.itemManual
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ItemManualSuccessAwardAnswer extends obf_O_8_1034
   {
      
      public var awardSuccessIds:Array;
      
      public function ItemManualSuccessAwardAnswer()
      {
         super(CommandCodeItemManual.ITEM_MANUAL_SUCCESS_AWARD_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["awardSuccessIds:array(string)"];
      }
   }
}

