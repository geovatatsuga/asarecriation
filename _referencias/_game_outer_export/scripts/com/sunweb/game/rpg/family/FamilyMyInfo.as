package com.sunweb.game.rpg.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class FamilyMyInfo extends obf_2_M_853
   {
      
      public var familyName:String;
      
      public var postLevel:int;
      
      public var postName:String;
      
      public var familyTitle:String;
      
      public var thisFamilyGx:int;
      
      public var totalFamilyGx:int;
      
      public function FamilyMyInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["familyName:string","postLevel:ubyte","postName:string","familyTitle:string","thisFamilyGx:int","totalFamilyGx:int"];
      }
   }
}

