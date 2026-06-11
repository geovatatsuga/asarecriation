package com.sunweb.game.rpg.worldZone.command.legend
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class LegendUpLevelAnswer extends obf_O_8_1034
   {
      
      public var isSucceeded:Boolean;
      
      public function LegendUpLevelAnswer()
      {
         super(CommandCodeLegendStone.LEGENG_UP_LEVEL_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["isSucceeded:boolean"];
      }
   }
}

