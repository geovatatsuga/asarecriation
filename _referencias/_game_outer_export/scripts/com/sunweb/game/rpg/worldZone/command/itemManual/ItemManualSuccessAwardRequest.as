package com.sunweb.game.rpg.worldZone.command.itemManual
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ItemManualSuccessAwardRequest extends obf_O_8_1034
   {
      
      public var successId:String;
      
      public function ItemManualSuccessAwardRequest()
      {
         super(CommandCodeItemManual.ITEM_MANUAL_SUCCESS_AWARD_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["successId:string"];
      }
   }
}

