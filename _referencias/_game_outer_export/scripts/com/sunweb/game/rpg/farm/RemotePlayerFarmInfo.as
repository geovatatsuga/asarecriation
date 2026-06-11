package com.sunweb.game.rpg.farm
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class RemotePlayerFarmInfo extends obf_2_M_853
   {
      
      public var mapId:String;
      
      public var farmId:String;
      
      public var name:String;
      
      public var ownerId:String;
      
      public var currentLevel:int = 1;
      
      public var styleCode:String;
      
      public function RemotePlayerFarmInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","farmId:string","name:string","ownerId:string","currentLevel:byte","styleCode:string"];
      }
   }
}

