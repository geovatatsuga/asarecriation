package com.sunweb.game.rpg.worldZone.command.itemManual
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ItemManualSuccessRequest extends obf_O_8_1034
   {
      
      public var successId:String;
      
      public function ItemManualSuccessRequest()
      {
         super(CommandCodeItemManual.ITEM_MANUAL_SUCCESS_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["successId:string"];
      }
   }
}

