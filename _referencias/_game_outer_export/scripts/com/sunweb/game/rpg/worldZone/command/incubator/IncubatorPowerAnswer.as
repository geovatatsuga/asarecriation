package com.sunweb.game.rpg.worldZone.command.incubator
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class IncubatorPowerAnswer extends obf_O_8_1034
   {
      
      public var power:int;
      
      public function IncubatorPowerAnswer()
      {
         super(CommandCodeIncubator.INCUBATOR_POWER_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["power:short"];
      }
   }
}

