package com.sunweb.game.rpg.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class FamilyMemberInfo extends obf_2_M_853
   {
      
      public var name:String;
      
      public var isOnline:Boolean;
      
      public var jobCode:int;
      
      public var sex:int;
      
      public var level:int;
      
      public var postLevel:int;
      
      public var postName:String;
      
      public var familyTitle:String;
      
      public var thisFamilyGx:int;
      
      public function FamilyMemberInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["name:string","isOnline:boolean","jobCode:byte","sex:byte","level:short","postLevel:ubyte","postName:string","familyTitle:string","thisFamilyGx:int"];
      }
   }
}

