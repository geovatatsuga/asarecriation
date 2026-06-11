package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerCounterCheckNotify extends obf_O_8_1034
   {
      
      public var isCheckAll:Boolean;
      
      public var counterItems:Array;
      
      public function PlayerCounterCheckNotify()
      {
         super(CommandCodePlayer.PLAYER_COUNTER_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["isCheckAll:boolean","counterItems:array(com.sunweb.game.rpg.task.PeriodCounterItemInfo)"];
      }
   }
}

