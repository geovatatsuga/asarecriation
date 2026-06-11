package com.sunweb.game.rpg.role
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class RoleBaseInfo extends obf_2_M_853
   {
      
      public var name:String;
      
      public var jobCode:int;
      
      public var sex:int;
      
      public var level:int;
      
      public var headIconIndex:int;
      
      public var hairStyleIndex:int;
      
      public function RoleBaseInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["name:string","jobCode:byte","sex:byte","level:short","headIconIndex:ushort","hairStyleIndex:ubyte"];
      }
   }
}

