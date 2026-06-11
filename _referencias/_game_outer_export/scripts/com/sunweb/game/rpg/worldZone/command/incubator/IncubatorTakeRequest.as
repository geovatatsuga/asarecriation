package com.sunweb.game.rpg.worldZone.command.incubator
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class IncubatorTakeRequest extends obf_O_8_1034
   {
      
      public function IncubatorTakeRequest()
      {
         super(CommandCodeIncubator.INCUBATOR_TAKE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

