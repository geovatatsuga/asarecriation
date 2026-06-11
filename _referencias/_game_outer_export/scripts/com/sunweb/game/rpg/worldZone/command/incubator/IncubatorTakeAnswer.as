package com.sunweb.game.rpg.worldZone.command.incubator
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class IncubatorTakeAnswer extends obf_O_8_1034
   {
      
      public var itemCode:String;
      
      public function IncubatorTakeAnswer()
      {
         super(CommandCodeIncubator.INCUBATOR_TAKE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemCode:string"];
      }
   }
}

