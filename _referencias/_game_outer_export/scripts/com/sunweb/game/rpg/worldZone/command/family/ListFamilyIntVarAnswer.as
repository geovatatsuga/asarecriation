package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ListFamilyIntVarAnswer extends obf_O_8_1034
   {
      
      public var varName:String;
      
      public var usage:String;
      
      public var familyList:Array;
      
      public function ListFamilyIntVarAnswer()
      {
         super(CommandCodePlayerFamily.LIST_FAMILY_INT_VAR_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["varName:string","usage:string","familyList:array(com.sunweb.game.rpg.family.FamilyIntVarListInfo)"];
      }
   }
}

