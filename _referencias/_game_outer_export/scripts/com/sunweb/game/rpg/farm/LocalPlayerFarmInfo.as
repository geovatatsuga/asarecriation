package com.sunweb.game.rpg.farm
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class LocalPlayerFarmInfo extends obf_2_M_853
   {
      
      public var mapId:String;
      
      public var farmId:String;
      
      public var templetCode:String;
      
      public var name:String;
      
      public var ownerId:String;
      
      public var currentLevel:int = 1;
      
      public var farmExp:int = 0;
      
      public var styleCode:String;
      
      public function LocalPlayerFarmInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","farmId:string","templetCode:string","name:string","ownerId:string","currentLevel:byte","farmExp:int","styleCode:string"];
      }
   }
}

