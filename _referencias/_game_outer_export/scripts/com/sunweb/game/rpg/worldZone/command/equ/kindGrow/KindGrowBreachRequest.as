package com.sunweb.game.rpg.worldZone.command.equ.kindGrow
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class KindGrowBreachRequest extends obf_O_8_1034
   {
      
      public var kind:int;
      
      public function KindGrowBreachRequest()
      {
         super(CommandCodePlayerEquipKindGrow.KIND_GROW_BREACH_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["kind:ubyte"];
      }
   }
}

