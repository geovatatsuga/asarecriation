package com.sunweb.game.rpg.worldZone.command.incubator
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class IncubatorPressureRequest extends obf_O_8_1034
   {
      
      public function IncubatorPressureRequest()
      {
         super(CommandCodeIncubator.INCUBATOR_PRESSURE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

