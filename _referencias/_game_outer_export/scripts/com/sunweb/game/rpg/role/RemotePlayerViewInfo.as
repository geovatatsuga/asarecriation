package com.sunweb.game.rpg.role
{
   import com.sunweb.game.rpg.animal.AnimalInfo;
   import com.sunweb.game.rpg.farm.RemotePlayerFarmInfo;
   import com.sunweb.game.rpg.pet.PetBriefInfo;
   import com.sunweb.game.rpg.ride.RideBriefInfo;
   
   public class RemotePlayerViewInfo extends RoleBaseInfo
   {
      
      public var vipLevel:int;
      
      public var titleIndex:int;
      
      public var equipments:Array;
      
      public var equipmentModels:Object;
      
      public var attributes:RoleAttributesInfo;
      
      public var lifeJob:int;
      
      public var lifeLevel:int;
      
      public var farmSkillLevelArray:Array;
      
      public var mainFarm:RemotePlayerFarmInfo;
      
      public var extraFarmArray:Array;
      
      public var familyName:String;
      
      public var postLevel:int;
      
      public var postName:String;
      
      public var mateName:String;
      
      public var mateRelation:int;
      
      public var pet:PetBriefInfo;
      
      public var usingRide:RideBriefInfo;
      
      public var honorValue:int;
      
      public var honorLevel:int;
      
      public var pkValue:int;
      
      public var rebornTimes:int;
      
      public var constellation:int;
      
      public var animalAtr:AnimalInfo;
      
      public function RemotePlayerViewInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return super.getFieldList().concat(["vipLevel:byte","titleIndex:short","equipments:array(com.sunweb.game.rpg.gameItem.GameItemBriefInfo)","equipmentModels:map(byte,string)","attributes:com.sunweb.game.rpg.role.RoleAttributesInfo","lifeJob:byte","lifeLevel:byte","farmSkillLevelArray:array(byte)","mainFarm:com.sunweb.game.rpg.farm.RemotePlayerFarmInfo","extraFarmArray:array(com.sunweb.game.rpg.farm.RemotePlayerFarmInfo)","familyName:string","postLevel:ubyte","postName:string","mateName:string","mateRelation:byte","pet:com.sunweb.game.rpg.pet.PetBriefInfo","usingRide:com.sunweb.game.rpg.ride.RideBriefInfo","honorValue:int","honorLevel:byte","pkValue:byte","rebornTimes:byte","constellation:byte","animalAtr:com.sunweb.game.rpg.animal.AnimalInfo"]);
      }
   }
}

