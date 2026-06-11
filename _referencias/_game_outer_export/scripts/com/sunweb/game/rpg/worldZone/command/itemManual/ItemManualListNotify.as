package com.sunweb.game.rpg.worldZone.command.itemManual
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ItemManualListNotify extends obf_O_8_1034
   {
      
      public var itemManualMap:Object;
      
      public function ItemManualListNotify()
      {
         super(CommandCodeItemManual.ITEM_MANUAL_LIST_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemManualMap:map(string,ubyte)"];
      }
   }
}

