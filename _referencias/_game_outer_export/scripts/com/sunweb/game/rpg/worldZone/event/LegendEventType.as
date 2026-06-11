package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.legend.CommandCodeLegendStone;
   
   public class LegendEventType
   {
      
      public static const LEGEND_HOLE_ANSWER:String = CommandCodeLegendStone.LEGEND_HOLE_ANSWER.toString(16);
      
      public static const LEGEND_EMBED_ANSWER:String = CommandCodeLegendStone.LEGEND_EMBED_ANSWER.toString(16);
      
      public static const LEGEND_REMOVE_ANSWER:String = CommandCodeLegendStone.LEGEND_REMOVE_ANSWER.toString(16);
      
      public static const LEGENG_UP_LEVEL_ANSWER:String = CommandCodeLegendStone.LEGENG_UP_LEVEL_ANSWER.toString(16);
      
      public function LegendEventType()
      {
         super();
      }
   }
}

