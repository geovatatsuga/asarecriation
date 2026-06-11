package com.sunweb.game.rpg.worldZone.command.incubator
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class IncubatorDoRequest extends obf_O_8_1034
   {
      
      public function IncubatorDoRequest()
      {
         super(CommandCodeIncubator.INCUBATOR_DO_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

