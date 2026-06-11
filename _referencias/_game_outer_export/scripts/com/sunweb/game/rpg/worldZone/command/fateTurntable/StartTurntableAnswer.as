package com.sunweb.game.rpg.worldZone.command.fateTurntable
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class StartTurntableAnswer extends obf_O_8_1034
   {
      
      public var result:Object;
      
      public var fateValue:int;
      
      public function StartTurntableAnswer()
      {
         super(CommandCodeFateTurntable.START_TURNTABLE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["result:map(ubyte,ubyte)","fateValue:int"];
      }
   }
}

