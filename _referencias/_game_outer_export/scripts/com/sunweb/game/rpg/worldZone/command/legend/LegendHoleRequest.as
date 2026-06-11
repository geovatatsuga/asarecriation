package com.sunweb.game.rpg.worldZone.command.legend
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class LegendHoleRequest extends obf_O_8_1034
   {
      
      public var id:String;
      
      public function LegendHoleRequest()
      {
         super(CommandCodeLegendStone.LEGEND_HOLE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["id:string"];
      }
   }
}

