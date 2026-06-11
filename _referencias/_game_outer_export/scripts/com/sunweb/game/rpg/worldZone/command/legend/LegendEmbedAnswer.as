package com.sunweb.game.rpg.worldZone.command.legend
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class LegendEmbedAnswer extends obf_O_8_1034
   {
      
      public var equipmentItemId:String;
      
      public function LegendEmbedAnswer()
      {
         super(CommandCodeLegendStone.LEGEND_EMBED_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentItemId:string"];
      }
   }
}

