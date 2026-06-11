package com.sunweb.game.rpg.pet
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class PetBriefInfo extends obf_2_M_853
   {
      
      public var petId:String;
      
      public var petCode:String;
      
      public var petName:String;
      
      public var buffInfo:Array;
      
      public function PetBriefInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["petId:string","petCode:string","petName:string","buffInfo:array(com.sunweb.game.rpg.buff.BuffInfo)"];
      }
   }
}

