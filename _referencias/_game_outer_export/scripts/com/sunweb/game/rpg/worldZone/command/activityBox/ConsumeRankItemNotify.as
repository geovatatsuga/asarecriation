package com.sunweb.game.rpg.worldZone.command.activityBox
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ConsumeRankItemNotify extends obf_O_8_1034
   {
      
      public var rank:int;
      
      public function ConsumeRankItemNotify()
      {
         super(CommandTermConfig.CONSUME_RANK_ITEM_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["rank:ubyte"];
      }
   }
}

