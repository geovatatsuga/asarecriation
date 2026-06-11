package com.sunweb.game.rpg.role
{
   import com.sunweb.game.rpg.farm.LocalPlayerFarmInfo;
   import com.sunweb.game.rpg.farm.obf_3_U_4495;
   import com.sunweb.game.rpg.mate.MateRelationInfo;
   import com.sunweb.game.rpg.script.DynamicVars;
   import com.sunweb.game.rpg.world.map.MapPoint;
   
   public class LocalPlayerInfo extends RoleBaseInfo
   {
      
      public var isGM:Boolean;
      
      public var vipLevel:int;
      
      public var mapId:String;
      
      public var position:MapPoint;
      
      public var pathArrayReversed:Array;
      
      public var buffs:Array;
      
      public var rideCode:String;
      
      public var rideMasterPlayerId:String;
      
      public var rideGuestPlayerIds:Array;
      
      public var titleIndex:int;
      
      public var kitTitleIndex:int;
      
      public var isDead:Boolean;
      
      public var isSitting:Boolean;
      
      public var exp:Number;
      
      public var attributes:RoleAttributesInfo;
      
      public var statusFlags:int;
      
      public var gold:Number;
      
      public var money:int;
      
      public var coin:int;
      
      public var vipExp:int;
      
      public var lifeJob:int;
      
      public var lifeLevel:int;
      
      public var lifeExp:int;
      
      public var farmSkillLevelArray:Array;
      
      public var farmSkillExpArray:Array;
      
      public var mainFarm:LocalPlayerFarmInfo;
      
      public var extraFarmArray:Array;
      
      public var pkMode:int;
      
      public var pkValue:int;
      
      public var lineIndex:int;
      
      public var mateRelationInfo:MateRelationInfo;
      
      public var mateVars:DynamicVars;
      
      public var bkHp:int;
      
      public var bkHpMax:int;
      
      public var bkMp:int;
      
      public var bkMpMax:int;
      
      public var petBkHp:int;
      
      public var petBkHpMax:int;
      
      public var petBkMp:int;
      
      public var petBkMpMax:int;
      
      public var honorValue:int;
      
      public var honorLevel:int;
      
      public var freeAttrPt:int;
      
      public var rebornTimes:int;
      
      public var side:int;
      
      public var payMarks:int;
      
      public var charmValue:int;
      
      public var charmInt:int;
      
      public var beliefGod:int;
      
      public var beliefLevel:int;
      
      public var armoryExp:int;
      
      public var armoryLevel:int;
      
      public var armoryGridInfo:Array;
      
      public var maxLevel:int;
      
      public var mapHonorValues:Object;
      
      public var dragonExp:int;
      
      public var dragonLevel:int;
      
      public var dragonUpChanceNum:int;
      
      public var isAntoHp:Boolean;
      
      public var isAntoMp:Boolean;
      
      public var consecutiveLoginDays:int;
      
      public var boonItemCode:String;
      
      public var stirpLevel:int;
      
      public var potentialLevel:int;
      
      public var potentialValue:int;
      
      public var refineLevel:int;
      
      public var lightLevel:int;
      
      public var boneLevel:int;
      
      public var constellation:int;
      
      public var constellationLevel:int;
      
      public var constellationTaskId:int;
      
      public var luckLevel:int;
      
      public var hartLevel:int;
      
      public var gameTimes:int;
      
      public var arenaIntegral:int;
      
      public var towerValue:int;
      
      public var pearlNumMap:Object;
      
      public var serverDateTime:String;
      
      public var modelCode:String;
      
      public function LocalPlayerInfo()
      {
         super();
      }
      
      public function getFarmSkillExpByKind(param1:int) : int
      {
         if(param1 == obf_3_U_4495.PLANT)
         {
            return this.farmSkillExpArray[0];
         }
         if(param1 == obf_3_U_4495.obf_0___D_549)
         {
            return this.farmSkillExpArray[1];
         }
         if(param1 == obf_3_U_4495.obf_d_z_1837)
         {
            return this.farmSkillExpArray[2];
         }
         if(param1 == obf_3_U_4495.obf_A_q_1072)
         {
            return this.farmSkillExpArray[3];
         }
         return 0;
      }
      
      public function getFarmSkillLevelByKind(param1:int) : int
      {
         if(param1 == obf_3_U_4495.PLANT)
         {
            return this.farmSkillLevelArray[0];
         }
         if(param1 == obf_3_U_4495.obf_0___D_549)
         {
            return this.farmSkillLevelArray[1];
         }
         if(param1 == obf_3_U_4495.obf_d_z_1837)
         {
            return this.farmSkillLevelArray[2];
         }
         if(param1 == obf_3_U_4495.obf_A_q_1072)
         {
            return this.farmSkillLevelArray[3];
         }
         return 0;
      }
      
      public function getMaxFarmSkillLevel() : int
      {
         return Math.max(this.getFarmSkillLevelByKind(obf_3_U_4495.PLANT),this.getFarmSkillLevelByKind(obf_3_U_4495.obf_d_z_1837),this.getFarmSkillLevelByKind(obf_3_U_4495.obf_0___D_549),this.getFarmSkillLevelByKind(obf_3_U_4495.obf_A_q_1072));
      }
      
      public function getFarmInfoByFullID(param1:String) : LocalPlayerFarmInfo
      {
         var _loc3_:LocalPlayerFarmInfo = null;
         var _loc2_:Array = [this.mainFarm].concat(this.extraFarmArray);
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.farmId + "@" + _loc3_.mapId == param1)
            {
               return _loc3_;
            }
         }
         return null;
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
         return super.getFieldList().concat(["isGM:boolean","vipLevel:byte","mapId:string","position:com.sunweb.game.rpg.world.map.MapPoint","pathArrayReversed:array(com.sunweb.game.rpg.world.map.MapPoint)","buffs:array(com.sunweb.game.rpg.buff.BuffInfo)","rideCode:string","rideMasterPlayerId:string","rideGuestPlayerIds:array(string)","titleIndex:short","kitTitleIndex:short","isDead:boolean","isSitting:boolean","exp:double","attributes:com.sunweb.game.rpg.role.RoleAttributesInfo","statusFlags:int","gold:double","money:int","coin:int","vipExp:int","lifeJob:byte","lifeLevel:byte","lifeExp:int","farmSkillLevelArray:array(byte)","farmSkillExpArray:array(int)","mainFarm:com.sunweb.game.rpg.farm.LocalPlayerFarmInfo","extraFarmArray:array(com.sunweb.game.rpg.farm.LocalPlayerFarmInfo)","pkMode:byte","pkValue:byte","lineIndex:byte","mateRelationInfo:com.sunweb.game.rpg.mate.MateRelationInfo","mateVars:com.sunweb.game.rpg.script.DynamicVars","bkHp:int","bkHpMax:int","bkMp:int","bkMpMax:int","petBkHp:int","petBkHpMax:int"
         ,"petBkMp:int","petBkMpMax:int","honorValue:int","honorLevel:byte","freeAttrPt:int","rebornTimes:byte","side:byte","payMarks:int","charmValue:int","charmInt:int","beliefGod:byte","beliefLevel:byte","armoryLevel:byte","armoryGridInfo:array(string)","armoryExp:int","maxLevel:short","mapHonorValues:map(string,int)","dragonLevel:int","dragonExp:int","dragonUpChanceNum:vint","isAntoHp:boolean","isAntoMp:boolean","consecutiveLoginDays:int","boonItemCode:string","stirpLevel:int","potentialLevel:ubyte","potentialValue:int","refineLevel:byte","lightLevel:byte","boneLevel:byte","constellation:ubyte","constellationLevel:ubyte","constellationTaskId:int","luckLevel:ubyte","hartLevel:ubyte","gameTimes:ubyte","arenaIntegral:short","towerValue:int","pearlNumMap:map(string,ushort)","serverDateTime:string","modelCode:string"]);
      }
   }
}

