package com.sunweb.game.rpg.worldZone.command.equ.kindGrow
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.equipKindGrow.EquipKindGrowInfo;
   
   public class KindGrowBreachAnswer extends obf_O_8_1034
   {
      
      public var info:EquipKindGrowInfo;
      
      public function KindGrowBreachAnswer()
      {
         super(CommandCodePlayerEquipKindGrow.KIND_GROW_BREACH_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["info:com.sunweb.game.rpg.equipKindGrow.EquipKindGrowInfo"];
      }
   }
}

