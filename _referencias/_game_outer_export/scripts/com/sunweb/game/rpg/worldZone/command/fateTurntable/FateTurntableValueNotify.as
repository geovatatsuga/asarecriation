package com.sunweb.game.rpg.worldZone.command.fateTurntable
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class FateTurntableValueNotify extends obf_O_8_1034
   {
      
      public var fateValue:int;
      
      public function FateTurntableValueNotify()
      {
         super(CommandCodeFateTurntable.FATE_TURNTABLE_VALUE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["fateValue:int"];
      }
   }
}

