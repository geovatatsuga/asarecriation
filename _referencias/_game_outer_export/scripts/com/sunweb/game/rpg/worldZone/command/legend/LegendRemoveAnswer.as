package com.sunweb.game.rpg.worldZone.command.legend
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class LegendRemoveAnswer extends obf_O_8_1034
   {
      
      public var equipmentItemId:String;
      
      public function LegendRemoveAnswer()
      {
         super(CommandCodeLegendStone.LEGEND_REMOVE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentItemId:string"];
      }
   }
}

