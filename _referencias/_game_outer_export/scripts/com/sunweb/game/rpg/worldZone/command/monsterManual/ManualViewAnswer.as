package com.sunweb.game.rpg.worldZone.command.monsterManual
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ManualViewAnswer extends obf_O_8_1034
   {
      
      public var manualList:Object;
      
      public function ManualViewAnswer()
      {
         super(CommandCodeMonsterManual.MANUAL_VIEW_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["manualList:map(string,int)"];
      }
   }
}

