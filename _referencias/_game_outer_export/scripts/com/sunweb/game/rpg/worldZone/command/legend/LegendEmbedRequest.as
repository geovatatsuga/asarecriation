package com.sunweb.game.rpg.worldZone.command.legend
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class LegendEmbedRequest extends obf_O_8_1034
   {
      
      public var id:String;
      
      public var index:int;
      
      public var gemItemIndex:int;
      
      public function LegendEmbedRequest()
      {
         super(CommandCodeLegendStone.LEGEND_EMBED_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["id:string","index:ubyte","gemItemIndex:ubyte"];
      }
   }
}

