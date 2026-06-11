package com.sunweb.game.rpg.worldZone.command.legend
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class LegendRemoveRequest extends obf_O_8_1034
   {
      
      public var equipmentItemId:String;
      
      public var holeIndex:int;
      
      public function LegendRemoveRequest()
      {
         super(CommandCodeLegendStone.LEGEND_REMOVE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentItemId:string","holeIndex:byte"];
      }
   }
}

