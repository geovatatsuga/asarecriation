package com.sunweb.game.rpg.script
{
   import obf_b_2_1718.obf_0_8_D_73;
   import obf_r_4635.obf_R_6_1363;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.activity.obf_J_F_3431;
   import com.sunweb.game.rpg.animal.AnimalInfo;
   import com.sunweb.game.rpg.dragon.obf_Y_1494;
   import com.sunweb.game.rpg.family.obf_F_9_1495;
   import com.sunweb.game.rpg.farm.FarmTempletManager;
   import com.sunweb.game.rpg.farm.obf_0_1_N_478;
   import com.sunweb.game.rpg.farm.obf_3_U_4495;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.obf_t_v_4376;
   import com.sunweb.game.rpg.genie.GenieFullInfo;
   import com.sunweb.game.rpg.genie.ItemPlayerGenieInfo;
   import com.sunweb.game.rpg.genie.obf_P_e_2948;
   import com.sunweb.game.rpg.netRole.RemotePlayer;
   import com.sunweb.game.rpg.pet.PetFullInfo;
   import com.sunweb.game.rpg.pet.obf_c_4686;
   import com.sunweb.game.rpg.playerDevil.DevilFullInfo;
   import com.sunweb.game.rpg.playerDevil.ItemPlayerDevilInfo;
   import com.sunweb.game.rpg.playerDevil.obf_0_4_6_372;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.playerUI.pet.PetBoxUI;
   import com.sunweb.game.rpg.ride.obf_0___z_209;
   import com.sunweb.game.rpg.settingConfig.NumberConfig;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.rpg.social.FriendInfo;
   import com.sunweb.game.rpg.social.FriendManager;
   import com.sunweb.game.rpg.success.obf_j_Y_1351;
   import com.sunweb.game.rpg.task.TaskManager;
   import com.sunweb.game.rpg.team.TeamManager;
   import com.sunweb.game.rpg.team.TeamMemberInfo;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.map.MapManager;
   import com.sunweb.game.rpg.world.map.WorldMapManager;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   
   public class ConditionScript
   {
      
      public static var petInfoForCondition:PetFullInfo;
      
      public static var genieInfoForCondition:GenieFullInfo;
      
      public static var rideInfoForCondition:GameItemFullInfo;
      
      public static var devilInfoForCondition:DevilFullInfo;
      
      public static var animalInfoForCondition:AnimalInfo;
      
      private static var conditionFunObj:Object = {
         "roleLevel>=":roleLevelGE,
         "roleLevel<=":roleLevelLE,
         "roleMaxLevel>=":obf_I_N_2530,
         "roleMaxLevel<=":obf_h_0_3572,
         "roleSex=":roleSexEQ,
         "roleJob=":roleJobEQ,
         "roleExp>=":roleExpGE,
         "gold>=":goldGE,
         "gold<=":goldLE,
         "money>=":moneyGE,
         "money<=":moneyLE,
         "coin>=":coinGE,
         "coin<=":coinLE,
         "hp>=":hpGE,
         "hp<=":hpLE,
         "hpMax>=":hpMaxGE,
         "hpMax<=":hpMaxLE,
         "mp>=":mpGE,
         "mp<=":mpLE,
         "mp%>=":mpGEP,
         "mp%<=":mpLEP,
         "sp>=":spGE,
         "sp<=":spLE,
         "hp%>=":hpGEP,
         "hp%<=":hpLEP,
         "sp%>=":spGEP,
         "sp%<=":spLEP,
         "xp>=":obf_R_q_1207,
         "xp<=":obf_q_b_3299,
         "xp%>=":obf_0_5_X_413,
         "xp%<=":obf_S_j_3640,
         "strength>=":strengthGE,
         "strength<=":strengthLE,
         "agility>=":agilityGE,
         "agility<=":agilityLE,
         "wisdom>=":wisdomGE,
         "wisdom<=":wisdomLE,
         "vitality>=":vitalityGE,
         "vitality<=":vitalityLE,
         "luckyAttack>=":obf_e_U_4518,
         "bkHp<=":obf_V_7_2737,
         "bkMp<=":obf_0_B_2889,
         "isVip":isVip,
         "roleRebornTimes=":obf_0_1_m_219,
         "roleRebornTimes>=":obf_S_l_1817,
         "roleRebornTimes<=":obf_U_Z_2088,
         "vipLevel>=":vipLevelGE,
         "vipLevel<=":vipLevelLE,
         "pkValue>=":pkValueGE,
         "pkValue<=":pkValueLE,
         "SkillLevelPlant>=":skillLevelPlantGE,
         "SkillLevelPlant<=":skillLevelPlantLE,
         "SkillLevelCrop>=":skillLevelCropGE,
         "SkillLevelCrop<=":skillLevelCropLE,
         "SkillLevelAnimal>=":skillLevelAnimalGE,
         "SkillLevelAnimal<=":skillLevelAnimalLE,
         "SkillLevelMine>=":skillLevelMineGE,
         "SkillLevelMine<=":skillLevelMineLE,
         "SkillLevelMax>=":obf_G_j_3072,
         "mainBagSpace>=":mainBagSpaceGE,
         "petBagSpace>=":petBagSpaceGE,
         "rideBagSpace>=":rideBagSpaceGE,
         "genieBagSpace>=":genieBagSpaceGE,
         "lockerSpace>=":lockerSpaceGE,
         "itemsInBag":itemsInBag,
         "equalItemsInBag":equalItemsInBag,
         "hasAnyItem":hasAnyItem,
         "hasAnyItems":hasAnyItems,
         "hasNoItem":hasNoItem,
         "equipItems":equipItems,
         "equipAnyItem":equipAnyItem,
         "equipReLv":equipReLv,
         "equFusionEqu":equFusionEqu,
         "equKindFusionEqu":equKindFusionEqu,
         "equipItemsByReLv":equipItemsByReLv,
         "equipSuitAny":equipSuitAny,
         "equipAnySuit":equipAnySuit,
         "isDoingRandomTask":isDoingRandomTask,
         "isDoingTaskAny":isDoingTaskAny,
         "isOnlyDoingTasks":isOnlyDoingTasks,
         "hasDoneTask":hasDoneTask,
         "hasDoneTaskTimes":hasDoneTaskTimes,
         "hasDoneTaskAny":hasDoneTaskAny,
         "hasTaskCond":hasTaskCond,
         "hasNotTaskCond":hasNotTaskCond,
         "hasDoneSuccess":hasDoneSuccess,
         "hasDoneSuccessAny":hasDoneSuccessAny,
         "noDoneSuccess":noDoneSuccess,
         "noDoneSuccessAny":noDoneSuccessAny,
         "hasKilledMonster":hasKilledMonster,
         "hasKilledMonsterOfSuccess":hasKilledMonsterOfSuccess,
         "isInMyFarm":isInMyFarm,
         "isFarmRenamed":isFarmRenamed,
         "isFarmStyleChanged":isFarmStyleChanged,
         "isInAssignableFarm":isInAssignableFarm,
         "mainFarmLevel>=":mainFarmLevelGE,
         "mainFarmLevel<=":mainFarmLevelLE,
         "friendNumber>=":obf_3_h_923,
         "maxFriendRelLevel>=":maxFriendRelLevel,
         "hasTeam":hasTeam,
         "isTeamLeader":isTeamLeader,
         "teamMember>=":teamMemberGE,
         "teamMember<=":teamMemberLE,
         "isPairedTeam":isPairedTeam,
         "isUnmateTeam":isUnmateTeam,
         "isMateTeam":isMateTeam,
         "teamNetPlayerAllInMap":teamNetPlayerAllInMap,
         "teamMateRelType=":isTeamMateRelType,
         "teamFriendRelLevel>=":teamFriendRelLevelGE,
         "mateRelType=":isMateRelType,
         "hasMate":hasMate,
         "mateValue>=":mateValueGE,
         "mateGold>=":mateGoldGE,
         "canGotoMate":nullFunction,
         "canSummonMate":nullFunction,
         "hasLifeJob":hasLifeJob,
         "hasTitle":hasTitle,
         "lifeJob=":isLifeJob,
         "lifeLevel>=":lifeLevelGE,
         "lifeLevel<=":lifeLevelLE,
         "lifeLevel=":lifeLevelIs,
         "canLifeLevelUp":canLifeLevelUp,
         "hasAnyBuff":hasAnyBuff,
         "hasNoBuffs":hasNoBuffs,
         "isInMap":isInMap,
         "isNotInMap":isNotInMap,
         "isRiding":isRiding,
         "isInCombat":isInCombat,
         "hasFamily":hasFamily,
         "familyLevel>=":familyLevelGE,
         "familyLevel<=":familyLevelLE,
         "familyGold>=":familyGoldGE,
         "familyGold<=":familyGoldLE,
         "familyPost>=":familyPostGE,
         "familyPost<=":familyPostLE,
         "familyGx>=":familyGxGE,
         "familyGx<=":familyGxLE,
         "familyRes1>=":familyRes1GE,
         "familyRes2>=":familyRes2GE,
         "familyRes3>=":familyRes3GE,
         "family=sysStrVar":familyIsSysStrVar,
         "familyExp>=":familyExpGE,
         "familyExp<=":familyExpLE,
         "isLdzLeader":isLdzLeader,
         "isLdzMember":isLdzMember,
         "hasAnySkill":hasAnySkill,
         "hasNoSkill":hasNoSkill,
         "hasAllSkill":hasAllSkill,
         "hasAnySkillLevel":hasAnySkillLevel,
         "hasAllSkillLevel":hasAllSkillLevel,
         "jobSkPtUsed>=":obf_A_y_4607,
         "jobSkPtUsed<=":obf_O_4_3320,
         "freeJobSkPt>=":freeJobSkPtGE,
         "freeJobSkPt<=":freeJobSkPtLE,
         "freeAttrPt>=":freeAttrPtGE,
         "freeAttrPt<=":freeAttrPtLE,
         "isInAnyActivity":isInAnyActivity,
         "monsterNumber>=":monsterNumberGE,
         "monsterNumber<=":monsterNumberLE,
         "harvestNumber>=":obf_h_H_2820,
         "harvestNumber<=":obf_C_L_2488,
         "playerNumber>=":playerNumberGE,
         "playerNumber<=":playerNumberLE,
         "genieLevel<=":genieLevelLE,
         "genieLevel>=":genieLevelGE,
         "genieExp>=":genieExpGE,
         "constellationLevel>=":constellationLevelGE,
         "constellationLevel<=":constellationLevelLE,
         "hartLevel>=":obf_U_X_4321,
         "hartLevel<=":obf_0_3_p_270,
         "canAddGenieLifeApt":canAddGenieLifeApt,
         "canAddGeniePhysicsAttackApt":canAddGeniePhysicsAttackApt,
         "canAddGeniePhysicsDefenseApt":canAddGeniePhysicsDefenseApt,
         "canAddGenieMagicAttackApt":canAddGenieMagicAttackApt,
         "canAddGenieMagicDefenseApt":canAddGenieMagicDefenseApt,
         "canAddGenieCureApt":canAddGenieCureApt,
         "devilLevel<=":devilLevelLE,
         "devilLevel>=":devilLevelGE,
         "devilExp>=":devilExpGE,
         "canAddDevilLifeApt":canAddDevilLifeApt,
         "canAddDevilPhysicsAttackApt":canAddDevilPhysicsAttackApt,
         "canAddDevilPhysicsDefenseApt":canAddDevilPhysicsDefenseApt,
         "canAddDevilMagicAttackApt":canAddDevilMagicAttackApt,
         "canAddDevilMagicDefenseApt":canAddDevilMagicDefenseApt,
         "canAddDevilCureApt":canAddDevilCureApt,
         "petLevel>=":petLevelGE,
         "petLevel<=":petLevelLE,
         "petExp>=":petExpGE,
         "petSex=":petSexIs,
         "petHp>=":petHPGE,
         "petHp<=":petHPLE,
         "petMp>=":petMPGE,
         "petMp<=":petMPLE,
         "petBkHp<=":petBkHpLE,
         "petBkMp<=":petBkMpLE,
         "petFreeAttrPt>=":petFreeAttrPtGE,
         "petFreeAttrPt<=":petFreeAttrPtLE,
         "loy>=":petLoyGE,
         "loy<=":petLoyLE,
         "petLife>=":petLifeGE,
         "petLife<=":petLifeLE,
         "petStrength>=":petStrengthGE,
         "petStrength<=":petStrengthLE,
         "petAgility>=":petAgilityGE,
         "petAgility<=":petAgilityLE,
         "petWisdom>=":petWisdomGE,
         "petWisdom<=":petWisdomLE,
         "petVitality>=":petVitalityGE,
         "petVitality<=":petVitalityLE,
         "petGeneration>=":petGenerationGE,
         "petGeneration<=":petGenerationLE,
         "petEnhanceLevel>=":petEnhanceLevelGE,
         "petEnhanceLevel<=":petEnhanceLevelLE,
         "fateValue>=":obf_H_T_1359,
         "fateValue<=":obf_J_c_2209,
         "honorValue>=":obf_R_8_1120,
         "honorValue<=":obf_y_T_3814,
         "canOpenPetSkillSlot":canOpenPetSkillSlot,
         "hasNullPetSkillSlot":hasNullPetSkillSlot,
         "hasAnyPetSkill":hasAnyPetSkill,
         "petSkillLevel=":petSkillLevelIs,
         "petSkillLevel>=":petSkillLevelGE,
         "petSkillLevel<=":petSkillLevelLE,
         "boneValue>=":boneValueGE,
         "boneValue<=":boneValueLE,
         "hasPet":hasPet,
         "hasRide":hasRide,
         "hasGenie":hasGenie,
         "hasDevil":hasDevil,
         "hasAnimal":hasAnimal,
         "rideLevel>=":rideLevelGE,
         "rideLevel<=":rideLevelLE,
         "rideExp>=":rideExpGE,
         "canAddRideLifeApt":canAddRideLifeApt,
         "canAddRideAttackApt":canAddRideAttackApt,
         "canAddRideDefenseApt":canAddRideDefenseApt,
         "canAddRideCureApt":canAddRideCureApt,
         "honorValue>=":obf_R_8_1120,
         "honorValue<=":obf_y_T_3814,
         "honorLevel>=":obf_9_D_1330,
         "honorLevel<=":obf_0_3_B_175,
         "robotTime1<=":obf_t_3_1762,
         "robotTime2<=":obf_6_w_1752,
         "side=":obf_F_5_1777,
         "charmValue>=":charmValueGE,
         "charmValue<=":charmValueLE,
         "charmInt>=":charmIntGE,
         "charmInt<=":charmIntLE,
         "beliefGod=":beliefGodIs,
         "beliefLevel>=":beliefLevelGE,
         "beliefLevel<=":beliefLevelLE,
         "mapDmgRank>=":mapDPSRankGE,
         "mapDmgRank<=":mapDPSRankLE,
         "mapDmg>=":mapDmgGE,
         "mapDmg<=":mapDmgLE,
         "mapHonor>=":mapHonorGE,
         "mapHonor<=":mapHonorLE,
         "ranking>=":rankingGE,
         "ranking<=":rankingLE,
         "mapHonorLevel>=":mapHonorLevelGE,
         "mapHonorLevel<=":mapHonorLevelLE,
         "armyTitleValue>=":obf_B_m_1738,
         "armyTitleValue<=":obf_q_l_2890,
         "armyTitleLevel>=":obf_U_a_2970,
         "armyTitleLevel<=":obf_0_4_Y_57,
         "dragonLevel>=":dragonLevelGE,
         "dragonLevel<=":dragonLevelLE,
         "sysCond":sysCond,
         "mapCond":mapCond,
         "appointPetCode":appointPetCode,
         "petCond":petCond,
         "appointRideCode":appointRideCode,
         "rideCond":rideCond,
         "appointGenieCode":appointGenieCode,
         "genieCond":genieCond,
         "devilCond":devilCond,
         "appointAnimalCode":appointAnimalCode,
         "animalCond":animalCond,
         "animalHp>=":animalHpGE,
         "animalHp<=":animalHpLE,
         "animalStrength>=":animalStrengthGE,
         "animalStrength<=":animalStrengthLE,
         "animalAgility>=":animalAgilityGE,
         "animalAgility<=":animalAgilityLE,
         "animalWisdom>=":animalWisdomGE,
         "animalWisdom<=":animalWisdomLE,
         "animalVitality>=":animalVitalityGE,
         "animalVitality<=":animalVitalityLE,
         "animalType":animalTypeEQ,
         "callSkillLevel>=":callSkillLevelGE,
         "callSkillLevel<=":callSkillLevelLE,
         "monsterManualNum>=":obf_c_B_2961,
         "monsterManualNum<=":obf_0_4_D_605,
         "manualCodeAbsorb>=":manualCodeAbsorbGE,
         "manualCodeAbsorb<=":manualCodeAbsorbLE,
         "hasAnyAnimalSkill":hasAnyAnimalSkill,
         "fantasyLv>=":obf_1_1_2398,
         "legendLv>=":legendLvGE,
         "epicLv>=":obf_j_c_2522,
         "miracleLv>=":obf_L_x_1460,
         "skySoulLevel>=":skySoulLevelGE,
         "skySoulLevel<=":skySoulLevelLE,
         "terraSoulLevel>=":obf_3_d_1306,
         "terraSoulLevel<=":obf_P_1_4086,
         "deitySoulLevel>=":obf_c_o_n_s_t_224,
         "deitySoulLevel<=":obf_T_1_2281,
         "babyLevel>=":obf_W_I_1249,
         "stirpLevel>=":obf_p_G_2613,
         "stirpLevel<=":obf_p_r_1427,
         "offerFavorLevel>=":offerFavorLevelGE,
         "isRobot":isRobotEQ,
         "reGrowLevel>=":obf_D_K_4164,
         "reGrowLevel<=":obf_i_r_3263,
         "creatures>=":obf_T_v_2987,
         "creatures<=":obf_U_2_3674,
         "chartLevel>=":obf_0_7_M_311,
         "chartLevel<=":obf_0_5_r_243,
         "canAddGodExp":canAddGodExp,
         "isOpenBook":isOpenBook,
         "ranksNumGE":ranksNumGE
      };
      
      public static var mainConditionSet:Array = ["roleLevel>=","roleLevel<=","roleMaxLevel>=","roleMaxLevel<=","roleSex=","roleJob=","lifeJob=","roleRebornTimes=","hasLifeJob","lifeLevel>=","lifeLevel<=","lifeLevel=","mainFarmLevel>=","mainFarmLevel<=","hasDoneTask","hasDoneTaskTimes","hasDoneTaskAny","SkillLevelPlant>=","SkillLevelPlant<=","SkillLevelCrop>=","SkillLevelCrop<=","SkillLevelAnimal>=","SkillLevelAnimal<=","SkillLevelMine>=","SkillLevelMine<=","SkillLevelMax>=","hasAnyBuff","boolVar=","intVar=","intVar>","intVar<","strVar=","isPairedTeam","isUnmateTeam","isMateTeam","teamMateRelType=","teamFriendRelLevel>=","mateRelType=","hasMate","mateBoolVar=","mateIntVar=","mateIntVar>=","mateIntVar<=","familyBoolVar=","familyIntVar=","familyIntVar>=","familyIntVar<=","petEnhanceLevel>=","petEnhanceLevel<="];
      
      public function ConditionScript()
      {
         super();
      }
      
      public static function checkCondition(param1:Object, param2:DynamicVars = null, param3:Boolean = false, param4:Boolean = true) : Boolean
      {
         var _loc5_:String = null;
         if(!GameContext.localPlayer)
         {
            return false;
         }
         if(!petInfoForCondition)
         {
            petInfoForCondition = GameContext.localPlayer.petFullInfo;
         }
         if(!genieInfoForCondition)
         {
            genieInfoForCondition = GameContext.localPlayer.genieFullInfo;
         }
         if(!rideInfoForCondition)
         {
            rideInfoForCondition = obf_K_e_3075.playerFullInfoUI.getEquipRideInfo();
         }
         if(!devilInfoForCondition)
         {
            devilInfoForCondition = GameContext.localPlayer.devilFullInfo;
         }
         if(!animalInfoForCondition)
         {
            animalInfoForCondition = GameContext.localPlayer.trainerFullInfo;
         }
         for(_loc5_ in param1)
         {
            if(!obf_H_E_2430(param1,_loc5_))
            {
               if(param3)
               {
                  WindowManager.showMessageBox(getConditionHTML(_loc5_,param1[_loc5_]));
               }
               if(param4)
               {
                  obf_5_3_2661();
               }
               return false;
            }
         }
         if(param4)
         {
            obf_5_3_2661();
         }
         return true;
      }
      
      public static function obf_H_E_2430(param1:Object, param2:String) : Boolean
      {
         if(!conditionFunObj[param2])
         {
            obf_x_0_1295.obf_r_w_3556("obf_________39:" + param2);
            return false;
         }
         if(!isEmptyPar(param1[param2]))
         {
            return conditionFunObj[param2].call(null,param1[param2]);
         }
         return true;
      }
      
      public static function updateDynamicVarsCondition() : void
      {
         if(Boolean(GameContext.localPlayer) && Boolean(GameContext.localPlayer.dynamicVars))
         {
            conditionFunObj["boolVar="] = GameContext.localPlayer.dynamicVars.boolVarsEQ;
            conditionFunObj["intVar="] = GameContext.localPlayer.dynamicVars.intVarsEQ;
            conditionFunObj["intVar>"] = GameContext.localPlayer.dynamicVars.intVarsGT;
            conditionFunObj["intVar<"] = GameContext.localPlayer.dynamicVars.intVarsLT;
            conditionFunObj["intVar>="] = GameContext.localPlayer.dynamicVars.intVarsGE;
            conditionFunObj["intVar<="] = GameContext.localPlayer.dynamicVars.intVarsLE;
            conditionFunObj["strVar="] = GameContext.localPlayer.dynamicVars.strVarsEQ;
         }
         if(JSONUtil.getObject(GameContext.localPlayer,["fullInfo","mateVars"]))
         {
            conditionFunObj["mateBoolVar="] = GameContext.localPlayer.fullInfo.mateVars.boolVarsEQ;
            conditionFunObj["mateIntVar="] = GameContext.localPlayer.fullInfo.mateVars.intVarsEQ;
            conditionFunObj["mateIntVar>="] = GameContext.localPlayer.fullInfo.mateVars.intVarsGE;
            conditionFunObj["mateIntVar<="] = GameContext.localPlayer.fullInfo.mateVars.intVarsLE;
         }
         if(DynamicVars.systemVar)
         {
            conditionFunObj["sysBoolVar="] = DynamicVars.systemVar.boolVarsEQ;
            conditionFunObj["sysStrVar="] = DynamicVars.systemVar.strVarsEQ;
            conditionFunObj["sysIntVar="] = DynamicVars.systemVar.intVarsEQ;
            conditionFunObj["sysIntVar>="] = DynamicVars.systemVar.intVarsGE;
            conditionFunObj["sysIntVar<="] = DynamicVars.systemVar.intVarsLT;
         }
         if(DynamicVars.mapVar)
         {
            conditionFunObj["mapBoolVar="] = DynamicVars.mapVar.boolVarsEQ;
            conditionFunObj["mapIntVar="] = DynamicVars.mapVar.intVarsEQ;
            conditionFunObj["mapIntVar>="] = DynamicVars.mapVar.intVarsGE;
            conditionFunObj["mapIntVar<="] = DynamicVars.mapVar.intVarsLT;
         }
         if(DynamicVars.familyVar)
         {
            conditionFunObj["familyBoolVar="] = DynamicVars.familyVar.boolVarsEQ;
            conditionFunObj["familyIntVar="] = DynamicVars.familyVar.intVarsEQ;
            conditionFunObj["familyIntVar>="] = DynamicVars.familyVar.intVarsGE;
            conditionFunObj["familyIntVar<="] = DynamicVars.familyVar.intVarsLT;
         }
      }
      
      public static function isEmptyPar(param1:*) : Boolean
      {
         if(param1 == null)
         {
            return true;
         }
         if(param1 is int || param1 is Number || param1 is Boolean)
         {
            return false;
         }
         if(param1 is Array)
         {
            return (param1 as Array).length == 0;
         }
         if(param1 is String)
         {
            return param1 as String == "";
         }
         if(param1 is Object)
         {
            return JSONUtil.obf_P_M_2133(param1 as Object);
         }
         return false;
      }
      
      public static function getConditionsHTML(param1:Object, param2:Boolean = true) : String
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc3_:String = "";
         var _loc4_:Array = new Array();
         for(_loc5_ in param1)
         {
            _loc4_.push(_loc5_);
         }
         _loc4_.sort();
         for each(_loc6_ in _loc4_)
         {
            _loc3_ += getConditionHTML(_loc6_,param1[_loc6_],false,false) + "\n";
         }
         if(param2)
         {
            obf_5_3_2661();
         }
         return _loc3_;
      }
      
      public static function getConditionHTML(param1:String, param2:*, param3:Boolean = false, param4:Boolean = true) : String
      {
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          * Instruction count: 9644
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
      }
      
      public static function obf_5_3_2661() : void
      {
         petInfoForCondition = null;
         genieInfoForCondition = null;
         rideInfoForCondition = null;
         animalInfoForCondition = null;
      }
      
      public static function nullFunction(param1:* = null) : Boolean
      {
         return true;
      }
      
      public static function roleLevelGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.level >= param1;
      }
      
      public static function roleLevelLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.level <= param1;
      }
      
      public static function obf_I_N_2530(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.maxLevel >= param1;
      }
      
      public static function obf_h_0_3572(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.maxLevel <= param1;
      }
      
      public static function roleSexEQ(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         if(param1 == -1)
         {
            return true;
         }
         return GameContext.localPlayer.fullInfo.sex == param1;
      }
      
      public static function roleJobEQ(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         if(param1 == -1)
         {
            return true;
         }
         return GameContext.localPlayer.fullInfo.jobCode == param1;
      }
      
      public static function roleExpGE(param1:int) : Boolean
      {
         return GameContext.localPlayer.fullInfo.exp >= param1;
      }
      
      public static function hpGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.attributes.hp >= param1;
      }
      
      public static function hpLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.attributes.hp <= param1;
      }
      
      public static function hpMaxGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.attributes.hpMax >= param1;
      }
      
      public static function hpMaxLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.attributes.hpMax <= param1;
      }
      
      public static function hpGEP(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.hpPercent >= param1;
      }
      
      public static function hpLEP(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.hpPercent <= param1;
      }
      
      public static function mpGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.attributes.mp >= param1;
      }
      
      public static function mpLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.attributes.mp <= param1;
      }
      
      public static function mpGEP(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.attributes.mp / GameContext.localPlayer.fullInfo.attributes.mpMax * 100 >= param1;
      }
      
      public static function mpLEP(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.attributes.mp / GameContext.localPlayer.fullInfo.attributes.mpMax * 100 <= param1;
      }
      
      public static function spGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.attributes.sp >= param1;
      }
      
      public static function spLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.attributes.sp <= param1;
      }
      
      public static function spGEP(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.attributes.sp / GameContext.localPlayer.fullInfo.attributes.spMax >= param1 / 100;
      }
      
      public static function spLEP(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.attributes.sp / GameContext.localPlayer.fullInfo.attributes.spMax <= param1 / 100;
      }
      
      public static function obf_R_q_1207(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.attributes.xp >= param1;
      }
      
      public static function obf_q_b_3299(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.attributes.xp <= param1;
      }
      
      public static function obf_0_5_X_413(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.attributes.xp / GameContext.localPlayer.fullInfo.attributes.xpMax >= param1;
      }
      
      public static function obf_S_j_3640(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.attributes.xp / GameContext.localPlayer.fullInfo.attributes.xpMax <= param1;
      }
      
      public static function strengthGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.attributes.strength >= param1;
      }
      
      public static function strengthLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.attributes.strength <= param1;
      }
      
      public static function agilityGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.attributes.agility >= param1;
      }
      
      public static function agilityLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.attributes.agility <= param1;
      }
      
      public static function wisdomGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.attributes.wisdom >= param1;
      }
      
      public static function wisdomLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.attributes.wisdom <= param1;
      }
      
      public static function vitalityGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.attributes.vitality >= param1;
      }
      
      public static function vitalityLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.attributes.vitality <= param1;
      }
      
      public static function obf_e_U_4518(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.attributes.luckyAttack >= param1;
      }
      
      public static function obf_V_7_2737(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.bkHp <= param1;
      }
      
      public static function obf_0_B_2889(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.bkMp <= param1;
      }
      
      public static function isVip(param1:Boolean) : Boolean
      {
         return GameContext.localPlayer.fullInfo.vipLevel > 0 == param1;
      }
      
      public static function obf_0_1_m_219(param1:int) : Boolean
      {
         return GameContext.localPlayer.fullInfo.rebornTimes == param1;
      }
      
      public static function obf_S_l_1817(param1:int) : Boolean
      {
         return GameContext.localPlayer.fullInfo.rebornTimes >= param1;
      }
      
      public static function obf_U_Z_2088(param1:int) : Boolean
      {
         return GameContext.localPlayer.fullInfo.rebornTimes <= param1;
      }
      
      public static function vipLevelGE(param1:int) : Boolean
      {
         return GameContext.localPlayer.fullInfo.vipLevel >= param1;
      }
      
      public static function vipLevelLE(param1:int) : Boolean
      {
         return GameContext.localPlayer.fullInfo.vipLevel <= param1;
      }
      
      public static function pkValueGE(param1:int) : Boolean
      {
         return GameContext.localPlayer.pkValue >= param1;
      }
      
      public static function pkValueLE(param1:int) : Boolean
      {
         return GameContext.localPlayer.pkValue <= param1;
      }
      
      public static function goldGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.gold >= param1;
      }
      
      public static function goldLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.gold <= param1;
      }
      
      public static function moneyGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.money >= param1;
      }
      
      public static function moneyLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.money <= param1;
      }
      
      public static function coinGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.coin >= param1;
      }
      
      public static function coinLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.coin <= param1;
      }
      
      public static function skillLevelPlantGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         if(param1 <= 0)
         {
            return true;
         }
         return GameContext.localPlayer.fullInfo.getFarmSkillLevelByKind(obf_3_U_4495.PLANT) >= param1;
      }
      
      public static function skillLevelPlantLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         if(param1 <= 0)
         {
            return true;
         }
         return GameContext.localPlayer.fullInfo.getFarmSkillLevelByKind(obf_3_U_4495.PLANT) <= param1;
      }
      
      public static function skillLevelCropGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         if(param1 <= 0)
         {
            return true;
         }
         return GameContext.localPlayer.fullInfo.getFarmSkillLevelByKind(obf_3_U_4495.obf_0___D_549) >= param1;
      }
      
      public static function skillLevelCropLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         if(param1 <= 0)
         {
            return true;
         }
         return GameContext.localPlayer.fullInfo.getFarmSkillLevelByKind(obf_3_U_4495.obf_0___D_549) <= param1;
      }
      
      public static function skillLevelAnimalGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         if(param1 <= 0)
         {
            return true;
         }
         return GameContext.localPlayer.fullInfo.getFarmSkillLevelByKind(obf_3_U_4495.obf_d_z_1837) >= param1;
      }
      
      public static function skillLevelAnimalLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         if(param1 <= 0)
         {
            return true;
         }
         return GameContext.localPlayer.fullInfo.getFarmSkillLevelByKind(obf_3_U_4495.obf_d_z_1837) <= param1;
      }
      
      public static function skillLevelMineGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         if(param1 <= 0)
         {
            return true;
         }
         return GameContext.localPlayer.fullInfo.getFarmSkillLevelByKind(obf_3_U_4495.obf_A_q_1072) >= param1;
      }
      
      public static function skillLevelMineLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         if(param1 <= 0)
         {
            return true;
         }
         return GameContext.localPlayer.fullInfo.getFarmSkillLevelByKind(obf_3_U_4495.obf_A_q_1072) <= param1;
      }
      
      public static function obf_G_j_3072(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         if(!GameContext.localPlayer)
         {
            return false;
         }
         for each(_loc2_ in GameContext.localPlayer.fullInfo.farmSkillLevelArray)
         {
            if(_loc2_ >= param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function mainBagSpaceGE(param1:int) : Boolean
      {
         if(!obf_K_e_3075.playerBagUI)
         {
            return false;
         }
         return obf_K_e_3075.playerBagUI.haveEmptyBag(param1);
      }
      
      private static function petBagSpaceGE(param1:int) : Boolean
      {
         if(!obf_K_e_3075.petBoxUI)
         {
            return false;
         }
         return obf_K_e_3075.petBoxUI.getEnptyBag() >= param1;
      }
      
      public static function lockerSpaceGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return obf_K_e_3075.tempBagUI.haveEmptyBag(param1);
      }
      
      public static function rideBagSpaceGE(param1:int) : Boolean
      {
         if(!obf_K_e_3075.rideBoxUI)
         {
            return false;
         }
         return obf_K_e_3075.rideBoxUI.haveEmptyBag(param1);
      }
      
      public static function genieBagSpaceGE(param1:int) : Boolean
      {
         if(!obf_K_e_3075.genieBoxUI)
         {
            return false;
         }
         return obf_K_e_3075.genieBoxUI.haveEmptyBag(param1);
      }
      
      public static function devilBagSpaceGE(param1:int) : Boolean
      {
         if(!obf_K_e_3075.playerDevilUI)
         {
            return false;
         }
         return obf_K_e_3075.playerDevilUI.haveEmptyBag(param1);
      }
      
      public static function itemsInBag(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         if(!obf_K_e_3075.playerBagUI)
         {
            return false;
         }
         for(_loc2_ in param1)
         {
            if(obf_K_e_3075.playerBagUI.getItemCount(_loc2_) < param1[_loc2_] && obf_K_e_3075.petBoxUI.getItemCount(_loc2_) < param1[_loc2_] && obf_K_e_3075.rideBoxUI.getItemCount(_loc2_) < param1[_loc2_] && obf_K_e_3075.genieBoxUI.getItemCount(_loc2_) < param1[_loc2_])
            {
               return false;
            }
         }
         return true;
      }
      
      public static function equalItemsInBag(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         if(!obf_K_e_3075.playerBagUI)
         {
            return false;
         }
         for(_loc2_ in param1)
         {
            if(GameContext.bagItemManager.getHaveItemCount(_loc2_,true) < param1[_loc2_])
            {
               return false;
            }
         }
         return true;
      }
      
      public static function hasAnyItem(param1:Array) : Boolean
      {
         if(obf_K_e_3075.playerBagUI)
         {
            if(obf_K_e_3075.playerBagUI.hasAnyItem(param1))
            {
               return true;
            }
         }
         if(obf_K_e_3075.rideBoxUI)
         {
            if(obf_K_e_3075.rideBoxUI.hasAnyItem(param1))
            {
               return true;
            }
         }
         if(obf_K_e_3075.petBoxUI)
         {
            if(obf_K_e_3075.petBoxUI.hasAnyItem(param1))
            {
               return true;
            }
         }
         if(obf_K_e_3075.genieBoxUI)
         {
            if(obf_K_e_3075.genieBoxUI.hasAnyItem(param1))
            {
               return true;
            }
         }
         if(obf_K_e_3075.playerDevilUI)
         {
            if(obf_K_e_3075.playerDevilUI.hasAnyItem(param1))
            {
               return true;
            }
         }
         return false;
      }
      
      public static function hasAnyItems(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         for(_loc2_ in param1)
         {
            if(GameContext.bagItemManager.getHaveItemCount(_loc2_) >= param1[_loc2_])
            {
               return true;
            }
         }
         return false;
      }
      
      public static function hasNoItem(param1:Array) : Boolean
      {
         if(!obf_K_e_3075.playerBagUI || !obf_K_e_3075.rideBoxUI)
         {
            return false;
         }
         return !obf_K_e_3075.playerBagUI.hasAnyItem(param1) && !obf_K_e_3075.rideBoxUI.hasAnyItem(param1) && !obf_K_e_3075.petBoxUI.hasAnyItem(param1);
      }
      
      public static function equipItems(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         if(!obf_K_e_3075.playerFullInfoUI)
         {
            return false;
         }
         for each(_loc2_ in param1)
         {
            if(!obf_K_e_3075.playerFullInfoUI.obf_C_K_1175(_loc2_))
            {
               return false;
            }
         }
         return true;
      }
      
      public static function equipAnyItem(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         if(!obf_K_e_3075.playerFullInfoUI)
         {
            return false;
         }
         for each(_loc2_ in param1)
         {
            if(obf_K_e_3075.playerFullInfoUI.obf_C_K_1175(_loc2_))
            {
               return true;
            }
         }
         return false;
      }
      
      public static function equipReLv(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:GameItemFullInfo = null;
         for(_loc2_ in param1)
         {
            _loc3_ = obf_K_e_3075.playerFullInfoUI.getEquipItemInfo(int(_loc2_));
            if(!_loc3_ || _loc3_.equipmentInfo.refineLevel < param1[_loc2_])
            {
               return false;
            }
         }
         return true;
      }
      
      public static function equFusionEqu(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:GameItemFullInfo = null;
         if(!GameContext.localPlayer || !obf_K_e_3075.playerFullInfoUI)
         {
            return false;
         }
         for(_loc2_ in param1)
         {
            _loc3_ = obf_K_e_3075.playerFullInfoUI.getEquipItemInfoByCode(_loc2_);
            if(!_loc3_ || JSONUtil.getStr(_loc3_.equipmentInfo,["fusionEquCode"]) != param1[_loc2_])
            {
               return false;
            }
         }
         return true;
      }
      
      public static function equKindFusionEqu(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:GameItemFullInfo = null;
         if(!GameContext.localPlayer || !obf_K_e_3075.playerFullInfoUI)
         {
            return false;
         }
         for(_loc2_ in param1)
         {
            _loc3_ = obf_K_e_3075.playerFullInfoUI.getEquipItemInfo(int(_loc2_));
            if(!_loc3_ || JSONUtil.getStr(_loc3_.equipmentInfo,["fusionEquCode"]) != param1[_loc2_])
            {
               return false;
            }
         }
         return true;
      }
      
      public static function equipItemsByReLv(param1:Object) : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         var _loc5_:GameItemFullInfo = null;
         var _loc2_:Object = obf_K_e_3075.playerFullInfoUI.equipInfo;
         if(!_loc2_)
         {
            return false;
         }
         for(_loc3_ in param1)
         {
            _loc4_ = GameItemManager.getItemConfig(_loc3_);
            if(!_loc4_)
            {
               return false;
            }
            _loc5_ = _loc2_[JSONUtil.getInt(_loc4_,["properties","kind"])];
            if(JSONUtil.getStr(_loc5_,["itemCode"]) != _loc3_ || JSONUtil.getInt(_loc5_,["equipmentInfo","refineLevel"],-1) < param1[_loc3_])
            {
               return false;
            }
         }
         return true;
      }
      
      public static function equipSuitAny(param1:Array) : Boolean
      {
         var _loc3_:String = null;
         var _loc2_:Object = obf_t_v_4376.getPlayerEquipSuit();
         for each(_loc3_ in param1)
         {
            if(_loc2_[_loc3_])
            {
               if(_loc2_[_loc3_] >= obf_t_v_4376.getSuitEquipCount(_loc3_))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public static function equipAnySuit(param1:Boolean) : Boolean
      {
         var _loc3_:String = null;
         var _loc2_:Object = obf_t_v_4376.getPlayerEquipSuit();
         for(_loc3_ in _loc2_)
         {
            if(_loc2_[_loc3_] >= obf_t_v_4376.getSuitEquipCount(_loc3_))
            {
               return true == param1;
            }
         }
         return false;
      }
      
      public static function isDoingRandomTask(param1:int) : Boolean
      {
         return TaskManager.isDoingAllocator(param1);
      }
      
      public static function isDoingTaskAny(param1:Array) : Boolean
      {
         var _loc2_:int = 0;
         for each(_loc2_ in param1)
         {
            if(TaskManager.doingTasks.indexOf(_loc2_) > -1)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function isOnlyDoingTasks(param1:Array) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         for each(_loc2_ in param1)
         {
            if(TaskManager.doingTasks.indexOf(_loc2_) == -1)
            {
               return false;
            }
         }
         for each(_loc3_ in TaskManager.doingTasks)
         {
            if(param1.indexOf(_loc3_) == -1)
            {
               return false;
            }
         }
         return true;
      }
      
      public static function hasDoneTask(param1:Array) : Boolean
      {
         var _loc2_:int = 0;
         for each(_loc2_ in param1)
         {
            if(!TaskManager.doneTasks[_loc2_] || TaskManager.doneTasks[_loc2_] <= 0)
            {
               return false;
            }
         }
         return true;
      }
      
      public static function hasDoneTaskTimes(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         for(_loc2_ in param1)
         {
            if(!TaskManager.doneTasks[_loc2_] || TaskManager.doneTasks[_loc2_] < param1[_loc2_])
            {
               return false;
            }
         }
         return true;
      }
      
      public static function hasDoneTaskAny(param1:Array) : Boolean
      {
         var _loc2_:int = 0;
         for each(_loc2_ in param1)
         {
            if(JSONUtil.getInt(TaskManager.doneTasks,[_loc2_]) > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function hasTaskCond(param1:int) : Boolean
      {
         if(param1 == 0)
         {
            return true;
         }
         var _loc2_:Object = TaskManager.getTaskObjById(param1);
         if(!_loc2_)
         {
            return false;
         }
         return checkCondition(JSONUtil.getObject(_loc2_,["finishRule","condition"]));
      }
      
      public static function hasNotTaskCond(param1:int) : Boolean
      {
         if(param1 == 0)
         {
            return true;
         }
         var _loc2_:Object = TaskManager.getTaskObjById(param1);
         if(!_loc2_)
         {
            return false;
         }
         return !checkCondition(JSONUtil.getObject(_loc2_,["finishRule","condition"]));
      }
      
      public static function hasDoneSuccess(param1:Array) : Boolean
      {
         var _loc2_:int = 0;
         for each(_loc2_ in param1)
         {
            if(!obf_j_Y_1351.successIsDone(_loc2_))
            {
               return false;
            }
         }
         return true;
      }
      
      public static function hasDoneSuccessAny(param1:Array) : Boolean
      {
         var _loc2_:int = 0;
         for each(_loc2_ in param1)
         {
            if(obf_j_Y_1351.successIsDone(_loc2_))
            {
               return true;
            }
         }
         return false;
      }
      
      public static function noDoneSuccess(param1:Array) : Boolean
      {
         var _loc2_:int = 0;
         for each(_loc2_ in param1)
         {
            if(obf_j_Y_1351.successIsDone(_loc2_))
            {
               return false;
            }
         }
         return true;
      }
      
      public static function noDoneSuccessAny(param1:Array) : Boolean
      {
         var _loc2_:int = 0;
         for each(_loc2_ in param1)
         {
            if(obf_j_Y_1351.successIsDone(_loc2_))
            {
               return true;
            }
         }
         return false;
      }
      
      public static function hasKilledMonster(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         if(!GameContext.localPlayer)
         {
            return false;
         }
         for(_loc2_ in param1)
         {
            if(!GameContext.localPlayer.obf_i_S_846 || GameContext.localPlayer.obf_i_S_846.intVarLT(_loc2_,param1[_loc2_]))
            {
               return false;
            }
         }
         return true;
      }
      
      public static function hasKilledMonsterOfSuccess(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         if(!obf_j_Y_1351.dynamicVars)
         {
            return false;
         }
         for(_loc2_ in param1)
         {
            if(!obf_j_Y_1351.dynamicVars || obf_j_Y_1351.dynamicVars.intVarLT(_loc2_,param1[_loc2_]))
            {
               return false;
            }
         }
         return true;
      }
      
      public static function isInMyFarm(param1:Boolean) : Boolean
      {
         var _loc2_:obf_0_1_N_478 = GameContext.localPlayer.getFarm();
         var _loc3_:Boolean = Boolean(_loc2_) && _loc2_.ownerId == GameContext.localPlayer.id;
         return _loc3_ == param1;
      }
      
      public static function isFarmRenamed(param1:Boolean) : Boolean
      {
         return GameContext.localPlayer.fullInfo.mainFarm.name != FarmTempletManager.getFarmTemplet(GameContext.localPlayer.fullInfo.mainFarm.templetCode).name == param1;
      }
      
      public static function isFarmStyleChanged(param1:Boolean) : Boolean
      {
         return !obf_L_l_4100.isEmpty(GameContext.localPlayer.fullInfo.mainFarm.styleCode) == param1;
      }
      
      public static function isInAssignableFarm(param1:Boolean) : Boolean
      {
         if(!GameContext.currentMap)
         {
            return false;
         }
         var _loc2_:obf_0_1_N_478 = GameContext.localPlayer.getFarm();
         return (_loc2_ && JSONUtil.getBoolean(WorldMapManager.getMapConfig(_loc2_.getMap().mapId),["isAssignable"]) && _loc2_.templetCode == WorldConfig.getStringSetting("assignableFarmCode") && obf_L_l_4100.isEmpty(_loc2_.ownerId)) == param1;
      }
      
      public static function mainFarmLevelGE(param1:int) : Boolean
      {
         return GameContext.localPlayer.fullInfo.mainFarm.currentLevel >= param1;
      }
      
      public static function mainFarmLevelLE(param1:int) : Boolean
      {
         return GameContext.localPlayer.fullInfo.mainFarm.currentLevel <= param1;
      }
      
      public static function obf_3_h_923(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         if(FriendManager.friendList)
         {
            _loc2_ = int(FriendManager.friendList.length);
         }
         return _loc2_ >= param1;
      }
      
      public static function maxFriendRelLevel(param1:int) : Boolean
      {
         var _loc2_:FriendInfo = null;
         for each(_loc2_ in FriendManager.friendList)
         {
            if(FriendManager.getFriendRelLevel(_loc2_.relationValue) >= param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function hasTeam(param1:Boolean) : Boolean
      {
         return GameContext.localPlayer.hasTeam() == param1;
      }
      
      public static function isTeamLeader(param1:Boolean) : Boolean
      {
         return TeamManager.isLeader == param1;
      }
      
      public static function teamMemberGE(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         if(TeamManager.teamMembers)
         {
            _loc2_ = int(TeamManager.teamMembers.length);
         }
         return _loc2_ >= param1;
      }
      
      public static function teamMemberLE(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         if(TeamManager.teamMembers)
         {
            _loc2_ = int(TeamManager.teamMembers.length);
         }
         return _loc2_ <= param1;
      }
      
      public static function isPairedTeam(param1:Boolean) : Boolean
      {
         var _loc2_:TeamMemberInfo = null;
         if(!TeamManager.teamMembers || TeamManager.teamMembers.length != 2)
         {
            return false == param1;
         }
         for each(_loc2_ in TeamManager.teamMembers)
         {
            if(!_loc2_ || !_loc2_.isOnline)
            {
               return false == param1;
            }
            if(_loc2_.name != GameContext.localPlayer.id)
            {
               if(_loc2_.sex != GameContext.localPlayer.fullInfo.sex)
               {
                  return true == param1;
               }
            }
         }
         return false == param1;
      }
      
      public static function isUnmateTeam(param1:Boolean) : Boolean
      {
         var _loc2_:TeamMemberInfo = null;
         if(!TeamManager.teamMembers || TeamManager.teamMembers.length != 2)
         {
            return false == param1;
         }
         for each(_loc2_ in TeamManager.teamMembers)
         {
            if(!_loc2_ || !obf_L_l_4100.isEmpty(_loc2_.mateName) || !_loc2_.isOnline)
            {
               return false == param1;
            }
            if(_loc2_.name != GameContext.localPlayer.id)
            {
               if(_loc2_.sex != GameContext.localPlayer.fullInfo.sex)
               {
                  return true == param1;
               }
            }
         }
         return false == param1;
      }
      
      public static function isMateTeam(param1:Boolean) : Boolean
      {
         var _loc2_:TeamMemberInfo = null;
         if(isPairedTeam(false))
         {
            return false == param1;
         }
         for each(_loc2_ in TeamManager.teamMembers)
         {
            if(!_loc2_ || !_loc2_.isOnline || !GameContext.localPlayer.fullInfo.mateRelationInfo)
            {
               return false == param1;
            }
            if(_loc2_.name != GameContext.localPlayer.id)
            {
               if(_loc2_.name != GameContext.localPlayer.fullInfo.mateRelationInfo.mateName)
               {
                  return false == param1;
               }
            }
         }
         return true == param1;
      }
      
      public static function isTeamMateRelType(param1:int) : Boolean
      {
         var _loc2_:TeamMemberInfo = null;
         if(!TeamManager.teamMembers || TeamManager.teamMembers.length != 2)
         {
            return false;
         }
         for each(_loc2_ in TeamManager.teamMembers)
         {
            if(!_loc2_ || !_loc2_.isOnline || !GameContext.localPlayer.fullInfo.mateRelationInfo)
            {
               return false;
            }
            if(_loc2_.name != GameContext.localPlayer.id)
            {
               if(_loc2_.name == GameContext.localPlayer.fullInfo.mateRelationInfo.mateName && GameContext.localPlayer.fullInfo.mateRelationInfo.relationType == param1)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public static function teamFriendRelLevelGE(param1:int) : Boolean
      {
         var _loc2_:TeamMemberInfo = null;
         if(!TeamManager.teamMembers || TeamManager.teamMembers.length != 2)
         {
            return false;
         }
         for each(_loc2_ in TeamManager.teamMembers)
         {
            if(!_loc2_ || !_loc2_.isOnline)
            {
               return false;
            }
            if(_loc2_.name != GameContext.localPlayer.id)
            {
               if(FriendManager.haveFriend(_loc2_.name) && FriendManager.getFriendRelLevel(FriendManager.getFriendInfoById(_loc2_.name).relationValue) >= param1)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public static function isMateRelType(param1:int) : Boolean
      {
         if(Boolean(GameContext.localPlayer.fullInfo.mateRelationInfo) && GameContext.localPlayer.fullInfo.mateRelationInfo.relationType == param1)
         {
            return true;
         }
         return false;
      }
      
      public static function hasMate(param1:Boolean) : Boolean
      {
         return GameContext.localPlayer.fullInfo.mateRelationInfo != null == param1;
      }
      
      public static function mateValueGE(param1:int) : Boolean
      {
         if(Boolean(GameContext.localPlayer.fullInfo.mateRelationInfo) && GameContext.localPlayer.fullInfo.mateRelationInfo.mateValue >= param1)
         {
            return true;
         }
         return false;
      }
      
      public static function mateGoldGE(param1:int) : Boolean
      {
         if(Boolean(GameContext.localPlayer.fullInfo.mateRelationInfo) && GameContext.localPlayer.fullInfo.mateRelationInfo.mateGold >= param1)
         {
            return true;
         }
         return false;
      }
      
      public static function hasLifeJob(param1:Boolean) : Boolean
      {
         return GameContext.localPlayer.fullInfo.lifeJob > 0 == param1;
      }
      
      public static function hasTitle(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         for each(_loc2_ in GameContext.localPlayer.playerTitleList)
         {
            if(_loc2_ == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function isLifeJob(param1:int) : Boolean
      {
         return GameContext.localPlayer.fullInfo.lifeJob == param1;
      }
      
      public static function lifeLevelGE(param1:int) : Boolean
      {
         return GameContext.localPlayer.fullInfo.lifeLevel >= param1;
      }
      
      public static function lifeLevelLE(param1:int) : Boolean
      {
         return GameContext.localPlayer.fullInfo.lifeLevel <= param1;
      }
      
      public static function lifeLevelIs(param1:int) : Boolean
      {
         return GameContext.localPlayer.fullInfo.lifeLevel == param1;
      }
      
      public static function canLifeLevelUp(param1:Boolean) : Boolean
      {
         if(GameContext.localPlayer.fullInfo.lifeJob == 0 || NumberConfig.getLifeJobLevelNumber(GameContext.localPlayer.fullInfo.lifeLevel) == 0)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.lifeExp >= NumberConfig.getLifeJobLevelNumber(GameContext.localPlayer.fullInfo.lifeLevel);
      }
      
      public static function hasAnyBuff(param1:Array) : Boolean
      {
         var _loc2_:int = 0;
         for each(_loc2_ in param1)
         {
            if(GameContext.localPlayer.haveBuff(_loc2_) || GameContext.localPlayer.obf_G_3_787(_loc2_))
            {
               return true;
            }
         }
         return false;
      }
      
      public static function hasNoBuffs(param1:Array) : Boolean
      {
         var _loc2_:int = 0;
         for each(_loc2_ in param1)
         {
            if(GameContext.localPlayer.haveBuff(_loc2_))
            {
               return false;
            }
         }
         return true;
      }
      
      public static function isInMap(param1:Array) : Boolean
      {
         var _loc2_:String = null;
         if(!GameContext.currentMap)
         {
            return false;
         }
         for each(_loc2_ in param1)
         {
            if(GameContext.currentMap.mapId == _loc2_)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function isNotInMap(param1:Array) : Boolean
      {
         var _loc2_:String = null;
         if(!GameContext.currentMap)
         {
            return false;
         }
         for each(_loc2_ in param1)
         {
            if(GameContext.currentMap.mapId == _loc2_)
            {
               return false;
            }
         }
         return true;
      }
      
      public static function isRiding(param1:Boolean) : Boolean
      {
         return GameContext.localPlayer.isActiveOrPassiveRiding == param1;
      }
      
      public static function isInCombat(param1:Boolean) : Boolean
      {
         return GameContext.localPlayer.isInCombat == param1;
      }
      
      public static function hasFamily(param1:Boolean) : Boolean
      {
         return GameContext.localPlayer.hasFamily() == param1;
      }
      
      public static function familyLevelGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer.hasFamily() || !GameContext.localPlayer.familyInfo)
         {
            return false;
         }
         return GameContext.localPlayer.familyInfo.level >= param1;
      }
      
      public static function familyLevelLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer.hasFamily() || !GameContext.localPlayer.familyInfo)
         {
            return false;
         }
         return GameContext.localPlayer.familyInfo.level <= param1;
      }
      
      public static function familyGoldGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer.hasFamily() || !GameContext.localPlayer.familyInfo)
         {
            return false;
         }
         return GameContext.localPlayer.familyInfo.gold >= param1;
      }
      
      public static function familyGoldLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer.hasFamily() || !GameContext.localPlayer.familyInfo)
         {
            return false;
         }
         return GameContext.localPlayer.familyInfo.gold <= param1;
      }
      
      public static function familyPostGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer.hasFamily() || !GameContext.localPlayer.familyInfo)
         {
            return false;
         }
         return GameContext.localPlayer.familyMyInfo.postLevel >= param1;
      }
      
      public static function familyPostLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer.hasFamily() || !GameContext.localPlayer.familyInfo)
         {
            return false;
         }
         return GameContext.localPlayer.familyMyInfo.postLevel <= param1;
      }
      
      public static function familyGxGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer.hasFamily() || !GameContext.localPlayer.familyInfo)
         {
            return false;
         }
         return GameContext.localPlayer.familyMyInfo.thisFamilyGx >= param1;
      }
      
      public static function familyGxLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer.hasFamily() || !GameContext.localPlayer.familyInfo)
         {
            return false;
         }
         return GameContext.localPlayer.familyMyInfo.thisFamilyGx <= param1;
      }
      
      public static function familyRes1GE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer.hasFamily() || !GameContext.localPlayer.familyInfo)
         {
            return false;
         }
         return GameContext.localPlayer.familyInfo.res1 >= param1;
      }
      
      public static function familyRes2GE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer.hasFamily() || !GameContext.localPlayer.familyInfo)
         {
            return false;
         }
         return GameContext.localPlayer.familyInfo.res2 >= param1;
      }
      
      public static function familyRes3GE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer.hasFamily() || !GameContext.localPlayer.familyInfo)
         {
            return false;
         }
         return GameContext.localPlayer.familyInfo.res3 >= param1;
      }
      
      public static function familyIsSysStrVar(param1:String) : Boolean
      {
         if(!DynamicVars.systemVar)
         {
            return false;
         }
         return DynamicVars.systemVar.strVarEQ(param1,GameContext.localPlayer.familyName);
      }
      
      public static function familyExpGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer.hasFamily() || !GameContext.localPlayer.familyInfo)
         {
            return false;
         }
         return GameContext.localPlayer.familyInfo.exp >= param1;
      }
      
      public static function familyExpLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer.hasFamily() || !GameContext.localPlayer.familyInfo)
         {
            return false;
         }
         return GameContext.localPlayer.familyInfo.exp <= param1;
      }
      
      public static function isLdzLeader(param1:Boolean) : Boolean
      {
         var _loc2_:Boolean = false;
         if(Boolean(DynamicVars.systemVar && GameContext.localPlayer.familyInfo) && Boolean(DynamicVars.systemVar.getStrVar("#ldz_winner") == GameContext.localPlayer.familyInfo.familyName) && obf_F_9_1495.isLeaderPost(GameContext.localPlayer.familyMyInfo.postLevel))
         {
            _loc2_ = true;
         }
         return _loc2_ == param1;
      }
      
      public static function isLdzMember(param1:Boolean) : Boolean
      {
         var _loc2_:Boolean = false;
         if(Boolean(DynamicVars.systemVar) && Boolean(GameContext.localPlayer.familyInfo) && DynamicVars.systemVar.getStrVar("#ldz_winner") == GameContext.localPlayer.familyInfo.familyName)
         {
            _loc2_ = true;
         }
         return _loc2_ == param1;
      }
      
      public static function hasAnySkill(param1:Array) : Boolean
      {
         var _loc2_:String = null;
         for each(_loc2_ in param1)
         {
            if(PlayerSkillManager.obf_0_6_G_255(_loc2_))
            {
               return true;
            }
         }
         return false;
      }
      
      public static function hasNoSkill(param1:Array) : Boolean
      {
         var _loc2_:String = null;
         for each(_loc2_ in param1)
         {
            if(PlayerSkillManager.obf_0_6_G_255(_loc2_))
            {
               return false;
            }
         }
         return true;
      }
      
      public static function hasAllSkill(param1:Array) : Boolean
      {
         var _loc2_:String = null;
         for each(_loc2_ in param1)
         {
            if(!PlayerSkillManager.obf_0_6_G_255(_loc2_))
            {
               return false;
            }
         }
         return true;
      }
      
      public static function hasAnySkillLevel(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         for(_loc2_ in param1)
         {
            if(PlayerSkillManager.obf_0_6_G_255(_loc2_) && PlayerSkillManager.getSkillLevel(_loc2_) >= param1[_loc2_])
            {
               return true;
            }
         }
         return false;
      }
      
      public static function hasAllSkillLevel(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         for(_loc2_ in param1)
         {
            if(!PlayerSkillManager.obf_0_6_G_255(_loc2_))
            {
               return false;
            }
            if(PlayerSkillManager.getSkillLevel(_loc2_) < param1[_loc2_])
            {
               return false;
            }
         }
         return true;
      }
      
      public static function obf_A_y_4607(param1:int) : Boolean
      {
         return PlayerSkillManager.getUsedSkillPoint() >= param1;
      }
      
      public static function obf_O_4_3320(param1:int) : Boolean
      {
         return PlayerSkillManager.getUsedSkillPoint() <= param1;
      }
      
      public static function freeJobSkPtGE(param1:int) : Boolean
      {
         return PlayerSkillManager.getOverSkillPoint() >= param1;
      }
      
      public static function freeJobSkPtLE(param1:int) : Boolean
      {
         return PlayerSkillManager.getOverSkillPoint() <= param1;
      }
      
      public static function freeAttrPtGE(param1:int) : Boolean
      {
         return GameContext.localPlayer.fullInfo.freeAttrPt >= param1;
      }
      
      public static function freeAttrPtLE(param1:int) : Boolean
      {
         return GameContext.localPlayer.fullInfo.freeAttrPt <= param1;
      }
      
      public static function isInAnyActivity(param1:Array) : Boolean
      {
         return obf_J_F_3431.obf_U_Q_3887(param1);
      }
      
      public static function monsterNumberGE(param1:int) : Boolean
      {
         if(!GameContext.currentMap)
         {
            return false;
         }
         return GameContext.currentMap.monsterSet.size >= param1;
      }
      
      public static function monsterNumberLE(param1:int) : Boolean
      {
         if(!GameContext.currentMap)
         {
            return false;
         }
         return GameContext.currentMap.monsterSet.size <= param1;
      }
      
      public static function obf_h_H_2820(param1:int) : Boolean
      {
         if(!GameContext.currentMap)
         {
            return false;
         }
         return GameContext.currentMap.obf_b_h_1770.size >= param1;
      }
      
      public static function obf_C_L_2488(param1:int) : Boolean
      {
         if(!GameContext.currentMap)
         {
            return false;
         }
         return GameContext.currentMap.obf_b_h_1770.size <= param1;
      }
      
      public static function playerNumberGE(param1:int) : Boolean
      {
         if(!GameContext.currentMap)
         {
            return false;
         }
         return GameContext.currentMap.remotePlayerSet.size + 1 >= param1;
      }
      
      public static function playerNumberLE(param1:int) : Boolean
      {
         if(!GameContext.currentMap)
         {
            return false;
         }
         return GameContext.currentMap.remotePlayerSet.size + 1 <= param1;
      }
      
      public static function genieLevelLE(param1:int) : Boolean
      {
         if(!genieInfoForCondition)
         {
            return false;
         }
         return genieInfoForCondition.level <= param1;
      }
      
      public static function genieLevelGE(param1:int) : Boolean
      {
         if(!genieInfoForCondition)
         {
            return false;
         }
         return genieInfoForCondition.level >= param1;
      }
      
      public static function genieExpGE(param1:int) : Boolean
      {
         if(!genieInfoForCondition)
         {
            return false;
         }
         return genieInfoForCondition.exp >= param1;
      }
      
      public static function devilLevelLE(param1:int) : Boolean
      {
         if(!devilInfoForCondition)
         {
            return false;
         }
         return devilInfoForCondition.level <= param1;
      }
      
      public static function devilLevelGE(param1:int) : Boolean
      {
         if(!devilInfoForCondition)
         {
            return false;
         }
         return devilInfoForCondition.level >= param1;
      }
      
      public static function devilExpGE(param1:int) : Boolean
      {
         if(!devilInfoForCondition)
         {
            return false;
         }
         return devilInfoForCondition.exp >= param1;
      }
      
      public static function canAddDevilLifeApt(param1:Boolean) : Boolean
      {
         if(!devilInfoForCondition)
         {
            return false;
         }
         var _loc2_:Object = obf_0_4_6_372.getDevilFinalApt(devilInfoForCondition as ItemPlayerDevilInfo,devilInfoForCondition.devilCode);
         var _loc3_:Object = GameItemManager.getItemConfig(devilInfoForCondition.devilCode);
         if(!_loc3_)
         {
            return false;
         }
         return _loc2_.life < JSONUtil.getInt(_loc3_,["properties","lifeAptMax"]) == param1;
      }
      
      public static function canAddDevilPhysicsAttackApt(param1:Boolean) : Boolean
      {
         if(!devilInfoForCondition)
         {
            return false;
         }
         var _loc2_:Object = obf_0_4_6_372.getDevilFinalApt(devilInfoForCondition as ItemPlayerDevilInfo,devilInfoForCondition.devilCode);
         var _loc3_:Object = GameItemManager.getItemConfig(devilInfoForCondition.devilCode);
         if(!_loc3_)
         {
            return false;
         }
         return _loc2_.physicsAttack < JSONUtil.getInt(_loc3_,["properties","physicsAttackAptMax"]) == param1;
      }
      
      public static function canAddDevilPhysicsDefenseApt(param1:Boolean) : Boolean
      {
         if(!devilInfoForCondition)
         {
            return false;
         }
         var _loc2_:Object = obf_0_4_6_372.getDevilFinalApt(devilInfoForCondition as ItemPlayerDevilInfo,devilInfoForCondition.devilCode);
         var _loc3_:Object = GameItemManager.getItemConfig(devilInfoForCondition.devilCode);
         if(!_loc3_)
         {
            return false;
         }
         return _loc2_.physicsDef < JSONUtil.getInt(_loc3_,["properties","physicsDefenseAptMax"]) == param1;
      }
      
      public static function canAddDevilMagicAttackApt(param1:Boolean) : Boolean
      {
         if(!devilInfoForCondition)
         {
            return false;
         }
         var _loc2_:Object = obf_0_4_6_372.getDevilFinalApt(devilInfoForCondition as ItemPlayerDevilInfo,devilInfoForCondition.devilCode);
         var _loc3_:Object = GameItemManager.getItemConfig(devilInfoForCondition.devilCode);
         if(!_loc3_)
         {
            return false;
         }
         return _loc2_.magicAttack < JSONUtil.getInt(_loc3_,["properties","magicAttackAptMax"]) == param1;
      }
      
      public static function canAddDevilMagicDefenseApt(param1:Boolean) : Boolean
      {
         if(!devilInfoForCondition)
         {
            return false;
         }
         var _loc2_:Object = obf_0_4_6_372.getDevilFinalApt(devilInfoForCondition as ItemPlayerDevilInfo,devilInfoForCondition.devilCode);
         var _loc3_:Object = GameItemManager.getItemConfig(devilInfoForCondition.devilCode);
         if(!_loc3_)
         {
            return false;
         }
         return _loc2_.magicDef < JSONUtil.getInt(_loc3_,["properties","magicDefenseAptMax"]) == param1;
      }
      
      public static function canAddDevilCureApt(param1:Boolean) : Boolean
      {
         if(!devilInfoForCondition)
         {
            return false;
         }
         var _loc2_:Object = obf_0_4_6_372.getDevilFinalApt(devilInfoForCondition as ItemPlayerDevilInfo,devilInfoForCondition.devilCode);
         var _loc3_:Object = GameItemManager.getItemConfig(devilInfoForCondition.devilCode);
         if(!_loc3_)
         {
            return false;
         }
         return _loc2_.cure < JSONUtil.getInt(_loc3_,["properties","cureAptMax"]) == param1;
      }
      
      public static function canAddGenieLifeApt(param1:Boolean) : Boolean
      {
         if(!genieInfoForCondition)
         {
            return false;
         }
         var _loc2_:Object = obf_P_e_2948.getGenieAptExcludeLv(genieInfoForCondition as ItemPlayerGenieInfo,genieInfoForCondition.genieCode);
         var _loc3_:Object = GameItemManager.getItemConfig(genieInfoForCondition.genieCode);
         if(!_loc3_)
         {
            return false;
         }
         return _loc2_.life < JSONUtil.getInt(_loc3_,["properties","lifeAptMax"]) == param1;
      }
      
      public static function canAddGeniePhysicsAttackApt(param1:Boolean) : Boolean
      {
         if(!genieInfoForCondition)
         {
            return false;
         }
         var _loc2_:Object = obf_P_e_2948.getGenieAptExcludeLv(genieInfoForCondition as ItemPlayerGenieInfo,genieInfoForCondition.genieCode);
         var _loc3_:Object = GameItemManager.getItemConfig(genieInfoForCondition.genieCode);
         if(!_loc3_)
         {
            return false;
         }
         return _loc2_.physicsAttack < JSONUtil.getInt(_loc3_,["properties","physicsAttackAptMax"]) == param1;
      }
      
      public static function canAddGeniePhysicsDefenseApt(param1:Boolean) : Boolean
      {
         if(!genieInfoForCondition)
         {
            return false;
         }
         var _loc2_:Object = obf_P_e_2948.getGenieAptExcludeLv(genieInfoForCondition as ItemPlayerGenieInfo,genieInfoForCondition.genieCode);
         var _loc3_:Object = GameItemManager.getItemConfig(genieInfoForCondition.genieCode);
         if(!_loc3_)
         {
            return false;
         }
         return _loc2_.physicsDef < JSONUtil.getInt(_loc3_,["properties","physicsDefenseAptMax"]) == param1;
      }
      
      public static function canAddGenieMagicAttackApt(param1:Boolean) : Boolean
      {
         if(!genieInfoForCondition)
         {
            return false;
         }
         var _loc2_:Object = obf_P_e_2948.getGenieAptExcludeLv(genieInfoForCondition as ItemPlayerGenieInfo,genieInfoForCondition.genieCode);
         var _loc3_:Object = GameItemManager.getItemConfig(genieInfoForCondition.genieCode);
         if(!_loc3_)
         {
            return false;
         }
         return _loc2_.magicAttack < JSONUtil.getInt(_loc3_,["properties","magicAttackAptMax"]) == param1;
      }
      
      public static function canAddGenieMagicDefenseApt(param1:Boolean) : Boolean
      {
         if(!genieInfoForCondition)
         {
            return false;
         }
         var _loc2_:Object = obf_P_e_2948.getGenieAptExcludeLv(genieInfoForCondition as ItemPlayerGenieInfo,genieInfoForCondition.genieCode);
         var _loc3_:Object = GameItemManager.getItemConfig(genieInfoForCondition.genieCode);
         if(!_loc3_)
         {
            return false;
         }
         return _loc2_.magicDef < JSONUtil.getInt(_loc3_,["properties","magicDefenseAptMax"]) == param1;
      }
      
      public static function canAddGenieCureApt(param1:Boolean) : Boolean
      {
         if(!genieInfoForCondition)
         {
            return false;
         }
         var _loc2_:Object = obf_P_e_2948.getGenieAptExcludeLv(genieInfoForCondition as ItemPlayerGenieInfo,genieInfoForCondition.genieCode);
         var _loc3_:Object = GameItemManager.getItemConfig(genieInfoForCondition.genieCode);
         if(!_loc3_)
         {
            return false;
         }
         return _loc2_.cure < JSONUtil.getInt(_loc3_,["properties","cureAptMax"]) == param1;
      }
      
      public static function petLevelGE(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.level >= param1;
      }
      
      public static function petLevelLE(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.level <= param1;
      }
      
      public static function petExpGE(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.exp >= param1;
      }
      
      public static function petSexIs(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.sex == param1;
      }
      
      public static function petHPGE(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.hp >= param1;
      }
      
      public static function petHPLE(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.hp <= param1;
      }
      
      public static function petMPGE(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.mp >= param1;
      }
      
      public static function petMPLE(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.mp <= param1;
      }
      
      public static function petBkHpLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.petBkHp <= param1;
      }
      
      public static function petBkMpLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.petBkMp <= param1;
      }
      
      public static function petFreeAttrPtGE(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.freeAttrPt >= param1;
      }
      
      public static function petFreeAttrPtLE(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.freeAttrPt <= param1;
      }
      
      public static function petLoyGE(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.loyalty >= param1;
      }
      
      public static function petLoyLE(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.loyalty <= param1;
      }
      
      public static function petLifeGE(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.life >= param1;
      }
      
      public static function petLifeLE(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.life <= param1;
      }
      
      public static function petStrengthGE(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.attributes.strength >= param1;
      }
      
      public static function petStrengthLE(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.attributes.strength <= param1;
      }
      
      public static function petAgilityGE(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.attributes.agility >= param1;
      }
      
      public static function petAgilityLE(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.attributes.agility <= param1;
      }
      
      public static function petWisdomGE(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.attributes.wisdom >= param1;
      }
      
      public static function petWisdomLE(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.attributes.wisdom <= param1;
      }
      
      public static function petVitalityGE(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.attributes.vitality >= param1;
      }
      
      public static function petVitalityLE(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.attributes.vitality <= param1;
      }
      
      public static function petGenerationGE(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.generation >= param1;
      }
      
      public static function petGenerationLE(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.generation <= param1;
      }
      
      public static function petEnhanceLevelGE(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.enhanceLevel <= param1;
      }
      
      public static function petEnhanceLevelLE(param1:int) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.enhanceLevel <= param1;
      }
      
      public static function obf_H_T_1359(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return obf_K_e_3075.fateSkillUI.currentSkillPoint >= param1;
      }
      
      public static function obf_J_c_2209(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return obf_K_e_3075.fateSkillUI.currentSkillPoint <= param1;
      }
      
      public static function obf_R_8_1120(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.honorValue >= param1;
      }
      
      public static function obf_y_T_3814(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.honorValue <= param1;
      }
      
      public static function canOpenPetSkillSlot(param1:Boolean) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.openedSkillNum < PetBoxUI.petSkillSlot == param1;
      }
      
      public static function hasNullPetSkillSlot(param1:Boolean) : Boolean
      {
         if(!petInfoForCondition)
         {
            return false;
         }
         return petInfoForCondition.openedSkillNum > petInfoForCondition.learnedSkillList.length == param1;
      }
      
      public static function hasAnyPetSkill(param1:Array) : Boolean
      {
         var _loc3_:String = null;
         if(!petInfoForCondition)
         {
            return false;
         }
         var _loc2_:Array = obf_c_4686.getPetSkillCodes(petInfoForCondition);
         for each(_loc3_ in param1)
         {
            if(_loc2_.indexOf(_loc3_) > -1)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function petSkillLevelIs(param1:Object) : Boolean
      {
         var _loc3_:String = null;
         if(!petInfoForCondition)
         {
            return false;
         }
         var _loc2_:Object = obf_c_4686.getPetSkillMap(petInfoForCondition);
         for(_loc3_ in param1)
         {
            if(_loc2_[_loc3_] != param1[_loc3_])
            {
               return false;
            }
         }
         return true;
      }
      
      public static function petSkillLevelGE(param1:Object) : Boolean
      {
         var _loc3_:String = null;
         if(!petInfoForCondition)
         {
            return false;
         }
         var _loc2_:Object = obf_c_4686.getPetSkillMap(petInfoForCondition);
         for(_loc3_ in param1)
         {
            if(!_loc2_.hasOwnProperty(_loc3_) || _loc2_[_loc3_] < param1[_loc3_])
            {
               return false;
            }
         }
         return true;
      }
      
      public static function petSkillLevelLE(param1:Object) : Boolean
      {
         var _loc3_:String = null;
         if(!petInfoForCondition)
         {
            return false;
         }
         var _loc2_:Object = obf_c_4686.getPetSkillMap(petInfoForCondition);
         for(_loc3_ in param1)
         {
            if(_loc2_[_loc3_] > param1[_loc3_])
            {
               return false;
            }
         }
         return true;
      }
      
      public static function hasPet(param1:Boolean) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.petFullInfo != null == param1;
      }
      
      public static function hasRide(param1:Boolean) : Boolean
      {
         return obf_K_e_3075.playerFullInfoUI.getRideBag().haveIconItem != null == param1;
      }
      
      public static function hasGenie(param1:Boolean) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.genieFullInfo != null == param1;
      }
      
      public static function hasDevil(param1:Boolean) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.devilFullInfo != null == param1;
      }
      
      public static function hasAnimal(param1:Boolean) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.trainerFullInfo != null == param1;
      }
      
      public static function rideLevelGE(param1:int) : Boolean
      {
         if(!rideInfoForCondition)
         {
            return false;
         }
         return rideInfoForCondition.rideInfo.level >= param1;
      }
      
      public static function rideLevelLE(param1:int) : Boolean
      {
         if(!rideInfoForCondition)
         {
            return false;
         }
         return rideInfoForCondition.rideInfo.level <= param1;
      }
      
      public static function rideExpGE(param1:int) : Boolean
      {
         if(!rideInfoForCondition)
         {
            return false;
         }
         return rideInfoForCondition.rideInfo.exp >= param1;
      }
      
      public static function canAddRideLifeApt(param1:Boolean) : Boolean
      {
         if(!rideInfoForCondition)
         {
            return false;
         }
         var _loc2_:Object = obf_0___z_209.getRideLevelConfig(rideInfoForCondition.rideInfo.level);
         if(!_loc2_)
         {
            return false;
         }
         return rideInfoForCondition.rideInfo.lifeAptAdded < JSONUtil.getInt(_loc2_,["availableExtraApt"]) == param1;
      }
      
      public static function canAddRideAttackApt(param1:Boolean) : Boolean
      {
         if(!rideInfoForCondition)
         {
            return false;
         }
         var _loc2_:Object = obf_0___z_209.getRideLevelConfig(rideInfoForCondition.rideInfo.level);
         if(!_loc2_)
         {
            return false;
         }
         return rideInfoForCondition.rideInfo.attackAptAdded < JSONUtil.getInt(_loc2_,["availableExtraApt"]) == param1;
      }
      
      public static function canAddRideDefenseApt(param1:Boolean) : Boolean
      {
         if(!rideInfoForCondition)
         {
            return false;
         }
         var _loc2_:Object = obf_0___z_209.getRideLevelConfig(rideInfoForCondition.rideInfo.level);
         if(!_loc2_)
         {
            return false;
         }
         return rideInfoForCondition.rideInfo.defenseAptAdded < JSONUtil.getInt(_loc2_,["availableExtraApt"]) == param1;
      }
      
      public static function canAddRideCureApt(param1:Boolean) : Boolean
      {
         if(!rideInfoForCondition)
         {
            return false;
         }
         var _loc2_:Object = obf_0___z_209.getRideLevelConfig(rideInfoForCondition.rideInfo.level);
         if(!_loc2_)
         {
            return false;
         }
         return rideInfoForCondition.rideInfo.cureAptAdded < JSONUtil.getInt(_loc2_,["availableExtraApt"]) == param1;
      }
      
      public static function obf_9_D_1330(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.honorLevel >= param1;
      }
      
      public static function obf_0_3_B_175(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.honorLevel <= param1;
      }
      
      public static function obf_t_3_1762(param1:int) : Boolean
      {
         var _loc2_:Array = obf_R_6_1363.getTimeLeftInSec();
         return _loc2_[0] <= param1;
      }
      
      public static function obf_6_w_1752(param1:int) : Boolean
      {
         var _loc2_:Array = obf_R_6_1363.getTimeLeftInSec();
         return _loc2_[1] <= param1;
      }
      
      public static function charmValueGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.charmValue >= param1;
      }
      
      public static function charmValueLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.charmValue <= param1;
      }
      
      public static function charmIntGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.charmInt >= param1;
      }
      
      public static function charmIntLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.charmInt <= param1;
      }
      
      public static function beliefGodIs(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.beliefGod == param1;
      }
      
      public static function beliefLevelGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.beliefLevel >= param1;
      }
      
      public static function beliefLevelLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.beliefLevel <= param1;
      }
      
      public static function mapDPSRankGE(param1:int) : Boolean
      {
         return MapManager.instance.getMyMapDPSRank() >= param1;
      }
      
      public static function mapDPSRankLE(param1:int) : Boolean
      {
         return MapManager.instance.getMyMapDPSRank() <= param1;
      }
      
      public static function mapDmgGE(param1:int) : Boolean
      {
         return MapManager.instance.getMyDPSValue() >= param1;
      }
      
      public static function mapDmgLE(param1:int) : Boolean
      {
         return MapManager.instance.getMyDPSValue() <= param1;
      }
      
      public static function obf_F_5_1777(param1:int) : Boolean
      {
         return GameContext.localPlayer.side == param1;
      }
      
      public static function sysCond(param1:Object) : Boolean
      {
         return checkCondition(param1);
      }
      
      public static function mapCond(param1:Object) : Boolean
      {
         return checkCondition(param1);
      }
      
      public static function petCond(param1:Object) : Boolean
      {
         return checkCondition(param1);
      }
      
      public static function genieCond(param1:Object) : Boolean
      {
         return checkCondition(param1);
      }
      
      public static function devilCond(param1:Object) : Boolean
      {
         return checkCondition(param1);
      }
      
      public static function animalCond(param1:Object) : Boolean
      {
         return checkCondition(param1);
      }
      
      public static function rideCond(param1:Object) : Boolean
      {
         return checkCondition(param1);
      }
      
      public static function teamNetPlayerAllInMap(param1:Boolean) : Boolean
      {
         var _loc2_:TeamMemberInfo = null;
         var _loc3_:RemotePlayer = null;
         if(!TeamManager.teamMembers || TeamManager.teamMembers.length <= 1 || !GameContext.currentMap)
         {
            return true;
         }
         for each(_loc2_ in TeamManager.teamMembers)
         {
            if(_loc2_.isOnline)
            {
               if(_loc2_.name != GameContext.localPlayer.id)
               {
                  _loc3_ = GameContext.currentMap.remotePlayerSet.getObject(_loc2_.name) as RemotePlayer;
                  if(!_loc3_)
                  {
                     return false == param1;
                  }
               }
            }
         }
         return true == param1;
      }
      
      public static function appointPetCode(param1:String) : Boolean
      {
         if(!GameContext.localPlayer || !GameContext.localPlayer.petFullInfo)
         {
            return false;
         }
         if(obf_K_e_3075.petBoxUI.getItemCount(param1) > 0)
         {
            return GameContext.localPlayer.petFullInfo.petCode == param1 ? true : false;
         }
         return false;
      }
      
      public static function appointRideCode(param1:String) : Boolean
      {
         if(!GameContext.localPlayer || !obf_K_e_3075.playerFullInfoUI.getEquipRideInfo())
         {
            return false;
         }
         if(obf_K_e_3075.rideBoxUI.getItemCount(param1) > 0)
         {
            return obf_K_e_3075.playerFullInfoUI.getEquipRideInfo().itemCode == param1 ? true : false;
         }
         return false;
      }
      
      public static function appointGenieCode(param1:String) : Boolean
      {
         if(!GameContext.localPlayer || !GameContext.localPlayer.genieFullInfo)
         {
            return false;
         }
         if(obf_K_e_3075.genieBoxUI.getItemCount(param1) > 0)
         {
            return GameContext.localPlayer.genieFullInfo.genieCode == param1 ? true : false;
         }
         return false;
      }
      
      public static function constellationLevelGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.constellationLevel >= param1;
      }
      
      public static function constellationLevelLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.constellationLevel <= param1;
      }
      
      public static function obf_U_X_4321(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.hartLevel >= param1;
      }
      
      public static function obf_0_3_p_270(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.hartLevel <= param1;
      }
      
      public static function boneValueGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return obf_0_8_D_73.getBoneCurrentLightAll(GameContext.localPlayer.fullInfo.boneLevel,GameContext.localPlayer.fullInfo.lightLevel) >= param1;
      }
      
      public static function boneValueLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return obf_0_8_D_73.getBoneCurrentLightAll(GameContext.localPlayer.fullInfo.boneLevel,GameContext.localPlayer.fullInfo.lightLevel) <= param1;
      }
      
      public static function dragonLevelGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return obf_Y_1494.obf_U_n_2740 >= param1;
      }
      
      public static function dragonLevelLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return obf_Y_1494.obf_U_n_2740 <= param1;
      }
      
      public static function appointAnimalCode(param1:String) : Boolean
      {
         if(!GameContext.localPlayer || !GameContext.localPlayer.trainerFullInfo)
         {
            return false;
         }
         return GameContext.localPlayer.trainerFullInfo.animalCode == param1 ? true : false;
      }
      
      public static function animalHpGE(param1:int) : Boolean
      {
         if(!animalInfoForCondition)
         {
            return false;
         }
         return animalInfoForCondition.animalAtr.hp >= param1;
      }
      
      public static function animalHpLE(param1:int) : Boolean
      {
         if(!animalInfoForCondition)
         {
            return false;
         }
         return animalInfoForCondition.animalAtr.hp <= param1;
      }
      
      public static function animalStrengthGE(param1:int) : Boolean
      {
         if(!animalInfoForCondition)
         {
            return false;
         }
         return animalInfoForCondition.animalAtr.strength >= param1;
      }
      
      public static function animalStrengthLE(param1:int) : Boolean
      {
         if(!animalInfoForCondition)
         {
            return false;
         }
         return animalInfoForCondition.animalAtr.strength <= param1;
      }
      
      public static function animalAgilityGE(param1:int) : Boolean
      {
         if(!animalInfoForCondition)
         {
            return false;
         }
         return animalInfoForCondition.animalAtr.agility >= param1;
      }
      
      public static function animalAgilityLE(param1:int) : Boolean
      {
         if(!animalInfoForCondition)
         {
            return false;
         }
         return animalInfoForCondition.animalAtr.agility <= param1;
      }
      
      public static function animalWisdomGE(param1:int) : Boolean
      {
         if(!animalInfoForCondition)
         {
            return false;
         }
         return animalInfoForCondition.animalAtr.wisdom >= param1;
      }
      
      public static function animalWisdomLE(param1:int) : Boolean
      {
         if(!animalInfoForCondition)
         {
            return false;
         }
         return animalInfoForCondition.animalAtr.wisdom <= param1;
      }
      
      public static function animalVitalityGE(param1:int) : Boolean
      {
         if(!animalInfoForCondition)
         {
            return false;
         }
         return animalInfoForCondition.animalAtr.vitality >= param1;
      }
      
      public static function animalVitalityLE(param1:int) : Boolean
      {
         if(!animalInfoForCondition)
         {
            return false;
         }
         return animalInfoForCondition.animalAtr.vitality <= param1;
      }
      
      public static function animalTypeEQ(param1:int) : Boolean
      {
         if(!animalInfoForCondition)
         {
            return false;
         }
         return animalInfoForCondition.type == param1;
      }
      
      public static function callSkillLevelGE(param1:int) : Boolean
      {
         if(!animalInfoForCondition)
         {
            return false;
         }
         return animalInfoForCondition.level >= param1;
      }
      
      public static function callSkillLevelLE(param1:int) : Boolean
      {
         if(!animalInfoForCondition)
         {
            return false;
         }
         return animalInfoForCondition.level <= param1;
      }
      
      public static function obf_c_B_2961(param1:int) : Boolean
      {
         return false;
      }
      
      public static function obf_0_4_D_605(param1:int) : Boolean
      {
         return false;
      }
      
      public static function hasAnyAnimalSkill(param1:Array) : Boolean
      {
         var _loc3_:String = null;
         if(!animalInfoForCondition)
         {
            return false;
         }
         var _loc2_:Array = animalInfoForCondition.animalAtr.skillArray;
         for each(_loc3_ in param1)
         {
            if(_loc2_.indexOf(_loc3_) > -1)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function mapHonorGE(param1:Object) : Boolean
      {
         var _loc3_:String = null;
         if(!GameContext.localPlayer || !GameContext.localPlayer.fullInfo.mapHonorValues)
         {
            return false;
         }
         var _loc2_:Object = GameContext.localPlayer.fullInfo.mapHonorValues;
         for(_loc3_ in param1)
         {
            if(_loc2_[_loc3_] < param1[_loc3_])
            {
               return false;
            }
         }
         return true;
      }
      
      public static function mapHonorLE(param1:Object) : Boolean
      {
         var _loc3_:String = null;
         if(!GameContext.localPlayer || !GameContext.localPlayer.fullInfo.mapHonorValues)
         {
            return false;
         }
         var _loc2_:Object = GameContext.localPlayer.fullInfo.mapHonorValues;
         for(_loc3_ in param1)
         {
            if(_loc2_[_loc3_] > param1[_loc3_])
            {
               return false;
            }
         }
         return true;
      }
      
      public static function rankingGE(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         if(!GameContext.localPlayer)
         {
            return false;
         }
         for(_loc2_ in param1)
         {
            _loc3_ = obf_K_e_3075.rankingUI.getLocalTier(int(_loc2_));
            if(_loc3_ < param1[_loc2_])
            {
               return false;
            }
         }
         return true;
      }
      
      public static function rankingLE(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         if(!GameContext.localPlayer)
         {
            return false;
         }
         for(_loc2_ in param1)
         {
            _loc3_ = obf_K_e_3075.rankingUI.getLocalTier(int(_loc2_));
            if(_loc3_ > param1[_loc2_])
            {
               return false;
            }
         }
         return true;
      }
      
      public static function mapHonorLevelGE(param1:Object) : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         if(!GameContext.localPlayer || !GameContext.localPlayer.fullInfo.mapHonorValues)
         {
            return false;
         }
         var _loc2_:Object = GameContext.localPlayer.fullInfo.mapHonorValues;
         for(_loc3_ in param1)
         {
            _loc4_ = int(_loc2_[_loc3_]);
            _loc6_ = NumberConfig.getSettingObject("mapHonorLevelValues") as Array;
            _loc7_ = 0;
            while(_loc7_ < _loc6_.length)
            {
               if(_loc6_[_loc7_] <= _loc4_)
               {
                  _loc5_ = _loc7_;
               }
               _loc7_++;
            }
            if(_loc5_ < param1[_loc3_])
            {
               return false;
            }
         }
         return true;
      }
      
      public static function mapHonorLevelLE(param1:Object) : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         if(!GameContext.localPlayer || !GameContext.localPlayer.fullInfo.mapHonorValues)
         {
            return false;
         }
         var _loc2_:Object = GameContext.localPlayer.fullInfo.mapHonorValues;
         for(_loc3_ in param1)
         {
            _loc4_ = int(_loc2_[_loc3_]);
            _loc6_ = NumberConfig.getSettingObject("mapHonorLevelValues") as Array;
            _loc7_ = 0;
            while(_loc7_ < _loc6_.length)
            {
               if(_loc6_[_loc7_] <= _loc4_)
               {
                  _loc5_ = _loc7_;
               }
               _loc7_++;
            }
            if(_loc5_ > param1[_loc3_])
            {
               return false;
            }
         }
         return true;
      }
      
      public static function obf_B_m_1738(param1:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         if(!GameContext.localPlayer || !GameContext.localPlayer.fullInfo.mapHonorValues)
         {
            return false;
         }
         var _loc2_:Object = GameContext.localPlayer.fullInfo.mapHonorValues;
         if(!_loc2_)
         {
            return false;
         }
         for each(_loc4_ in _loc2_)
         {
            _loc3_ += int(_loc4_);
         }
         if(_loc3_ < param1)
         {
            return false;
         }
         return true;
      }
      
      public static function obf_q_l_2890(param1:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         if(!GameContext.localPlayer || !GameContext.localPlayer.fullInfo.mapHonorValues)
         {
            return false;
         }
         var _loc2_:Object = GameContext.localPlayer.fullInfo.mapHonorValues;
         if(!_loc2_)
         {
            return false;
         }
         for each(_loc4_ in _loc2_)
         {
            _loc3_ += int(_loc4_);
         }
         if(_loc3_ > param1)
         {
            return false;
         }
         return true;
      }
      
      public static function obf_U_a_2970(param1:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         if(!GameContext.localPlayer || !GameContext.localPlayer.fullInfo.mapHonorValues)
         {
            return false;
         }
         var _loc2_:Object = GameContext.localPlayer.fullInfo.mapHonorValues;
         if(!_loc2_)
         {
            return false;
         }
         for each(_loc4_ in _loc2_)
         {
            _loc3_ += int(_loc4_);
         }
         _loc6_ = NumberConfig.getSettingObject("armyTitleValues") as Array;
         _loc7_ = 0;
         while(_loc7_ < _loc6_.length)
         {
            if(_loc6_[_loc7_] <= _loc3_)
            {
               _loc5_ = _loc7_;
            }
            _loc7_++;
         }
         return _loc5_ >= param1;
      }
      
      public static function obf_0_4_Y_57(param1:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         if(!GameContext.localPlayer || !GameContext.localPlayer.fullInfo.mapHonorValues)
         {
            return false;
         }
         var _loc2_:Object = GameContext.localPlayer.fullInfo.mapHonorValues;
         if(!_loc2_)
         {
            return false;
         }
         for each(_loc4_ in _loc2_)
         {
            _loc3_ += int(_loc4_);
         }
         _loc6_ = NumberConfig.getSettingObject("armyTitleValues") as Array;
         _loc7_ = 0;
         while(_loc7_ < _loc6_.length)
         {
            if(_loc6_[_loc7_] <= _loc3_)
            {
               _loc5_ = _loc7_;
            }
            _loc7_++;
         }
         return _loc5_ <= param1;
      }
      
      public static function obf_1_1_2398(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return obf_K_e_3075.towerBoxUI.getTxtLvObject[GameItemRank.FANTASY] >= param1;
      }
      
      public static function legendLvGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return obf_K_e_3075.towerBoxUI.getTxtLvObject[GameItemRank.LEGEND] >= param1;
      }
      
      public static function obf_j_c_2522(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return obf_K_e_3075.towerBoxUI.getTxtLvObject[GameItemRank.EPIC] >= param1;
      }
      
      public static function obf_L_x_1460(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return obf_K_e_3075.towerBoxUI.getTxtLvObject[GameItemRank.obf_f_l_943] >= param1;
      }
      
      public static function manualCodeAbsorbGE(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(!GameContext.localPlayer)
         {
            return false;
         }
         for(_loc2_ in param1)
         {
            _loc3_ = obf_K_e_3075.manualUI.spareTimes(_loc2_);
            _loc4_ = int(_loc3_.split(":")[1]);
            if(_loc4_ < param1[_loc2_])
            {
               return false;
            }
         }
         return true;
      }
      
      public static function manualCodeAbsorbLE(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(!GameContext.localPlayer)
         {
            return false;
         }
         for(_loc2_ in param1)
         {
            _loc3_ = obf_K_e_3075.manualUI.spareTimes(_loc2_);
            _loc4_ = int(_loc3_.split(":")[1]);
            if(_loc4_ > param1[_loc2_])
            {
               return false;
            }
         }
         return true;
      }
      
      public static function skySoulLevelGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer || !obf_K_e_3075.obf_J_K_2135)
         {
            return false;
         }
         return obf_K_e_3075.obf_J_K_2135.skyLv >= param1;
      }
      
      public static function skySoulLevelLE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer || !obf_K_e_3075.obf_J_K_2135)
         {
            return false;
         }
         return obf_K_e_3075.obf_J_K_2135.skyLv <= param1;
      }
      
      public static function obf_3_d_1306(param1:int) : Boolean
      {
         if(!GameContext.localPlayer || !obf_K_e_3075.obf_J_K_2135)
         {
            return false;
         }
         return obf_K_e_3075.obf_J_K_2135.terraLv >= param1;
      }
      
      public static function obf_P_1_4086(param1:int) : Boolean
      {
         if(!GameContext.localPlayer || !obf_K_e_3075.obf_J_K_2135)
         {
            return false;
         }
         return obf_K_e_3075.obf_J_K_2135.terraLv <= param1;
      }
      
      public static function obf_c_o_n_s_t_224(param1:int) : Boolean
      {
         if(!GameContext.localPlayer || !obf_K_e_3075.obf_J_K_2135)
         {
            return false;
         }
         return obf_K_e_3075.obf_J_K_2135.godLv >= param1;
      }
      
      public static function obf_T_1_2281(param1:int) : Boolean
      {
         if(!GameContext.localPlayer || !obf_K_e_3075.obf_J_K_2135)
         {
            return false;
         }
         return obf_K_e_3075.obf_J_K_2135.godLv <= param1;
      }
      
      public static function obf_W_I_1249(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return obf_K_e_3075.obf_7_S_4368.currentLv >= param1;
      }
      
      public static function obf_p_G_2613(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.stirpLevel >= param1;
      }
      
      public static function obf_p_r_1427(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return GameContext.localPlayer.fullInfo.stirpLevel <= param1;
      }
      
      public static function offerFavorLevelGE(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return obf_K_e_3075.favorUI.getOfferFavorValue() >= param1;
      }
      
      public static function isRobotEQ(param1:Boolean) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return obf_R_6_1363.isRuning == param1;
      }
      
      public static function obf_D_K_4164(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return obf_K_e_3075.obf_a_A_1284.getReGrowLevel() >= param1;
      }
      
      public static function obf_i_r_3263(param1:int) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return obf_K_e_3075.obf_a_A_1284.getReGrowLevel() <= param1;
      }
      
      public static function obf_T_v_2987(param1:Number) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return obf_K_e_3075.countryUI.getCreatures() >= param1;
      }
      
      public static function obf_U_2_3674(param1:Number) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return obf_K_e_3075.countryUI.getCreatures() <= param1;
      }
      
      public static function obf_0_7_M_311(param1:Number) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return obf_K_e_3075.starAdventureUI.getStarAdventureLevel() >= param1;
      }
      
      public static function obf_0_5_r_243(param1:Number) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         return obf_K_e_3075.starAdventureUI.getStarAdventureLevel() <= param1;
      }
      
      public static function canAddGodExp(param1:Boolean) : Boolean
      {
         return obf_K_e_3075.angelBoxUI.isFullExp() == param1;
      }
      
      public static function isOpenBook(param1:Boolean) : Boolean
      {
         return obf_K_e_3075.playerBookUI.isOpenBook() == param1;
      }
      
      public static function ranksNumGE(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         if(!GameContext.localPlayer)
         {
            return false;
         }
         for(_loc2_ in param1)
         {
            _loc3_ = obf_K_e_3075.itemManualUI.getItemManualAll(int(_loc2_));
            if(_loc3_ < param1[_loc2_])
            {
               return false;
            }
         }
         return true;
      }
   }
}

