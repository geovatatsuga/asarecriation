package com.sunweb.game.rpg.worldZone.command.equ.kindGrow
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class KindGrowBlessAnswer extends obf_O_8_1034
   {
      
      public var equipId:String;
      
      public function KindGrowBlessAnswer()
      {
         super(CommandCodePlayerEquipKindGrow.KIND_GROW_BLESS_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipId:string"];
      }
   }
}

