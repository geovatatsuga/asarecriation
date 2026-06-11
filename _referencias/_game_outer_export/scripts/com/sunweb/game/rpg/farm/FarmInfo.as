package com.sunweb.game.rpg.farm
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class FarmInfo extends obf_2_M_853
   {
      
      public var id:String;
      
      public var name:String;
      
      public var ownerId:String;
      
      public var currentLevel:int = 1;
      
      public var styleCode:String;
      
      public function FarmInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["id:string","name:string","ownerId:string","currentLevel:byte","styleCode:string"];
      }
   }
}

