package com.sunweb.game.rpg.worldZone.command.equ.kindGrow
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.equipKindGrow.EquipKindGrowInfo;
   
   public class KindGrowTemperAnswer extends obf_O_8_1034
   {
      
      public var info:EquipKindGrowInfo;
      
      public function KindGrowTemperAnswer()
      {
         super(CommandCodePlayerEquipKindGrow.KIND_GROW_TEMPER_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["info:com.sunweb.game.rpg.equipKindGrow.EquipKindGrowInfo"];
      }
   }
}

