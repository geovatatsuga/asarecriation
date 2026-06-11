package com.sunweb.game.rpg.worldZone.command.legend
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class LegendUpLevelRequest extends obf_O_8_1034
   {
      
      public var itemCode:String;
      
      public var needList:Object;
      
      public var isMoney:Boolean;
      
      public function LegendUpLevelRequest()
      {
         super(CommandCodeLegendStone.LEGEND_UP_LEVEL_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemCode:string","needList:map(string,ubyte)","isMoney:boolean"];
      }
   }
}

