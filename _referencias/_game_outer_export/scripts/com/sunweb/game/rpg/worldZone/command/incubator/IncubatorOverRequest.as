package com.sunweb.game.rpg.worldZone.command.incubator
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class IncubatorOverRequest extends obf_O_8_1034
   {
      
      public function IncubatorOverRequest()
      {
         super(CommandCodeIncubator.INCUBATOR_OVER_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

