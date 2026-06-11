package com.sunweb.game.rpg.farm
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemFarm;
   import com.sunweb.game.rpg.map.MapInteractiveObject;
   import com.sunweb.game.rpg.module.obf_0_K_4070;
   import com.sunweb.game.rpg.playerBag.PlayerBagIndex;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.obf_0_0_8_669;
   import com.sunweb.game.rpg.role.obf_0_9_V_473;
   import com.sunweb.game.rpg.settingConfig.NumberConfig;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.map.MapPoint;
   import com.sunweb.game.rpg.worldZone.command.farm.*;
   import com.sunweb.game.rpg.worldZone.command.map.FarmTeleportRequest;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   import com.sunweb.game.rpg.worldZone.command.player.PlayerViewMapAnswer;
   import com.sunweb.game.rpg.worldZone.command.playerBag.PlayerUseItemRequest;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class FarmManager
   {
      
      private static var showState:Boolean;
      
      private static var _farmItem:IconItemFarm;
      
      private static var _farm:obf_0_1_N_478;
      
      private static var _farmObject:FarmObject;
      
      private static var _mapSprite:Sprite;
      
      private static var moveTime:TimeLimiter = new TimeLimiter(200);
      
      public function FarmManager()
      {
         super();
      }
      
      public static function init(param1:Sprite) : void
      {
         _mapSprite = param1;
         addListener();
      }
      
      public static function get obf_0_9_2_382() : Boolean
      {
         return showState;
      }
      
      private static function addListener() : void
      {
         _mapSprite.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
         _mapSprite.addEventListener(MouseEvent.CLICK,onMouseClick);
      }
      
      private static function removeListener() : void
      {
         _mapSprite.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
         _mapSprite.removeEventListener(MouseEvent.CLICK,onMouseClick);
      }
      
      public static function useFarmItem(param1:IconItemFarm) : Boolean
      {
         var _loc4_:Object = null;
         if(!GameContext.currentMap || !GameContext.localPlayer)
         {
            return false;
         }
         hideFarmState();
         if(!GameItemManager.obf_D_n_3089(param1.itemCode,true))
         {
            return false;
         }
         _farm = GameContext.localPlayer.getFarm();
         if(!_farm)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmPrompt","useSeedInFarm"));
            return false;
         }
         var _loc2_:Object = GameItemManager.getItemConfig(param1.itemCode);
         if(!_loc2_)
         {
            obf_x_0_1295.obf_r_w_3556("obf_________42，(" + param1.itemCode + ")obf___4949！");
            return false;
         }
         var _loc3_:obf_n_v_1693 = FarmTempletManager.getFarmTemplet(_farm.templetCode);
         if(!_loc3_)
         {
            obf_x_0_1295.obf_r_w_3556("obf_____4724(" + param1.itemCode + ")obf___4949！");
            return false;
         }
         if(param1.farmItemType == IconItemFarm.FARM_SEED)
         {
            _loc4_ = obf_P_f_3747.getFarmHarvestInfo(_loc2_.properties.harvestCode);
            if(!_loc4_)
            {
               obf_x_0_1295.obf_r_w_3556("obf_______1044（" + _loc2_.properties.harvestCode + "）obf_____4794！");
               return false;
            }
         }
         else if(param1.farmItemType == IconItemFarm.FARM_BUILDING)
         {
            _loc4_ = obf_d_8_4301.getFarmBuildingInfo(_loc2_.properties.buildingCode);
            if(!_loc4_)
            {
               obf_x_0_1295.obf_r_w_3556("obf_______2206（" + _loc2_.properties.harvestCode + "）obf_____4794！");
               return false;
            }
         }
         if(!_loc4_)
         {
            obf_x_0_1295.obf_r_w_3556("obf________________9！");
            return false;
         }
         if(param1.farmItemType == IconItemFarm.FARM_SEED && GameContext.localPlayer.getFarmSkillLevelByKind(_loc4_.kind) < _loc4_.level)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmPrompt","useSeedNeedFarmSkillLevel",[getKindName(_loc4_.kind),JSONUtil.getInt(_loc4_,["level"])]));
            return false;
         }
         if(Boolean(_loc4_.allowFarmCodes) && Boolean(_loc4_.allowFarmCodes.length > 0) && _loc4_.allowFarmCodes.indexOf(_farm.templetCode) == -1)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmPrompt","cantSeedInThisFarm"));
            return false;
         }
         if(_loc3_.farmType == FarmType.obf_0_7_w_551)
         {
            if(_farm.ownerId != GameContext.localPlayer.id)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmPrompt","onlySeedInMyFarm"));
               return false;
            }
         }
         else if(_loc3_.farmType != FarmType.obf_5_b_4269)
         {
            if(_loc3_.farmType == FarmType.obf_U_z_3456)
            {
               return false;
            }
            if(_loc3_.farmType == FarmType.FAMILY_FARM)
            {
               if(!GameContext.localPlayer.hasFamily() || GameContext.localPlayer.familyName != _farm.ownerId)
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmPrompt","useSeedInSelfFamily"));
                  return false;
               }
            }
         }
         if(Boolean(_loc4_.farmLevel) && _farm.currentLevel < _loc4_.farmLevel)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmPrompt","seedHighLevelFarm",[JSONUtil.getInt(_loc4_,["farmLevel"])]));
            return false;
         }
         _farmItem = param1;
         showState = true;
         _farm.showTileState = true;
         if(_farmItem.farmItemType == IconItemFarm.FARM_SEED)
         {
            _farmObject = new obf_0_1_1_203(_loc4_.code);
            GameContext.currentMap.obf_b_h_1770.addObject(_farmObject);
         }
         else if(_farmItem.farmItemType == IconItemFarm.FARM_BUILDING)
         {
            _farmObject = new obf_j_1_3698(_loc4_.code);
            GameContext.currentMap.obf_4_h_2582.addObject(_farmObject);
         }
         if(_farmObject)
         {
            _farmObject.showTileState = true;
            _farmObject.moveToPixel(GameContext.localPlayer.rootPX,GameContext.localPlayer.rootPY);
         }
         obf_K_e_3075.closeUI(obf_K_e_3075.playerBagUI);
         return true;
      }
      
      public static function hideFarmState() : void
      {
         if(!GameContext.currentMap || !GameContext.localPlayer)
         {
            return;
         }
         if(_farmObject)
         {
            _farmObject.showTileState = false;
            GameContext.currentMap.obf_b_h_1770.removeObject(_farmObject,true);
            GameContext.currentMap.obf_4_h_2582.removeObject(_farmObject,true);
         }
         if(_farm)
         {
            _farm.showTileState = false;
            _farm = null;
         }
         showState = false;
         _farmItem = null;
      }
      
      private static function onMouseMove(param1:MouseEvent) : void
      {
         if(!showState || !moveTime.checkTimeout())
         {
            return;
         }
         if(Boolean(_farmObject) && Boolean(GameContext.currentMap))
         {
            _farmObject.moveToPixel(GameContext.currentMap.mouseX,GameContext.currentMap.mouseY);
         }
      }
      
      private static function onMouseClick(param1:MouseEvent) : void
      {
         if(Boolean(showState) && Boolean(GameContext.currentMap) && !GameContext.localPlayer.isDead)
         {
            _farmObject.showTileState = false;
            GameContext.currentMap.obf_b_h_1770.removeObject(_farmObject);
            GameContext.currentMap.obf_4_h_2582.removeObject(_farmObject);
            if(_farm.canPutFarmObject(_farmObject,_farmObject.rootX - _farm.rootX,_farmObject.rootY - _farm.rootY))
            {
               obf_0_K_4070.showWelcome("ish");
               sendSeedHarvest(_farmItem.itemCode,new Point(_farmObject.rootPX,_farmObject.rootPY));
               hideFarmState();
            }
            else if(!_farm.isInAvailableFarmArea(_farmObject.rootX - _farm.rootX,_farmObject.rootY - _farm.rootY))
            {
               hideFarmState();
            }
            else
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmPrompt","noMoreArea"));
               if(_farmItem.farmItemType == IconItemFarm.FARM_SEED)
               {
                  GameContext.currentMap.obf_b_h_1770.addObject(_farmObject);
               }
               else if(_farmItem.farmItemType == IconItemFarm.FARM_BUILDING)
               {
                  GameContext.currentMap.obf_4_h_2582.addObject(_farmObject);
               }
               _farmObject.showTileState = true;
            }
         }
      }
      
      public static function cureHarvest(param1:AIFarmHarvest) : void
      {
         var _loc2_:String = null;
         if(param1.obf_z_g_4271())
         {
            if(checkActionHaveCost(param1.currentPhaseConfig.cureConfig))
            {
               _loc2_ = getActionCostPrompt(param1.currentPhaseConfig.cureConfig);
               if(!checkActionCost(param1.currentPhaseConfig.cureConfig))
               {
                  WindowManager.showMessageBox(DiversityManager.getString("FarmPrompt","actionCost",[_loc2_]));
               }
               else
               {
                  WindowManager.showConfirmBox(DiversityManager.getString("FarmPrompt","actionConfirm",[_loc2_]),confirmAction,[param1.getPhaseChildConfig(param1.phaseIndex,"cureConfig","skillCode"),param1,null,null,param1.getPhaseChildConfig(param1.phaseIndex,"cureConfig","name")]);
               }
            }
            else
            {
               GameContext.localPlayer.sendSkill(param1.getPhaseChildConfig(param1.phaseIndex,"cureConfig","skillCode"),param1,null,null,param1.getPhaseChildConfig(param1.phaseIndex,"cureConfig","name"));
            }
         }
      }
      
      public static function obf_U_E_3190(param1:AIFarmHarvest) : void
      {
         var _loc2_:String = null;
         if(!param1.currentPhaseConfig)
         {
            obf_x_0_1295.obf_r_w_3556("obf_____4783（" + param1.code + "）obf__________36！");
            return;
         }
         if(param1.canCollect())
         {
            if(!obf_K_e_3075.playerBagUI.haveEmptyBag(1))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","playerBagFull"));
               return;
            }
            if(checkActionHaveCost(param1.currentPhaseConfig.collectConfig))
            {
               _loc2_ = getActionCostPrompt(param1.currentPhaseConfig.collectConfig);
               if(!checkActionCost(param1.currentPhaseConfig.collectConfig))
               {
                  WindowManager.showMessageBox(DiversityManager.getString("FarmPrompt","actionCost",[_loc2_]));
               }
               else
               {
                  WindowManager.showConfirmBox(DiversityManager.getString("FarmPrompt","actionConfirm",[_loc2_]),confirmAction,[param1.getPhaseChildConfig(param1.phaseIndex,"collectConfig","skillCode"),param1,null,null,param1.getPhaseChildConfig(param1.phaseIndex,"collectConfig","name")]);
               }
            }
            else
            {
               GameContext.localPlayer.sendSkill(param1.getPhaseChildConfig(param1.phaseIndex,"collectConfig","skillCode"),param1,null,null,param1.getPhaseChildConfig(param1.phaseIndex,"collectConfig","name"));
            }
         }
      }
      
      public static function obf_Y_H_4001(param1:AIFarmHarvest) : void
      {
         var _loc2_:String = null;
         if(!param1.obf_E_A_1702())
         {
            return;
         }
         if(checkActionHaveCost(param1.currentPhaseConfig.promoteConfig))
         {
            _loc2_ = getActionCostPrompt(param1.currentPhaseConfig.promoteConfig);
            if(!checkActionCost(param1.currentPhaseConfig.promoteConfig))
            {
               WindowManager.showMessageBox(DiversityManager.getString("FarmPrompt","actionCost",[_loc2_]));
            }
            else
            {
               WindowManager.showConfirmBox(DiversityManager.getString("FarmPrompt","actionConfirm",[_loc2_]),confirmAction,[param1.getPhaseChildConfig(param1.phaseIndex,"promoteConfig","skillCode"),param1,null,null,param1.getPhaseChildConfig(param1.phaseIndex,"promoteConfig","name")]);
            }
         }
         else
         {
            GameContext.localPlayer.sendSkill(param1.getPhaseChildConfig(param1.phaseIndex,"promoteConfig","skillCode"),param1,null,null,param1.getPhaseChildConfig(param1.phaseIndex,"promoteConfig","name"));
         }
      }
      
      private static function confirmAction(param1:Object) : void
      {
         if(param1.confirm)
         {
            GameContext.localPlayer.sendSkill.apply(null,param1.par);
         }
      }
      
      private static function checkActionHaveCost(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         if(!param1)
         {
            return false;
         }
         if(param1.cost)
         {
            var _loc3_:int = 0;
            var _loc4_:* = param1.cost;
            for(_loc2_ in _loc4_)
            {
               return true;
            }
         }
         if(JSONUtil.getInt(param1,["costGold"]) > 0 || JSONUtil.getInt(param1,["costMoney"]) > 0)
         {
            return true;
         }
         return false;
      }
      
      private static function checkActionCost(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         if(!param1)
         {
            return true;
         }
         if(JSONUtil.getInt(param1,["costGold"]) > 0 && GameContext.localPlayer.fullInfo.gold < JSONUtil.getInt(param1,["costGold"]))
         {
            return false;
         }
         if(JSONUtil.getInt(param1,["costMoney"]) > 0 && GameContext.localPlayer.fullInfo.money < JSONUtil.getInt(param1,["costMoney"]))
         {
            return false;
         }
         if(param1.cost)
         {
            for(_loc2_ in param1.cost)
            {
               if(!obf_L_l_4100.isEmpty(_loc2_))
               {
                  if(obf_K_e_3075.playerBagUI.getItemCount(_loc2_) < param1.cost[_loc2_])
                  {
                     return false;
                  }
               }
            }
         }
         return true;
      }
      
      private static function getActionCostPrompt(param1:Object) : String
      {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         var _loc2_:String = "";
         if(JSONUtil.getInt(param1,["costGold"]) > 0)
         {
            _loc2_ += obf_a_f_2935.getGoldString(param1.costGold,true) + "\n";
         }
         if(JSONUtil.getInt(param1,["costMoney"]) > 0)
         {
            _loc2_ += obf_a_f_2935.getMoneyString(param1.costMoney) + "\n";
         }
         if(param1.cost)
         {
            for(_loc3_ in param1.cost)
            {
               if(!obf_L_l_4100.isEmpty(_loc3_))
               {
                  _loc4_ = GameItemManager.getItemConfig(_loc3_);
                  _loc2_ += (_loc4_ != null ? _loc4_.name : "") + " x" + param1.cost[_loc3_] + "\n";
               }
            }
         }
         return _loc2_;
      }
      
      public static function obf_e_1_946(param1:AIFarmHarvest) : void
      {
         if(param1.canRemove())
         {
            GameContext.localPlayer.sendSkill(param1.getOperationSkillCode("remove"),param1,null,null,param1.getOperationName("remove"));
         }
      }
      
      public static function removeHarvest(param1:MapInteractiveObject) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:String = null;
         if(param1 is AIFarmHarvest || param1 is obf_F_L_3912)
         {
            if(param1 is AIFarmHarvest)
            {
               _loc2_ = (param1 as AIFarmHarvest).canRemove();
            }
            if(param1 is obf_F_L_3912)
            {
               _loc2_ = (param1 as obf_F_L_3912).canRemove();
            }
            if(_loc2_)
            {
               _loc3_ = "";
               if(param1 is AIFarmHarvest)
               {
                  _loc3_ = AIFarmHarvest(param1).getOperationName("remove");
               }
               else if(param1 is obf_F_L_3912)
               {
                  _loc3_ = DiversityManager.getString("FarmPrompt","removeActionName",[obf_F_L_3912(param1).obf_F_M_892]);
               }
               WindowManager.showConfirmBox(DiversityManager.getString("FarmPrompt","removeConfirm",[_loc3_]),confirmRemove,param1);
            }
            else
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmPrompt","contRemove"));
            }
         }
      }
      
      public static function confirmRemove(param1:Object) : void
      {
         if(param1.confirm)
         {
            if(param1.par is AIFarmHarvest)
            {
               obf_e_1_946(param1.par);
            }
            else if(param1.par is obf_F_L_3912)
            {
               sendRemoveBuilding(param1.par);
            }
            GameContext.localPlayer.obf_L_r_3810();
         }
      }
      
      private static function obf_0_0_J_319(param1:FarmHarvestInfo) : AIFarmHarvest
      {
         var _loc2_:AIFarmHarvest = new AIFarmHarvest(param1.code);
         _loc2_.createrId = param1.createrId;
         _loc2_.phaseIndex = param1.phaseIndex;
         _loc2_.phaseTimeLeftInSec = param1.phaseTimeLeftInSec;
         _loc2_.id = param1.id;
         _loc2_.isIll = param1.isIll;
         _loc2_.productNumberLeft = param1.productNumberLeft;
         _loc2_.productNumberTotal = param1.productNumberTotal;
         _loc2_.each = param1.productRate;
         _loc2_.moveToPixel(param1.x,param1.y);
         _loc2_.show();
         return _loc2_;
      }
      
      private static function obf__4793(param1:FarmBuildingInfo) : obf_F_L_3912
      {
         var _loc2_:obf_F_L_3912 = new obf_F_L_3912(param1.code);
         _loc2_.id = param1.id;
         _loc2_.moveToPixel(param1.x,param1.y);
         _loc2_.timeLeftInHour = param1.timeLeftInHour;
         return _loc2_;
      }
      
      public static function getKindName(param1:int) : String
      {
         if(param1 == obf_3_U_4495.PLANT)
         {
            return DiversityManager.getString("FarmSkillKindName","plant");
         }
         if(param1 == obf_3_U_4495.obf_0___D_549)
         {
            return DiversityManager.getString("FarmSkillKindName","crop");
         }
         if(param1 == obf_3_U_4495.obf_d_z_1837)
         {
            return DiversityManager.getString("FarmSkillKindName","animal");
         }
         if(param1 == obf_3_U_4495.obf_A_q_1072)
         {
            return DiversityManager.getString("FarmSkillKindName","mine");
         }
         return "";
      }
      
      public static function getFarmTempletLevelMaxExp(param1:String, param2:int) : int
      {
         var _loc3_:obf_n_v_1693 = FarmTempletManager.getFarmTemplet(param1);
         if(Boolean(_loc3_) && param2 <= _loc3_.levelInfo.length)
         {
            return _loc3_.levelInfo[param2 - 1].expCost;
         }
         return 0;
      }
      
      public static function teleportToFarm(param1:String, param2:String) : void
      {
         if(GameContext.localPlayer.fullInfo.attributes.sp < int(NumberConfig.getSettingObject("spCostPerTeleport")))
         {
            WindowManager.showMessageBox(DiversityManager.getString("CommonPrompt","noMoreSP"));
            return;
         }
         if(!obf_K_e_3075.worldMapUI.obf_L_c_4251())
         {
            if(!(Boolean(obf_K_e_3075.playerBagUI) && obf_K_e_3075.playerBagUI.getItemCount(WorldConfig.getStringSetting("mapTeleportItem")) > 0))
            {
               WindowManager.showMessageBox(DiversityManager.getString("WorldMapUI","teleportCD"));
               return;
            }
            WindowManager.showConfirmBox(DiversityManager.getString("WorldMapUI","confirmUseItemTeleport"),confirmTeleportFarm,[param1,param2,true]);
         }
         else
         {
            sendFarmTeleport(param1,param2,false);
         }
      }
      
      private static function confirmTeleportFarm(param1:Object) : void
      {
         if(param1.confirm)
         {
            sendFarmTeleport.apply(null,param1.par);
         }
      }
      
      public static function obf_G_F_2927() : void
      {
         var _loc1_:String = null;
         var _loc2_:AIFarmHarvest = null;
         if(!GameContext.currentMap)
         {
            return;
         }
         for(_loc1_ in GameContext.currentMap.obf_b_h_1770.obf_0_678)
         {
            _loc2_ = GameContext.currentMap.obf_b_h_1770.getObject(_loc1_) as AIFarmHarvest;
            if(_loc2_)
            {
               _loc2_.obf_Y_f_4243();
            }
         }
      }
      
      public static function sendSeedHarvest(param1:String, param2:Point) : void
      {
         var _loc4_:PlayerUseItemRequest = null;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc3_:IconItemBag = obf_K_e_3075.playerBagUI.getIconItemBagByCode(param1);
         if(Boolean(_loc3_) && Boolean(_loc3_.haveIconItem))
         {
            _loc4_ = new PlayerUseItemRequest();
            _loc4_.bagIndex = PlayerBagIndex.PLAYER_MAIN_BAG;
            _loc4_.itemIndex = _loc3_.itemIndex;
            _loc4_.mapId = GameContext.currentMap.mapId;
            _loc4_.targetPoint = MapPoint.PointToMapPoint(param2);
            _loc5_ = GameItemManager.getItemConfig(param1);
            if(IconItemFarm(_loc3_.haveIconItem).farmItemType == IconItemFarm.FARM_SEED)
            {
               if(_loc5_)
               {
                  _loc6_ = obf_P_f_3747.getFarmHarvestInfo(_loc5_.properties.harvestCode);
               }
               if(Boolean(_loc6_) && Boolean(_loc6_.operationConfig) && Boolean(_loc6_.operationConfig.seed))
               {
                  GameContext.localPlayer.sendSkill(_loc6_.operationConfig.seed.skillCode,null,param2,_loc4_,_loc6_.operationConfig.seed.name);
               }
            }
            else
            {
               GameContext.worldClient.sendCommand(_loc4_);
            }
         }
      }
      
      public static function sendRemoveBuilding(param1:obf_F_L_3912) : void
      {
         if(!GameContext.currentMap)
         {
            return;
         }
         var _loc2_:FarmBuildingRemoveRequest = new FarmBuildingRemoveRequest();
         _loc2_.farmBuildingId = param1.id;
         _loc2_.mapId = GameContext.currentMap.mapId;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendFarmRename(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:FarmRenameRequest = new FarmRenameRequest();
         _loc4_.farmId = param2;
         _loc4_.mapId = param1;
         _loc4_.newName = param3;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public static function sendFarmLevelUp(param1:String, param2:String) : void
      {
         var _loc3_:FarmLevelUpRequest = new FarmLevelUpRequest();
         _loc3_.farmId = param1;
         _loc3_.mapId = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendBuyFarmStyle(param1:String, param2:String, param3:String, param4:Boolean) : void
      {
         var _loc5_:FarmChangeStyleRequest = new FarmChangeStyleRequest();
         _loc5_.farmId = param2;
         _loc5_.mapId = param1;
         _loc5_.newStyleCode = param3;
         _loc5_.useMoney = param4;
         GameContext.worldClient.sendCommand(_loc5_);
      }
      
      public static function sendFarmTeleport(param1:String, param2:String, param3:Boolean) : void
      {
         if(!GameContext.localPlayer.canTeleport())
         {
            return;
         }
         var _loc4_:FarmTeleportRequest = new FarmTeleportRequest();
         _loc4_.toFarmFullId = param1;
         _loc4_.toFarmOfPlayerId = param2;
         _loc4_.useItem = param3;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public static function sendHarvestCollectTest(param1:String) : void
      {
         var _loc2_:FarmHarvestCollectTestRequest = new FarmHarvestCollectTestRequest();
         _loc2_.farmHarvestId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendUseImproveItem(param1:MapInteractiveObject, param2:String, param3:int, param4:int, param5:int, param6:int) : void
      {
         var _loc7_:AIFarmHarvest = null;
         if(param1 is AIFarmHarvest)
         {
            _loc7_ = param1 as AIFarmHarvest;
            if(!_loc7_.obf_I_K_2631(param5,param6))
            {
               return;
            }
            GameContext.bagItemManager.sendUseItem(param2,param3,param4,null,param1);
            obf_0_9_V_473.showEffectOnObject(GameContext.currentMap,param1,"C_HarvestImprove");
         }
      }
      
      public static function sendHarvestQuery(param1:String) : void
      {
         var _loc2_:FarmHarvestQueryRequest = new FarmHarvestQueryRequest();
         _loc2_.productCode = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(!GameContext.currentMap)
         {
            return;
         }
         if(param1.code == CommandCodePlayer.PLAYER_VIEW_MAP_ANSWER)
         {
            onViewMap(param1 as PlayerViewMapAnswer);
         }
         else if(param1.code == CommandCodeFarm.FARM_HARVEST_ADDED_NOTIFY)
         {
            obf_0_7_S_594(param1 as FarmHarvestAddedNotify);
         }
         else if(param1.code == CommandCodeFarm.FARM_HARVEST_CHECK_NOTIFY)
         {
            obf_K_F_3476(param1 as FarmHarvestCheckNotify);
         }
         else if(param1.code == CommandCodeFarm.FARM_HARVEST_REMOVED_NOTIFY)
         {
            obf_3_b_4087(param1 as FarmHarvestRemovedNotify);
         }
         else if(param1.code == CommandCodeFarm.FARM_BUILDING_ADDED_NOTIFY)
         {
            obf_d_P_2422(param1 as FarmBuildingAddedNotify);
         }
         else if(param1.code == CommandCodeFarm.FARM_BUILDING_REMOVED_NOTIFY)
         {
            obf_k_U_3408(param1 as FarmBuildingRemovedNotify);
         }
         else if(param1.code == CommandCodeFarm.FARM_EXP_CHANGE_NOTIFY)
         {
            obf_x_R_1636(param1 as FarmExpChangeNotify);
         }
         else if(param1.code == CommandCodeFarm.FARM_CHECK_NOTIFY)
         {
            obf_v_9_3335(param1 as FarmCheckNotify);
         }
         else if(param1.code == CommandCodeFarm.FARM_LIST_CHECK_NOTIFY)
         {
            obf_0_5_j_256(param1 as FarmListCheckNotify);
         }
         else if(param1.code == CommandCodeFarm.FARM_HARVEST_COLLECT_TEST_ANSWER)
         {
            obf_C_s_4042(param1 as FarmHarvestCollectTestAnswer);
         }
         else if(param1.code == CommandCodeFarm.FARM_HARVEST_QUERY_ANSWER)
         {
            obf_x_D_1981(param1 as FarmHarvestQueryAnswer);
         }
      }
      
      private static function onViewMap(param1:PlayerViewMapAnswer) : void
      {
         var _loc2_:FarmInfo = null;
         var _loc3_:FarmHarvestInfo = null;
         var _loc4_:FarmBuildingInfo = null;
         var _loc5_:obf_0_1_N_478 = null;
         var _loc6_:AIFarmHarvest = null;
         var _loc7_:obf_F_L_3912 = null;
         if(!GameContext.currentMap)
         {
            return;
         }
         for each(_loc2_ in param1.farmsInUse)
         {
            _loc5_ = GameContext.currentMap.obf_v_P_2126.getFarm(_loc2_.id);
            if(_loc5_)
            {
               _loc5_.ownerId = _loc2_.ownerId;
               _loc5_.farmName = _loc2_.name;
               _loc5_.currentLevel = _loc2_.currentLevel;
               if(_loc2_.styleCode != "")
               {
                  _loc5_.obf_v_t_1412(obf_F_R_1745.getFarmStyleRes(_loc2_.styleCode));
               }
               _loc5_.obf_Q_z_861();
            }
         }
         for each(_loc3_ in param1.farmHarvests)
         {
            _loc6_ = obf_0_0_J_319(_loc3_);
            if(_loc6_)
            {
               GameContext.currentMap.obf_b_h_1770.addObject(_loc6_);
            }
         }
         for each(_loc4_ in param1.farmBuildings)
         {
            _loc7_ = obf__4793(_loc4_);
            if(_loc7_)
            {
               GameContext.currentMap.obf_4_h_2582.addObject(_loc7_);
            }
         }
         GameContext.currentMap.obf_W_t_3446();
      }
      
      private static function obf_0_7_S_594(param1:FarmHarvestAddedNotify) : void
      {
         if(!GameContext.currentMap || GameContext.currentMap.mapId != param1.mapId)
         {
            return;
         }
         var _loc2_:AIFarmHarvest = obf_0_0_J_319(param1.harvest);
         if(_loc2_)
         {
            GameContext.currentMap.obf_b_h_1770.addObject(_loc2_);
         }
         if(_loc2_.hasUnmovablePoint)
         {
            GameContext.currentMap.obf_W_t_3446();
         }
      }
      
      private static function obf_K_F_3476(param1:FarmHarvestCheckNotify) : void
      {
         if(GameContext.currentMap.mapId != param1.mapId)
         {
            return;
         }
         var _loc2_:AIFarmHarvest = GameContext.currentMap.obf_b_h_1770.getObject(param1.harvest.id) as AIFarmHarvest;
         if(_loc2_)
         {
            _loc2_.doCommand(param1);
         }
      }
      
      private static function obf_3_b_4087(param1:FarmHarvestRemovedNotify) : void
      {
         if(GameContext.currentMap.mapId != param1.mapId)
         {
            return;
         }
         var _loc2_:AIFarmHarvest = GameContext.currentMap.obf_b_h_1770.getObject(param1.harvestId) as AIFarmHarvest;
         if(_loc2_)
         {
            GameContext.currentMap.obf_b_h_1770.removeObject(_loc2_,true);
         }
         if(_loc2_.hasUnmovablePoint)
         {
            GameContext.currentMap.obf_W_t_3446();
         }
      }
      
      private static function obf_d_P_2422(param1:FarmBuildingAddedNotify) : void
      {
         if(GameContext.currentMap.mapId != param1.mapId)
         {
            return;
         }
         var _loc2_:obf_F_L_3912 = obf__4793(param1.building);
         if(_loc2_)
         {
            GameContext.currentMap.obf_4_h_2582.addObject(_loc2_);
         }
         if(_loc2_.hasUnmovablePoint)
         {
            GameContext.currentMap.obf_W_t_3446();
         }
      }
      
      private static function obf_k_U_3408(param1:FarmBuildingRemovedNotify) : void
      {
         if(GameContext.currentMap.mapId != param1.mapId)
         {
            return;
         }
         var _loc2_:obf_F_L_3912 = GameContext.currentMap.obf_4_h_2582.getObject(param1.buildingId) as obf_F_L_3912;
         if(_loc2_)
         {
            GameContext.currentMap.obf_4_h_2582.removeObject(_loc2_);
         }
         if(_loc2_.hasUnmovablePoint)
         {
            GameContext.currentMap.obf_W_t_3446();
         }
      }
      
      private static function obf_x_R_1636(param1:FarmExpChangeNotify) : void
      {
         var _loc2_:LocalPlayerFarmInfo = null;
         var _loc3_:LocalPlayerFarmInfo = null;
         if(Boolean(GameContext.localPlayer.fullInfo.mainFarm) && Boolean(GameContext.localPlayer.fullInfo.mainFarm.farmId == param1.farmId) && GameContext.localPlayer.fullInfo.mainFarm.mapId == param1.mapId)
         {
            GameContext.localPlayer.fullInfo.mainFarm.farmExp = param1.expCurrent;
            _loc3_ = GameContext.localPlayer.fullInfo.mainFarm;
            obf_K_e_3075.obf_0_7_E_147(_loc3_.farmId + "@" + _loc3_.mapId,param1.expCurrent,getFarmTempletLevelMaxExp(_loc3_.templetCode,_loc3_.currentLevel));
         }
         for each(_loc2_ in GameContext.localPlayer.fullInfo.extraFarmArray)
         {
            if(_loc2_.farmId == param1.farmId && _loc2_.mapId == param1.mapId)
            {
               _loc2_.farmExp = param1.expCurrent;
               obf_K_e_3075.obf_0_7_E_147(_loc2_.farmId + "@" + _loc2_.mapId,_loc2_.farmExp,getFarmTempletLevelMaxExp(_loc2_.templetCode,_loc2_.currentLevel));
            }
         }
         if(param1.expChanged > 0)
         {
            GameContext.localPlayer.obf_0_1_S_307(param1.expChanged,obf_0_0_8_669.obf_0_x_2302,DiversityManager.getString("FarmPrompt","farmExp") + " +");
            obf_6_D_3816.print(DiversityManager.getString("FarmPrompt","farmExpAdd",[param1.expChanged]));
         }
      }
      
      private static function obf_v_9_3335(param1:FarmCheckNotify) : void
      {
         var _loc3_:LocalPlayerFarmInfo = null;
         var _loc2_:Array = [GameContext.localPlayer.fullInfo.mainFarm].concat(GameContext.localPlayer.fullInfo.extraFarmArray);
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.farmId == param1.farm.id && _loc3_.mapId == param1.mapId)
            {
               if(_loc3_.currentLevel < param1.farm.currentLevel)
               {
                  obf_0_9_V_473.showEffectOnObject(GameContext.currentMap,GameContext.localPlayer,"C_FarmLevelUp");
               }
               _loc3_.currentLevel = param1.farm.currentLevel;
               _loc3_.styleCode = param1.farm.styleCode;
               _loc3_.name = param1.farm.name;
               obf_K_e_3075.obf_0_7_E_147(_loc3_.farmId + "@" + _loc3_.mapId,_loc3_.farmExp,getFarmTempletLevelMaxExp(_loc3_.templetCode,_loc3_.currentLevel));
               obf_K_e_3075.obf_j_v_3331(_loc3_.farmId + "@" + _loc3_.mapId,_loc3_.currentLevel);
            }
         }
         if(GameContext.currentMap.mapId != param1.mapId)
         {
            return;
         }
         var _loc4_:obf_0_1_N_478 = GameContext.currentMap.obf_v_P_2126.getFarm(param1.farm.id);
         if(_loc4_)
         {
            _loc4_.farmName = param1.farm.name;
            _loc4_.currentLevel = param1.farm.currentLevel;
            _loc4_.ownerId = param1.farm.ownerId;
            _loc4_.obf_Q_z_861();
            if(obf_F_R_1745.getFarmStyleRes(param1.farm.styleCode) != "")
            {
               _loc4_.obf_v_t_1412(obf_F_R_1745.getFarmStyleRes(param1.farm.styleCode));
            }
            else
            {
               _loc4_.obf_v_t_1412(FarmTempletManager.getFarmTemplet(_loc4_.templetCode).res);
            }
         }
      }
      
      private static function obf_0_5_j_256(param1:FarmListCheckNotify) : void
      {
         if(GameContext.localPlayer)
         {
            GameContext.localPlayer.fullInfo.mainFarm = param1.mainFarm;
            GameContext.localPlayer.fullInfo.extraFarmArray = param1.extraFarmArray;
            obf_K_e_3075.setFarmInfo([param1.mainFarm].concat(param1.extraFarmArray));
         }
      }
      
      private static function obf_C_s_4042(param1:FarmHarvestCollectTestAnswer) : void
      {
         var _loc2_:AIFarmHarvest = null;
         if(GameContext.currentMap)
         {
            _loc2_ = GameContext.currentMap.obf_b_h_1770.getObject(param1.farmHarvestId) as AIFarmHarvest;
            if(_loc2_)
            {
               _loc2_.doCommand(param1);
            }
         }
      }
      
      private static function obf_x_D_1981(param1:FarmHarvestQueryAnswer) : void
      {
      }
      
      public static function destroy() : void
      {
         removeListener();
         _farmObject = null;
         _farm = null;
         _mapSprite = null;
         _farmItem = null;
      }
   }
}

