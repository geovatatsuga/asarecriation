package com.sunweb.game.rpg.worldZone.command.equ.kindGrow
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class KindGrowTemperRequest extends obf_O_8_1034
   {
      
      public var kind:int;
      
      public var lockList:Array;
      
      public function KindGrowTemperRequest()
      {
         super(CommandCodePlayerEquipKindGrow.KIND_GROW_TEMPER_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["kind:ubyte","lockList:array(short)"];
      }
   }
}

