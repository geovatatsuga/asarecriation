package com.sunweb.game.rpg.worldZone.command.incubator
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class IncubatorDoAnswer extends obf_O_8_1034
   {
      
      public var endTime:int;
      
      public var pressure:int;
      
      public var temp:int;
      
      public var power:int;
      
      public function IncubatorDoAnswer()
      {
         super(CommandCodeIncubator.INCUBATOR_DO_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["endTime:int","pressure:short","temp:short","power:short"];
      }
   }
}

