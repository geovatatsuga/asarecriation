package com.sunweb.game.rpg.netRole
{
   import obf_E_p_2386.obf_S_Q_3707;
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.bless.obf_G_4_4620;
   import com.sunweb.game.rpg.booth.obf_c_o_n_t_i_n_u_e_24;
   import com.sunweb.game.rpg.buff.BuffInfo;
   import com.sunweb.game.rpg.buff.BuffManager;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.dragon.obf_Y_1494;
   import com.sunweb.game.rpg.family.obf_F_9_1495;
   import com.sunweb.game.rpg.map.MapInteractiveObject;
   import com.sunweb.game.rpg.mate.MateRelationType;
   import com.sunweb.game.rpg.playerUI.MagicMotionManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_0_3_0_538;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.PKMode;
   import com.sunweb.game.rpg.role.RemotePlayerInfo;
   import com.sunweb.game.rpg.role.obf_0_0_8_669;
   import com.sunweb.game.rpg.role.obf_0_9_V_473;
   import com.sunweb.game.rpg.role.obf_0_M_3913;
   import com.sunweb.game.rpg.role.obf_I_5_1944;
   import com.sunweb.game.rpg.role.obf_Z_Q_3056;
   import com.sunweb.game.rpg.role.obf_c_y_957;
   import com.sunweb.game.rpg.script.DynamicVars;
   import com.sunweb.game.rpg.settingConfig.NumberConfig;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.map.MapManager;
   import com.sunweb.game.rpg.world.map.MapPoint;
   import com.sunweb.game.rpg.worldZone.command.remote.*;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.filters.GlowFilter;
   
   public class RemotePlayer extends obf_Y_E_3667
   {
      
      public var bufferTime:int;
      
      public var jobCode:int;
      
      public var sex:int;
      
      public var obf_k_0_1406:int;
      
      public var isGM:Boolean;
      
      private var _remoteInfo:RemotePlayerInfo;
      
      public var agoLv:int = 0;
      
      public function RemotePlayer(param1:int, param2:int, param3:int, param4:String = "")
      {
         super(param1,param2,param3,param4);
         this._labelTextField.filters = [new GlowFilter(0,1,2,2,1000,1)];
      }
      
      public function set obf_I_0_1698(param1:RemotePlayerInfo) : void
      {
         this._remoteInfo = param1;
         this.isGM = param1.isGM;
         this.level = param1.level;
         this.jobCode = param1.jobCode;
         this.sex = param1.sex;
         this.obf_k_0_1406 = param1.headIconIndex;
         this.hpPercent = 100;
         this.pkMode = param1.pkMode;
         this.pkValue = param1.pkValue;
         this.labelColor = obf_0_3_0_538.getPKValueColor(param1.pkValue);
         this.familyName = this._remoteInfo.familyName;
         this.playerTitleId = this._remoteInfo.titleIndex;
         this.statusFlags = param1.statusFlags;
         this.setHatDefaultModel(param1.jobCode,param1.sex,param1.hairStyleIndex,false);
         if(param1.isDead)
         {
            this.die(false,null,int.MAX_VALUE);
         }
         else
         {
            this.rebirth();
            if(param1.isSitting)
            {
               this.sit();
            }
            else
            {
               this.stand();
            }
         }
         this.teamName = param1.teamName;
         this.obf_G_p_757();
      }
      
      public function get obf_I_0_1698() : RemotePlayerInfo
      {
         return this._remoteInfo;
      }
      
      override public function set familyName(param1:String) : void
      {
         super.familyName = param1;
         this._remoteInfo.familyName = param1;
      }
      
      public function obf_0_7_L_545() : void
      {
         if(this._remoteInfo.pet)
         {
            this.setPet(this._remoteInfo.pet.petCode,this._remoteInfo.pet.petName,this._remoteInfo.pet.petId);
         }
         else
         {
            this.removePet();
         }
      }
      
      public function obf_K_l_3510() : void
      {
         if(this._remoteInfo.genie)
         {
            this.setGenie(this._remoteInfo.genie.genieCode,this._remoteInfo.genie.genieId);
         }
         else
         {
            this.removeGenie();
         }
      }
      
      public function obf_T_U_1505() : void
      {
         if(this._remoteInfo.devil)
         {
            this.setDevil(this._remoteInfo.devil.devilCode,this._remoteInfo.devil.devilId);
         }
         else
         {
            this.removeDevil();
         }
      }
      
      public function obf_w_h_i_l_e_293() : void
      {
         this.agoLv = this._remoteInfo.dragonLevel;
         if(this._remoteInfo.dragonLevel > 0)
         {
            this.setDragon(this._remoteInfo.dragonLevel);
         }
         else
         {
            this.removeDragon();
         }
      }
      
      public function obf_B_6_3905() : void
      {
         if(this.jobCode != obf_I_5_1944.obf_0_1_133)
         {
            return;
         }
         if(this._remoteInfo.animal)
         {
            this.setTrainer(this._remoteInfo.animal);
            this.setTrainerBuff(this._remoteInfo.animal.buffs);
         }
         else
         {
            this.removeTrainer();
         }
      }
      
      public function obf_G_p_757(param1:Boolean = false) : void
      {
         var _loc6_:obf_0_M_3913 = null;
         var _loc7_:Boolean = false;
         var _loc2_:String = "";
         if(this.pkMode == PKMode.obf_N_W_2421)
         {
            _loc2_ = "<font color=\'#" + obf_0_3_0_538.obf_8_A_3160.toString(16) + "\'>　" + DiversityManager.getString("PlayerNameLabel","pkmode_slay_mode") + "</font>";
         }
         else if(this.pkMode == PKMode.obf_9_P_3540)
         {
            _loc2_ = "<font color=\'#" + obf_0_3_0_538.obf_I_F_4289.toString(16) + "\'>　" + DiversityManager.getString("PlayerNameLabel","pkmode_team_mode") + "</font>";
         }
         else if(this.pkMode == PKMode.obf_f_U_3730)
         {
            _loc2_ = "<font color=\'#" + obf_0_3_0_538.obf_j_y_2343.toString(16) + "\'>　" + DiversityManager.getString("PlayerNameLabel","pkmode_family_mode") + "</font>";
         }
         var _loc3_:String = "";
         if(Boolean(DynamicVars.systemVar && !obf_L_l_4100.isEmpty(this._remoteInfo.familyName)) && Boolean(DynamicVars.systemVar.getStrVar("#ldz_winner") == this._remoteInfo.familyName) && obf_F_9_1495.isLeaderPost(this._remoteInfo.postLevel))
         {
            _loc3_ += DiversityManager.getString("FamilyBoxUI","title_LdzLeader") + "\r";
         }
         if(param1 && !obf_L_l_4100.isEmpty(familyName))
         {
            _loc3_ += "<font color=\'#" + obf_0_3_0_538.obf_G_I_2446.toString(16) + "\'>" + familyName;
            if(obf_F_9_1495.postLevelShow(this._remoteInfo.postLevel))
            {
               _loc3_ += " " + this._remoteInfo.postName;
            }
            _loc3_ += "</font>\r";
         }
         var _loc4_:String = obf_n_u_l_l_2508.getPlayerTitle(playerTitleId,this);
         if(!obf_L_l_4100.isEmpty(_loc4_))
         {
            _loc3_ += "<font color=\'#FFFFFF\'>" + _loc4_ + "</font>\n";
         }
         if(this._remoteInfo)
         {
            if(this._remoteInfo.mateRelation == MateRelationType.LOVE)
            {
               _loc3_ += "<font color=\'#" + obf_0_3_0_538.obf_0_5_n_235.toString(16) + "\'>" + DiversityManager.getString("MatePrompt","playerLabel_Love_Sex" + this._remoteInfo.sex,[this._remoteInfo.mateName]) + "</font>\n";
            }
            else if(this._remoteInfo.mateRelation == MateRelationType.MARRY)
            {
               _loc3_ += "<font color=\'#" + obf_0_3_0_538.obf_0_5_n_235.toString(16) + "\'>" + DiversityManager.getString("MatePrompt","playerLabel_Marry_Sex" + this._remoteInfo.sex,[this._remoteInfo.mateName]) + "</font>\n";
            }
         }
         if(this.isGM)
         {
            _loc3_ += "<font color=\'#" + obf_0_3_0_538.obf_5_1_4573.toString(16) + "\'>[GM]</font> ";
         }
         var _loc5_:String = obf_0_3_0_538.getPKValueColor(this.pkValue).toString(16);
         if(this._remoteInfo.vipLevel > 0 && !WorldConfig.getValue("functionSwitch","showPlayerVIP"))
         {
            if(WorldConfig.getValue("vip","vipMode") == 1)
            {
               _loc3_ += DiversityManager.getString("CommonPrompt","vipTitle",[""]);
            }
            else
            {
               _loc3_ += DiversityManager.getString("CommonPrompt","vipTitle",[this._remoteInfo.vipLevel]);
            }
         }
         if(this._remoteInfo.rebornTimes > 0)
         {
            _loc3_ += DiversityManager.getString("CommonPrompt","rebornTitle",[obf_S_Q_3707.getRebornName(this._remoteInfo.rebornTimes)]);
         }
         if(GameContext.localPlayer.isInSameTeamByPlayerId(this.id))
         {
            _loc5_ = "33FF00";
         }
         _loc3_ = _loc3_ + "<font color=\'#" + _loc5_ + "\'>" + this.id + "</font>";
         if(this._remoteInfo.honorLevel > 0)
         {
            _loc3_ = _loc3_ + "  <font color=\'#FFFFFF\'>" + JSONUtil.getStr(NumberConfig.getSettingObject("honorLevelNames"),[this._remoteInfo.honorLevel]) + "</font>";
         }
         _loc3_ += _loc2_;
         for each(_loc6_ in this.obf_N_u_1040)
         {
            if(_loc6_ != this)
            {
               if(_loc6_ is RemotePlayer)
               {
                  _loc7_ = (_loc6_ as RemotePlayer).isGM;
               }
               else if(_loc6_ is obf_U_6_3454)
               {
                  _loc7_ = (_loc6_ as obf_U_6_3454).fullInfo.isGM;
               }
               _loc3_ += "\n" + (_loc7_ ? "<font color=\'#" + obf_0_3_0_538.obf_5_1_4573.toString(16) + "\'>[GM]</font> " : "") + "<font color=\'#" + obf_0_3_0_538.getPKValueColor(_loc6_.pkValue).toString(16) + "\'>" + _loc6_.id + "</font>";
            }
         }
         this.setAndShowLabel(_loc3_);
         if(this._remoteInfo.isDead)
         {
            labelColor = obf_0_3_0_538.obf_9_w_804;
         }
      }
      
      override public function set isTracked(param1:Boolean) : void
      {
         super.isTracked = param1;
         this.obf_G_p_757(param1);
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      public function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeRemotePlayer.REMOTE_POSITION_CHECK_NOTIFY)
         {
            this.obf_y_b_1154(param1 as RemotePositionCheckNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_USE_SKILL_NOTIFY)
         {
            this.obf_D_D_3405(param1 as RemoteUseSkillNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_SKILL_INTERRUPTED_NOTIFY)
         {
            this.obf_U_J_2602(param1 as RemoteSkillInterruptedNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_HP_CHANGE_NOTIFY)
         {
            this.onRemoteHpChange(param1 as RemoteHpChangeNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_MP_CHANGE_NOTIFY)
         {
            this.onRemoteMpChange(param1 as RemoteMpChangeNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_LEVEL_UP_NOTIFY)
         {
            this.onRemoteLevelUp(param1 as RemoteLevelUpNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_BUFF_CHANGE_NOTIFY)
         {
            this.obf_S_m_3852(param1 as RemoteBuffChangeNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_LUCKY_SKILL_NOTIFY)
         {
            this.obf_g_w_3949(param1 as RemoteLuckySkillNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_DIED_NOTIFY)
         {
            this.obf_z_7_1626(param1 as RemoteDiedNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_REBIRTH_LOCALLY_NOTIFY)
         {
            this.obf_W_L_2356(param1 as RemoteRebirthLocallyNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_SIT_CHECK_NOTIFY)
         {
            this.obf_B_g_1163(param1 as RemoteSitCheckNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_PK_MODE_CHANGE_NOTIFY)
         {
            this.obf_Z_R_4283(param1 as RemotePKModeChangeNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_PK_VALUE_CHANGE_NOTIFY)
         {
            this.obf_l_V_1402(param1 as RemotePKValueChangeNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_SIDE_CHECK_NOTIFY)
         {
            this.obf_c_J_2329(param1 as RemoteSideChangeNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_USE_MOTION_NOTIFY)
         {
            this.obf_p_Y_3818(param1 as RemoteUseMotionNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_STATUS_CHANGE_NOTIFY)
         {
            this.obf_0___u_119(param1 as RemoteStatusChangeNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_TEAM_CHECK_NOTIFY)
         {
            this.obf_p_a_3530(param1 as RemoteTeamCheckNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_FAMILY_CHECK_NOTIFY)
         {
            this.obf_X_0_1650(param1 as RemoteFamilyCheckNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_MATE_CHECK_NOTIFY)
         {
            this.obf_0_4_1_84(param1 as RemoteMateCheckNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_HAIR_STYLE_CHANGE_NOTIFY)
         {
            this.obf_0_T_1968(param1 as RemoteHairStyleChangeNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_PET_CHECK_NOTIFY)
         {
            this.obf_1_F_1507(param1 as RemotePetCheckNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_GENIE_CHECK_NOTIFY)
         {
            this.obf_0_2_7_171(param1 as RemoteGenieCheckNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_DEVIL_CHECK_NOTIFY)
         {
            this.obf_R_L_2077(param1 as RemoteDevilCheckNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_BOOTH_CHECK_NOTIFY)
         {
            this.obf_j_E_1695(param1 as RemoteBoothCheckNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_BLESS_CHECK_NOTIFY)
         {
            this.obf_r_m_3620(param1 as RemoteBlessCheckNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_VIP_CHECK_NOTIFY)
         {
            this.obf_R_C_1485(param1 as RemoteVipCheckNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_HONOR_LEVEL_CHECK_NOTIFY)
         {
            this.obf_9_2_1434(param1 as RemoteHonorLevelCheckNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_DRAGON_CHECK_NOTIFY)
         {
            this.obf_A_c_1593(param1 as RemoteDragonCheckNotify);
         }
         else if(param1.code == CommandCodeRemotePlayer.REMOTE_CALL_TRAINER_NOTIFY)
         {
            this.obf_G_4647(param1 as RemoteCallTrainerNotify);
         }
      }
      
      private function obf_y_b_1154(param1:RemotePositionCheckNotify) : void
      {
         var _loc3_:Boolean = false;
         if(param1.mapId != GameContext.currentMap.mapId)
         {
            return;
         }
         this.walkSpeed = param1.walkSpeed;
         if(Boolean(obf_F_o_1931) && Boolean(this._remoteInfo.animal))
         {
            obf_F_o_1931.walkSpeed = this.walkSpeed;
         }
         if(Boolean(obf_p_o_4531) && Boolean(this._remoteInfo.devil))
         {
            obf_p_o_4531.walkSpeed = this.walkSpeed;
         }
         if(param1.reasonCode == obf_Z_Q_3056.obf_z_n_3070 && this.isInStage)
         {
            MapManager.instance.showMapFastMoveBlur(this,param1.position.x,param1.position.y);
         }
         var _loc2_:int = this.getLineDistancePt(param1.position.x,param1.position.y);
         if(!param1.pathArrayReversed || param1.pathArrayReversed.length == 0)
         {
            this.resetPosition(param1.position.x,param1.position.y,_loc2_ > 200);
         }
         else
         {
            _loc3_ = param1.reasonCode != obf_Z_Q_3056.obf_z_n_3070 && _loc2_ < 200;
            this.walkAlongPath(MapPoint.MapArrayToPoint(param1.pathArray),_loc3_);
         }
      }
      
      private function obf_D_D_3405(param1:RemoteUseSkillNotify) : void
      {
         var _loc2_:MapInteractiveObject = null;
         if(!_loc2_)
         {
            _loc2_ = GameContext.currentMap.getObjectById(param1.targetId);
         }
         if(_loc2_)
         {
            this.useSkillOnObject(param1.skillSn,param1.skillCode,_loc2_,param1.singTime,param1.castTime,param1.skillLevel);
         }
         else if(param1.targetPoint)
         {
            this.useSkillOnPoint(param1.skillSn,param1.skillCode,MapPoint.MapPointToPoint(param1.targetPoint),param1.singTime,param1.castTime,param1.skillLevel);
         }
         else
         {
            this.useSkillOnObject(param1.skillSn,param1.skillCode,this,param1.singTime,param1.castTime,param1.skillLevel);
         }
      }
      
      private function obf_U_J_2602(param1:RemoteSkillInterruptedNotify) : void
      {
         if(this.isUsingSkill && this.obf_3_y_4486 == param1.skillSn)
         {
            this.stopSkill();
         }
      }
      
      private function onRemoteHpChange(param1:RemoteHpChangeNotify) : void
      {
         this.hpPercent = param1.hpPercentCurrent;
         if(param1.hpChanged == 0)
         {
            obf_0_9_V_473.showEffectOnObject(GameContext.currentMap,this,"C_NumberMiss");
         }
         else if(param1.hpChanged < 0)
         {
            this.showNumberEffect(Math.abs(param1.hpChanged),param1.isCriticalStrike ? obf_0_0_8_669.obf_w_d_3136 : obf_0_0_8_669.obf_F_F_4169);
         }
         else
         {
            this.showNumberEffect(param1.hpChanged,obf_0_0_8_669.obf_0___1_276);
         }
         if(Boolean(param1.skillCode) && param1.skillCode != "")
         {
            this.showHitEffect(param1.skillCode,param1.isCriticalStrike);
         }
      }
      
      private function onRemoteMpChange(param1:RemoteMpChangeNotify) : void
      {
      }
      
      private function onRemoteLevelUp(param1:RemoteLevelUpNotify) : void
      {
         this.level = param1.newLevel;
         obf_0_9_V_473.showEffectOnObject(GameContext.currentMap,this,"C_RoleLevelUp");
      }
      
      private function obf_S_m_3852(param1:RemoteBuffChangeNotify) : void
      {
         var _loc4_:int = 0;
         var _loc5_:BuffInfo = null;
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc2_:Boolean = GameContext.localPlayer.obf_0_6_a_430 == this;
         var _loc3_:Boolean = GameContext.localPlayer.isInSameTeamByPlayerId(this.id);
         for each(_loc4_ in param1.buffsRemoved)
         {
            _loc6_ = BuffManager.getBuffConfigById(_loc4_);
            if(_loc6_)
            {
               if(!_loc6_.isDebuff)
               {
                  this.removeBuffInfo(_loc4_);
                  if(Boolean(obf_K_e_3075.targetInfoUI) && _loc2_)
                  {
                     obf_K_e_3075.targetInfoUI.buffUI.removeBuff(_loc4_);
                  }
               }
               else
               {
                  this.removeDebuffInfo(_loc4_);
                  if(Boolean(obf_K_e_3075.targetInfoUI) && _loc2_)
                  {
                     obf_K_e_3075.targetInfoUI.debuffUI.removeBuff(_loc4_);
                  }
               }
               if(_loc3_ && Boolean(obf_K_e_3075.teamUI))
               {
                  obf_K_e_3075.teamUI.removeBuffByPlayerId(this.id,_loc4_);
               }
            }
         }
         for each(_loc5_ in param1.buffsAdded)
         {
            _loc7_ = BuffManager.getBuffConfigById(_loc5_.buffId);
            if(_loc7_)
            {
               if(!_loc7_.isDebuff)
               {
                  this.obf_a_8_4261(_loc5_);
                  if(Boolean(obf_K_e_3075.targetInfoUI) && _loc2_)
                  {
                     obf_K_e_3075.targetInfoUI.buffUI.addBuff(_loc5_);
                  }
               }
               else
               {
                  this.obf_i_b_872(_loc5_);
                  if(Boolean(obf_K_e_3075.targetInfoUI) && _loc2_)
                  {
                     obf_K_e_3075.targetInfoUI.debuffUI.addBuff(_loc5_);
                  }
               }
               if(_loc3_ && Boolean(obf_K_e_3075.teamUI))
               {
                  obf_K_e_3075.teamUI.obf_w_O_1339(this.id,_loc5_);
               }
            }
         }
      }
      
      private function obf_g_w_3949(param1:RemoteLuckySkillNotify) : void
      {
         this.showLuckySkillEffect();
      }
      
      private function obf_z_7_1626(param1:RemoteDiedNotify) : void
      {
         if(GameContext.currentMap.mapId != param1.mapId)
         {
            return;
         }
         this.moveToPixel(param1.x,param1.y);
         this.die(false,null,int.MAX_VALUE);
         this._remoteInfo.isDead = true;
         this.obf_G_p_757();
      }
      
      private function obf_W_L_2356(param1:RemoteRebirthLocallyNotify) : void
      {
         if(GameContext.currentMap.mapId != param1.mapId)
         {
            return;
         }
         this.rebirth();
         this.resetPosition(param1.x,param1.y);
         this._remoteInfo.isDead = false;
         this.obf_G_p_757();
      }
      
      private function obf_B_g_1163(param1:RemoteSitCheckNotify) : void
      {
         this._remoteInfo.isSitting = param1.isSitting;
         if(param1.isSitting)
         {
            this.sit();
         }
         else
         {
            this.stand();
         }
      }
      
      private function obf_Z_R_4283(param1:RemotePKModeChangeNotify) : void
      {
         this.pkMode = param1.pkMode;
         this.obf_G_p_757();
      }
      
      private function obf_l_V_1402(param1:RemotePKValueChangeNotify) : void
      {
         this.pkValue = param1.pkValueCurrent;
         this._remoteInfo.pkValue = param1.pkValueCurrent;
         this.obf_G_p_757();
      }
      
      private function obf_c_J_2329(param1:RemoteSideChangeNotify) : void
      {
         this._remoteInfo.side = this.side = param1.side;
         this.obf_G_p_757();
      }
      
      private function obf_p_Y_3818(param1:RemoteUseMotionNotify) : void
      {
         if(!GameContext.currentMap)
         {
            return;
         }
         var _loc2_:MapInteractiveObject = GameContext.currentMap.getObjectById(param1.targetId);
         MagicMotionManager.showMagicMotion(this,_loc2_,param1.motionCode);
      }
      
      private function obf_0___u_119(param1:RemoteStatusChangeNotify) : void
      {
         this._remoteInfo.statusFlags = param1.statusFlags;
         this.statusFlags = param1.statusFlags;
         this.bodySprite.alpha = (param1.statusFlags & obf_c_y_957.obf_U_U_4127) >= 1 ? 0.4 : 1;
      }
      
      private function obf_p_a_3530(param1:RemoteTeamCheckNotify) : void
      {
         this._remoteInfo.isTeamLeader = param1.isTeamLeader;
         this._remoteInfo.teamName = param1.teamName;
         this.teamName = param1.teamName;
         this.obf_G_p_757();
      }
      
      private function obf_X_0_1650(param1:RemoteFamilyCheckNotify) : void
      {
         this._remoteInfo.postLevel = param1.postLevel;
         this._remoteInfo.postName = param1.postName;
         this.familyName = param1.familyName;
         this.obf_G_p_757();
      }
      
      private function obf_0_4_1_84(param1:RemoteMateCheckNotify) : void
      {
         this._remoteInfo.mateName = param1.mateName;
         this._remoteInfo.mateRelation = param1.mateRelation;
         this.obf_G_p_757();
      }
      
      private function obf_0_T_1968(param1:RemoteHairStyleChangeNotify) : void
      {
         this._remoteInfo.hairStyleIndex = param1.hairStyleIndex;
         setHatDefaultModel(this._remoteInfo.jobCode,this._remoteInfo.sex,this._remoteInfo.hairStyleIndex);
      }
      
      private function obf_1_F_1507(param1:RemotePetCheckNotify) : void
      {
         this._remoteInfo.pet = param1.pet;
         this.obf_0_7_L_545();
      }
      
      private function obf_0_2_7_171(param1:RemoteGenieCheckNotify) : void
      {
         this._remoteInfo.genie = param1.usingGenie;
         this.obf_K_l_3510();
      }
      
      private function obf_R_L_2077(param1:RemoteDevilCheckNotify) : void
      {
         this._remoteInfo.devil = param1.usingDevil;
         this.obf_T_U_1505();
      }
      
      private function obf_j_E_1695(param1:RemoteBoothCheckNotify) : void
      {
         this._remoteInfo.isBooth = param1.isBooth;
         this._remoteInfo.boothTitle = param1.boothTitle;
         this.setBooth(param1.isBooth,param1.boothTitle);
         if(obf_K_e_3075.boothViewUI.playerName == this.id)
         {
            obf_c_o_n_t_i_n_u_e_24.sendViewBooth(this.id);
         }
      }
      
      private function obf_r_m_3620(param1:RemoteBlessCheckNotify) : void
      {
         this._remoteInfo.isBless = param1.isBless;
         this._remoteInfo.blessCode = param1.blessCode;
         this._remoteInfo.blessLevel = param1.blessLevel;
         this.setBlessing(param1.isBless,param1.blessCode,param1.blessLevel);
         if(obf_K_e_3075.obf_d_7_1584.playerName == this.id)
         {
            obf_G_4_4620.sendViewBlessBooth(this.id);
         }
      }
      
      private function obf_R_C_1485(param1:RemoteVipCheckNotify) : void
      {
         this._remoteInfo.vipLevel = param1.vipLevel;
         this.obf_G_p_757();
      }
      
      private function obf_9_2_1434(param1:RemoteHonorLevelCheckNotify) : void
      {
         this._remoteInfo.honorLevel = param1.honorLevel;
         this.obf_G_p_757();
      }
      
      private function obf_A_c_1593(param1:RemoteDragonCheckNotify) : void
      {
         this._remoteInfo.dragonLevel = param1.dragonLevel;
         if(obf_Y_1494.obf_x_b_4157(this.agoLv) != obf_Y_1494.obf_x_b_4157(param1.dragonLevel))
         {
            this.obf_w_h_i_l_e_293();
         }
         this.agoLv = param1.dragonLevel;
      }
      
      private function obf_G_4647(param1:RemoteCallTrainerNotify) : void
      {
         var _loc2_:obf_Y_E_3667 = GameContext.currentMap.remotePlayerSet.getObject(param1.roleName) as obf_Y_E_3667;
         if(Boolean(_loc2_) && GameContext.localPlayer.obf_0_6_a_430 == _loc2_.obf_F_o_1931)
         {
            GameContext.localPlayer.obf_3_v_4336();
         }
         this._remoteInfo.animal = param1.animal;
         if(!param1.animal)
         {
            _loc2_.obf_F_o_1931.die();
         }
         else
         {
            this.obf_B_6_3905();
         }
      }
   }
}

