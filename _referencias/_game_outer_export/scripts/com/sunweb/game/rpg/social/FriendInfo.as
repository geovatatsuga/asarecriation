package com.sunweb.game.rpg.social
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class FriendInfo extends obf_2_M_853
   {
      
      public var friendName:String;
      
      public var relationValue:int;
      
      public var sex:int;
      
      public var level:int;
      
      public var isOnline:Boolean;
      
      public var moodIndex:int;
      
      public function FriendInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["friendName:string","relationValue:int","sex:byte","level:short","isOnline:boolean","moodIndex:byte"];
      }
   }
}

