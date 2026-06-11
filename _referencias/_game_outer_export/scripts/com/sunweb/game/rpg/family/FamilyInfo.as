package com.sunweb.game.rpg.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class FamilyInfo extends obf_2_M_853
   {
      
      public var familyName:String;
      
      public var level:int;
      
      public var exp:int;
      
      public var gold:int;
      
      public var res1:int;
      
      public var res2:int;
      
      public var res3:int;
      
      public var skills:Object;
      
      public var bossGrow:int;
      
      public function FamilyInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["familyName:string","level:byte","exp:int","gold:int","res1:int","res2:int","res3:int","skills:map(string,byte)","bossGrow:int"];
      }
   }
}

