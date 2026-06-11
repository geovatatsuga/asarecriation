package com.sunweb.game.rpg.worldZone.command.incubator
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class IncubatorChangePressureTempNotify extends obf_O_8_1034
   {
      
      public var pressure:int;
      
      public var temp:int;
      
      public function IncubatorChangePressureTempNotify()
      {
         super(CommandCodeIncubator.INCUBATOR_CHANGE_PRESSURE_TEMP_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["pressure:short","temp:short"];
      }
   }
}

