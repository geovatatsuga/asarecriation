package com.sunweb.game.rpg.worldZone.command.incubator
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class IncubatorSaveAnswer extends obf_O_8_1034
   {
      
      public var haveItems:Object;
      
      public var pressure:int;
      
      public var temp:int;
      
      public var power:int;
      
      public function IncubatorSaveAnswer()
      {
         super(CommandCodeIncubator.INCUBATOR_SAVE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["haveItems:map(string,short)","pressure:short","temp:short","power:short"];
      }
   }
}

