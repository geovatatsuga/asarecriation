package com.sunweb.game.rpg.worldZone.command.incubator
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class IncubatorPowerRequest extends obf_O_8_1034
   {
      
      public function IncubatorPowerRequest()
      {
         super(CommandCodeIncubator.INCUBATOR_POWER_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

