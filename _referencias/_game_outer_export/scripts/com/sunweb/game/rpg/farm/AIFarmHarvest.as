package com.sunweb.game.rpg.farm
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.res.ResourceBag;
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.res.obf_b_8_4256;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.family.obf_F_9_1495;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.SkillConfig;
   import com.sunweb.game.rpg.role.obf_A_w_2394;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.settingConfig.NumberConfig;
   import com.sunweb.game.rpg.team.TeamManager;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.worldZone.command.farm.CommandCodeFarm;
   import com.sunweb.game.rpg.worldZone.command.farm.FarmHarvestCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.farm.FarmHarvestCollectTestAnswer;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.util.obf_e_P_918;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_l_y_733;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class AIFarmHarvest extends obf_0_1_1_203
   {
      
      public var createrId:String;
      
      private var _phaseIndex:int;
      
      public var isIll:Boolean;
      
      public var productNumberTotal:int;
      
      public var productNumberLeft:int;
      
      public var each:int;
      
      public var phaseTimeLeftInSec:int;
      
      public var checkTime:int;
      
      private var promoteTimesCurrent:int;
      
      public var obf_R_J_2909:String;
      
      private var _harvestConfig:Object;
      
      private var _currentPhaseConfig:Object;
      
      public var skillKind:int;
      
      public var skillLevel:int;
      
      public var hideInfo:Boolean;
      
      private var collectTestObject:Object;
      
      private var obf_0_0_P_596:TimeLimiter;
      
      public function AIFarmHarvest(param1:String)
      {
         super(param1);
         this.checkTime = getTimer();
         this._harvestConfig = obf_P_f_3747.getFarmHarvestInfo(param1);
         this.obf_R_J_2909 = this._harvestConfig.name;
         this.skillKind = this._harvestConfig.kind;
         this.skillLevel = this._harvestConfig.level;
         this.hideInfo = this._harvestConfig.hideInfo;
         this.obf_Y_f_4243();
      }
      
      override protected function obf_N_O_3481() : void
      {
         var _loc1_:ResourceBag = ResourceManager.instance.getBag("fh_" + this._harvestConfig.modelCode,true);
         _loc1_.obf_z_U_2156(obf_b_8_4256.getResIdToImport(this._harvestConfig.res));
         _loc1_.load();
      }
      
      public function get obf_i_H_2166() : String
      {
         return JSONUtil.getStr(this._harvestConfig,["code"]);
      }
      
      public function set phaseIndex(param1:int) : void
      {
         this._phaseIndex = param1;
         this._currentPhaseConfig = this.getPhaseConfig(param1);
      }
      
      public function get phaseIndex() : int
      {
         return this._phaseIndex;
      }
      
      public function get currentPhaseConfig() : Object
      {
         return this._currentPhaseConfig;
      }
      
      public function obf_Y_f_4243() : void
      {
         this.visible = ConditionScript.checkCondition(JSONUtil.getObject(this._harvestConfig,["showIf"]));
      }
      
      public function show() : void
      {
         var _loc1_:Object = obf_P_f_3747.getFarmHarvestInfo(this._code);
         if(!_loc1_)
         {
            obf_x_0_1295.obf_r_w_3556("obf________604(" + this._code + ")");
            return;
         }
         if(this.phaseIndex >= _loc1_.phaseConfig.length)
         {
            obf_x_0_1295.obf_r_w_3556("obf__________35(" + this.obf_L_w_3939 + ")obf____4860" + this.phaseIndex + "obf______4642!");
            return;
         }
         this.showPhase(this.getPhaseConfig(this.phaseIndex).id,this.isIll,this.productNumberLeft > 0);
         if(this.showLabel)
         {
            this.showInfo();
         }
      }
      
      public function showInfo() : void
      {
         var _loc6_:String = null;
         var _loc7_:String = null;
         if(this.hideInfo)
         {
            this.label = this.obf_R_J_2909;
            this.showLabel = true;
            return;
         }
         var _loc1_:Object = obf_P_f_3747.getFarmHarvestInfo(this._code);
         if(!_loc1_ || this.phaseIndex >= _loc1_.phaseConfig.length)
         {
            return;
         }
         var _loc2_:Object = this.getPhaseConfig(this.phaseIndex);
         var _loc3_:String = this.obf_R_J_2909 + " - " + _loc2_.name;
         var _loc4_:Object = this.getPhaseConfig(this.phaseIndex + 1);
         var _loc5_:String = "";
         if(_loc4_)
         {
            _loc5_ = _loc4_.name || "";
         }
         if(this.isIll)
         {
            _loc3_ += "(" + (_loc2_.hasOwnProperty("illName") ? _loc2_.illName : "") + ")";
         }
         if(_loc4_)
         {
            _loc3_ += DiversityManager.getString("FarmPrompt","nextRate",[this.each]);
         }
         if(_loc2_.phaseType == obf_F_a_1500.obf_o_q_1400)
         {
            _loc3_ += "\n" + DiversityManager.getString("FarmPrompt","timeToNextPhase",[this.getNextPhaseTimeString(),_loc5_ || ""]);
         }
         else if(_loc2_.phaseType == obf_F_a_1500.obf_F_g_4535)
         {
            _loc6_ = this.currentPhaseConfig.promoteConfig != null ? this.currentPhaseConfig.promoteConfig.name : "";
            _loc7_ = this.currentPhaseConfig.promoteTimesTotal > 0 ? DiversityManager.getString("FarmPrompt","promoteTimes",[this.currentPhaseConfig.promoteTimesTotal - this.promoteTimesCurrent]) : "";
            _loc3_ += "\n" + DiversityManager.getString("FarmPrompt","actToNextPhase",[_loc7_ + _loc6_,_loc5_ || ""]);
            if(this.phaseTimeLeftInSec > 0)
            {
               _loc3_ += "\n" + DiversityManager.getString("FarmPrompt","timeLeftToNextPhase",[this.getNextPhaseTimeString()]);
            }
         }
         else if(_loc2_.phaseType == obf_F_a_1500.obf_Y_i_1717)
         {
            _loc3_ += "\n" + DiversityManager.getString("FarmPrompt","yield") + this.productNumberLeft + "/" + this.productNumberTotal;
            if(this.phaseTimeLeftInSec > 0)
            {
               _loc3_ += "\n" + DiversityManager.getString("FarmPrompt","timeLeftToNextPhase",[this.getNextPhaseTimeString()]);
            }
         }
         this.label = _loc3_;
         this.showLabel = true;
      }
      
      override public function set isTracked(param1:Boolean) : void
      {
         var _loc2_:Object = null;
         if(this.isTracked == param1)
         {
            return;
         }
         super.isTracked = param1;
         if(param1)
         {
            if(Boolean(this.currentPhaseConfig) && (!this.getFarm() || this.getFarm() == GameContext.localPlayer.getFarm()))
            {
               if(this.currentPhaseConfig.phaseType == 2 && (!this.obf_0_0_P_596 || this.obf_0_0_P_596.checkTimeout() || !this.collectTestObject))
               {
                  FarmManager.sendHarvestCollectTest(this.id);
               }
            }
         }
         if(param1 && GameContext.currentMap.containsPoint(new Point(GameContext.gameStage.mouseX,GameContext.gameStage.mouseY)))
         {
            this.showInfo();
            if(this.isIll)
            {
               _loc2_ = SkillConfig.getSkillConfig(this.getPhaseChildConfig(this.phaseIndex,"cureConfig","skillCode"));
               if(_loc2_)
               {
                  obf_e_P_918.useCustomCursor(ResourceManager.instance.getDisplayObject(_loc2_.iconRes));
               }
            }
            else if(this.productNumberLeft > 0)
            {
               _loc2_ = SkillConfig.getSkillConfig(this.getPhaseChildConfig(this.phaseIndex,"collectConfig","skillCode"));
               if(_loc2_)
               {
                  obf_e_P_918.useCustomCursor(ResourceManager.instance.getDisplayObject(_loc2_.iconRes));
               }
            }
            else if(Boolean(this._currentPhaseConfig) && this._currentPhaseConfig.phaseType == obf_F_a_1500.obf_F_g_4535)
            {
               _loc2_ = SkillConfig.getSkillConfig(this.getPhaseChildConfig(this.phaseIndex,"promoteConfig","skillCode"));
               if(_loc2_)
               {
                  obf_e_P_918.useCustomCursor(ResourceManager.instance.getDisplayObject(_loc2_.iconRes));
               }
            }
         }
         else
         {
            this.showLabel = false;
            obf_e_P_918.useDefaultCursor();
         }
      }
      
      public function getCanStealNumber() : int
      {
         if(this._currentPhaseConfig.phaseType != 2)
         {
            return 0;
         }
         if(this.getFarm() == null || this.getFarm().farmType == FarmType.obf_5_b_4269)
         {
            return this.productNumberLeft;
         }
         return this.productNumberLeft - Math.round(this.productNumberTotal * (1 - this._currentPhaseConfig.stealRatioTotal));
      }
      
      private function obf_F_B_829() : Boolean
      {
         if(!this.collectTestObject)
         {
            return false;
         }
         if(this.collectTestObject.canCollect)
         {
            return true;
         }
         if(this.collectTestObject.hasNoProduct)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmPrompt","nothingCollect"));
            return false;
         }
         var _loc1_:int = 1;
         if(JSONUtil.getInt(this.currentPhaseConfig,["stealTimesPerPlayer"],1) > 1)
         {
            _loc1_ = int(this.currentPhaseConfig.stealTimesPerPlayer);
         }
         if(this.collectTestObject.collectTimes >= _loc1_)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmPrompt","collected"));
            return false;
         }
         var _loc2_:int = this.collectTestObject.cdTimeLeftInSec * 1000 - (getTimer() - this.collectTestObject.checkedTime);
         if(_loc2_ > 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmPrompt","timeToNextCollect",[obf_l_y_733.getTimeStringSec(_loc2_)]));
            return false;
         }
         return true;
      }
      
      public function obf_I_K_2631(param1:int, param2:int) : Boolean
      {
         if(param2 != obf_A_w_2394.obf_E_f_3397 && !GameContext.localPlayer.obf_p_u_1039(param2,this.createrId))
         {
            return false;
         }
         if(this.createrId != GameContext.localPlayer.id)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmPrompt","onlyUseSelfHarvest"));
            return false;
         }
         if(this.getNextPhaseTimeInMS() <= 0 || this.productNumberLeft > 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmPrompt","onlyUseGrowingHarvest"));
            return false;
         }
         if(param1 == 0)
         {
            param1 == -1;
         }
         if((this.skillKind & param1) == 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmPrompt","onlyUseWithType",[FarmManager.getKindName(param1)]));
            return false;
         }
         if(GameContext.localPlayer.getFarm() != getFarm())
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmPrompt","onlyUseInSameFarmWithHarvest"));
            return false;
         }
         if(this._harvestConfig.disableSpeedItem)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmPrompt","cantUseWithThisHarvest"));
            return false;
         }
         return true;
      }
      
      public function obf_z_g_4271() : Boolean
      {
         if(!this.isIll)
         {
            return false;
         }
         if(GameContext.localPlayer.fullInfo.attributes.sp < int(NumberConfig.getSettingObject("spCostPerCure")))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMoreSP"));
            return false;
         }
         return true;
      }
      
      public function canCollect(param1:Boolean = true) : Boolean
      {
         var _loc3_:obf_n_v_1693 = null;
         if(!this._currentPhaseConfig)
         {
            return false;
         }
         if(this._currentPhaseConfig.phaseType != 2)
         {
            return false;
         }
         if(this.productNumberLeft <= 0)
         {
            return false;
         }
         var _loc2_:obf_0_1_N_478 = this.getFarm();
         if(_loc2_)
         {
            _loc3_ = FarmTempletManager.getFarmTemplet(_loc2_.templetCode);
         }
         if(!_loc2_ || this.createrId != GameContext.localPlayer.id)
         {
            if(GameContext.localPlayer.fullInfo.attributes.sp < int(NumberConfig.getSettingObject("spCostPerSteal")))
            {
               if(param1)
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMoreSP"));
               }
               return false;
            }
         }
         if(Boolean(this._harvestConfig.roleLevelToCollect) && GameContext.localPlayer.level < this._harvestConfig.roleLevelToCollect)
         {
            if(param1)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmPrompt","needPlayerLevelToCollect",[this._harvestConfig.roleLevelToCollect]));
            }
            return false;
         }
         if(Boolean(this._harvestConfig.roleSideToCollect) && GameContext.localPlayer.side != this._harvestConfig.roleSideToCollect)
         {
            if(param1)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmPrompt","needPlayerSideToCollect"));
            }
            return false;
         }
         if(GameContext.localPlayer.fullInfo.getMaxFarmSkillLevel() < this.skillLevel - WorldConfig.getNumberSetting("skillReduceToCollect"))
         {
            if(param1)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmPrompt","needFarmSkillLevelToCollect",[this.skillLevel - WorldConfig.getNumberSetting("skillReduceToCollect")]));
            }
            return false;
         }
         if(Boolean(_loc2_) && GameContext.localPlayer.getFarm() != _loc2_)
         {
            if(param1)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmPrompt","mustInFarm"));
            }
            return false;
         }
         var _loc4_:Boolean = false;
         if(Boolean(_loc3_ && _loc3_.farmType == FarmType.FAMILY_FARM && _loc2_ && GameContext.localPlayer.hasFamily()) && Boolean(_loc2_.ownerId == GameContext.localPlayer.familyName) && !GameContext.localPlayer.isInSameFamilyByPlayerId(this.createrId))
         {
            _loc4_ = true;
         }
         if(Boolean(!_loc4_) && Boolean(this._currentPhaseConfig.stealPlayerScope) && this._currentPhaseConfig.stealPlayerScope != obf_A_w_2394.obf_E_f_3397)
         {
            if(!GameContext.localPlayer.obf_p_u_1039(this._currentPhaseConfig.stealPlayerScope,this.createrId))
            {
               if(param1)
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmPrompt","cantCollect"));
               }
               return false;
            }
         }
         else if(_loc2_)
         {
            if(!_loc3_)
            {
               return false;
            }
            if(_loc3_.farmType == FarmType.obf_0_7_w_551)
            {
               if(_loc2_.ownerId != GameContext.localPlayer.id)
               {
               }
            }
            if(_loc3_.farmType == FarmType.obf_U_z_3456)
            {
               if(_loc2_.ownerId != GameContext.localPlayer.id)
               {
                  if(!GameContext.localPlayer.isInSameTeamByPlayerId(this.createrId))
                  {
                     obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmPrompt","createrNotInSameTeam"));
                     return false;
                  }
               }
            }
            if(_loc3_.farmType == FarmType.obf_5_b_4269)
            {
            }
            if(_loc3_.farmType == FarmType.FAMILY_FARM)
            {
               if(!GameContext.localPlayer.hasFamily() || _loc2_.ownerId != GameContext.localPlayer.familyName)
               {
                  if(param1)
                  {
                     obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmPrompt","cantCollect"));
                  }
                  return false;
               }
            }
         }
         return true;
      }
      
      public function obf_E_A_1702() : Boolean
      {
         var _loc2_:obf_n_v_1693 = null;
         if(!this._currentPhaseConfig)
         {
            return false;
         }
         if(this._currentPhaseConfig.phaseType != 1)
         {
            return false;
         }
         var _loc1_:obf_0_1_N_478 = this.getFarm();
         if(_loc1_)
         {
            _loc2_ = FarmTempletManager.getFarmTemplet(_loc1_.templetCode);
         }
         if(!_loc1_)
         {
            return true;
         }
         var _loc3_:Boolean = false;
         if(Boolean(_loc2_ && _loc2_.farmType == FarmType.FAMILY_FARM && _loc1_ && GameContext.localPlayer.hasFamily()) && Boolean(_loc1_.ownerId == GameContext.localPlayer.familyName) && !GameContext.localPlayer.isInSameFamilyByPlayerId(this.createrId))
         {
            _loc3_ = true;
         }
         if(Boolean(!_loc3_) && Boolean(this._currentPhaseConfig.promotePlayerScope) && this._currentPhaseConfig.promotePlayerScope != obf_A_w_2394.obf_E_f_3397)
         {
            return GameContext.localPlayer.obf_p_u_1039(this._currentPhaseConfig.promotePlayerScope,this.createrId);
         }
         if(_loc2_.farmType == FarmType.obf_0_7_w_551)
         {
            if(this.createrId == GameContext.localPlayer.id)
            {
               return true;
            }
            return false;
         }
         if(_loc2_.farmType == FarmType.obf_5_b_4269)
         {
            return true;
         }
         if(_loc2_.farmType == FarmType.obf_U_z_3456)
         {
            return GameContext.localPlayer.isInSameTeamByPlayerId(this.createrId);
         }
         if(_loc2_.farmType == FarmType.FAMILY_FARM)
         {
            if(GameContext.localPlayer.hasFamily() && _loc1_.ownerId == GameContext.localPlayer.familyName)
            {
               return true;
            }
         }
         return false;
      }
      
      public function canRemove() : Boolean
      {
         if(!this._currentPhaseConfig)
         {
            return false;
         }
         var _loc1_:obf_0_1_N_478 = this.getFarm();
         if(!_loc1_)
         {
            return false;
         }
         var _loc2_:obf_n_v_1693 = FarmTempletManager.getFarmTemplet(_loc1_.templetCode);
         if(_loc2_.farmType == FarmType.obf_0_7_w_551)
         {
            if(this.createrId == GameContext.localPlayer.id)
            {
               return true;
            }
            return false;
         }
         if(_loc2_.farmType == FarmType.obf_5_b_4269)
         {
            return false;
         }
         if(_loc2_.farmType == FarmType.obf_U_z_3456)
         {
            return GameContext.localPlayer.id == this.createrId || TeamManager.isLeader;
         }
         if(_loc2_.farmType == FarmType.FAMILY_FARM)
         {
            if(GameContext.localPlayer.hasFamily() && GameContext.localPlayer.familyName == _loc1_.ownerId)
            {
               if(this.createrId == GameContext.localPlayer.id)
               {
                  return true;
               }
               if(obf_F_9_1495.isLeaderPost(GameContext.localPlayer.familyMyInfo.postLevel))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function getNextPhaseTimeString() : String
      {
         var _loc1_:int = this.getNextPhaseTimeInMS();
         return obf_l_y_733.getTimeStringMin(_loc1_);
      }
      
      public function getNextPhaseTimeInMS() : int
      {
         return this.phaseTimeLeftInSec * 1000 - (getTimer() - this.checkTime);
      }
      
      public function getPhaseConfig(param1:int) : Object
      {
         var _loc2_:Object = obf_P_f_3747.getFarmHarvestInfo(this.code);
         if(Boolean(_loc2_) && Boolean(param1 >= 0) && param1 < _loc2_.phaseConfig.length)
         {
            return _loc2_.phaseConfig[param1];
         }
         return null;
      }
      
      public function getPhaseName(param1:int) : String
      {
         var _loc2_:Object = this.getPhaseConfig(param1);
         if(_loc2_)
         {
            return _loc2_.name;
         }
         return "";
      }
      
      public function getPhaseChildConfig(param1:int, param2:String, param3:String) : *
      {
         var _loc4_:Object = this.getPhaseConfig(param1);
         if((Boolean(_loc4_)) && Boolean(_loc4_[param2] != null) && _loc4_[param2][param3] != null)
         {
            return _loc4_[param2][param3];
         }
         return "";
      }
      
      public function getOperationConfig(param1:String) : Object
      {
         var _loc2_:Object = obf_P_f_3747.getFarmHarvestInfo(this.code);
         if(Boolean(_loc2_) && Boolean(_loc2_.operationConfig))
         {
            return _loc2_.operationConfig[param1];
         }
         return null;
      }
      
      public function getOperationName(param1:String) : String
      {
         var _loc2_:Object = this.getOperationConfig(param1);
         if(_loc2_)
         {
            return _loc2_.name;
         }
         return "";
      }
      
      public function getOperationSkillCode(param1:String) : String
      {
         var _loc2_:Object = this.getOperationConfig(param1);
         if(_loc2_)
         {
            return _loc2_.skillCode;
         }
         return "";
      }
      
      public function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeFarm.FARM_HARVEST_CHECK_NOTIFY)
         {
            this.obf_K_F_3476(param1 as FarmHarvestCheckNotify);
         }
         else if(param1.code == CommandCodeFarm.FARM_HARVEST_COLLECT_TEST_ANSWER)
         {
            this.obf_y_l_2755(param1 as FarmHarvestCollectTestAnswer);
         }
      }
      
      private function obf_K_F_3476(param1:FarmHarvestCheckNotify) : void
      {
         if(this.phaseIndex != param1.harvest.phaseIndex || this.productNumberLeft != param1.harvest.productNumberLeft)
         {
            this.collectTestObject = null;
         }
         this.productNumberLeft = param1.harvest.productNumberLeft;
         this.productNumberTotal = param1.harvest.productNumberTotal;
         this.promoteTimesCurrent = param1.harvest.promoteTimesCurrent;
         this.each = param1.harvest.productRate;
         this.isIll = param1.harvest.isIll;
         this.phaseIndex = param1.harvest.phaseIndex;
         this.checkTime = getTimer();
         this.phaseTimeLeftInSec = param1.harvest.phaseTimeLeftInSec;
         this.show();
      }
      
      private function obf_y_l_2755(param1:FarmHarvestCollectTestAnswer) : void
      {
         this.collectTestObject = new Object();
         this.collectTestObject.canCollect = param1.canCollect;
         this.collectTestObject.collectTimes = param1.collectTimes;
         this.collectTestObject.cdTimeLeftInSec = param1.cdTimeLeftInSec;
         this.collectTestObject.checkedTime = getTimer();
         this.collectTestObject.hasNoProduct = param1.hasNoProduct;
         this.obf_0_0_P_596 = new TimeLimiter(1 * obf_l_y_733.obf_0___a_609);
      }
   }
}

