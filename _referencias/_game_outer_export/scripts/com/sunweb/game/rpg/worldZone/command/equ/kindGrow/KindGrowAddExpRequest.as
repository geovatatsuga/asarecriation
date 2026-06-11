package com.sunweb.game.rpg.worldZone.command.equ.kindGrow
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class KindGrowAddExpRequest extends obf_O_8_1034
   {
      
      public var kind:int;
      
      public var equIds:Array;
      
      public function KindGrowAddExpRequest()
      {
         super(CommandCodePlayerEquipKindGrow.KIND_GROW_ADD_EXP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["kind:ubyte","equIds:array(string)"];
      }
   }
}

