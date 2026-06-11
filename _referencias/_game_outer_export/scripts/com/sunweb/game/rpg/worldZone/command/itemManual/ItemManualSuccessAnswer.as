package com.sunweb.game.rpg.worldZone.command.itemManual
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ItemManualSuccessAnswer extends obf_O_8_1034
   {
      
      public var successIds:Array;
      
      public var awardSuccessIds:Array;
      
      public function ItemManualSuccessAnswer()
      {
         super(CommandCodeItemManual.ITEM_MANUAL_SUCCESS_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["successIds:array(string)","awardSuccessIds:array(string)"];
      }
   }
}

