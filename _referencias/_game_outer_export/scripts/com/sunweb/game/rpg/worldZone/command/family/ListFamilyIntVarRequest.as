package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ListFamilyIntVarRequest extends obf_O_8_1034
   {
      
      public var varName:String;
      
      public var usage:String;
      
      public function ListFamilyIntVarRequest()
      {
         super(CommandCodePlayerFamily.LIST_FAMILY_INT_VAR_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["varName:string","usage:string"];
      }
   }
}

