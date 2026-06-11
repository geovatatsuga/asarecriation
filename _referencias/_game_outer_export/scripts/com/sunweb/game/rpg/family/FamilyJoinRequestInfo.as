package com.sunweb.game.rpg.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class FamilyJoinRequestInfo extends obf_2_M_853
   {
      
      public var playerId:String;
      
      public var requestTime:String;
      
      public var requestMsg:String;
      
      public function FamilyJoinRequestInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["playerId:string","requestTime:string","requestMsg:string"];
      }
   }
}

