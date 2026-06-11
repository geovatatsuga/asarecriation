package com.sunweb.game.rpg.worldZone.command.incubator
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class IncubatorTempRequest extends obf_O_8_1034
   {
      
      public function IncubatorTempRequest()
      {
         super(CommandCodeIncubator.INCUBATOR_TEMP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

