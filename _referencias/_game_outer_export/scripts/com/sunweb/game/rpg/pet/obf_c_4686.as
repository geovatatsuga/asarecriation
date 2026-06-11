package com.sunweb.game.rpg.pet
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.map.MapInteractiveObject;
   import com.sunweb.game.rpg.netRole.obf_Y_E_3667;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.obf_0_0_8_669;
   import com.sunweb.game.rpg.role.obf_0_9_V_473;
   import com.sunweb.game.rpg.skill.SkillCDManager;
   import com.sunweb.game.rpg.skill.SkillManager;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.map.MapPoint;
   import com.sunweb.game.rpg.worldZone.command.pet.CommandCodePlayerPet;
   import com.sunweb.game.rpg.worldZone.command.pet.PetAssignAttrRequest;
   import com.sunweb.game.rpg.worldZone.command.pet.PetAttrIntChangeNotify;
   import com.sunweb.game.rpg.worldZone.command.pet.PetCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.pet.PetEnhanceAnswer;
   import com.sunweb.game.rpg.worldZone.command.pet.PetEnhanceRequest;
   import com.sunweb.game.rpg.worldZone.command.pet.PetForgetSkillRequest;
   import com.sunweb.game.rpg.worldZone.command.pet.PetFusionAnswer;
   import com.sunweb.game.rpg.worldZone.command.pet.PetFusionRequest;
   import com.sunweb.game.rpg.worldZone.command.pet.PetHpChangeNotify;
   import com.sunweb.game.rpg.worldZone.command.pet.PetLearnSkillAnswer;
   import com.sunweb.game.rpg.worldZone.command.pet.PetLearnSkillRequest;
   import com.sunweb.game.rpg.worldZone.command.pet.PetRemoveEquipmentRequest;
   import com.sunweb.game.rpg.worldZone.command.pet.PetRenameRequest;
   import com.sunweb.game.rpg.worldZone.command.pet.PetUseSkillNotify;
   import com.sunweb.game.rpg.worldZone.command.pet.PetViewRequest;
   import com.sunweb.game.rpg.worldZone.command.pet.PlayerPetActionModeChangeNotify;
   import com.sunweb.game.rpg.worldZone.command.pet.PlayerSetPetActionModeRequest;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   
   public class obf_c_4686
   {
      
      private static var _config:Object;
      
      private static var petInfoMap:Object = new Object();
      
      public function obf_c_4686()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         _config = param1;
      }
      
      public static function get config() : Object
      {
         return _config;
      }
      
      public static function get getPetBagsNum() : int
      {
         if(!WorldConfig.getValue("playerPetBag"))
         {
            return 8;
         }
         return WorldConfig.getValue("playerPetBag");
      }
      
      public static function getPetFullInfo(param1:String) : PetFullInfo
      {
         return petInfoMap[param1];
      }
      
      public static function removePetFullInfo(param1:String) : void
      {
         delete petInfoMap[param1];
      }
      
      public static function getPetLevelUpExp(param1:int) : int
      {
         return JSONUtil.getInt(_config,["petLevelUpExp",param1 - 1]);
      }
      
      public static function getAttributesAptRate(param1:int) : Number
      {
         return Number(param1) / 1000 * 0.3;
      }
      
      public static function getPetEnhanceAptRate(param1:int) : Number
      {
         return JSONUtil.getNumber(_config,["enhance","enhanceLevelArray",param1 - 1,"resultAttr",PetAttributesModifierEnum.ALL_APT_ADD_RATE]);
      }
      
      public static function getPetEnhanceAptUpValue(param1:int, param2:int) : int
      {
         var _loc3_:Number = getPetEnhanceAptRate(param1);
         var _loc4_:int = Math.round(param2 * _loc3_);
         var _loc5_:int = JSONUtil.getInt(_config,["enhance","enhanceLevelArray",param1 - 1,"resultAttr",PetAttributesModifierEnum.ALL_APT_ADD_VALUE]);
         return _loc4_ + _loc5_;
      }
      
      public static function getSkillAttributes(param1:PetFullInfo) : PetAttributesInfo
      {
         var _loc2_:PetAttributesInfo = new PetAttributesInfo();
         _loc2_.strengthApt = param1.attributes.strengthApt - param1.baseAttributes.strengthApt - param1.fusionAttributes.strengthApt - getPetEnhanceAptUpValue(param1.enhanceLevel,param1.baseAttributes.strengthApt);
         _loc2_.agilityApt = param1.attributes.agilityApt - param1.baseAttributes.agilityApt - param1.fusionAttributes.agilityApt - getPetEnhanceAptUpValue(param1.enhanceLevel,param1.baseAttributes.agilityApt);
         _loc2_.wisdomApt = param1.attributes.wisdomApt - param1.baseAttributes.wisdomApt - param1.fusionAttributes.wisdomApt - getPetEnhanceAptUpValue(param1.enhanceLevel,param1.baseAttributes.wisdomApt);
         _loc2_.vitalityApt = param1.attributes.vitalityApt - param1.baseAttributes.vitalityApt - param1.fusionAttributes.vitalityApt - getPetEnhanceAptUpValue(param1.enhanceLevel,param1.baseAttributes.vitalityApt);
         return _loc2_;
      }
      
      public static function getEnhanceAttributes(param1:ItemPlayerPetInfo) : PetAttributesInfo
      {
         var _loc2_:PetAttributesInfo = new PetAttributesInfo();
         _loc2_.strengthApt = param1.attributes.strengthApt - param1.baseAttributes.strengthApt - param1.fusionAttributes.strengthApt;
         _loc2_.agilityApt = param1.attributes.agilityApt - param1.baseAttributes.agilityApt - param1.fusionAttributes.agilityApt;
         _loc2_.wisdomApt = param1.attributes.wisdomApt - param1.baseAttributes.wisdomApt - param1.fusionAttributes.wisdomApt;
         _loc2_.vitalityApt = param1.attributes.vitalityApt - param1.baseAttributes.vitalityApt - param1.fusionAttributes.vitalityApt;
         return _loc2_;
      }
      
      public static function getPetEnhanceLevelConfig(param1:int) : Object
      {
         return JSONUtil.getObject(_config,["enhance","enhanceLevelArray",param1]);
      }
      
      public static function getPetMaxGrowthRate(param1:String, param2:ItemPlayerPetInfo = null) : Number
      {
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc3_)
         {
            return 0;
         }
         var _loc4_:Number = 0;
         if(Boolean(param2) && Boolean(param2.fusionAttributes) && Boolean(param2.attributes))
         {
            _loc4_ = param2.fusionAttributes.growthRate * param2.attributes.levelUpAttrPt * 0.01;
         }
         return JSONUtil.getNumber(_loc3_,["properties","growthRateMax"],JSONUtil.getNumber(config,["defaultValue","growthRateMax"])) * JSONUtil.getNumber(_loc3_,["properties","levelUpAttrPt"],JSONUtil.getNumber(config,["defaultValue","levelUpAttrPt"])) * 0.01 + _loc4_;
      }
      
      public static function getPetGrowthRate(param1:PetAttributesInfo) : Number
      {
         if(param1)
         {
            return param1.growthRate * param1.levelUpAttrPt * 0.01;
         }
         return 0;
      }
      
      public static function getItemFusionValue(param1:String) : int
      {
         return JSONUtil.getInt(config,["fusion","fusionValueItems",param1]);
      }
      
      public static function getFusionConvertValue(param1:int, param2:int) : int
      {
         var _loc3_:Array = JSONUtil.getObject(config,["fusion","fusionValueConvert"],[]) as Array;
         _loc3_.sort(Array.NUMERIC);
         var _loc4_:Number = getGenerationFusionRate(param2);
         var _loc5_:* = int(_loc3_.length - 1);
         while(_loc5_ >= 0)
         {
            if(param1 >= _loc3_[_loc5_] * _loc4_)
            {
               return _loc5_ + 1;
            }
            _loc5_--;
         }
         return 0;
      }
      
      public static function getGenerationFusionRate(param1:int) : Number
      {
         return JSONUtil.getNumber(config,["fusion","fusionValueRate",param1 - 1],1);
      }
      
      public static function getMaxFusionConvertValue(param1:int) : int
      {
         var _loc2_:Array = JSONUtil.getObject(config,["fusion","fusionValueConvert"],[]) as Array;
         _loc2_.sort(Array.NUMERIC);
         return _loc2_[_loc2_.length - 1] * getGenerationFusionRate(param1);
      }
      
      public static function getPetSkillMap(param1:ItemPlayerPetInfo) : Object
      {
         var _loc3_:PetSkillSlot = null;
         var _loc4_:PetSkillSlot = null;
         var _loc2_:Object = new Object();
         for each(_loc3_ in param1.learnedSkillList)
         {
            _loc2_[_loc3_.skillCode] = _loc3_.skillLevel;
         }
         for each(_loc4_ in param1.fateSkillList)
         {
            _loc2_[_loc4_.skillCode] = _loc4_.skillLevel;
         }
         return _loc2_;
      }
      
      public static function getPetSkillCodes(param1:ItemPlayerPetInfo) : Array
      {
         var _loc3_:PetSkillSlot = null;
         var _loc4_:PetSkillSlot = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in param1.learnedSkillList)
         {
            _loc2_.push(_loc3_.skillCode);
         }
         for each(_loc4_ in param1.fateSkillList)
         {
            _loc2_.push(_loc4_.skillCode);
         }
         return _loc2_;
      }
      
      public static function sendViewPet(param1:String) : void
      {
         var _loc2_:PetViewRequest = new PetViewRequest();
         _loc2_.petId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendPetRename(param1:String, param2:String) : void
      {
         var _loc3_:PetRenameRequest = new PetRenameRequest();
         _loc3_.petId = param1;
         _loc3_.petName = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendAssignAttr(param1:String, param2:int, param3:int, param4:int, param5:int) : void
      {
         var _loc6_:PetAssignAttrRequest = new PetAssignAttrRequest();
         _loc6_.petId = param1;
         _loc6_.strAdded = param2;
         _loc6_.agiAdded = param3;
         _loc6_.vitAdded = param4;
         _loc6_.wisAdded = param5;
         GameContext.worldClient.sendCommand(_loc6_);
      }
      
      public static function sendForgetSkill(param1:String, param2:String) : void
      {
         if(GameContext.localPlayer.fullInfo.money < JSONUtil.getInt(obf_c_4686.config,["forgetSkillMoney"]))
         {
            obf_K_e_3075.showShortOfMoney();
            return;
         }
         var _loc3_:PetForgetSkillRequest = new PetForgetSkillRequest();
         _loc3_.petId = param1;
         _loc3_.skillCode = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendPetActionModeChange(param1:int) : void
      {
         var _loc2_:PlayerSetPetActionModeRequest = new PlayerSetPetActionModeRequest();
         _loc2_.petActionMode = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendPetEnhance(param1:String, param2:int) : void
      {
         var _loc3_:PetEnhanceRequest = new PetEnhanceRequest();
         _loc3_.currentEnhanceLevel = param2;
         _loc3_.petId = param1;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendPetFusion(param1:String, param2:String, param3:Object, param4:String) : void
      {
         var _loc5_:PetFusionRequest = new PetFusionRequest();
         _loc5_.manPetId = param1;
         _loc5_.womanPetId = param2;
         _loc5_.fusionItems = param3;
         _loc5_.protectItem = param4;
         GameContext.worldClient.sendCommand(_loc5_);
      }
      
      public static function sendRemovePetEquipment(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:PetRemoveEquipmentRequest = new PetRemoveEquipmentRequest();
         _loc4_.petId = param1;
         _loc4_.equipmentKind = param2;
         _loc4_.toBagItemIndex = param3;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public static function sendPetLearnSkill(param1:String, param2:String, param3:int) : void
      {
         var _loc4_:PetLearnSkillRequest = new PetLearnSkillRequest();
         _loc4_.petId = param1;
         _loc4_.skillCode = param2;
         _loc4_.skillKind = param3;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerPet.PET_CHECK_NOTIFY)
         {
            obf_m_w_1443(param1 as PetCheckNotify);
         }
         else if(param1.code == CommandCodePlayerPet.PET_ATTR_INT_CHANGE_NOTIFY)
         {
            obf_6_m_4600(param1 as PetAttrIntChangeNotify);
         }
         else if(param1.code == CommandCodePlayerPet.PET_USE_SKILL_NOTIFY)
         {
            obf_M_R_1736(param1 as PetUseSkillNotify);
         }
         else if(param1.code == CommandCodePlayerPet.PET_LEARN_SKILL_ANSWER)
         {
            obf_A_6_3601(param1 as PetLearnSkillAnswer);
         }
         else if(param1.code == CommandCodePlayerPet.PET_HP_CHANGE_NOTIFY)
         {
            obf_a_R_3737(param1 as PetHpChangeNotify);
         }
         else if(param1.code == CommandCodePlayerPet.PLAYER_PET_ACTION_MODE_CHANGE_NOTIFY)
         {
            obf_H_4_1554(param1 as PlayerPetActionModeChangeNotify);
         }
         else if(param1.code == CommandCodePlayerPet.PET_ENHANCE_ANSWER)
         {
            obf_1_I_2309(param1 as PetEnhanceAnswer);
         }
         else if(param1.code == CommandCodePlayerPet.PET_FUSION_ANSWER)
         {
            obf_f_T_1549(param1 as PetFusionAnswer);
         }
      }
      
      private static function obf_m_w_1443(param1:PetCheckNotify) : void
      {
         var _loc2_:String = null;
         if(param1.pet)
         {
            petInfoMap[param1.pet.petId] = param1.pet;
         }
         if(obf_K_e_3075.petBoxUI)
         {
            obf_K_e_3075.petBoxUI.selectPet(JSONUtil.getStr(param1.pet,["petId"]),JSONUtil.getStr(param1.pet,["petCode"]));
            if(param1.isUsing)
            {
               obf_K_e_3075.petBoxUI.setSummonPet(JSONUtil.getStr(param1.pet,["petId"]));
            }
            obf_K_e_3075.petBoxUI.showPetInfo(param1.pet);
         }
         if(param1.isUsing && Boolean(GameContext.localPlayer))
         {
            if(Boolean(GameContext.localPlayer.petFullInfo) && Boolean(param1.pet) && GameContext.localPlayer.petFullInfo.level != param1.pet.level)
            {
               obf_6_D_3816.print(DiversityManager.getString("PetUI","petPrompt_PetLevelChange",[param1.pet.level]));
               obf_0_9_V_473.showEffectOnObject(GameContext.currentMap,GameContext.localPlayer.obf_y_G_2458,"C_RoleLevelUp");
            }
            _loc2_ = JSONUtil.getStr(GameContext.localPlayer.petFullInfo,["petId"]);
            GameContext.localPlayer.petFullInfo = param1.pet;
            if(Boolean(GameContext.currentMap) && (!param1.pet || _loc2_ != param1.pet.petId))
            {
               GameContext.localPlayer.obf_Z_E_4144();
            }
            GameContext.localPlayer.obf_2_I_3678();
         }
         if(param1.pet)
         {
            GameItemInfoManager.removeItemInfo(param1.pet.petId);
         }
         obf_K_e_3075.playerInfoUI.updatePetInfo();
      }
      
      private static function obf_6_m_4600(param1:PetAttrIntChangeNotify) : void
      {
         if(param1.attr == obf_b_H_2924.obf_0_7_Z_613)
         {
            if(param1.valueChanged > 0)
            {
               obf_6_D_3816.print(DiversityManager.getString("PetUI","petPrompt_AddExp",[param1.valueChanged]));
            }
            if(obf_K_e_3075.petBoxUI.selectedPetId == param1.petId)
            {
               obf_K_e_3075.petBoxUI.setPetExp(param1.valueCurrent);
            }
         }
         else if(param1.attr == obf_b_H_2924.obf_v_J_1381)
         {
            if(obf_K_e_3075.petBoxUI.selectedPetId == param1.petId)
            {
               obf_K_e_3075.petBoxUI.txtLife.text = param1.valueCurrent + "";
            }
         }
         else if(param1.attr == obf_b_H_2924.obf_g_x_2339)
         {
            if(obf_K_e_3075.petBoxUI.selectedPetId == param1.petId)
            {
               obf_K_e_3075.petBoxUI.txtLoyalty.text = param1.valueCurrent + "";
            }
         }
         else if(param1.attr == obf_b_H_2924.obf_Q_F_4333)
         {
            if(obf_K_e_3075.petBoxUI.selectedPetId == param1.petId)
            {
               obf_K_e_3075.petBoxUI.txtHP.text = param1.valueCurrent + "/" + obf_K_e_3075.petBoxUI.obf_O_O_3039.attributes.hpMax;
            }
            if(Boolean(GameContext.localPlayer.petFullInfo) && GameContext.localPlayer.petFullInfo.petId == param1.petId)
            {
               GameContext.localPlayer.petFullInfo.hp = param1.valueCurrent;
               obf_K_e_3075.playerInfoUI.updatePetInfo();
            }
         }
         else if(param1.attr == obf_b_H_2924.obf_V_c_792)
         {
            if(obf_K_e_3075.petBoxUI.selectedPetId == param1.petId)
            {
               obf_K_e_3075.petBoxUI.txtMP.text = param1.valueCurrent + "/" + obf_K_e_3075.petBoxUI.obf_O_O_3039.attributes.mpMax;
            }
            if(Boolean(GameContext.localPlayer.petFullInfo) && GameContext.localPlayer.petFullInfo.petId == param1.petId)
            {
               GameContext.localPlayer.petFullInfo.mp = param1.valueCurrent;
               obf_K_e_3075.playerInfoUI.updatePetInfo();
            }
         }
      }
      
      private static function obf_M_R_1736(param1:PetUseSkillNotify) : void
      {
         var _loc2_:obf_Y_E_3667 = null;
         var _loc3_:MapInteractiveObject = null;
         var _loc4_:String = null;
         if(!GameContext.currentMap)
         {
            return;
         }
         if(obf_L_l_4100.isEmpty(param1.petOwnerName) || param1.petOwnerName == GameContext.localPlayer.id)
         {
            _loc2_ = GameContext.localPlayer;
         }
         else
         {
            _loc2_ = GameContext.currentMap.remotePlayerSet.getObject(param1.petOwnerName) as obf_Y_E_3667;
         }
         if(Boolean(_loc2_) && Boolean(_loc2_.obf_y_G_2458))
         {
            if(_loc2_.obf_y_G_2458.isUsingSkill)
            {
               _loc2_.obf_y_G_2458.stopAction();
            }
            _loc3_ = GameContext.currentMap.getObjectById(param1.targetId);
            if(_loc3_)
            {
               _loc2_.obf_y_G_2458.useSkillOnObject(0,param1.skillCode,_loc3_,param1.singTime,param1.castTime,param1.skillLevel);
            }
            else if(param1.targetPoint)
            {
               _loc2_.obf_y_G_2458.useSkillOnPoint(0,param1.skillCode,MapPoint.MapPointToPoint(param1.targetPoint),param1.singTime,param1.castTime,param1.skillLevel);
            }
            else
            {
               _loc2_.obf_y_G_2458.useSkillOnObject(0,param1.skillCode,_loc2_.obf_y_G_2458,param1.singTime,param1.castTime,param1.skillLevel);
            }
            if(_loc2_ == GameContext.localPlayer)
            {
               _loc4_ = SkillCDManager.getSkillCDFlag(param1.skillCode);
               SkillCDManager.setSkillCD(_loc4_,SkillCDManager.getSkillCDTime(param1.skillCode,param1.skillLevel) + param1.singTime + param1.castTime,0);
            }
         }
      }
      
      private static function obf_A_6_3601(param1:PetLearnSkillAnswer) : void
      {
         obf_6_D_3816.print(DiversityManager.getString("PetUI","petPrompt_LearnSkill",[SkillManager.getSkillName(param1.skillCode) + " Lv" + param1.skillLevel]));
      }
      
      private static function obf_a_R_3737(param1:PetHpChangeNotify) : void
      {
         var _loc2_:obf_Y_E_3667 = null;
         var _loc3_:String = null;
         if(!GameContext.currentMap)
         {
            return;
         }
         if(obf_L_l_4100.isEmpty(param1.petOwnerName) || param1.petOwnerName == GameContext.localPlayer.id)
         {
            _loc2_ = GameContext.localPlayer;
            GameContext.localPlayer.doCommand(param1);
            obf_K_e_3075.playerInfoUI.updatePetInfo();
            if(obf_K_e_3075.petBoxUI.selectedPetId == _loc2_.obf_y_G_2458.id)
            {
               obf_K_e_3075.petBoxUI.txtHP.text = param1.hpCurrent + "/" + param1.hpMax;
            }
            _loc3_ = param1.isCriticalStrike ? obf_0_0_8_669.obf_v_e_4597 : obf_0_0_8_669.obf_o_0_932;
         }
         else
         {
            _loc2_ = GameContext.currentMap.remotePlayerSet.getObject(param1.petOwnerName) as obf_Y_E_3667;
            _loc3_ = param1.isCriticalStrike ? obf_0_0_8_669.obf_w_d_3136 : obf_0_0_8_669.obf_F_F_4169;
         }
         if(_loc2_.obf_y_G_2458)
         {
            if(param1.hpChanged < 0)
            {
               _loc2_.obf_y_G_2458.showNumberEffect(Math.abs(param1.hpChanged),_loc3_);
            }
            else if(param1.hpChanged > 0)
            {
               _loc2_.obf_y_G_2458.showNumberEffect(param1.hpChanged,obf_0_0_8_669.obf_0___1_276);
            }
         }
      }
      
      private static function obf_H_4_1554(param1:PlayerPetActionModeChangeNotify) : void
      {
         GameContext.localPlayer.petActionMode = param1.petActionMode;
         obf_K_e_3075.playerInfoUI.updatePetInfo();
      }
      
      private static function obf_1_I_2309(param1:PetEnhanceAnswer) : void
      {
         if(param1.isSucceeded)
         {
            obf_K_e_3075.showInfoOnUI(DiversityManager.getString("PetEnhanceUI","prompt_EnhanceComplete"),obf_K_e_3075.petEnhanceUI);
            obf_c_4686.removePetFullInfo(param1.petId);
         }
         else
         {
            obf_K_e_3075.showInfoOnUI(DiversityManager.getString("PetEnhanceUI","prompt_EnhanceFailed"),obf_K_e_3075.petEnhanceUI);
         }
         obf_K_e_3075.petEnhanceUI.obf_B_A_1617();
         obf_K_e_3075.petEnhanceUI.setPetToEnhance(param1.petId,param1.petCode);
      }
      
      private static function obf_f_T_1549(param1:PetFusionAnswer) : void
      {
         if(param1.isSucceeded)
         {
            obf_K_e_3075.petFusionUI.obf_0_1_4_232();
            obf_K_e_3075.petFusionUI.obf_I_H_3596();
            obf_K_e_3075.petFusionUI.obf_2_B_4604();
            obf_K_e_3075.petFusionUI.obf_f_F_4408(param1.petCode,param1.petId);
            obf_K_e_3075.showInfoOnUI(DiversityManager.getString("PetFusionUI","prompt_FusionComplete"),obf_K_e_3075.petFusionUI);
         }
         else
         {
            obf_K_e_3075.petFusionUI.obf_I_H_3596();
            obf_K_e_3075.petFusionUI.obf_2_B_4604();
            obf_K_e_3075.showInfoOnUI(DiversityManager.getString("PetFusionUI","prompt_FusionFailed"),obf_K_e_3075.petFusionUI);
         }
      }
   }
}

