package com.sunweb.game.rpg.worldZone.command.monsterManual
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.manual.MonsterManualInfo;
   
   public class ManualAbsorbAnswer extends obf_O_8_1034
   {
      
      public var manualInfo:MonsterManualInfo;
      
      public function ManualAbsorbAnswer()
      {
         super(CommandCodeMonsterManual.MANUAL_ABSORB_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["manualInfo:com.sunweb.game.rpg.manual.MonsterManualInfo"];
      }
   }
}

