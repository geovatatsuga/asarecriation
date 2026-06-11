package com.sunweb.game.rpg.netRole
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.buff.BuffInfo;
   import com.sunweb.game.rpg.buff.BuffManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.map.Map;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.RemotePlayerInfo;
   import com.sunweb.game.rpg.role.obf_0_9_V_473;
   import com.sunweb.game.rpg.role.obf_0_M_3913;
   import com.sunweb.game.rpg.role.obf_I_5_1944;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.map.MapPoint;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   import com.sunweb.game.rpg.worldZone.command.player.PlayerViewMapAnswer;
   import com.sunweb.game.rpg.worldZone.command.remote.CommandCodeRemotePlayer;
   import com.sunweb.game.rpg.worldZone.command.remote.RemoteChangeModelNotify;
   import com.sunweb.game.rpg.worldZone.command.remote.RemoteEnterMapNotify;
   import com.sunweb.game.rpg.worldZone.command.remote.RemoteEquipmentModelCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.remote.RemoteHpChangeNotify;
   import com.sunweb.game.rpg.worldZone.command.remote.RemoteLeaveMapNotify;
   import com.sunweb.game.rpg.worldZone.command.remote.RemoteLevelUpNotify;
   import com.sunweb.game.rpg.worldZone.command.remote.RemoteMpChangeNotify;
   import com.sunweb.game.rpg.worldZone.command.remote.RemoteRideCheckNotify;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import com.sunweb.game.utils.obf_L_l_4100;
   
   public class RemotePlayerManager
   {
      
      public function RemotePlayerManager()
      {
         super();
      }
      
      public static function dispatchCommand(param1:obf_C_m_1350, param2:Map) : void
      {
         var cmdObj:Object = null;
         var thisRemote:RemotePlayer = null;
         var cmd:obf_C_m_1350 = param1;
         var map:Map = param2;
         try
         {
            if(cmd.code == CommandCodeRemotePlayer.REMOTE_ENTER_NOTIFY)
            {
               onRemoteEnter(cmd as RemoteEnterMapNotify,map);
            }
            else if(cmd.code == CommandCodeRemotePlayer.REMOTE_LEAVE_NOTIFY)
            {
               onRemoteLeave(cmd as RemoteLeaveMapNotify,map);
            }
            else if(cmd.code == CommandCodePlayer.PLAYER_VIEW_MAP_ANSWER)
            {
               onViewMap(cmd as PlayerViewMapAnswer,map);
            }
            else if(cmd.code == CommandCodeRemotePlayer.REMOTE_HP_CHANGE_NOTIFY)
            {
               onRemoteHpChange(cmd as RemoteHpChangeNotify);
            }
            else if(cmd.code == CommandCodeRemotePlayer.REMOTE_MP_CHANGE_NOTIFY)
            {
               onRemoteMpChange(cmd as RemoteMpChangeNotify);
            }
            else if(cmd.code == CommandCodeRemotePlayer.REMOTE_LEVEL_UP_NOTIFY)
            {
               onRemoteLevelUp(cmd as RemoteLevelUpNotify);
            }
            else if(cmd.code == CommandCodeRemotePlayer.REMOTE_EQUIPMENT_MODEL_CHECK_NOTIFY)
            {
               onRemoteEquCheck(cmd as RemoteEquipmentModelCheckNotify);
            }
            else if(cmd.code == CommandCodeRemotePlayer.REMOTE_RIDE_CHECK_NOTIFY)
            {
               onRemoteRideCheck(cmd as RemoteRideCheckNotify,map);
            }
            else if(cmd.code == CommandCodeRemotePlayer.REMOTE_CHANGE_MODEL_NOTIFY)
            {
               obf_0_4_W_68(cmd as RemoteChangeModelNotify,map);
            }
            else
            {
               cmdObj = cmd as Object;
               if(cmdObj.roleName)
               {
                  thisRemote = map.remotePlayerSet.getObject(cmdObj.roleName) as RemotePlayer;
                  if(thisRemote)
                  {
                     try
                     {
                        thisRemote.doCommand(cmd);
                     }
                     catch(err:Error)
                     {
                        trace("Command Error:" + cmd.code + "\n" + err);
                     }
                  }
               }
            }
         }
         catch(err:Error)
         {
            trace("Command Error:" + cmd.code + "\n" + err);
         }
      }
      
      private static function createRemote(param1:RemotePlayerInfo) : RemotePlayer
      {
         var _loc3_:BuffInfo = null;
         var _loc4_:Object = null;
         var _loc2_:RemotePlayer = RemotePlayerBuffer.getRemoteFromBuffer(param1.name);
         if(Boolean(_loc2_) && Boolean(_loc2_.obf_I_0_1698.modelCode) || Boolean(param1.modelCode))
         {
            RemotePlayerBuffer.removeRemoteFromBuffer(param1.name);
            _loc2_ = null;
         }
         if(!_loc2_ || _loc2_.isDestroyed() || _loc2_.obf_I_0_1698.sex != param1.sex)
         {
            _loc2_ = new RemotePlayer(param1.jobCode,param1.sex,param1.hairStyleIndex);
            _loc2_.id = param1.name;
         }
         _loc2_.initCommand(WorldConfig.getObjectSetting("effectCommand") as Array);
         _loc2_.bodySprite.alpha = 1;
         _loc2_.obf_I_0_1698 = param1;
         _loc2_.side = param1.side;
         if(param1.equipmentModels)
         {
            _loc2_.setEquipmentModels(param1.equipmentModels);
         }
         if(param1.position)
         {
            _loc2_.moveToPixel(param1.position.x,param1.position.y);
            _loc2_.walkSpeed = param1.walkSpeed;
            _loc2_.walkAlongPath(MapPoint.MapArrayToPoint(param1.pathArray),false);
         }
         _loc2_.buffList = new Array();
         _loc2_.debuffList = new Array();
         for each(_loc3_ in param1.buffs)
         {
            _loc4_ = BuffManager.getBuffConfigById(_loc3_.buffId);
            if(_loc4_)
            {
               if(!_loc4_.isDebuff)
               {
                  _loc2_.obf_a_8_4261(_loc3_);
               }
               else
               {
                  _loc2_.obf_i_b_872(_loc3_);
               }
            }
         }
         _loc2_.setBooth(param1.isBooth,param1.boothTitle);
         _loc2_.setBlessing(param1.isBless,param1.blessCode,param1.blessLevel);
         _loc2_.obf_A_j_2560();
         return _loc2_;
      }
      
      private static function setRemoteRide(param1:RemotePlayer, param2:String, param3:String, param4:Array) : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:Object = null;
         var _loc9_:Boolean = false;
         var _loc10_:obf_0_M_3913 = null;
         var _loc11_:int = 0;
         var _loc12_:obf_0_M_3913 = null;
         var _loc13_:String = null;
         var _loc14_:obf_0_M_3913 = null;
         var _loc15_:obf_0_M_3913 = null;
         if(!param1)
         {
            return;
         }
         if(param4 == null)
         {
            param4 = new Array();
         }
         if(param2 == "")
         {
            if(param1.isPassiveRiding && param1.obf_Z_T_3864 != null)
            {
               param1.obf_X_x_4358(false,param1.obf_Z_T_3864);
            }
            param1.ride(false);
         }
         else
         {
            _loc8_ = GameItemManager.getItemConfig(param2);
            if(!_loc8_)
            {
               obf_x_0_1295.obf_r_w_3556("obf________________5(" + param2 + ")obf___4949！");
               return;
            }
            _loc6_ = _loc8_.properties.modelCode || "";
            _loc7_ = int(int(_loc8_.properties.capacity) || 1);
            if(param3 == "" || param3 == param1.id)
            {
               param1.setRideModel(_loc6_,_loc7_);
               param1.ride(true);
               if(param1.obf_N_u_1040.length - 1 != param4.length)
               {
                  _loc9_ = true;
               }
               else
               {
                  _loc11_ = 1;
                  while(_loc11_ < param1.obf_N_u_1040.length)
                  {
                     _loc12_ = param1.obf_N_u_1040[_loc11_];
                     if(_loc12_.id != param4[_loc11_ - 1])
                     {
                        _loc9_ = true;
                        break;
                     }
                     _loc11_++;
                  }
               }
               if(_loc9_)
               {
                  param1.ride(false);
                  param1.ride(true);
                  for each(_loc13_ in param4)
                  {
                     _loc14_ = GameContext.currentMap.getObjectById(_loc13_) as obf_0_M_3913;
                     if(_loc14_)
                     {
                        param1.obf_4_Y_4598(_loc14_);
                     }
                  }
               }
               for each(_loc10_ in param1.obf_N_u_1040)
               {
                  if(_loc10_ != param1)
                  {
                     _loc10_.obf_X_x_4358(true,param1);
                  }
               }
            }
            else
            {
               _loc15_ = GameContext.currentMap.getObjectById(param3) as obf_0_M_3913;
               if(_loc15_)
               {
                  param1.obf_X_x_4358(true,_loc15_);
               }
            }
         }
         param1.obf_G_p_757();
         for(_loc5_ in param1.obf_M_n_3303)
         {
            param1.showAlwaysEffect(_loc5_,param1.obf_M_n_3303[_loc5_]);
         }
      }
      
      private static function onViewMap(param1:PlayerViewMapAnswer, param2:Map) : void
      {
         var thisInfo:RemotePlayerInfo = null;
         var rInfo:RemotePlayerInfo = null;
         var thisRemote:RemotePlayer = null;
         var thisRideRemote:RemotePlayer = null;
         var cmd:PlayerViewMapAnswer = param1;
         var map:Map = param2;
         if(cmd.mapId != map.mapId || !cmd.remotePlayers)
         {
            return;
         }
         for each(thisInfo in cmd.remotePlayers)
         {
            try
            {
               if(thisInfo)
               {
                  thisRemote = createRemote(thisInfo);
                  map.remotePlayerSet.addObject(thisRemote);
                  thisRemote.obf_0_7_L_545();
                  thisRemote.obf_K_l_3510();
                  thisRemote.obf_T_U_1505();
                  thisRemote.obf_w_h_i_l_e_293();
                  thisRemote.obf_B_6_3905();
                  if(GameContext.localPlayer.isInSameTeamByPlayerId(thisRemote.id))
                  {
                     if(obf_K_e_3075.teamUI)
                     {
                        obf_K_e_3075.teamUI.refreshMemberBuff(thisRemote.id);
                     }
                  }
               }
            }
            catch(err:Error)
            {
               trace("RemotePlayer ViewMap Error:\n" + err);
            }
         }
         for each(rInfo in cmd.remotePlayers)
         {
            try
            {
               if(rInfo)
               {
                  thisRideRemote = map.remotePlayerSet.getObject(rInfo.name) as RemotePlayer;
                  if(thisRideRemote)
                  {
                     setRemoteRide(thisRideRemote,rInfo.rideCode,rInfo.rideMasterPlayerId,rInfo.rideGuestPlayerIds);
                  }
               }
            }
            catch(err:Error)
            {
            }
         }
         if(obf_K_e_3075.systemSettingUI)
         {
            obf_K_e_3075.systemSettingUI.init();
         }
         if(GameContext.currentMap)
         {
            GameContext.currentMap.limitRemotePlayerNumber(Map.obf_0_2_l_577);
         }
         if(obf_K_e_3075.systemSettingUI)
         {
            obf_K_e_3075.systemSettingUI.showEffectCommand();
         }
      }
      
      private static function onRemoteEnter(param1:RemoteEnterMapNotify, param2:Map) : void
      {
         if(param1.role.mapId != param2.mapId)
         {
            return;
         }
         var _loc3_:RemotePlayer = createRemote(param1.role);
         param2.remotePlayerSet.addObject(_loc3_);
         _loc3_.obf_0_7_L_545();
         _loc3_.obf_K_l_3510();
         _loc3_.obf_T_U_1505();
         _loc3_.obf_w_h_i_l_e_293();
         _loc3_.obf_B_6_3905();
         setRemoteRide(_loc3_,param1.role.rideCode,param1.role.rideMasterPlayerId,param1.role.rideGuestPlayerIds);
         if(GameContext.localPlayer.isInSameTeamByPlayerId(_loc3_.id))
         {
            if(obf_K_e_3075.teamUI)
            {
               obf_K_e_3075.teamUI.refreshMemberBuff(_loc3_.id);
            }
         }
         obf_0_9_V_473.showEffectOnObject(param2,_loc3_,"C_RoleTeleport");
      }
      
      private static function onRemoteLeave(param1:RemoteLeaveMapNotify, param2:Map) : void
      {
         if(param1.mapId != param2.mapId)
         {
            return;
         }
         var _loc3_:RemotePlayer = param2.remotePlayerSet.getObject(param1.roleName) as RemotePlayer;
         if(GameContext.localPlayer.isInSameTeamByPlayerId(param1.roleName))
         {
            if(obf_K_e_3075.teamUI)
            {
               obf_K_e_3075.teamUI.clearMemberBuff(param1.roleName);
            }
         }
         obf_0_9_V_473.showEffectOnObject(param2,_loc3_,"C_RoleTeleport");
         if(_loc3_)
         {
            if(GameContext.localPlayer.obf_0_6_a_430 == _loc3_ || GameContext.localPlayer.obf_0_6_a_430 == _loc3_.obf_F_o_1931)
            {
               GameContext.localPlayer.obf_3_v_4336();
            }
            _loc3_.removePet();
            _loc3_.removeGenie();
            _loc3_.removeDevil();
            _loc3_.removeDragon();
            _loc3_.removeTrainer();
            param2.remotePlayerSet.removeObject(_loc3_);
            RemotePlayerBuffer.addRemoteToBuffer(_loc3_);
         }
      }
      
      private static function onRemoteHpChange(param1:RemoteHpChangeNotify) : void
      {
         var _loc2_:RemotePlayer = GameContext.currentMap.remotePlayerSet.getObject(param1.roleName) as RemotePlayer;
         if(!_loc2_)
         {
            return;
         }
         _loc2_.doCommand(param1);
         if(GameContext.localPlayer.obf_0_6_a_430 == _loc2_)
         {
            obf_K_e_3075.targetInfoUI.setHpPercent(_loc2_.hpPercent);
         }
      }
      
      private static function onRemoteMpChange(param1:RemoteMpChangeNotify) : void
      {
         var _loc2_:RemotePlayer = GameContext.currentMap.remotePlayerSet.getObject(param1.roleName) as RemotePlayer;
         if(!_loc2_)
         {
            return;
         }
         _loc2_.doCommand(param1);
         if(GameContext.localPlayer.obf_0_6_a_430 == _loc2_)
         {
            obf_K_e_3075.setTargetInfo(_loc2_);
         }
      }
      
      private static function onRemoteLevelUp(param1:RemoteLevelUpNotify) : void
      {
         var _loc2_:RemotePlayer = GameContext.currentMap.remotePlayerSet.getObject(param1.roleName) as RemotePlayer;
         if(!_loc2_)
         {
            return;
         }
         _loc2_.doCommand(param1);
         if(GameContext.localPlayer.obf_0_6_a_430 == _loc2_)
         {
            obf_K_e_3075.setTargetInfo(_loc2_);
         }
      }
      
      private static function onRemoteEquCheck(param1:RemoteEquipmentModelCheckNotify) : void
      {
         if(!GameContext.currentMap)
         {
            return;
         }
         var _loc2_:RemotePlayer = GameContext.currentMap.remotePlayerSet.getObject(param1.roleName) as RemotePlayer;
         if(_loc2_)
         {
            _loc2_.setEquipmentModels(param1.equipmentModels);
         }
      }
      
      private static function onRemoteRideCheck(param1:RemoteRideCheckNotify, param2:Map) : void
      {
         if(!param2)
         {
            return;
         }
         var _loc3_:RemotePlayer = param2.getObjectById(param1.roleName) as RemotePlayer;
         if(_loc3_)
         {
            setRemoteRide(_loc3_,param1.rideCode,param1.rideMasterPlayerId,param1.rideGuestPlayerIds);
         }
      }
      
      private static function obf_0_4_W_68(param1:RemoteChangeModelNotify, param2:Map) : void
      {
         var _loc3_:RemotePlayer = param2.getObjectById(param1.roleName) as RemotePlayer;
         if(_loc3_)
         {
            if(!obf_L_l_4100.isEmpty(param1.modelCode))
            {
               _loc3_.setMonsterModelCode(param1.modelCode);
            }
            else
            {
               _loc3_.setPlayerModelCode(obf_I_5_1944.getJobName(_loc3_.jobCode,_loc3_.sex));
               _loc3_.setEquipmentModels(_loc3_.obf_I_0_1698.equipmentModels);
            }
         }
      }
   }
}

