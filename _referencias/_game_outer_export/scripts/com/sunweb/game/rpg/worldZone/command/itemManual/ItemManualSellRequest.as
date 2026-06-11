package com.sunweb.game.rpg.worldZone.command.itemManual
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ItemManualSellRequest extends obf_O_8_1034
   {
      
      public var sellCode:String;
      
      public var type:int;
      
      public function ItemManualSellRequest()
      {
         super(CommandCodeItemManual.ITEM_MANUAL_SELL_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["sellCode:string","type:ubyte"];
      }
   }
}

