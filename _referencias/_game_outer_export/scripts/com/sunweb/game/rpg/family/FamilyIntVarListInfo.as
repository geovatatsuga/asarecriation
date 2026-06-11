package com.sunweb.game.rpg.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class FamilyIntVarListInfo extends obf_2_M_853
   {
      
      public var familyName:String;
      
      public var level:int;
      
      public var exp:int;
      
      public var leaderName:String;
      
      public var intVarValue:int;
      
      public function FamilyIntVarListInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["familyName:string","level:byte","exp:int","leaderName:string","intVarValue:int"];
      }
   }
}

