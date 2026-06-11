package com.sunweb.game.rpg.worldZone.command.incubator
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class IncubatorNoRequest extends obf_O_8_1034
   {
      
      public function IncubatorNoRequest()
      {
         super(CommandCodeIncubator.INCUBATOR_NO_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

