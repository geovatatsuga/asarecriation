package com.sunweb.game.rpg.worldZone.command.incubator
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class IncubatorSaveRequest extends obf_O_8_1034
   {
      
      public function IncubatorSaveRequest()
      {
         super(CommandCodeIncubator.INCUBATOR_SAVE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

