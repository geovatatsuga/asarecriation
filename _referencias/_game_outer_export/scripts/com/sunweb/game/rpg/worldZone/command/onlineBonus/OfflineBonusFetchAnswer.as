package com.sunweb.game.rpg.worldZone.command.onlineBonus
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class OfflineBonusFetchAnswer extends obf_O_8_1034
   {
      
      public var expMul:int;
      
      public var isDone:Boolean;
      
      public var offlineHours:int;
      
      public var expTotal:int;
      
      public function OfflineBonusFetchAnswer()
      {
         super(CommandCodeOnlineBonus.OFFLINE_BONUS_FETCH_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["expMul:byte","isDone:boolean","offlineHours:short","expTotal:int"];
      }
   }
}

