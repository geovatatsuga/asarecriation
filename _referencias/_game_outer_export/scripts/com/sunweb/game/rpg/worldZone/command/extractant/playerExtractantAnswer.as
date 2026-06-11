package com.sunweb.game.rpg.worldZone.command.extractant
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class playerExtractantAnswer extends obf_O_8_1034
   {
      
      public var surplusTime:int;
      
      public var ability:int;
      
      public function playerExtractantAnswer()
      {
         super(CommandPlayerExtractant.REMARK_TIMEINFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["surplusTime:int","ability:int"];
      }
   }
}

