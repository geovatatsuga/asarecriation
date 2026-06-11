package com.sunweb.game.rpg.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class FamilyListInfo extends obf_2_M_853
   {
      
      public var familyName:String;
      
      public var level:int;
      
      public var exp:int;
      
      public var createDate:String;
      
      public var leaderName:String;
      
      public var people:String;
      
      public function FamilyListInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["familyName:string","level:byte","exp:int","createDate:string","leaderName:string","people:string"];
      }
   }
}

