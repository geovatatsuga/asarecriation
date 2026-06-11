package com.sunweb.game.rpg.worldZone.command.itemManual
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ItemManualInfoNotify extends obf_O_8_1034
   {
      
      public var itemManualMap:Object;
      
      public var starValue:int;
      
      public var successIds:Array;
      
      public var awardSuccessIds:Array;
      
      public function ItemManualInfoNotify()
      {
         super(CommandCodeItemManual.ITEM_MANUAL_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemManualMap:map(string,ubyte)","starValue:int","successIds:array(string)","awardSuccessIds:array(string)"];
      }
   }
}

