package com.sunweb.game.rpg.role
{
   import com.sunweb.game.rpg.animal.AnimalInfo;
   import com.sunweb.game.rpg.genie.GenieBriefInfo;
   import com.sunweb.game.rpg.pet.PetBriefInfo;
   import com.sunweb.game.rpg.playerDevil.DevilBriefInfo;
   import com.sunweb.game.rpg.world.map.MapPoint;
   
   public class RemotePlayerInfo extends RoleBaseInfo
   {
      
      public var isGM:Boolean;
      
      public var vipLevel:int;
      
      public var walkSpeed:int;
      
      public var mapId:String;
      
      public var position:MapPoint;
      
      public var pathArrayReversed:Array;
      
      public var buffs:Array;
      
      public var equipmentModels:Object;
      
      public var rideCode:String;
      
      public var rideMasterPlayerId:String;
      
      public var rideGuestPlayerIds:Array;
      
      public var titleIndex:int;
      
      public var teamName:String;
      
      public var isTeamLeader:Boolean;
      
      public var isDead:Boolean;
      
      public var isSitting:Boolean;
      
      public var familyName:String;
      
      public var postLevel:int;
      
      public var postName:String;
      
      public var pkMode:int;
      
      public var pkValue:int;
      
      public var statusFlags:int;
      
      public var mateName:String;
      
      public var mateRelation:int;
      
      public var pet:PetBriefInfo;
      
      public var genie:GenieBriefInfo;
      
      public var devil:DevilBriefInfo;
      
      public var animal:AnimalInfo;
      
      public var isBooth:Boolean;
      
      public var boothTitle:String;
      
      public var honorLevel:int;
      
      public var rebornTimes:int;
      
      public var side:int;
      
      public var isBless:Boolean;
      
      public var blessCode:String;
      
      public var blessLevel:int;
      
      public var dragonLevel:int;
      
      public var modelCode:String;
      
      public var isShowRide:Boolean;
      
      public var rideModel:String;
      
      public function RemotePlayerInfo()
      {
         super();
      }
      
      public function get pathArray() : Array
      {
         return this.pathArrayReversed != null ? this.pathArrayReversed.concat().reverse() : null;
      }
      
      public function set pathArray(param1:Array) : void
      {
         if(param1)
         {
            this.pathArrayReversed = param1.concat().reverse();
         }
         else
         {
            this.pathArrayReversed = null;
         }
      }
      
      override public function getFieldList() : Array
      {
         return super.getFieldList().concat(["isGM:boolean","vipLevel:byte","walkSpeed:short","mapId:string","position:com.sunweb.game.rpg.world.map.MapPoint","pathArrayReversed:array(com.sunweb.game.rpg.world.map.MapPoint)","buffs:array(com.sunweb.game.rpg.buff.BuffInfo)","equipmentModels:map(byte,string)","rideCode:string","rideMasterPlayerId:string","rideGuestPlayerIds:array(string)","titleIndex:short","teamName:string","isTeamLeader:boolean","isDead:boolean","isSitting:boolean","familyName:string","postLevel:ubyte","postName:string","pkMode:byte","pkValue:byte","statusFlags:int","mateName:string","mateRelation:byte","pet:com.sunweb.game.rpg.pet.PetBriefInfo","genie:com.sunweb.game.rpg.genie.GenieBriefInfo","devil:com.sunweb.game.rpg.playerDevil.DevilBriefInfo","animal:com.sunweb.game.rpg.animal.AnimalInfo","isBooth:boolean","boothTitle:string","honorLevel:byte","rebornTimes:byte","side:byte","isBless:boolean","blessCode:string","blessLevel:byte","dragonLevel:int","modelCode:string","isShowRide:boolean"
         ,"rideModel:string"]);
      }
   }
}

