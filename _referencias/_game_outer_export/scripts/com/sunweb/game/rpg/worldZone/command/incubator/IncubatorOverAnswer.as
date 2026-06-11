package com.sunweb.game.rpg.worldZone.command.incubator
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class IncubatorOverAnswer extends obf_O_8_1034
   {
      
      public var isSuccess:Boolean;
      
      public function IncubatorOverAnswer()
      {
         super(CommandCodeIncubator.INCUBATOR_OVER_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["isSuccess:boolean"];
      }
   }
}

