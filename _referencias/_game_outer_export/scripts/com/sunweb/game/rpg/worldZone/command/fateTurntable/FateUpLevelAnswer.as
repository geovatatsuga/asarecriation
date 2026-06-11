package com.sunweb.game.rpg.worldZone.command.fateTurntable
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class FateUpLevelAnswer extends obf_O_8_1034
   {
      
      public var fateList:Array;
      
      public var fateValue:int;
      
      public function FateUpLevelAnswer()
      {
         super(CommandCodeFateTurntable.FATE_UP_LEVEL_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["fateList:array(com.sunweb.game.rpg.fateTurntable.FateInfo)","fateValue:int"];
      }
   }
}

