package com.sunweb.game.rpg.worldZone.command.itemManual
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ItemManualStarValueNotify extends obf_O_8_1034
   {
      
      public var starValue:int;
      
      public function ItemManualStarValueNotify()
      {
         super(CommandCodeItemManual.ITEM_MANUAL_STAR_VALUE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["starValue:int"];
      }
   }
}

