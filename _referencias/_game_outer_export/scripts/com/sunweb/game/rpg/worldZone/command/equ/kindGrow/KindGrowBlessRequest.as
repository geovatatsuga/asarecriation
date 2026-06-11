package com.sunweb.game.rpg.worldZone.command.equ.kindGrow
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class KindGrowBlessRequest extends obf_O_8_1034
   {
      
      public var kind:int;
      
      public var equipId:String;
      
      public function KindGrowBlessRequest()
      {
         super(CommandCodePlayerEquipKindGrow.KIND_GROW_BLESS_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["kind:ubyte","equipId:string"];
      }
   }
}

