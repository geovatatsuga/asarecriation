package com.sunweb.game.rpg.worldZone.command.equ.kindGrow
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class KindGrowInfoNotify extends obf_O_8_1034
   {
      
      public var infoList:Array;
      
      public function KindGrowInfoNotify()
      {
         super(CommandCodePlayerEquipKindGrow.KIND_GROW_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["infoList:array(com.sunweb.game.rpg.equipKindGrow.EquipKindGrowInfo)"];
      }
   }
}

