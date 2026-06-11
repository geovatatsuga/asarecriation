package com.sunweb.game.rpg.worldZone.command.fateTurntable
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class FateTurntableInfoNotify extends obf_O_8_1034
   {
      
      public var result:Object;
      
      public var fateList:Array;
      
      public var fateValue:int;
      
      public function FateTurntableInfoNotify()
      {
         super(CommandCodeFateTurntable.FATE_TURNTABLE_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["result:map(ubyte,ubyte)","fateList:array(com.sunweb.game.rpg.fateTurntable.FateInfo)","fateValue:int"];
      }
   }
}

