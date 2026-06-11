package com.sunweb.game.rpg.worldZone.command.activityBox
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ConsumeRankNotify extends obf_O_8_1034
   {
      
      public var rankInfo:Array;
      
      public function ConsumeRankNotify()
      {
         super(CommandTermConfig.CONSUME_RANK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["rankInfo:array(com.sunweb.game.rpg.activity.ConsumeInfo)"];
      }
   }
}

