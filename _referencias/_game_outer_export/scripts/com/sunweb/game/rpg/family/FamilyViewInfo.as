package com.sunweb.game.rpg.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class FamilyViewInfo extends obf_2_M_853
   {
      
      public var familyName:String;
      
      public var level:int;
      
      public var exp:int;
      
      public var gold:int;
      
      public var res1:int;
      
      public var res2:int;
      
      public var res3:int;
      
      public var createPlayerId:String;
      
      public var createDate:String;
      
      public var leaderName:String;
      
      public var declaration:String;
      
      public var totalMemberNumber:int;
      
      public var onlineMemberNumber:int;
      
      public function FamilyViewInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["familyName:string","level:byte","exp:int","gold:int","res1:int","res2:int","res3:int","createPlayerId:string","createDate:string","leaderName:string","declaration:string","totalMemberNumber:ubyte","onlineMemberNumber:ubyte"];
      }
   }
}

