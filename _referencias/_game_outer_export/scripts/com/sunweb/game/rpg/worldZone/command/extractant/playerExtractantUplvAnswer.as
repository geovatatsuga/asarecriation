package com.sunweb.game.rpg.worldZone.command.extractant
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class playerExtractantUplvAnswer extends obf_O_8_1034
   {
      
      public var ability:int;
      
      public var upLvs:Array;
      
      public function playerExtractantUplvAnswer()
      {
         super(CommandPlayerExtractant.REMARK_EXTRACTANT_UP_LV_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["ability:int","upLvs:array(ubyte)"];
      }
   }
}

