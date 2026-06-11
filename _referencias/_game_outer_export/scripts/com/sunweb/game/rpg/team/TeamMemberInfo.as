package com.sunweb.game.rpg.team
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class TeamMemberInfo extends obf_2_M_853
   {
      
      public var name:String;
      
      public var isOnline:Boolean;
      
      public var jobCode:int;
      
      public var sex:int;
      
      public var level:int;
      
      public var headIconIndex:int;
      
      public var hp:Number;
      
      public var hpMax:Number;
      
      public var mateName:String;
      
      public var mp:int;
      
      public var mpMax:int;
      
      public var mateRelation:int;
      
      public function TeamMemberInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["name:string","isOnline:boolean","jobCode:byte","sex:byte","level:short","headIconIndex:ushort","hp:double","hpMax:double","mp:ushort","mpMax:ushort","mateName:string","mateRelation:byte"];
      }
   }
}

