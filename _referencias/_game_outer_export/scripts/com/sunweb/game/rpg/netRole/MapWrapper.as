package com.sunweb.game.rpg.netRole
{
   import obf_Z_U_3013.obf_L_4641;
   import obf_r_4635.obf_R_6_1363;
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.bless.obf_G_4_4620;
   import com.sunweb.game.rpg.booth.obf_c_o_n_t_i_n_u_e_24;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.farm.AIFarmHarvest;
   import com.sunweb.game.rpg.farm.FarmManager;
   import com.sunweb.game.rpg.farm.obf_F_L_3912;
   import com.sunweb.game.rpg.farm.obf_F_a_1500;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.map.Map;
   import com.sunweb.game.rpg.map.MapInteractiveObject;
   import com.sunweb.game.rpg.map.obf_0_3_x_417;
   import com.sunweb.game.rpg.map.obf_6_H_3213;
   import com.sunweb.game.rpg.map.obf_c_4_964;
   import com.sunweb.game.rpg.map.obf_z_T_3316;
   import com.sunweb.game.rpg.playerUI.ControlBarUI;
   import com.sunweb.game.rpg.playerUI.PlayerMenuUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.obf_0_M_3913;
   import com.sunweb.game.rpg.role.obf_0_Y_3475;
   import com.sunweb.game.rpg.script.DynamicVars;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.rpg.skill.SkillAreaAimManager;
   import com.sunweb.game.rpg.skill.SkillManager;
   import com.sunweb.game.rpg.task.TaskManager;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.map.MapItemInfo;
   import com.sunweb.game.rpg.world.map.MapManager;
   import com.sunweb.game.rpg.world.ui.MouseCursor;
   import com.sunweb.game.rpg.worldZone.command.map.CommandCodeMap;
   import com.sunweb.game.rpg.worldZone.command.map.MapDamageRankCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.map.MapDamageValueCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.map.MapItemAddedNotify;
   import com.sunweb.game.rpg.worldZone.command.map.MapItemRemovedNotify;
   import com.sunweb.game.rpg.worldZone.command.map.MapNpcSayNotify;
   import com.sunweb.game.rpg.worldZone.command.map.MapRefreshNotify;
   import com.sunweb.game.rpg.worldZone.command.map.MapVarChangeNotify;
   import com.sunweb.game.rpg.worldZone.command.map.MapVarClearNotify;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   import com.sunweb.game.rpg.worldZone.command.player.PlayerEnterMapRequest;
   import com.sunweb.game.rpg.worldZone.command.player.PlayerViewMapAnswer;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.util.obf_e_P_918;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapWrapper extends EventDispatcher implements obf_c_4_964
   {
      
      private var _map:Map;
      
      private var mouseMoveTime:TimeLimiter = new TimeLimiter(200);
      
      public function MapWrapper()
      {
         super();
      }
      
      public function set map(param1:Map) : void
      {
         if(this._map)
         {
            this.removeListener();
         }
         this._map = param1;
         this._map.setListener(this);
         this._map.obf_b_w_4360 = true;
         this.addListener();
      }
      
      public function get map() : Map
      {
         return this._map;
      }
      
      private function addListener() : void
      {
         if(!this._map)
         {
            return;
         }
         this._map.addEventListener(MouseEvent.CLICK,this.onMapClick);
         this._map.addEventListener(MouseEvent.MOUSE_MOVE,this.onMapMouseMove);
         this._map.addEventListener(MouseEvent.MOUSE_OUT,this.onMapMouseOut,false,999);
      }
      
      private function removeListener() : void
      {
         if(!this._map)
         {
            return;
         }
         this._map.removeEventListener(MouseEvent.CLICK,this.onMapClick);
         this._map.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMapMouseMove);
         this._map.removeEventListener(MouseEvent.MOUSE_OUT,this.onMapMouseOut);
      }
      
      private function onMapClick(param1:MouseEvent) : void
      {
         var _loc3_:AIFarmHarvest = null;
         var _loc4_:AINpc = null;
         var _loc2_:MapInteractiveObject = this._map.getObjectUnderPoint(this._map.mouseX,this._map.mouseY,null,this.selectMapObjectFilter);
         if(SkillAreaAimManager.isPresent)
         {
            return;
         }
         if(Boolean(_loc2_ && !param1.ctrlKey) && Boolean(!(_loc2_ is obf_0_3_x_417)) && !(_loc2_ is obf_Z_L_1552))
         {
            if(GameContext.localPlayer)
            {
               if(GameContext.localPlayer.obf_Z_y_1644(_loc2_))
               {
                  return;
               }
            }
            if(_loc2_ is obf_0_M_3913 && _loc2_ != GameContext.localPlayer || _loc2_ is obf_T_L_801 && !obf_T_L_801(_loc2_).isDead || _loc2_ is obf_9_c_4534 && _loc2_ != GameContext.localPlayer.obf_F_o_1931)
            {
               if(JSONUtil.getBoolean(GameContext.userConfig,["sst","cat"],true))
               {
                  GameContext.localPlayer.selectTarget(_loc2_);
               }
               if(!param1.shiftKey && GameContext.localPlayer.obf_0_6_a_430 == _loc2_ && SkillManager.instance.checkTarget(PlayerSkillManager.defaultAttackSkillObj,_loc2_))
               {
                  if(_loc2_ is obf_T_L_801 && !obf_L_l_4100.isEmpty((_loc2_ as obf_T_L_801).config.petCode))
                  {
                     PlayerSkillManager.useCatchPetSkill(_loc2_ as obf_T_L_801);
                  }
                  else
                  {
                     PlayerSkillManager.useDefaultAttackSkill();
                  }
               }
               GameContext.localPlayer.selectTarget(_loc2_);
               if(_loc2_ is obf_Y_E_3667)
               {
                  if((_loc2_ as obf_Y_E_3667).isBooth)
                  {
                     GameContext.localPlayer.obf_g_R_3687(new Point(_loc2_.rootPX,_loc2_.rootPY),WorldConfig.getValue("booth","visitDistance"),obf_c_o_n_t_i_n_u_e_24.sendViewBooth,[_loc2_.id]);
                  }
                  else if((_loc2_ as obf_Y_E_3667).isBlessing)
                  {
                     GameContext.localPlayer.obf_g_R_3687(new Point(_loc2_.rootPX,_loc2_.rootPY),WorldConfig.getValue("booth","visitDistance"),obf_G_4_4620.sendViewBlessBooth,[_loc2_.id]);
                  }
               }
            }
            else if(_loc2_ is AINpc)
            {
               if(_loc2_ is AINpc)
               {
                  if(GameContext.localPlayer.getLineDistance(_loc2_) <= WorldConfig.MAX_NPC_TALK_DISTANCE)
                  {
                     obf_K_e_3075.showNpcTalkBox(_loc2_ as AINpc);
                  }
                  else
                  {
                     GameContext.localPlayer.obf_g_R_3687(new Point(_loc2_.rootPX,_loc2_.rootPY),WorldConfig.MAX_NPC_TALK_DISTANCE,obf_K_e_3075.showNpcTalkBox,[_loc2_]);
                  }
               }
            }
            else if(_loc2_ is obf_z_T_3316)
            {
               GameContext.bagItemManager.sendPickUpItem(_loc2_.id);
            }
            else if(_loc2_ is AIFarmHarvest)
            {
               _loc3_ = _loc2_ as AIFarmHarvest;
               if(_loc3_.isIll)
               {
                  FarmManager.cureHarvest(_loc3_);
               }
               else if(_loc3_.productNumberLeft > 0)
               {
                  FarmManager.obf_U_E_3190(_loc3_);
               }
               else if(Boolean(_loc3_.currentPhaseConfig) && _loc3_.currentPhaseConfig.phaseType == obf_F_a_1500.obf_F_g_4535)
               {
                  FarmManager.obf_Y_H_4001(_loc3_);
               }
            }
            else if(_loc2_ is obf_F_L_3912)
            {
            }
         }
         else if(Boolean(param1.ctrlKey) && Boolean(_loc2_) && _loc2_ is AINpc)
         {
            if(obf_K_e_3075.obf_e_q_2572)
            {
               _loc4_ = _loc2_ as AINpc;
               obf_K_e_3075.obf_e_q_2572.addNPCPointLink(_loc4_.npcName,_loc4_.id,_loc4_.mapId);
            }
         }
         else if(Boolean(GameContext.localPlayer) && !param1.shiftKey)
         {
            GameContext.localPlayer.obf_I_V_3724(this._map.mouseX,this._map.mouseY);
            obf_R_6_1363.stopBot();
            TaskManager.isAutoTask = false;
            GameContext.localPlayer.stopAutoAttack();
            GameContext.localPlayer.obf_m_0_2998();
            if(GameContext.localPlayer.isSelectTargetToDo && GameContext.localPlayer.obf_c_6_1007 == ControlBarUI.TARGET_TODO_ACTION_REMOVE)
            {
               GameContext.localPlayer.obf_L_r_3810();
            }
            GameContext.localPlayer.obf_L_r_3810();
         }
         PlayerMenuUI.closeAllMenu();
         obf_K_e_3075.obf_c_D_2721 = obf_K_e_3075.obf_s_r_1801;
      }
      
      private function selectMapObjectFilter(param1:MapInteractiveObject) : Boolean
      {
         if(param1 is obf_t_T_3981)
         {
            return false;
         }
         if(param1 is obf_L_4641)
         {
            return false;
         }
         return true;
      }
      
      private function onMapMouseMove(param1:MouseEvent) : void
      {
         if(Boolean(this._map) && Boolean(this.mouseMoveTime.checkTimeout()) && this._map.getTrackingObject() == null)
         {
            if(!GameContext.localPlayer.isSelectTargetToDo && obf_K_e_3075.obf_c_D_2721 == obf_K_e_3075.obf_s_r_1801)
            {
               obf_e_P_918.useCursor(this._map.canWalk(this._map.mouseX,this._map.mouseY) ? MouseCursor.CURSOR_DEFAULT : MouseCursor.CURSOR_UNMOVE);
            }
            else
            {
               obf_K_e_3075.obf_S_Y_4185();
            }
         }
      }
      
      private function onMapMouseOut(param1:Event) : void
      {
         obf_K_e_3075.obf_S_Y_4185();
      }
      
      public function onObjectInSight(param1:MapInteractiveObject) : void
      {
         var _loc2_:obf_0_Y_3475 = null;
         var _loc3_:String = null;
         var _loc4_:DisplayObject = null;
         if(Boolean(obf_K_e_3075.systemSettingUI) && Boolean(obf_K_e_3075.systemSettingUI.openEffMap))
         {
            if(param1 is obf_0_Y_3475)
            {
               _loc2_ = param1 as obf_0_Y_3475;
               for(_loc3_ in _loc2_.flagMap)
               {
                  _loc4_ = _loc2_.flagMap[_loc3_] as DisplayObject;
                  if(obf_K_e_3075.systemSettingUI.openEffMap[_loc3_])
                  {
                     _loc4_.visible = false;
                  }
                  else
                  {
                     _loc4_.visible = true;
                  }
               }
            }
         }
      }
      
      public function onObjectOutSight(param1:MapInteractiveObject) : void
      {
         if(Boolean(GameContext.localPlayer) && param1 === GameContext.localPlayer.obf_0_6_a_430)
         {
            GameContext.localPlayer.obf_3_v_4336();
         }
      }
      
      public function onMouseTracking(param1:MapInteractiveObject, param2:Point) : void
      {
         if(param1 != null && GameContext.currentMap.containsPoint(new Point(GameContext.gameStage.mouseX,GameContext.gameStage.mouseY)))
         {
            if(param1 is obf_Y_E_3667 || param1 is obf_T_L_801 || param1 is obf_9_c_4534)
            {
               if(SkillManager.instance.checkTarget(PlayerSkillManager.defaultAttackSkillObj,param1))
               {
                  obf_e_P_918.useCursor(MouseCursor.CURSOR_ATTACK);
               }
            }
         }
      }
      
      public function onPlayerReachExit(param1:obf_6_H_3213) : void
      {
         var _loc2_:PlayerEnterMapRequest = new PlayerEnterMapRequest();
         _loc2_.fromExitId = param1.exitId;
         _loc2_.fromMapId = this._map.mapId;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      private function createMapItem(param1:MapItemInfo) : obf_z_T_3316
      {
         var _loc2_:Object = GameItemManager.getItemConfig(param1.itemCode);
         var _loc3_:obf_z_T_3316 = new obf_z_T_3316(param1.itemId,param1.itemCode,_loc2_ != null ? _loc2_.icon : "");
         _loc3_.moveToPixel(param1.x,param1.y);
         var _loc4_:String = param1.itemCount > 1 ? " x" + param1.itemCount : "";
         _loc3_.setAndShowLabel(_loc2_ != null ? _loc2_.name + _loc4_ : DiversityManager.getString("ItemPrompt","unknowItem"));
         _loc3_.labelColor = GameItemRank.getRankColor(_loc2_.rank);
         _loc3_.obf_H_4702(param1.protectionTimeLeft);
         return _loc3_;
      }
      
      public function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayer.PLAYER_VIEW_MAP_ANSWER)
         {
            this.onViewMap(param1 as PlayerViewMapAnswer);
         }
         else if(param1.code == CommandCodeMap.MAP_ITEM_ADDED_NOTIFY)
         {
            this.onMapItemAdded(param1 as MapItemAddedNotify);
         }
         else if(param1.code == CommandCodeMap.MAP_ITEM_REMOVED_NOTIFY)
         {
            this.onMapItemRemoved(param1 as MapItemRemovedNotify);
         }
         else if(param1.code == CommandCodeMap.MAP_VAR_CHANGE_NOTIFY)
         {
            this.obf_0___7_670(param1 as MapVarChangeNotify);
         }
         else if(param1.code == CommandCodeMap.MAP_VAR_CLEAR_NOTIFY)
         {
            this.obf_8_b_3670(param1 as MapVarClearNotify);
         }
         else if(param1.code == CommandCodeMap.MAP_NPC_SAY_NOTIFY)
         {
            this.obf_o_w_1909(param1 as MapNpcSayNotify);
         }
         else if(param1.code == CommandCodeMap.MAP_REFRESH_NOTIFY)
         {
            this.obf_3_2_4432(param1 as MapRefreshNotify);
         }
         else if(param1.code == CommandCodeMap.MAP_DAMAGE_RANK_CHECK_NOTIFY)
         {
            this.obf_o_B_3130(param1 as MapDamageRankCheckNotify);
         }
         else if(param1.code == CommandCodeMap.MAP_DAMAGE_VALUE_CHECK_NOTIFY)
         {
            this.obf_c_u_936(param1 as MapDamageValueCheckNotify);
         }
      }
      
      private function onViewMap(param1:PlayerViewMapAnswer) : void
      {
         var _loc2_:MapItemInfo = null;
         var _loc3_:obf_z_T_3316 = null;
         if(!this._map || this._map.mapId != param1.mapId)
         {
            return;
         }
         DynamicVars.mapVar = param1.mapVars;
         for each(_loc2_ in param1.items)
         {
            _loc3_ = null;
            _loc3_ = this.createMapItem(_loc2_);
            this._map.itemSet.addObject(_loc3_);
         }
         if(obf_K_e_3075.mapUI)
         {
            obf_K_e_3075.mapUI.obf_t_w_1459();
         }
         if(obf_K_e_3075.obf_o_J_3931)
         {
            if(JSONUtil.getBoolean(MapManager.instance.mapInfo,["rules","damageRecRule","enableDamageRec"]))
            {
               obf_K_e_3075.showUI(obf_K_e_3075.obf_o_J_3931);
            }
            else
            {
               obf_K_e_3075.closeUI(obf_K_e_3075.obf_o_J_3931);
            }
         }
         if(obf_K_e_3075.monsterNumUI)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.monsterNumUI);
            if(JSONUtil.getBoolean(MapManager.instance.mapInfo,["rules","monsterNum","isShow"]))
            {
               obf_K_e_3075.showUI(obf_K_e_3075.monsterNumUI);
            }
            else
            {
               obf_K_e_3075.closeUI(obf_K_e_3075.monsterNumUI);
            }
         }
         if(obf_K_e_3075.obf_6_R_3560)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.obf_6_R_3560);
            if(JSONUtil.getBoolean(MapManager.instance.mapInfo,["rules","copyInfoRule","isShow"]))
            {
               obf_K_e_3075.showUI(obf_K_e_3075.obf_6_R_3560);
            }
            else
            {
               obf_K_e_3075.closeUI(obf_K_e_3075.obf_6_R_3560);
            }
         }
      }
      
      private function onMapItemAdded(param1:MapItemAddedNotify) : void
      {
         if(!this._map || this._map.mapId != param1.mapId)
         {
            return;
         }
         var _loc2_:obf_z_T_3316 = this.createMapItem(param1.item);
         this._map.itemSet.addObject(_loc2_);
      }
      
      private function onMapItemRemoved(param1:MapItemRemovedNotify) : void
      {
         if(!this._map || this._map.mapId != param1.mapId)
         {
            return;
         }
         var _loc2_:obf_z_T_3316 = this._map.itemSet.getObject(param1.itemId) as obf_z_T_3316;
         if(_loc2_)
         {
            this._map.itemSet.removeObject(_loc2_,true);
         }
      }
      
      private function obf_0___7_670(param1:MapVarChangeNotify) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(!DynamicVars.mapVar)
         {
            DynamicVars.mapVar = new DynamicVars();
         }
         for(_loc2_ in param1.boolVars)
         {
            DynamicVars.mapVar.addBoolVar(_loc2_,param1.boolVars[_loc2_]);
         }
         for(_loc3_ in param1.intVars)
         {
            DynamicVars.mapVar.addIntVar(_loc3_,param1.intVars[_loc3_]);
         }
      }
      
      private function obf_8_b_3670(param1:MapVarClearNotify) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(!DynamicVars.mapVar)
         {
            return;
         }
         for each(_loc2_ in param1.boolVars)
         {
            DynamicVars.mapVar.delBoolVar(_loc2_);
         }
         for each(_loc3_ in param1.intVars)
         {
            DynamicVars.mapVar.delIntVar(_loc3_);
         }
      }
      
      private function obf_o_w_1909(param1:MapNpcSayNotify) : void
      {
         var _loc2_:String = null;
         var _loc3_:AINpc = null;
         if(!GameContext.currentMap)
         {
            return;
         }
         for(_loc2_ in param1.npcSay)
         {
            _loc3_ = GameContext.currentMap.npcSet.getObject(_loc2_) as AINpc;
            if(_loc3_)
            {
               _loc3_.say(param1.npcSay[_loc2_]);
            }
         }
      }
      
      private function obf_3_2_4432(param1:MapRefreshNotify) : void
      {
         MapManager.instance.obf_5_G_1974();
         FarmManager.obf_G_F_2927();
      }
      
      private function obf_o_B_3130(param1:MapDamageRankCheckNotify) : void
      {
         if(Boolean(GameContext.currentMap) && param1.mapId == GameContext.currentMap.mapId)
         {
            MapManager.instance.setMyMapDPSRank(param1.myRank,param1.mapId);
            obf_K_e_3075.obf_o_J_3931.setDPSRank(param1.damageRankList);
         }
      }
      
      private function obf_c_u_936(param1:MapDamageValueCheckNotify) : void
      {
         obf_K_e_3075.obf_o_J_3931.setMyDPS(param1.damageValue);
      }
   }
}

