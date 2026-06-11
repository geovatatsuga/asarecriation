package com.sunweb.game.rpg.netRole
{
   import obf_E_d_1594.TalkBoxUI;
   import obf_E_p_2386.obf_S_Q_3707;
   import obf_a_F_1055.obf_b_p_3604;
   import obf_g_A_3629.*;
   import obf_r_4635.obf_R_6_1363;
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.SystemPrompt;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.animal.AnimalInfo;
   import com.sunweb.game.rpg.buff.BuffInfo;
   import com.sunweb.game.rpg.buff.BuffManager;
   import com.sunweb.game.rpg.clientAction.obf_F_2_2975;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.family.FamilyInfo;
   import com.sunweb.game.rpg.family.FamilyMyInfo;
   import com.sunweb.game.rpg.family.obf_F_9_1495;
   import com.sunweb.game.rpg.farm.FarmManager;
   import com.sunweb.game.rpg.farm.obf_0_1_N_478;
   import com.sunweb.game.rpg.farm.obf_3_U_4495;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.genie.GenieFullInfo;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.lifeJob.LifeJobCode;
   import com.sunweb.game.rpg.map.MapInteractiveObject;
   import com.sunweb.game.rpg.mate.MateRelationType;
   import com.sunweb.game.rpg.pet.PetFullInfo;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerDevil.DevilFullInfo;
   import com.sunweb.game.rpg.playerUI.MagicMotionManager;
   import com.sunweb.game.rpg.playerUI.MessageScope;
   import com.sunweb.game.rpg.playerUI.fastApplyUI.obf_X_t_4110;
   import com.sunweb.game.rpg.playerUI.managers.obf_0_3_0_538;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.ride.obf_0___z_209;
   import com.sunweb.game.rpg.role.*;
   import com.sunweb.game.rpg.role.action.obf_S_c_3330;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.script.DynamicVars;
   import com.sunweb.game.rpg.settingConfig.NumberConfig;
   import com.sunweb.game.rpg.skill.*;
   import com.sunweb.game.rpg.success.obf_j_Y_1351;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.TaskManager;
   import com.sunweb.game.rpg.task.TaskRecorder;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.rpg.team.TeamManager;
   import com.sunweb.game.rpg.team.TeamMemberInfo;
   import com.sunweb.game.rpg.world.PromptsManager;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.info.CDItemInfo;
   import com.sunweb.game.rpg.world.map.MapManager;
   import com.sunweb.game.rpg.world.map.MapPoint;
   import com.sunweb.game.rpg.worldZone.command.animal.AnimalHpChangeNotify;
   import com.sunweb.game.rpg.worldZone.command.animal.AnimalMoveRequest;
   import com.sunweb.game.rpg.worldZone.command.animal.CommandCodePlayerAnimal;
   import com.sunweb.game.rpg.worldZone.command.map.MapTeleportRequest;
   import com.sunweb.game.rpg.worldZone.command.pet.CommandCodePlayerPet;
   import com.sunweb.game.rpg.worldZone.command.pet.PetHpChangeNotify;
   import com.sunweb.game.rpg.worldZone.command.player.*;
   import com.sunweb.game.rpg.worldZone.command.player.pk.*;
   import com.sunweb.game.rpg.worldZone.command.player.ride.*;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.util.obf_e_P_918;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import com.sunweb.game.utils.*;
   import cursor.CursorTargetToDo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import numberEffect.CollectFailed;
   
   public class obf_U_6_3454 extends obf_Y_E_3667
   {
      
      public static const obf_L_K_2966:String = "MoveToPoint";
      
      public static const obf_G_Q_2335:String = "MoveToObject";
      
      public static const obf_j_k_4275:String = "MoveToFarm";
      
      public static const obf_H_n_3781:String = "TalkNPC";
      
      public static const obf_q_O_2547:String = "DoFunction";
      
      public static const obf_Z_n_2536:String = "DoMacro";
      
      public var fullInfo:LocalPlayerInfo;
      
      public var mapId:String;
      
      public var obf_0_6_a_430:MapInteractiveObject;
      
      public var singTimeFactor:Number = 1;
      
      public var castTimeFactor:Number = 1;
      
      private var obf_D_9_3842:String;
      
      private var obf_X_A_1222:String;
      
      private var obf_9_L_4423:TimeLimiter = new TimeLimiter(200);
      
      public var playerTitleList:Array;
      
      public var reportTimeArr:Array;
      
      public var dragonSn:int = 0;
      
      public var taskRecorder:TaskRecorder;
      
      public var dynamicVars:DynamicVars;
      
      public var obf_i_S_846:DynamicVars;
      
      public var petActionMode:int;
      
      public var petFullInfo:PetFullInfo;
      
      public var genieFullInfo:GenieFullInfo;
      
      public var devilFullInfo:DevilFullInfo;
      
      public var trainerFullInfo:AnimalInfo;
      
      private var obf_z_N_2414:FamilyMyInfo;
      
      private var obf_Z_A_2081:FamilyInfo;
      
      private var _ops:Array;
      
      private var autoRideTimeInv:TimeLimiter = new TimeLimiter(3000);
      
      private var autoRideDistance:int = 500;
      
      private var walkToTargetTime:TimeLimiter = new TimeLimiter(100);
      
      private var walkToTargetPoint:Point;
      
      private var walkToTargetLength:int;
      
      private var walkToTarget:Boolean;
      
      private var walkToTargetDoFun:Function;
      
      private var walkToTargetDoPara:Array;
      
      private var obf_2_W_2001:Function;
      
      private var obf_m_p_1852:Array;
      
      private var obf_g_D_2470:Boolean;
      
      private var obf_X_4673:String;
      
      private var numberEffectList:Array = new Array();
      
      private var numberEffectTime:TimeLimiter = new TimeLimiter(400);
      
      private var autoAttackTimeInv:TimeLimiter = new TimeLimiter(100);
      
      private var obf_e_y_3381:Boolean;
      
      private var autoAttackTarget:MapInteractiveObject;
      
      private var attackTimeInv:TimeLimiter;
      
      private var obf_0_6_z_237:Array;
      
      private var obf_n_g_1131:Object;
      
      private var obf_0_6_W_189:Array;
      
      private var obf_u_i_1633:TimeLimiter = new TimeLimiter(300);
      
      private var obf_5_r_2310:SkillManager = new SkillManager();
      
      private var skillSn:int = 0;
      
      private var currentSkillObject:Object;
      
      private var currentSkillLevel:Object;
      
      private var _usingSkill:Boolean;
      
      private var tempAttributes:RoleAttributesInfo = new RoleAttributesInfo();
      
      public function obf_U_6_3454(param1:int, param2:int, param3:int, param4:String = "")
      {
         super(param1,param2,param3,param4);
         this.reportTimeArr = new Array();
         this.obf_6_U_3121 = this.skillDone;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this._labelTextField.filters = [new GlowFilter(0,1,2,2,1000,1)];
      }
      
      public function obf_G_p_757(param1:Boolean = false) : void
      {
         var _loc5_:obf_0_M_3913 = null;
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
         if(ConditionScript.isLdzLeader(true))
         {
            _loc3_ += DiversityManager.getString("FamilyBoxUI","title_LdzLeader") + "\r";
         }
         if(param1 && !obf_L_l_4100.isEmpty(familyName))
         {
            _loc3_ += "<font color=\'#" + obf_0_3_0_538.obf_G_I_2446.toString(16) + "\'>" + familyName;
            if(Boolean(this.obf_z_N_2414) && obf_F_9_1495.postLevelShow(this.obf_z_N_2414.postLevel))
            {
               _loc3_ += " " + this.obf_z_N_2414.postName;
            }
            _loc3_ += "</font>\r";
         }
         var _loc4_:String = obf_n_u_l_l_2508.getPlayerTitle(playerTitleId,this);
         if(!obf_L_l_4100.isEmpty(_loc4_))
         {
            _loc3_ += "<font color=\'#FFFFFF\'>" + _loc4_ + "</font>\n";
         }
         if(this.fullInfo.mateRelationInfo)
         {
            if(this.fullInfo.mateRelationInfo.relationType == MateRelationType.LOVE)
            {
               _loc3_ += "<font color=\'#" + obf_0_3_0_538.obf_0_5_n_235.toString(16) + "\'>" + DiversityManager.getString("MatePrompt","playerLabel_Love_Sex" + this.fullInfo.sex,[this.fullInfo.mateRelationInfo.mateName]) + "</font>\n";
            }
            else if(this.fullInfo.mateRelationInfo.relationType == MateRelationType.MARRY)
            {
               _loc3_ += "<font color=\'#" + obf_0_3_0_538.obf_0_5_n_235.toString(16) + "\'>" + DiversityManager.getString("MatePrompt","playerLabel_Marry_Sex" + this.fullInfo.sex,[this.fullInfo.mateRelationInfo.mateName]) + "</font>\n";
            }
         }
         if(this.fullInfo.isGM)
         {
            _loc3_ += "<font color=\'#" + obf_0_3_0_538.obf_5_1_4573.toString(16) + "\'>[GM]</font> ";
         }
         if(this.fullInfo.vipLevel > 0 && !WorldConfig.getValue("functionSwitch","showPlayerVIP"))
         {
            if(WorldConfig.getValue("vip","vipMode") == 1)
            {
               _loc3_ += DiversityManager.getString("CommonPrompt","vipTitle",[""]);
            }
            else
            {
               _loc3_ += DiversityManager.getString("CommonPrompt","vipTitle",[this.fullInfo.vipLevel]);
            }
         }
         if(this.fullInfo.rebornTimes > 0)
         {
            _loc3_ += DiversityManager.getString("CommonPrompt","rebornTitle",[obf_S_Q_3707.getRebornName(this.fullInfo.rebornTimes)]);
         }
         _loc3_ = _loc3_ + "<font color=\'#" + obf_0_3_0_538.getPKValueColor(this.pkValue).toString(16) + "\'>" + this.id + "</font>";
         if(this.fullInfo.honorLevel > 0)
         {
            _loc3_ = _loc3_ + "  <font color=\'#FFFFFF\'>" + JSONUtil.getStr(NumberConfig.getSettingObject("honorLevelNames"),[this.fullInfo.honorLevel]) + "</font>";
         }
         _loc3_ += _loc2_;
         for each(_loc5_ in this.obf_N_u_1040)
         {
            if(_loc5_ != this)
            {
               _loc3_ += "\n" + ((_loc5_ as RemotePlayer).isGM ? "<font color=\'#" + obf_0_3_0_538.obf_5_1_4573.toString(16) + "\'>[GM]</font> " : "") + "<font color=\'#" + obf_0_3_0_538.getPKValueColor(_loc5_.pkValue).toString(16) + "\'>" + _loc5_.id + "</font>";
            }
         }
         this.setAndShowLabel(_loc3_);
         if(this.isDead)
         {
            labelColor = obf_0_3_0_538.obf_9_w_804;
         }
      }
      
      override public function set isTracked(param1:Boolean) : void
      {
         super.isTracked = param1;
         this.obf_G_p_757(param1);
      }
      
      private function obf_v_n_3880(param1:PlayerDynamicVarChangeNotify) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(!this.dynamicVars)
         {
            return;
         }
         for(_loc2_ in param1.boolVars)
         {
            this.dynamicVars.addBoolVar(_loc2_,param1.boolVars[_loc2_]);
         }
         for(_loc3_ in param1.intVars)
         {
            this.dynamicVars.addIntVar(_loc3_,param1.intVars[_loc3_]);
         }
         for(_loc4_ in param1.strVars)
         {
            this.dynamicVars.addStrVar(_loc4_,param1.strVars[_loc4_]);
         }
      }
      
      private function obf_u_C_2266(param1:PlayerDynamicVarClearNotify) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         for each(_loc2_ in param1.boolVars)
         {
            this.dynamicVars.delBoolVar(_loc2_);
         }
         for each(_loc3_ in param1.intVars)
         {
            this.dynamicVars.delIntVar(_loc3_);
         }
         for each(_loc4_ in param1.strVars)
         {
            this.dynamicVars.delStrVar(_loc4_);
         }
      }
      
      private function obf_u_L_1438(param1:PlayerKilledMonsterChangeNotify) : void
      {
         var _loc2_:String = null;
         if(!this.obf_i_S_846)
         {
            return;
         }
         for(_loc2_ in param1.monsterNumber)
         {
            this.obf_i_S_846.addIntVar(_loc2_,param1.monsterNumber[_loc2_]);
         }
         TaskManager.doAutoTask();
      }
      
      private function obf_q_3581(param1:PlayerKilledMonsterOfSuccessChangeNotify) : void
      {
         var _loc2_:String = null;
         if(!obf_j_Y_1351.dynamicVars)
         {
            return;
         }
         for(_loc2_ in param1.monsterNumber)
         {
            obf_j_Y_1351.dynamicVars.addIntVar(_loc2_,param1.monsterNumber[_loc2_]);
         }
      }
      
      public function get obf_E_T_4135() : String
      {
         return this.obf_X_A_1222;
      }
      
      public function getFarmSkillLevelByKind(param1:int) : int
      {
         if(param1 == obf_3_U_4495.PLANT)
         {
            return this.fullInfo.farmSkillLevelArray[0];
         }
         if(param1 == obf_3_U_4495.obf_0___D_549)
         {
            return this.fullInfo.farmSkillLevelArray[1];
         }
         if(param1 == obf_3_U_4495.obf_d_z_1837)
         {
            return this.fullInfo.farmSkillLevelArray[2];
         }
         if(param1 == obf_3_U_4495.obf_A_q_1072)
         {
            return this.fullInfo.farmSkillLevelArray[3];
         }
         return 0;
      }
      
      private function setStatusFlag(param1:int) : void
      {
         this.fullInfo.statusFlags = param1;
         this.statusFlags = param1;
         this.bodySprite.alpha = (this.fullInfo.statusFlags & obf_c_y_957.obf_U_U_4127) >= 1 ? 0.4 : 1;
      }
      
      public function obf_Z_E_4144() : void
      {
         if(this.petFullInfo)
         {
            this.setPet(this.petFullInfo.petCode,this.petFullInfo.name,this.petFullInfo.petId);
            this.setPetBuff(this.petFullInfo.buffInfo);
         }
         else
         {
            this.removePet();
         }
      }
      
      public function obf_2_I_3678() : void
      {
         if(!this.petFullInfo || !obf_r_h_2193)
         {
            return;
         }
         obf_r_h_2193.setName(this.petFullInfo.name,this.id);
      }
      
      public function obf_0_0_4605() : void
      {
         if(this.genieFullInfo)
         {
            this.setGenie(this.genieFullInfo.genieCode,this.genieFullInfo.genieId);
         }
         else
         {
            this.removeGenie();
         }
      }
      
      public function obf_F_i_743() : void
      {
         if(this.devilFullInfo)
         {
            this.setDevil(this.devilFullInfo.devilCode,this.devilFullInfo.devilId);
         }
         else
         {
            this.removeDevil();
         }
      }
      
      public function obf_8_1_2164() : void
      {
         if(this.fullInfo.dragonLevel > 0 && !GameContext.userConfig.sst.hid)
         {
            this.setDragon(this.fullInfo.dragonLevel);
         }
         else
         {
            this.removeDragon();
         }
      }
      
      public function obf_0_H_3969() : void
      {
         if(this.fullInfo.dragonLevel > 0 && !GameContext.userConfig.sst.hid)
         {
            this.setDragon(this.fullInfo.dragonLevel);
         }
         else
         {
            this.removeDragon();
         }
      }
      
      public function obf_f_s_1651() : void
      {
         var _loc1_:BuffInfo = null;
         if(this.playerJobCode != obf_I_5_1944.obf_0_1_133)
         {
            return;
         }
         if(this.trainerFullInfo)
         {
            this.setTrainer(this.trainerFullInfo);
            this.setTrainerBuff(this.trainerFullInfo.buffs);
            if(obf_K_e_3075.obf_G_K_2049)
            {
               obf_K_e_3075.obf_G_K_2049.buffUI.clearAllBuff();
               obf_K_e_3075.obf_G_K_2049.debuffUI.clearAllBuff();
               for each(_loc1_ in this.trainerFullInfo.buffs)
               {
                  obf_K_e_3075.obf_G_K_2049.buffUI.addBuff(_loc1_);
               }
            }
         }
         else
         {
            this.removeTrainer();
         }
      }
      
      public function obf_I_a_3356() : void
      {
         if(!obf_v_H_3187)
         {
            return;
         }
      }
      
      public function set familyMyInfo(param1:FamilyMyInfo) : void
      {
         this.obf_z_N_2414 = param1;
         if(!this.obf_z_N_2414)
         {
            this._ops = null;
            familyName = "";
            return;
         }
         this._ops = JSONUtil.getObject(obf_F_9_1495.getPostConfig(this.obf_z_N_2414.postLevel),["ops"],[]) as Array;
         familyName = param1.familyName;
         this.obf_G_p_757();
      }
      
      public function get familyMyInfo() : FamilyMyInfo
      {
         return this.obf_z_N_2414;
      }
      
      public function set familyInfo(param1:FamilyInfo) : void
      {
         this.obf_Z_A_2081 = param1;
      }
      
      public function get familyInfo() : FamilyInfo
      {
         return this.obf_Z_A_2081;
      }
      
      public function hasFamily() : Boolean
      {
         return Boolean(GameContext.localPlayer.familyMyInfo) && !obf_L_l_4100.isEmpty(GameContext.localPlayer.familyMyInfo.familyName);
      }
      
      public function obf_O_l_2706(param1:int) : Boolean
      {
         if(!this._ops || this._ops.length == 0)
         {
            return false;
         }
         return this._ops.indexOf(param1) > -1;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         this.obf_L_7_3723();
         this.showNumberEffectList();
         this.obf_Z_W_2278();
         if(this.autoRideTimeInv.checkTimeout())
         {
            this.obf_5_N_2570();
         }
      }
      
      public function obf_5_N_2570() : void
      {
         var _loc1_:Array = null;
         var _loc2_:IconItemBag = null;
         var _loc3_:Boolean = false;
         if(!this.isWalking() || this.isActiveOrPassiveRiding)
         {
            return;
         }
         if(Boolean(obf_z_M_1523) && Boolean(obf_z_M_1523.length > 0) && this.getLineDistancePt(obf_z_M_1523[obf_z_M_1523.length - 1].x,obf_z_M_1523[obf_z_M_1523.length - 1].y) > this.autoRideDistance)
         {
            if(Boolean(obf_K_e_3075.playerFullInfoUI) && Boolean(obf_K_e_3075.rideBoxUI))
            {
               _loc1_ = [obf_K_e_3075.playerFullInfoUI.getRideBag()].concat(obf_K_e_3075.rideBoxUI.rideBags);
               for each(_loc2_ in _loc1_)
               {
                  if(!_loc2_.isLocked && Boolean(_loc2_.haveIconItem))
                  {
                     _loc3_ = _loc2_.haveIconItem.useIcon();
                     if(!_loc3_)
                     {
                        obf_K_e_3075.obf_n_h_4389();
                     }
                     break;
                  }
               }
            }
         }
      }
      
      override protected function obf_C_Z_3054() : void
      {
      }
      
      public function obf_g_R_3687(param1:Point, param2:int, param3:Function, param4:Array) : void
      {
         if(!this.obf_7_t_3798())
         {
            return;
         }
         if(param2 < 0)
         {
            param2 == 0;
         }
         this.walkToTargetPoint = param1;
         this.walkToTargetLength = param2;
         this.walkToTargetDoFun = param3;
         this.walkToTargetDoPara = param4;
         this.walkToTarget = true;
         this.obf_J_O_1057(param1.x,param1.y);
      }
      
      private function obf_L_7_3723() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Function = null;
         var _loc3_:Array = null;
         if(this.walkToTarget && this.walkToTargetTime.checkTimeout())
         {
            _loc1_ = this.getLineDistancePt(this.walkToTargetPoint.x,this.walkToTargetPoint.y);
            if(_loc1_ <= this.walkToTargetLength)
            {
               _loc2_ = this.walkToTargetDoFun;
               _loc3_ = this.walkToTargetDoPara;
               this.obf_2_R_3847();
               if(_loc2_ != null)
               {
                  _loc2_.apply(null,_loc3_);
               }
            }
         }
      }
      
      public function obf_2_R_3847() : void
      {
         this.walkToTarget = false;
         this.walkToTargetDoFun = null;
         this.walkToTargetDoPara = null;
      }
      
      public function get isSelectTargetToDo() : Boolean
      {
         return this.obf_g_D_2470;
      }
      
      public function get obf_c_6_1007() : String
      {
         return this.obf_X_4673;
      }
      
      public function obf_F_S_2208(param1:Function, param2:Array, param3:String = "") : void
      {
         if(param1 == null)
         {
            return;
         }
         this.obf_2_W_2001 = param1;
         this.obf_m_p_1852 = param2;
         this.obf_g_D_2470 = true;
         this.obf_X_4673 = param3;
      }
      
      public function obf_L_r_3810() : Boolean
      {
         var _loc1_:Boolean = this.obf_2_W_2001 != null;
         this.obf_2_W_2001 = null;
         this.obf_m_p_1852 = null;
         this.obf_g_D_2470 = false;
         this.obf_X_4673 = "";
         obf_e_P_918.setDefaultCursor(new Sprite());
         return _loc1_;
      }
      
      public function obf_Z_y_1644(param1:MapInteractiveObject) : Boolean
      {
         if(this.obf_2_W_2001 != null)
         {
            this.obf_2_W_2001.apply(null,[param1].concat(this.obf_m_p_1852));
            return true;
         }
         return false;
      }
      
      public function obf_0_1_S_307(param1:Number, param2:String, param3:String = "") : void
      {
         this.numberEffectList.push([param1,param2,param3]);
      }
      
      public function obf_3_w_1335(param1:DisplayObject, param2:String) : void
      {
         this.numberEffectList.push([param1,param2]);
      }
      
      private function showNumberEffectList() : void
      {
         var _loc1_:Array = null;
         if(this.numberEffectTime.checkTimeout() && this.numberEffectList.length > 0)
         {
            _loc1_ = this.numberEffectList.shift();
            if(_loc1_[0] is DisplayObject || _loc1_[0] == null)
            {
               this.showIconTextEffect.apply(null,_loc1_);
            }
            else
            {
               this.showNumberEffect.apply(null,_loc1_);
            }
         }
      }
      
      public function selectTarget(param1:MapInteractiveObject) : void
      {
         this.obf_0_6_a_430 = param1;
         this.obf_5_r_2310.followSkillCode = "";
         if(GameContext.currentMap)
         {
            GameContext.currentMap.setSelectedObject(param1);
         }
         obf_K_e_3075.setTargetInfo(param1);
      }
      
      public function obf_3_v_4336() : void
      {
         obf_K_e_3075.closeUI(obf_K_e_3075.targetInfoUI);
         this.obf_0_6_a_430 = null;
         if(GameContext.currentMap)
         {
            GameContext.currentMap.setSelectedObject(null);
         }
         this.stopAutoAttack();
      }
      
      public function obf_r_7_2244(param1:int, param2:int, param3:MapInteractiveObject) : Boolean
      {
         return param3.isValidSkillTarget(this,param1,param2);
      }
      
      public function obf_0_9_M_581(param1:String, param2:int, param3:Point, param4:Boolean = false, param5:String = "") : void
      {
         var _loc7_:Object = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc6_:Object = SkillConfig.getSkillConfig(param1);
         if(!_loc6_)
         {
            return;
         }
         if(param2 >= 0 && param2 < _loc6_.levelInfo.length)
         {
            _loc7_ = _loc6_.levelInfo[param2];
         }
         if(_loc7_)
         {
            _loc8_ = int(_loc7_.castRule.singTime);
            _loc9_ = int(_loc7_.castRule.castTime);
            useSkillOnPoint(0,_loc6_.code,param3,_loc8_,_loc9_,param2);
            if(param4 && _loc8_ > 0)
            {
               if(param5 == "")
               {
                  param5 = _loc6_.name;
               }
               obf_K_e_3075.showSingBar(true,param5,_loc8_);
            }
         }
      }
      
      private function obf_Z_W_2278() : void
      {
         if(!this.autoAttackTimeInv.checkTimeout())
         {
            return;
         }
         if(!this.obf_e_y_3381 || this.obf_w_e_2707 || (this.fullInfo.statusFlags & obf_c_y_957.obf_U_U_4127) >= 1)
         {
            return;
         }
         if(this.walkToTarget)
         {
            return;
         }
         if(!this.attackTimeInv)
         {
            this.attackTimeInv = new TimeLimiter(100);
         }
         if(this.attackTimeInv.checkTimeout())
         {
            this.attackTimeInv = null;
            if(!this.autoAttackTarget || !this.autoAttackTarget.getMap() || this.autoAttackTarget.isDestroyed() || this.autoAttackTarget is obf_0_Y_3475 && (this.autoAttackTarget as obf_0_Y_3475).isDead)
            {
               this.stopAutoAttack();
               return;
            }
            if(Boolean(this.obf_0_6_z_237) && this.obf_0_6_z_237.length > 0)
            {
               this.sendSkill.apply(null,this.obf_0_6_z_237);
               this.obf_0_6_z_237 = null;
            }
            else if(!SkillCDManager.checkSkillCD(PlayerSkillManager.defaultAttackSkillCode))
            {
               PlayerSkillManager.useDefaultAttackSkill(this.autoAttackTarget);
            }
            return;
         }
      }
      
      public function get isReadySkillToCast() : Boolean
      {
         if(!this.obf_e_y_3381)
         {
            return false;
         }
         return Boolean(this.obf_0_6_z_237) && this.obf_0_6_z_237.length > 0;
      }
      
      public function get obf_w_L_1217() : String
      {
         if(!this.obf_e_y_3381)
         {
            return "";
         }
         return JSONUtil.getStr(this.obf_0_6_z_237,[0]);
      }
      
      public function skillIsReadyToCast(param1:String) : Boolean
      {
         if(!this.obf_e_y_3381)
         {
            return false;
         }
         if(this.isReadySkillToCast)
         {
            return this.obf_0_6_z_237[0] == param1;
         }
         return false;
      }
      
      public function get isAutoAttacking() : Boolean
      {
         return this.obf_e_y_3381;
      }
      
      public function startAutoAttack(param1:MapInteractiveObject) : void
      {
         this.obf_e_y_3381 = true;
         this.autoAttackTarget = param1;
      }
      
      public function stopAutoAttack() : void
      {
         this.obf_e_y_3381 = false;
         this.obf_0_6_z_237 = null;
         this.autoAttackTarget = null;
      }
      
      public function obf_p_u_1039(param1:int, param2:String) : Boolean
      {
         if(param1 == obf_A_w_2394.obf_E_f_3397)
         {
            return true;
         }
         if(param1 == obf_A_w_2394.ALL)
         {
            return true;
         }
         if(param1 == obf_A_w_2394.obf_W_K_4417)
         {
            if(param2 == this.id)
            {
               return true;
            }
         }
         else if(param1 == obf_A_w_2394.obf_E_J_1418)
         {
            if(param2 != this.id)
            {
               return true;
            }
         }
         else
         {
            if(param1 == obf_A_w_2394.obf_3_p_4128)
            {
               return isInSameTeamByPlayerId(param2);
            }
            if(param1 == obf_A_w_2394.obf_h_9_3307)
            {
               return true;
            }
            if(param1 == obf_A_w_2394.obf_Y_q_3436)
            {
               return true;
            }
            if(param1 == obf_A_w_2394.obf_S_5_2754)
            {
               return isInSameFamilyByPlayerId(param2);
            }
         }
         return false;
      }
      
      public function obf_7_t_3798() : Boolean
      {
         if(this.isBooth)
         {
            return false;
         }
         if(this.isBlessing)
         {
            return false;
         }
         if(this.isCastingSkill)
         {
            return false;
         }
         if(this.isPassiveRiding)
         {
            return false;
         }
         if(this.isDead)
         {
            return false;
         }
         if(this.obf_Q_W_1326())
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","cantMove"));
            return false;
         }
         return true;
      }
      
      public function obf_B_R_3012() : Boolean
      {
         if(this.isBooth)
         {
            return false;
         }
         if(this.isBlessing)
         {
            return false;
         }
         if(this.obf_w_e_2707)
         {
            return false;
         }
         if(this.obf_I_z_3437(obf_c_y_957.obf_V_4_3128) || this.isInCombat)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","cantRide"));
            return false;
         }
         return true;
      }
      
      public function obf_0_0_z_623() : Boolean
      {
         if(this.obf_I_z_3437(obf_c_y_957.obf_J_z_1112))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","cantUseItem"));
            return false;
         }
         return true;
      }
      
      public function canTeleport() : Boolean
      {
         if(this.obf_I_z_3437(obf_c_y_957.obf_X_J_2904))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","cantTeleport"));
            return false;
         }
         return true;
      }
      
      override public function destroy() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.obf_2_R_3847();
         this.obf_L_r_3810();
         this.obf_5_r_2310.destroy();
         super.destroy();
      }
      
      public function obf_U_O_1769(param1:String, param2:*) : void
      {
         this.obf_n_g_1131 = new Object();
         this.obf_n_g_1131["action"] = param1;
         this.obf_n_g_1131["par"] = param2;
         this.obf_0_6_W_189 = null;
      }
      
      public function sendTeleportMapMove(param1:String, param2:String, param3:*) : void
      {
         obf_K_e_3075.worldMapUI.teleportToMap(param1);
         this.obf_U_O_1769(param2,param3);
      }
      
      public function obf_0_8_r_450(param1:String, param2:String, param3:*) : void
      {
         this.obf_n_g_1131 = new Object();
         this.obf_n_g_1131["action"] = param2;
         this.obf_n_g_1131["par"] = param3;
         if(param1 == GameContext.currentMap.mapId)
         {
            this.obf_M_J_1251();
         }
         else
         {
            this.obf_0_6_W_189 = MapManager.instance.getThroughMapArray(GameContext.currentMap.mapId,param1);
            if(this.obf_0_6_W_189)
            {
               this.obf_0_6_W_189.shift();
               this.moveToNextMap();
            }
            else
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","cantFindPath"));
            }
         }
      }
      
      public function obf_m_0_2998() : void
      {
         this.obf_n_g_1131 = null;
         this.obf_0_6_W_189 = new Array();
      }
      
      public function moveToNextMap() : void
      {
         var _loc2_:Object = null;
         var _loc3_:Rectangle = null;
         if(!_map)
         {
            return;
         }
         if(!this.obf_0_6_W_189 || this.obf_0_6_W_189.length == 0)
         {
            this.obf_M_J_1251();
            return;
         }
         var _loc1_:String = this.obf_0_6_W_189.shift();
         for each(_loc2_ in _map.exitArray)
         {
            if(_loc2_.toEntry.split("@").reverse()[0] == _loc1_)
            {
               _loc3_ = _loc2_ as Rectangle;
               if(_loc3_)
               {
                  this.obf_I_V_3724(_loc3_.x + _loc3_.width / 2,_loc3_.y + _loc3_.height / 2);
                  return;
               }
            }
         }
         obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","cantFindPath"));
      }
      
      private function obf_M_J_1251() : void
      {
         var _loc1_:Point = null;
         var _loc2_:MapInteractiveObject = null;
         var _loc3_:obf_0_1_N_478 = null;
         var _loc4_:AINpc = null;
         var _loc5_:Function = null;
         var _loc6_:Point = null;
         var _loc7_:String = null;
         if(!this.obf_n_g_1131)
         {
            return;
         }
         if(this.obf_n_g_1131["action"] == obf_L_K_2966)
         {
            _loc1_ = this.obf_n_g_1131["par"] as Point;
            if(_loc1_)
            {
               this.obf_I_V_3724(_loc1_.x,_loc1_.y);
            }
         }
         else if(this.obf_n_g_1131["action"] == obf_G_Q_2335)
         {
            _loc2_ = GameContext.currentMap.getObjectById(this.obf_n_g_1131["par"]);
            if(_loc2_)
            {
               this.obf_I_V_3724(_loc2_.rootPX,_loc2_.rootPY);
            }
         }
         else if(this.obf_n_g_1131["action"] == obf_j_k_4275)
         {
            _loc3_ = GameContext.currentMap.obf_v_P_2126.getFarm(this.obf_n_g_1131["par"]);
            if(_loc3_)
            {
               this.obf_I_V_3724(_loc3_.getCenterX(),_loc3_.getCenterY());
            }
         }
         else if(this.obf_n_g_1131["action"] == obf_H_n_3781)
         {
            _loc4_ = GameContext.currentMap.npcSet.getObject(this.obf_n_g_1131["par"]) as AINpc;
            if(_loc4_)
            {
               if(!obf_b_p_3604.checkNpcDistance(_loc4_.id,false))
               {
                  this.obf_g_R_3687(new Point(_loc4_.rootPX,_loc4_.rootPY),WorldConfig.MAX_NPC_TALK_DISTANCE,obf_K_e_3075.showNpcTalkBox,[_loc4_]);
               }
               else
               {
                  obf_K_e_3075.showNpcTalkBox(_loc4_);
               }
            }
         }
         else if(this.obf_n_g_1131["action"] == obf_q_O_2547)
         {
            _loc5_ = this.obf_n_g_1131["par"]["fun"];
            if(_loc5_ != null)
            {
               _loc5_.apply(null,this.obf_n_g_1131["par"]["par"]);
            }
         }
         else if(this.obf_n_g_1131["action"] == obf_Z_n_2536)
         {
            _loc6_ = this.obf_n_g_1131["par"]["target"];
            _loc7_ = this.obf_n_g_1131["par"]["macro"];
            if(_loc6_)
            {
               this.obf_g_R_3687(_loc6_,12,obf_F_2_2975.obf_O_p_3236,[_loc7_]);
            }
         }
         this.obf_n_g_1131 = null;
      }
      
      public function obf_I_V_3724(param1:int, param2:int) : Boolean
      {
         var _loc3_:obf_0_1_N_478 = null;
         if(!GameContext.currentMap || !GameContext.currentMap.bgObjectLayer)
         {
            return false;
         }
         if(!this.obf_u_i_1633.checkTimeout())
         {
            return false;
         }
         if(!this.obf_7_t_3798())
         {
            return false;
         }
         if(Boolean(this.fullInfo.mainFarm && GameContext.currentMap.mapId == this.fullInfo.mainFarm.mapId) && Boolean(JSONUtil.getInt(TaskManager.doneTasks,[WorldConfig.getNumberSetting("leaveFarmTaskId")]) <= 0) && (GameContext.currentMap.getFarmUnderPoint(param1,param2) == null || GameContext.currentMap.getFarmUnderPoint(param1,param2).id != this.fullInfo.mainFarm.farmId))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","dontMoveOutFarm"));
            _loc3_ = GameContext.currentMap.obf_v_P_2126.getFarm(this.fullInfo.mainFarm.farmId);
            if(!(Boolean(_loc3_) && (this.getFarm() == null || this.getFarm().id != this.fullInfo.mainFarm.farmId)))
            {
               return false;
            }
            param1 = _loc3_.getCenterX();
            param2 = _loc3_.getCenterY();
         }
         if(Boolean(this.skillRenderer) && this.skillRenderer.isRendering)
         {
            this.obf_T_9_2144();
         }
         obf_0_9_V_473.showEffectOnPoint(GameContext.currentMap,new Point(param1,param2),"C_MoveClickEfc");
         this.obf_J_O_1057(param1,param2);
         this.obf_2_R_3847();
         return true;
      }
      
      public function obf_K_2_1118() : void
      {
         if(!this.obf_7_t_3798())
         {
            return;
         }
         this.stopWalking();
         var _loc1_:PlayerMoveRequest = new PlayerMoveRequest();
         _loc1_.mapId = this.mapId;
         _loc1_.pathArray = [new MapPoint(this.rootPX,this.rootPY),new MapPoint(this.rootPX,this.rootPY)];
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      private function obf_J_O_1057(param1:int, param2:int) : void
      {
         var _loc3_:Array = null;
         var _loc5_:Point = null;
         trace("[MOVE] click=" + param1 + "," + param2 + " current=" + this.rootPX + "," + this.rootPY + " targetPassable=" + this.getMap().canWalk(param1,param2) + " currentPassable=" + this.getMap().canWalk(this.rootPX,this.rootPY));
         if(this.getMap().canWalk(param1,param2))
         {
            _loc3_ = this.walkToPixel(param1,param2);
         }
         else
         {
            _loc5_ = this.getMap().getNearestPassablePoint(param1,param2);
            if(_loc5_ != null)
            {
               _loc3_ = this.walkToPixel(_loc5_.x,_loc5_.y);
            }
         }
         var _loc4_:PlayerMoveRequest = new PlayerMoveRequest();
         _loc4_.mapId = this.mapId;
         trace("[MOVE] pathLength=" + (_loc3_ == null ? -1 : _loc3_.length));
         if(Boolean(_loc3_) && _loc3_.length > 1)
         {
            _loc4_.pathArray = MapPoint.PointArrayToMap(_loc3_);
            GameContext.worldClient.sendCommand(_loc4_);
         }
         else if(!this.getMap().canWalk(this.rootPX,this.rootPY))
         {
            _loc4_.pathArray = [new MapPoint(this.rootPX,this.rootPY),new MapPoint(param1,param2)];
            GameContext.worldClient.sendCommand(_loc4_);
         }
      }
      
      private function setAnimalMove(param1:int, param2:int) : void
      {
         var _loc3_:Array = null;
         var _loc5_:Point = null;
         if(this.playerJobCode != obf_I_5_1944.obf_0_1_133)
         {
            return;
         }
         if(!this.obf_v_H_3187)
         {
            return;
         }
         if(this.getMap().canWalk(param1,param2))
         {
            _loc3_ = this.obf_v_H_3187.walkToPixel(param1,param2);
         }
         else
         {
            _loc5_ = this.getMap().getNearestPassablePoint(param1,param2);
            if(_loc5_ != null)
            {
               _loc3_ = this.obf_v_H_3187.walkToPixel(_loc5_.x,_loc5_.y);
            }
         }
         var _loc4_:AnimalMoveRequest = new AnimalMoveRequest();
         _loc4_.mapId = this.mapId;
         if(Boolean(_loc3_) && _loc3_.length > 1)
         {
            _loc4_.pathArray = MapPoint.PointArrayToMap(_loc3_);
            GameContext.worldClient.sendCommand(_loc4_);
         }
         else if(!this.getMap().canWalk(this.obf_v_H_3187.rootPX,this.obf_v_H_3187.rootPY))
         {
            _loc4_.pathArray = [new MapPoint(this.obf_v_H_3187.rootPX,this.obf_v_H_3187.rootPY),new MapPoint(param1,param2)];
            GameContext.worldClient.sendCommand(_loc4_);
         }
      }
      
      public function sendSelectMapLine(param1:int) : void
      {
         var _loc2_:PlayerSelectLineRequest = new PlayerSelectLineRequest();
         _loc2_.lineIndex = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public function obf_M_m_4192(param1:int) : void
      {
         if(JSONUtil.getInt(MapManager.instance.mapInfo,["rules","pkRule","pkMode"]) > 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","cantChangePKModeInMap"));
         }
         var _loc2_:PlayerSetPKModeRequest = new PlayerSetPKModeRequest();
         _loc2_.pkMode = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public function sendViewRemote(param1:String) : void
      {
         var _loc2_:PlayerViewRemoteRequest = new PlayerViewRemoteRequest();
         _loc2_.remotePlayerId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public function sendAssignAttr(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:PlayerAssignAttrRequest = new PlayerAssignAttrRequest();
         _loc5_.agiAdded = param2;
         _loc5_.strAdded = param1;
         _loc5_.vitAdded = param4;
         _loc5_.wisAdded = param3;
         GameContext.worldClient.sendCommand(_loc5_);
      }
      
      public function sendTitleChange(param1:int) : void
      {
         var _loc2_:PlayerSetTitleRequest = new PlayerSetTitleRequest();
         _loc2_.titleIndex = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public function sendKitTitleChange(param1:int) : void
      {
         var _loc2_:PlayerSetKitTitleRequest = new PlayerSetKitTitleRequest();
         _loc2_.titleIndex = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public function sendReport(param1:String, param2:int) : void
      {
         if(!ConditionScript.checkCondition(WorldConfig.getValue("reportSetting","reportCond"),null,true))
         {
            return;
         }
         this.reportTimeArr.push(param1);
         var _loc3_:PlayerReportRemoteRequest = new PlayerReportRemoteRequest();
         _loc3_.remotePlayerId = param1;
         _loc3_.reportType = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public function sendPlayerChangeEnd() : void
      {
         var _loc1_:PlayerChangeModelEndRequest = new PlayerChangeModelEndRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public function get obf_w_e_2707() : Boolean
      {
         return this.isUsingSkill;
      }
      
      private function selectTargetSkill(param1:MapInteractiveObject, param2:String) : void
      {
         if(!param1)
         {
            return;
         }
         this.sendSkill(param2,param1,null);
      }
      
      public function sendSkill(param1:String, param2:MapInteractiveObject, param3:Point, param4:obf_O_8_1034 = null, param5:String = "") : Boolean
      {
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:String = null;
         var _loc13_:PlayerUseSkillRequest = null;
         var _loc14_:Object = null;
         var _loc15_:Point = null;
         var _loc6_:Object = SkillConfig.getSkillConfig(param1);
         if(!_loc6_)
         {
            obf_6_D_3816.obf_0_5_O_723("UseSkill failed! Skill " + param1 + " not finded!");
            return false;
         }
         var _loc7_:int = PlayerSkillManager.getSkillLevel(param1) - 1;
         if(_loc7_ < 0 || _loc7_ >= _loc6_.levelInfo.length)
         {
            obf_6_D_3816.obf_0_5_O_723("UseSkill failed! Skill level " + _loc7_ + " error!");
            return false;
         }
         SkillCDManager.setCDClickEffect(SkillCDManager.getSkillCDFlag(param1));
         var _loc8_:Object = _loc6_.levelInfo[_loc7_];
         if(!ConditionScript.checkCondition(JSONUtil.getObject(_loc8_,["enableRule","condition"])))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","cantDo"));
            return false;
         }
         if(_loc6_.aimMode == SkillAimMode.POINT && !SkillCDManager.checkSkillCD(SkillCDManager.getSkillCDFlag(param1)) && !param3)
         {
            SkillAreaAimManager.showAreaAim(param1,_loc6_.areaShape,_loc8_.castRule.areaAttributes,[param4,param5]);
            return false;
         }
         if(_loc6_.aimMode == SkillAimMode.OBJECT)
         {
            if(!param2 && (_loc6_.target & obf_7_4687.obf_U_V_1017 & obf_7_4687.FARM_BUILDING & obf_7_4687.obf_X_a_3948 & obf_7_4687.obf_W_D_2893 & obf_7_4687.obf_J_A_2140 & obf_7_4687.obf_1_H_3014 & obf_7_4687.obf_0_4_S_123) > 0)
            {
               this.obf_F_S_2208(this.selectTargetSkill,[param1]);
               obf_e_P_918.setDefaultCursor(new CursorTargetToDo());
               return false;
            }
            if(!param2 || !this.obf_r_7_2244(_loc6_.target,_loc6_.notTarget,param2))
            {
               if(this.obf_r_7_2244(_loc6_.target,_loc6_.notTarget,this))
               {
                  param2 = this;
               }
               else
               {
                  param2 = null;
               }
            }
         }
         PlayerSkillManager.obf_j_M_1052();
         this.obf_2_R_3847();
         var _loc9_:int = this.obf_5_r_2310.checkSkill(_loc6_,_loc7_,param2,param3);
         if(_loc9_ == 0)
         {
            if(!this.obf_9_L_4423.checkTimeout())
            {
               return false;
            }
            MapManager.instance.clearRecentList();
            if(!obf_L_l_4100.isEmpty(this.obf_X_A_1222))
            {
               _loc14_ = GameItemManager.getItemConfig(this.obf_X_A_1222);
               if(this.isActiveRiding && (!_loc14_ || !JSONUtil.getBoolean(_loc14_,["properties","canCombat"])))
               {
                  this.ride(false);
                  this.obf_K_2_1118();
                  this.obf_2_4683("");
               }
            }
            if(Boolean(this.actionManager) && this.actionManager.currentAction == obf_S_c_3330.obf_0_3_U_524)
            {
               this.stopAction();
            }
            if(Boolean(_loc6_.aimMode == SkillAimMode.OBJECT && param2) && Boolean(param2.isValidSkillTarget(this,obf_7_4687.obf_C_4201,0)) && (_loc6_.type == obf_M_F_3694.obf_a_w_4267 || _loc6_.type == obf_M_F_3694.MAGIC))
            {
               this.startAutoAttack(param2);
            }
            _loc10_ = int(_loc8_.castRule.singTime);
            _loc11_ = int(_loc8_.castRule.castTime);
            if(_loc6_.type != obf_M_F_3694.obf_v_J_1381)
            {
               if(!JSONUtil.getBoolean(_loc8_.castRule,["singTimeFixed"]))
               {
                  _loc10_ = Math.max(_loc10_ - this.fullInfo.attributes.singTimeReduceMS,0) * this.fullInfo.attributes.singTimeModifier;
               }
               if(!JSONUtil.getBoolean(_loc8_.castRule,["castTimeFixed"]))
               {
                  _loc11_ *= this.fullInfo.attributes.castTimeModifier;
               }
            }
            ++this.skillSn;
            if(this.skillSn > 65535)
            {
               this.skillSn = 0;
            }
            _loc12_ = SkillCDManager.getSkillCDFlag(param1);
            SkillCDManager.setSkillCD(_loc12_,JSONUtil.getInt(_loc8_.castRule,["coldTime"]) + _loc10_ + _loc11_,this.skillSn);
            if(_loc6_.aimMode == SkillAimMode.POINT)
            {
               this.useSkillOnPoint(this.skillSn,param1,param3,_loc10_,_loc11_,_loc7_);
            }
            else if(_loc6_.aimMode == SkillAimMode.NONE)
            {
               this.useSkillOnObject(this.skillSn,param1,this,_loc10_,_loc11_,_loc7_);
            }
            else if(_loc6_.aimMode == SkillAimMode.OBJECT)
            {
               this.useSkillOnObject(this.skillSn,param1,param2,_loc10_,_loc11_,_loc7_);
            }
            this.currentSkillObject = _loc6_;
            this.currentSkillLevel = _loc8_;
            if(_loc10_ > 0)
            {
               if(param5 == "")
               {
                  param5 = _loc6_.name;
               }
               obf_K_e_3075.showSingBar(true,param5,_loc10_);
            }
            _loc13_ = new PlayerUseSkillRequest();
            _loc13_.mapId = this.mapId;
            _loc13_.skillCode = param1;
            _loc13_.skillSn = this.skillSn;
            if(param4)
            {
               _loc13_.wrappedRequestBytes = GameContext.worldClient.netClient.commandCodec.encode(param4);
            }
            if(param2)
            {
               _loc13_.targetId = param2.id;
            }
            if(param3)
            {
               _loc13_.targetPoint = MapPoint.PointToMapPoint(param3);
            }
            GameContext.worldClient.sendCommand(_loc13_);
            return true;
         }
         if(_loc9_ == SkillManager.OUTRANGE || _loc9_ == SkillManager.BLOCKED)
         {
            _loc15_ = new Point();
            if(_loc6_.aimMode == SkillAimMode.OBJECT)
            {
               _loc15_.x = param2.rootPX;
               _loc15_.y = param2.rootPY;
            }
            else if(_loc6_.aimMode == SkillAimMode.POINT)
            {
               _loc15_.x = param3.x;
               _loc15_.y = param3.y;
            }
            this.obf_g_R_3687(_loc15_,_loc8_.castRule.range,this.sendSkill,[param1,param2,param3,param4,param5]);
            return false;
         }
         if(_loc9_ == SkillManager.USINGSKILL)
         {
            this.obf_0_6_z_237 = [param1,param2,param3,param4,param5];
            return false;
         }
         if(_loc9_ == SkillManager.RIDING)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","cantActionOnRide"));
            return false;
         }
         return false;
      }
      
      public function obf_T_9_2144() : void
      {
         var _loc1_:PlayerCancelSkillRequest = null;
         if(this.isUsingSkill && !this.isCastingSkill)
         {
            this.stopSkill();
            this.stopAutoAttack();
            _loc1_ = new PlayerCancelSkillRequest();
            _loc1_.skillSn = this.obf_3_y_4486;
            GameContext.worldClient.sendCommand(_loc1_);
         }
      }
      
      private function skillDone(param1:obf_0_Y_3475, param2:Boolean) : void
      {
         obf_K_e_3075.showSingBar(false,"");
         this.stopSkill();
         this.currentSkillObject = null;
      }
      
      public function obf_2_4683(param1:String) : Boolean
      {
         if(!obf_L_l_4100.isEmpty(param1) && param1 != this.obf_D_9_3842 && !this.obf_B_R_3012())
         {
            return false;
         }
         if(this.isTransfiguration)
         {
            return false;
         }
         var _loc2_:PlayerRideRequest = new PlayerRideRequest();
         if(param1 != "" && param1 != this.obf_D_9_3842 && !this.isActiveRiding)
         {
            if(!MapManager.instance.obf_C_O_3385())
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("RidePrompt","cantRideInMap"));
               return false;
            }
            this.obf_D_9_3842 = param1;
            _loc2_.rideId = param1;
            GameContext.worldClient.sendCommand(_loc2_);
            return true;
         }
         this.obf_D_9_3842 = "";
         _loc2_.rideId = "";
         GameContext.worldClient.sendCommand(_loc2_);
         return true;
      }
      
      public function sendAddRideExp(param1:String, param2:int) : void
      {
         var _loc3_:PlayerAddRideExpRequest = new PlayerAddRideExpRequest();
         _loc3_.exp = param2;
         _loc3_.rideId = param1;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public function sendSetUsingRide(param1:String) : void
      {
         var _loc2_:PlayerSetUsingRideRequest = new PlayerSetUsingRideRequest();
         _loc2_.rideId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public function obf_P_v_1396(param1:String) : void
      {
         if(!this.isActiveOrPassiveRiding || this.isPassiveRiding)
         {
            return;
         }
         var _loc2_:PlayerInviteRideRequest = new PlayerInviteRideRequest();
         _loc2_.guestPlayerId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public function sendInviteTeamRide() : void
      {
         var _loc1_:TeamMemberInfo = null;
         var _loc2_:RemotePlayer = null;
         if(!this.isActiveOrPassiveRiding || this.isPassiveRiding)
         {
            return;
         }
         if(this.teamName != "")
         {
            for each(_loc1_ in TeamManager.teamMembers)
            {
               if(_loc1_.name != this.id)
               {
                  _loc2_ = GameContext.currentMap.remotePlayerSet.getObject(_loc1_.name) as RemotePlayer;
                  if(Boolean(_loc2_) && this.getLineDistance(_loc2_) <= WorldConfig.MAX_PASSIVE_RIDE_DISTANCE)
                  {
                     this.obf_P_v_1396(_loc2_.id);
                  }
               }
            }
         }
      }
      
      public function obf_D_z_3450(param1:String) : void
      {
         if(this.isActiveOrPassiveRiding)
         {
            return;
         }
         var _loc2_:PlayerPassiveRideRequest = new PlayerPassiveRideRequest();
         _loc2_.masterPlayerId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public function kickRidePlayer(param1:String) : void
      {
         var _loc3_:obf_0_M_3913 = null;
         var _loc4_:PlayerKickRideRequest = null;
         if(!this.isActiveOrPassiveRiding || this.isPassiveRiding || param1 == this.id)
         {
            return;
         }
         var _loc2_:Boolean = false;
         for each(_loc3_ in this.obf_N_u_1040)
         {
            if(_loc3_.id == param1)
            {
               _loc2_ = true;
               break;
            }
         }
         _loc4_ = new PlayerKickRideRequest();
         _loc4_.kickPlayerId = param1;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public function sendMsg(param1:String, param2:int, param3:String = "") : void
      {
         if(!param1 || param1 == "")
         {
            return;
         }
         var _loc4_:PlayerSendMsgRequest = new PlayerSendMsgRequest();
         _loc4_.content = param1;
         _loc4_.scope = param2;
         _loc4_.toRoleName = param3;
         GameContext.worldClient.sendCommand(_loc4_);
         if(param2 == MessageScope.CHANNEL_NEARBY)
         {
            GameContext.localPlayer.say(ChatDecoder.decode(obf_L_l_4100.obf_r_1236(param1),null,[ChatDecoder.obf_E_4_4245,ChatDecoder.obf_9_K_1802,ChatDecoder.obf_W_v_983]));
         }
      }
      
      public function obf_0_6_S_694(param1:String, param2:Boolean = false) : void
      {
         if(!this.canTeleport())
         {
            return;
         }
         var _loc3_:MapTeleportRequest = new MapTeleportRequest();
         _loc3_.toMapId = param1;
         _loc3_.useItem = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public function obf_n_4015(param1:Boolean) : void
      {
         var _loc2_:PlayerSitRequest = new PlayerSitRequest();
         _loc2_.sit = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayer.PLAYER_ENTER_WORLD_ANSWER)
         {
            this.onEnterWorld(param1 as PlayerEnterWorldAnswer);
         }
         else if(param1.code != CommandCodePlayer.PLAYER_LEAVE_WORLD_ANSWER)
         {
            if(param1.code == CommandCodePlayer.PLAYER_ENTER_MAP_ANSWER)
            {
               this.onEnterMap(param1 as PlayerEnterMapAnswer);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_DYNAMIC_VAR_CHANGE_NOTIFY)
            {
               this.obf_v_n_3880(param1 as PlayerDynamicVarChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_DYNAMIC_VAR_CLEAR_NOTIFY)
            {
               this.obf_u_C_2266(param1 as PlayerDynamicVarClearNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_KILLED_MONSTER_CHANGE_NOTIFY)
            {
               this.obf_u_L_1438(param1 as PlayerKilledMonsterChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_KILLED_MONSTER_OF_SUCCESS_CHANGE_NOTIFY)
            {
               this.obf_q_3581(param1 as PlayerKilledMonsterOfSuccessChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_POSITION_CHECK_NOTIFY)
            {
               this.obf_P_Z_1242(param1 as PlayerPositionCheckNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_SIT_CHECK_NOTIFY)
            {
               this.obf_G_9_857(param1 as PlayerSitCheckNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_HP_CHANGE_NOTIFY)
            {
               this.obf_0_3_i_640(param1 as PlayerHpChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_HPMAX_CHANGE_NOTIFY)
            {
               this.obf_j_4_2710(param1 as PlayerHpMaxChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_MP_CHANGE_NOTIFY)
            {
               this.obf_e_T_3609(param1 as PlayerMpChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_MPMAX_CHANGE_NOTIFY)
            {
               this.obf_d_w_2752(param1 as PlayerMpMaxChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_SP_CHANGE_NOTIFY)
            {
               this.obf_h_t_3146(param1 as PlayerSpChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_SPMAX_CHANGE_NOTIFY)
            {
               this.obf_5_w_4524(param1 as PlayerSpMaxChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_XP_CHANGE_NOTIFY)
            {
               this.obf_d_U_2794(param1 as PlayerXpChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_XPMAX_CHANGE_NOTIFY)
            {
               this.obf_Q_f_4530(param1 as PlayerXpMaxChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_STATUS_CHANGE_NOTIFY)
            {
               this.obf_0___b_198(param1 as PlayerStatusChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_HAIR_STYLE_CHANGE_NOTIFY)
            {
               this.obf_u_t_1139(param1 as PlayerHairStyleChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_BUFF_CHANGE_NOTIFY)
            {
               this.obf_z_H_1991(param1 as PlayerBuffChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_DIED_NOTIFY)
            {
               this.obf_1_b_1526(param1 as PlayerDiedNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_REBIRTH_NOTIFY)
            {
               this.obf_0_1_p_225(param1 as PlayerRebirthNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_SKILL_INTERRUPTED_NOTIFY)
            {
               this.obf_p_7_3823(param1 as PlayerSkillInterruptedNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_COMBAT_STATUS_CHECK_NOTIFY)
            {
               this.obf_0_8_1_126(param1 as PlayerCombatStatusCheckNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_SKILL_CD_CHECK_NOTIFY)
            {
               this.obf_c_H_3189(param1 as PlayerSkillCDCheckNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_LUCKY_SKILL_NOTIFY)
            {
               this.obf_M_X_4595(param1 as PlayerLuckySkillNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_LEVEL_UP_NOTIFY)
            {
               this.onPlayerLevelUp(param1 as PlayerLevelUpNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_EXP_CHANGE_NOTIFY)
            {
               this.obf_u_Q_2503(param1 as PlayerExpChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_RECEIVE_REBIRTH_SKILL_NOTIFY)
            {
               this.obf_V_w_1783(param1 as PlayerReceiveRebirthSkillNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_RECEIVE_MSG_NOTIFY)
            {
               this.obf_X_8_1196(param1 as PlayerReceiveMsgNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_RECEIVE_SYS_PROMPT_NOTIFY)
            {
               this.obf_p_C_1227(param1 as PlayerReceiveSysPromptNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_SHOW_TALKS_NOTIFY)
            {
               this.obf_6_X_1376(param1 as PlayerShowTalksNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_RIDE_STATE_CHECK_NOTIFY)
            {
               this.obf_I_A_2945(param1 as PlayerRideStateCheckNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_USING_RIDE_CHECK_NOTIFY)
            {
               this.obf_k_9_1697(param1 as PlayerUsingRideCheckNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_RECEIVE_PASSIVE_RIDE_REQUEST_NOTIFY)
            {
               this.obf_Z_r_3063(param1 as PlayerReceivePassiveRideRequestNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_RECEIVE_INVITE_RIDE_REQUEST_NOTIFY)
            {
               this.obf_h_S_3553(param1 as PlayerReceiveInviteRideRequestNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_RIDE_ITEM_CHECK_NOTIFY)
            {
               this.obf_U_0_2632(param1 as PlayerRideItemCheckNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_GOLD_CHANGE_NOTIFY)
            {
               this.obf_2_4_3396(param1 as PlayerGoldChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_MONEY_CHANGE_NOTIFY)
            {
               this.obf_j_Z_1504(param1 as PlayerMoneyChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_COIN_CHANGE_NOTIFY)
            {
               this.obf_0_k_4282(param1 as PlayerCoinChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_FARM_SKILL_EXP_CHANGE_NOTIFY)
            {
               this.obf_X_1316(param1 as PlayerFarmSkillExpChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_FARM_SKILL_LEVEL_UP_NOTIFY)
            {
               this.obf_m_f_1847(param1 as PlayerFarmSkillLevelUpNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_ATTRIBUTES_CHANGE_NOTIFY)
            {
               this.obf_8_G_988(param1 as PlayerAttributesChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_LIFE_EXP_CHANGE_NOTIFY)
            {
               this.obf_3_J_2974(param1 as PlayerLifeExpChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_LIFE_JOB_CHANGE_NOTIFY)
            {
               this.obf_A_K_3552(param1 as PlayerLifeJobChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_LIFE_LEVEL_UP_NOTIFY)
            {
               this.obf_J_v_1439(param1 as PlayerLifeLevelUpNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_PK_MODE_CHANGE_NOTIFY)
            {
               this.obf_y_8_2836(param1 as PlayerPKModeChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_PK_VALUE_CHANGE_NOTIFY)
            {
               this.obf_q_0_4382(param1 as PlayerPKValueChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_SIDE_CHECK_NOTIFY)
            {
               this.obf_j_X_2478(param1 as PlayerSideChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_USE_MOTION_NOTIFY)
            {
               this.obf_7_v_2482(param1 as PlayerUseMotionNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_VIEW_REMOTE_ANSWER)
            {
               this.obf_0_1_u_503(param1 as PlayerViewRemoteAnswer);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_DO_CLIENT_MACRO_NOTIFY)
            {
               this.obf_q_q_2506(param1 as PlayerDoClientMacroNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_COUNTER_CHECK_NOTIFY)
            {
               this.obf_k_C_2828(param1 as PlayerCounterCheckNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_EXT_ATTR_INT_CHANGE_NOTIFY)
            {
               this.obf_T_f_3573(param1 as PlayerExtAttrIntChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_VIP_CHECK_NOTIFY)
            {
               this.obf_R_C_1485(param1 as PlayerVipCheckNotify);
            }
            else if(param1.code == CommandCodePlayerPet.PET_HP_CHANGE_NOTIFY)
            {
               this.obf_1_k_4149(param1 as PetHpChangeNotify);
            }
            else if(param1.code == CommandCodePlayerAnimal.ANIMAL_HP_CHANGE_NOTIFY)
            {
               this.obf_A_n_3641(param1 as AnimalHpChangeNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_TITLE_CHECK_NOTIFY)
            {
               this.obf_C_T_3158(param1 as PlayerTitleCheckNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_KIT_TITLE_CHECK_NOTIFY)
            {
               this.obf_s_U_4433(param1 as PlayerKitTitleCheckNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_TITLE_LIST_CHECK_NOTIFY)
            {
               this.obf_0_6_I_504(param1 as PlayerTitleListCheckNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_BELIEF_CHECK_NOTIFY)
            {
               this.obf_z_J_1950(param1 as PlayerBeliefCheckNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_CALL_TRAINER_NOTIFY)
            {
               this.obf_d_e_2670(param1 as PlayerCallTrainerNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_RIDE_FUSION_ANSWER)
            {
               obf_0___z_209.doCommand(param1);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_MAP_HONOR_CHECK_NOTIFY)
            {
               this.obf_A_r_2888(param1 as PlayerMapHonorCheckNotify);
            }
            else if(param1.code == CommandCodePlayer.PLAYER_CHANGE_MODEL_NOTIFY)
            {
               this.obf_Y_A_3009(param1 as PlayerChangeModelNotify);
            }
            else if(param1.code == CommandCodePlayer.obf_h_i_3566)
            {
               this.obf_U_I_3979(param1 as PlayerEquipSkillNotify);
            }
            else
            {
               trace("unhandled local player command: " + param1.code);
            }
         }
      }
      
      private function onEnterWorld(param1:PlayerEnterWorldAnswer) : void
      {
         var _loc2_:BuffInfo = null;
         var _loc4_:String = null;
         var _loc5_:Object = null;
         this.fullInfo = param1.role;
         this.id = param1.role.name;
         this.level = this.fullInfo.level;
         this.hpPercent = 100 * Number(this.fullInfo.attributes.hp / this.fullInfo.attributes.hpMax);
         this.mapId = this.fullInfo.mapId;
         this.walkSpeed = param1.role.attributes.walkSpeed;
         this.pkMode = param1.role.pkMode;
         this.playerTitleId = param1.role.titleIndex;
         this.side = param1.role.side;
         this.setStatusFlag(param1.role.statusFlags);
         if(!this.fullInfo.mateVars)
         {
            this.fullInfo.mateVars = new DynamicVars();
         }
         for each(_loc2_ in this.fullInfo.buffs)
         {
            _loc5_ = BuffManager.getBuffConfigById(_loc2_.buffId);
            if(_loc5_)
            {
               if(!_loc5_.isDebuff)
               {
                  this.obf_a_8_4261(_loc2_);
                  if(obf_K_e_3075.buffUI)
                  {
                     obf_K_e_3075.buffUI.addBuff(_loc2_);
                  }
               }
               else
               {
                  this.obf_a_8_4261(_loc2_);
                  if(obf_K_e_3075.debuffUI)
                  {
                     obf_K_e_3075.debuffUI.addBuff(_loc2_);
                  }
               }
            }
         }
         obf_K_e_3075.setPKMode(pkMode);
         this.pkValue = param1.role.pkValue;
         this.obf_G_p_757();
         this.obf_w_w_3550(this.fullInfo.position.x,this.fullInfo.position.y,this.fullInfo.pathArray);
         this.dynamicVars = param1.vars;
         if(!this.dynamicVars)
         {
            this.dynamicVars = new DynamicVars();
         }
         this.obf_i_S_846 = param1.killedMonsters;
         if(!this.obf_i_S_846)
         {
            this.obf_i_S_846 = new DynamicVars();
         }
         this.taskRecorder = param1.taskRecorder;
         if(!this.taskRecorder)
         {
            this.taskRecorder = new TaskRecorder();
         }
         if(obf_K_e_3075.obf_N_i_3901)
         {
            obf_K_e_3075.obf_N_i_3901.obf_8_4_3745();
         }
         if(obf_K_e_3075.newShopBoxUI)
         {
            obf_K_e_3075.newShopBoxUI.obf_8_4_3745();
         }
         obf_K_e_3075.setPlayerAttr(this.fullInfo);
         obf_K_e_3075.obf_a_E_3085(this.fullInfo.exp,NumberConfig.getPlayerLevelNumber(this.fullInfo.level));
         obf_K_e_3075.obf_Y_N_3077(obf_3_U_4495.obf_d_z_1837,this.fullInfo.getFarmSkillLevelByKind(obf_3_U_4495.obf_d_z_1837));
         obf_K_e_3075.obf_Y_N_3077(obf_3_U_4495.obf_0___D_549,this.fullInfo.getFarmSkillLevelByKind(obf_3_U_4495.obf_0___D_549));
         obf_K_e_3075.obf_Y_N_3077(obf_3_U_4495.obf_A_q_1072,this.fullInfo.getFarmSkillLevelByKind(obf_3_U_4495.obf_A_q_1072));
         obf_K_e_3075.obf_Y_N_3077(obf_3_U_4495.PLANT,this.fullInfo.getFarmSkillLevelByKind(obf_3_U_4495.PLANT));
         obf_K_e_3075.obf_P_r_4199(obf_3_U_4495.obf_d_z_1837,this.fullInfo.getFarmSkillExpByKind(obf_3_U_4495.obf_d_z_1837),NumberConfig.getSkillLevelNumber(this.fullInfo.getFarmSkillLevelByKind(obf_3_U_4495.obf_d_z_1837)));
         obf_K_e_3075.obf_P_r_4199(obf_3_U_4495.obf_0___D_549,this.fullInfo.getFarmSkillExpByKind(obf_3_U_4495.obf_0___D_549),NumberConfig.getSkillLevelNumber(this.fullInfo.getFarmSkillLevelByKind(obf_3_U_4495.obf_0___D_549)));
         obf_K_e_3075.obf_P_r_4199(obf_3_U_4495.obf_A_q_1072,this.fullInfo.getFarmSkillExpByKind(obf_3_U_4495.obf_A_q_1072),NumberConfig.getSkillLevelNumber(this.fullInfo.getFarmSkillLevelByKind(obf_3_U_4495.obf_A_q_1072)));
         obf_K_e_3075.obf_P_r_4199(obf_3_U_4495.PLANT,this.fullInfo.getFarmSkillExpByKind(obf_3_U_4495.PLANT),NumberConfig.getSkillLevelNumber(this.fullInfo.getFarmSkillLevelByKind(obf_3_U_4495.PLANT)));
         obf_K_e_3075.setFarmInfo([this.fullInfo.mainFarm].concat(this.fullInfo.extraFarmArray));
         PlayerSkillManager.obf_y_m_873();
         obf_K_e_3075.playerBlessUI.setGodType(Math.max(this.fullInfo.beliefGod,1));
         obf_K_e_3075.playerBlessUI.obf_0_6_e_338();
         obf_K_e_3075.playerBagUI.obf_S_L_1164();
         obf_K_e_3075.obf_N_i_3901.obf_8_4_3745();
         obf_K_e_3075.newShopBoxUI.obf_8_4_3745();
         obf_K_e_3075.fruitBoxUI.obf_S_L_1164();
         obf_K_e_3075.dayBonusUI.obf_e_9_2604();
         obf_K_e_3075.obf_S_w_2923.upData(this.fullInfo.consecutiveLoginDays,this.fullInfo.boonItemCode);
         obf_K_e_3075.stirpBoxUI.refurbishStirp();
         obf_K_e_3075.stirpBoxUI.getRoleAttributesInfo();
         obf_K_e_3075.armoryUpgradeUI.updateInfo();
         obf_K_e_3075.dragonBoxUI.updateInfo();
         obf_K_e_3075.towerBoxUI.showData(this.fullInfo.towerValue);
         obf_K_e_3075.obf_v_3_1831.setServerTime(param1.role.serverDateTime);
         obf_K_e_3075.playerTitleUI.obf_B_J_3258();
         obf_K_e_3075.singeSpUI.refresh();
         if(!obf_L_l_4100.isEmpty(this.fullInfo.modelCode))
         {
            GameContext.localPlayer.setMonsterModelCode(this.fullInfo.modelCode);
            obf_K_e_3075.druidBoxUI.showSkill(this.fullInfo.modelCode);
            obf_K_e_3075.showUI(obf_K_e_3075.druidBoxUI);
         }
         var _loc3_:Array = WorldConfig.getObjectSetting("mapHonorRankingList") as Array;
         for each(_loc4_ in _loc3_)
         {
            if(!this.fullInfo.mapHonorValues[_loc4_])
            {
               this.fullInfo.mapHonorValues[_loc4_] = 0;
            }
         }
      }
      
      private function onEnterMap(param1:PlayerEnterMapAnswer) : void
      {
         this.obf_3_v_4336();
         this.fullInfo.position = param1.toPosition;
         this.fullInfo.mapId = param1.toMapId;
         this.fullInfo.lineIndex = param1.lineIndex;
         this.mapId = param1.toMapId;
         this.obf_w_w_3550(param1.toPosition.x,param1.toPosition.y,null);
      }
      
      private function obf_P_Z_1242(param1:PlayerPositionCheckNotify) : void
      {
         trace("Position======");
         if(param1.mapId != this.mapId)
         {
            return;
         }
         this.walkSpeed = param1.walkSpeed;
         this.obf_w_w_3550(param1.position.x,param1.position.y,param1.pathArray,param1.reasonCode == obf_Z_Q_3056.obf_z_n_3070);
      }
      
      private function obf_G_9_857(param1:PlayerSitCheckNotify) : void
      {
         this.fullInfo.isSitting = param1.isSitting;
         if(param1.isSitting)
         {
            this.sit();
         }
         else
         {
            this.stand();
         }
      }
      
      private function obf_w_w_3550(param1:int, param2:int, param3:Array, param4:Boolean = false) : void
      {
         var _loc5_:int = 0;
         if(param4)
         {
            MapManager.instance.showMapFastMoveBlur(this,param1,param2);
         }
         if(Boolean(param3) && param3.length > 0)
         {
            this.skillDone(null,true);
            this.walkAlongPath(MapPoint.MapArrayToPoint(param3),false);
         }
         else
         {
            _loc5_ = Point.distance(new Point(this.rootPX,this.rootPY),new Point(param1,param2));
            this.resetPosition(param1,param2,_loc5_ >= 200);
         }
      }
      
      private function obf_0_3_i_640(param1:PlayerHpChangeNotify) : void
      {
         var _loc2_:int = 100 * Number(this.fullInfo.attributes.hp / this.fullInfo.attributes.hpMax);
         this.fullInfo.attributes.hp = param1.hpCurrent;
         this.hpPercent = 100 * Number(this.fullInfo.attributes.hp / this.fullInfo.attributes.hpMax);
         if(this.hpPercent < 25 && _loc2_ >= 25)
         {
            obf_0_9_V_473.showEffectOnObject(GameContext.currentMap,this,"C_LowHP");
         }
         obf_K_e_3075.obf_T_w_922(this.fullInfo.attributes.hp,this.fullInfo.attributes.hpMax);
         if(GameContext.localPlayer.obf_0_6_a_430 == this)
         {
            obf_K_e_3075.setTargetInfoHpPercent(this.hpPercent);
         }
         if(!param1.isHidden)
         {
            if(param1.hpChanged == 0)
            {
               obf_0_9_V_473.showEffectOnObject(GameContext.currentMap,this,"C_NumberDodge");
            }
            else if(param1.hpChanged < 0)
            {
               this.showNumberEffect(Math.abs(param1.hpChanged),param1.isCriticalStrike ? obf_0_0_8_669.obf_v_e_4597 : obf_0_0_8_669.obf_o_0_932);
            }
            else
            {
               this.showNumberEffect(param1.hpChanged,obf_0_0_8_669.obf_0___1_276);
            }
         }
         if(Boolean(param1.skillCode) && param1.skillCode != "")
         {
            this.showHitEffect(param1.skillCode,param1.isCriticalStrike);
         }
      }
      
      private function obf_j_4_2710(param1:PlayerHpMaxChangeNotify) : void
      {
         this.fullInfo.attributes.hpMax = param1.hpMax;
         this.fullInfo.attributes.hp = param1.hpCurrent;
         obf_K_e_3075.obf_T_w_922(this.fullInfo.attributes.hp,this.fullInfo.attributes.hpMax);
      }
      
      private function obf_e_T_3609(param1:PlayerMpChangeNotify) : void
      {
         this.fullInfo.attributes.mp = param1.mpCurrent;
         obf_K_e_3075.obf_V_z_3564(this.fullInfo.attributes.mp,this.fullInfo.attributes.mpMax);
      }
      
      private function obf_d_w_2752(param1:PlayerMpMaxChangeNotify) : void
      {
         this.fullInfo.attributes.mp = param1.mpCurrent;
         this.fullInfo.attributes.mpMax = param1.mpMax;
         obf_K_e_3075.obf_V_z_3564(this.fullInfo.attributes.mp,this.fullInfo.attributes.mpMax);
      }
      
      private function obf_h_t_3146(param1:PlayerSpChangeNotify) : void
      {
         this.fullInfo.attributes.sp = param1.spCurrent;
         obf_K_e_3075.obf_Q_Y_4182(this.fullInfo.attributes.sp,this.fullInfo.attributes.spMax);
         obf_K_e_3075.singeSpUI.refresh();
         obf_K_e_3075.singeSpUI.showAddSpEffect(param1.spChanged);
      }
      
      private function obf_5_w_4524(param1:PlayerSpMaxChangeNotify) : void
      {
         this.fullInfo.attributes.sp = param1.spCurrent;
         this.fullInfo.attributes.spMax = param1.spMax;
         obf_K_e_3075.obf_Q_Y_4182(this.fullInfo.attributes.sp,this.fullInfo.attributes.spMax);
         obf_K_e_3075.singeSpUI.refresh();
      }
      
      private function obf_d_U_2794(param1:PlayerXpChangeNotify) : void
      {
         this.fullInfo.attributes.xp = param1.xpCurrent;
         if(Boolean(obf_K_e_3075.playerBlessUI) && obf_K_e_3075.playerBlessUI.visible)
         {
            obf_K_e_3075.playerBlessUI.obf_0_6_e_338();
            obf_K_e_3075.playerBlessUI.obf_H_P_2879();
         }
      }
      
      private function obf_Q_f_4530(param1:PlayerXpMaxChangeNotify) : void
      {
         this.fullInfo.attributes.xp = param1.xpCurrent;
         this.fullInfo.attributes.xpMax = param1.xpMax;
         if(Boolean(obf_K_e_3075.playerBlessUI) && obf_K_e_3075.playerBlessUI.visible)
         {
            obf_K_e_3075.playerBlessUI.obf_0_6_e_338();
            obf_K_e_3075.playerBlessUI.obf_H_P_2879();
         }
      }
      
      private function obf_0___b_198(param1:PlayerStatusChangeNotify) : void
      {
         this.setStatusFlag(param1.statusFlags);
      }
      
      private function obf_u_t_1139(param1:PlayerHairStyleChangeNotify) : void
      {
         this.fullInfo.hairStyleIndex = param1.hairStyleIndex;
         setHatDefaultModel(this.fullInfo.jobCode,this.fullInfo.sex,this.fullInfo.hairStyleIndex);
      }
      
      private function obf_z_H_1991(param1:PlayerBuffChangeNotify) : void
      {
         var _loc2_:int = 0;
         var _loc3_:BuffInfo = null;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         for each(_loc2_ in param1.buffsRemoved)
         {
            _loc4_ = BuffManager.getBuffConfigById(_loc2_);
            if(_loc4_)
            {
               if(!_loc4_.isDebuff)
               {
                  obf_K_e_3075.buffUI.removeBuff(_loc2_);
                  this.removeBuffInfo(_loc2_);
               }
               else
               {
                  obf_K_e_3075.debuffUI.removeBuff(_loc2_);
                  this.removeDebuffInfo(_loc2_);
               }
            }
         }
         for each(_loc3_ in param1.buffsAdded)
         {
            _loc5_ = BuffManager.getBuffConfigById(_loc3_.buffId);
            if(_loc5_)
            {
               if(!_loc5_.isDebuff)
               {
                  obf_K_e_3075.buffUI.addBuff(_loc3_);
                  this.obf_a_8_4261(_loc3_);
               }
               else
               {
                  obf_K_e_3075.debuffUI.addBuff(_loc3_);
                  this.obf_i_b_872(_loc3_);
               }
            }
         }
      }
      
      private function obf_1_b_1526(param1:PlayerDiedNotify) : void
      {
         this.stopWalking();
         this.stopSkill();
         this.die(false,null,int.MAX_VALUE);
         if(!obf_L_l_4100.isEmpty(param1.byPlayerId))
         {
            obf_6_D_3816.print(DiversityManager.getString("CommonPrompt","diedByPlayer",[param1.byPlayerId]));
         }
         if(GameContext.localPlayer.pkValue > 0)
         {
            obf_6_D_3816.print(DiversityManager.getString("PKMode","prompt_SlayDead"));
         }
         obf_K_e_3075.showRebirth();
         this.obf_G_p_757();
         this.stopAutoAttack();
      }
      
      public function playerRebirthConfirm(param1:int = 0) : void
      {
         var _loc2_:PlayerRebirthRequest = new PlayerRebirthRequest();
         _loc2_.rebirthMode = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      private function obf_0_1_p_225(param1:PlayerRebirthNotify) : void
      {
         obf_K_e_3075.closeRebirth();
         this.stopSkill();
         this.stopWalking();
         this.rebirth();
         this.obf_G_p_757();
         if(param1.mapId == GameContext.currentMap.mapId)
         {
            this.moveToPixel(param1.x,param1.y);
         }
      }
      
      private function obf_V_w_1783(param1:PlayerReceiveRebirthSkillNotify) : void
      {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         var _loc2_:Object = obf_K_e_3075.obf_N_Y_1566;
         if(_loc2_)
         {
            _loc2_.cmdSkillRebirth.enabled = true;
            _loc3_ = param1.skillCasterName;
            _loc4_ = SkillConfig.getSkillConfig(param1.skillCode);
            if(_loc4_)
            {
               _loc3_ = DiversityManager.getString("CommonPrompt","rebirthBySkill",[param1.skillCasterName,_loc4_.name,param1.skillLevel]);
            }
            _loc2_.rebirthInfo.text = _loc3_;
         }
      }
      
      private function obf_p_7_3823(param1:PlayerSkillInterruptedNotify) : void
      {
         if(this.obf_w_e_2707 && this.obf_3_y_4486 == param1.skillSn)
         {
            this.stopSkill();
            if(param1.cancelCD)
            {
               SkillCDManager.cancleCDBySn(param1.skillSn);
            }
            trace("Skill Interrupted =====");
         }
         obf_R_6_1363.doCommand(param1);
      }
      
      private function obf_0_8_1_126(param1:PlayerCombatStatusCheckNotify) : void
      {
         this.isInCombat = param1.isInCombat;
         if(param1.isInCombat)
         {
            obf_0_9_V_473.showEffectOnObject(GameContext.currentMap,this,"C_JoinCombatStatus");
         }
         else
         {
            obf_0_9_V_473.showEffectOnObject(GameContext.currentMap,this,"C_LeaveCombatStatus");
            this.obf_5_N_2570();
         }
         obf_K_e_3075.playerInfoUI.setCombat(this.isInCombat);
      }
      
      private function obf_c_H_3189(param1:PlayerSkillCDCheckNotify) : void
      {
         var _loc2_:CDItemInfo = null;
         for each(_loc2_ in param1.cdItems)
         {
            SkillCDManager.setSkillCD(_loc2_.code,_loc2_.cdTimeLeftInMS,0);
            if(_loc2_.code == WorldConfig.getStringSetting("mapTeleportCDCode"))
            {
               obf_K_e_3075.setTeleportMapCD(_loc2_.cdTimeLeftInMS);
            }
         }
      }
      
      private function obf_M_X_4595(param1:PlayerLuckySkillNotify) : void
      {
         this.showLuckySkillEffect();
      }
      
      private function onPlayerLevelUp(param1:PlayerLevelUpNotify) : void
      {
         var cmd:PlayerLevelUpNotify = param1;
         this.level = cmd.newLevel;
         this.fullInfo.level = cmd.newLevel;
         obf_0_9_V_473.showEffectOnObject(GameContext.currentMap,this,"C_RoleLevelUp");
         try
         {
            obf_H_l_800.call("onPlayerLevelUp",cmd.newLevel);
         }
         catch(e:Error)
         {
         }
         obf_K_e_3075.skillBookUI.obf_0_5_m_711();
         obf_K_e_3075.obf_x_e_1087(this.level);
         obf_K_e_3075.obf_a_E_3085(this.fullInfo.exp,NumberConfig.getPlayerLevelNumber(this.fullInfo.level));
         PromptsManager.checkRoleLevelUp(this.fullInfo.level);
         AIMonsterManager.obf_4_M_4030();
         obf_X_t_4110.obf_G_J_1663();
         obf_X_t_4110.obf_j_6_2682();
      }
      
      private function obf_u_Q_2503(param1:PlayerExpChangeNotify) : void
      {
         this.fullInfo.exp = param1.expCurrent;
         if(param1.expChanged > 0)
         {
            this.obf_0_1_S_307(param1.expChanged,obf_0_0_8_669.obf_0_5_l_412,DiversityManager.getString("CommonPrompt","roleExp") + " +");
            obf_6_D_3816.print(DiversityManager.getString("CommonPrompt","havePlayerExp",[param1.expChanged]));
         }
         obf_K_e_3075.obf_a_E_3085(this.fullInfo.exp,NumberConfig.getPlayerLevelNumber(this.fullInfo.level));
      }
      
      private function obf_X_8_1196(param1:PlayerReceiveMsgNotify) : void
      {
         var _loc2_:RemotePlayer = null;
         if(param1.scope == MessageScope.CHANNEL_NEARBY)
         {
            _loc2_ = GameContext.currentMap.remotePlayerSet.getObject(param1.fromName) as RemotePlayer;
            if(_loc2_)
            {
               _loc2_.say(ChatDecoder.decode(obf_L_l_4100.obf_r_1236(param1.content),null,[ChatDecoder.obf_E_4_4245,ChatDecoder.obf_9_K_1802,ChatDecoder.obf_W_v_983]));
            }
         }
         if(param1.scope == MessageScope.LOTTERY_SYSTEM && Boolean(obf_K_e_3075.drgTreasureUI))
         {
            obf_K_e_3075.drgTreasureUI.obf_i_J_3003(param1.content);
         }
         obf_K_e_3075.receiveMsg(param1.content,param1.scope,param1.fromName);
      }
      
      private function obf_p_C_1227(param1:PlayerReceiveSysPromptNotify) : void
      {
         if(param1.promptIndex == SystemPrompt.obf_N_D_4579)
         {
            this.obf_3_w_1335(new Bitmap(new CollectFailed(1,1)),DiversityManager.getString("CommonPrompt","collectFail"));
            obf_6_D_3816.print(DiversityManager.getString("CommonPrompt","collectFail"));
         }
         else
         {
            SystemPrompt.showSystemPrompt(param1.promptIndex);
         }
      }
      
      private function obf_6_X_1376(param1:PlayerShowTalksNotify) : void
      {
         if(Boolean(param1.talkList) && param1.talkList.length > 0)
         {
            obf_K_e_3075.showUI(new TalkBoxUI(param1.talkList));
         }
      }
      
      private function obf_I_A_2945(param1:PlayerRideStateCheckNotify) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc6_:Boolean = false;
         var _loc7_:Array = null;
         var _loc8_:obf_0_M_3913 = null;
         var _loc9_:int = 0;
         var _loc10_:obf_0_M_3913 = null;
         var _loc11_:String = null;
         var _loc12_:obf_0_M_3913 = null;
         if(param1.rideGuestPlayerIds == null)
         {
            param1.rideGuestPlayerIds = new Array();
         }
         this.obf_X_A_1222 = param1.rideCode;
         if(param1.rideCode == "")
         {
            if(this.isPassiveRiding && this.obf_Z_T_3864 != null)
            {
               this.obf_X_x_4358(false,this.obf_Z_T_3864);
            }
            this.ride(false);
            obf_K_e_3075.closeUI(obf_K_e_3075.rideControlUI);
         }
         else
         {
            _loc5_ = GameItemManager.getItemConfig(param1.rideCode);
            if(!_loc5_)
            {
               obf_x_0_1295.obf_r_w_3556("obf________________7(" + param1.rideCode + ")obf___4949！");
               return;
            }
            _loc3_ = _loc5_.properties.modelCode || "";
            _loc4_ = int(int(_loc5_.properties.capacity) || 1);
            obf_K_e_3075.showUI(obf_K_e_3075.rideControlUI);
            if(param1.rideMasterPlayerId == "" || param1.rideMasterPlayerId == this.id)
            {
               this.setRideModel(_loc3_,_loc4_);
               this.ride(true);
               if(this.obf_N_u_1040.length - 1 != param1.rideGuestPlayerIds.length)
               {
                  _loc6_ = true;
               }
               else
               {
                  _loc9_ = 1;
                  while(_loc9_ < this.obf_N_u_1040.length)
                  {
                     _loc10_ = this.obf_N_u_1040[_loc9_];
                     if(_loc10_.id != param1.rideGuestPlayerIds[_loc9_])
                     {
                        _loc6_ = true;
                        break;
                     }
                     _loc9_++;
                  }
               }
               if(_loc6_)
               {
                  this.ride(false);
                  this.ride(true);
                  for each(_loc11_ in param1.rideGuestPlayerIds)
                  {
                     _loc12_ = GameContext.currentMap.getObjectById(_loc11_) as obf_0_M_3913;
                     if(_loc12_)
                     {
                        this.obf_4_Y_4598(_loc12_);
                     }
                  }
               }
               _loc7_ = new Array();
               for each(_loc8_ in this.obf_N_u_1040)
               {
                  if(_loc8_ != this)
                  {
                     _loc8_.obf_X_x_4358(true,this);
                     _loc7_.push(_loc8_.id);
                  }
               }
               obf_K_e_3075.setRideGuestIds(_loc7_);
            }
         }
         this.obf_G_p_757();
         for(_loc2_ in this.obf_M_n_3303)
         {
            this.showAlwaysEffect(_loc2_,this.obf_M_n_3303[_loc2_]);
         }
      }
      
      private function obf_k_9_1697(param1:PlayerUsingRideCheckNotify) : void
      {
         if(obf_K_e_3075.playerFullInfoUI)
         {
            obf_K_e_3075.playerFullInfoUI.setRideEquip(param1.usingRide);
         }
         PlayerSkillManager.obf_y_m_873();
      }
      
      private function obf_Z_r_3063(param1:PlayerReceivePassiveRideRequestNotify) : void
      {
         WindowManager.showConfirmBox(DiversityManager.getString("RidePrompt","confirmPassiveRide",[param1.guestPlayerId]),this.confirmPassiveRide,param1.guestPlayerId);
      }
      
      private function confirmPassiveRide(param1:Object) : void
      {
         var _loc2_:PlayerProcessPassiveRideRequestReply = new PlayerProcessPassiveRideRequestReply();
         _loc2_.isAgreed = param1.confirm;
         _loc2_.guestPlayerId = param1.par;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      private function obf_h_S_3553(param1:PlayerReceiveInviteRideRequestNotify) : void
      {
         if(JSONUtil.getBoolean(GameContext.userConfig,["sst","apr"]))
         {
            this.confirmInviteRide({
               "confirm":true,
               "par":param1.masterPlayerId
            });
         }
         else
         {
            WindowManager.showConfirmBox(DiversityManager.getString("RidePrompt","confirmInviteRide",[param1.masterPlayerId]),this.confirmInviteRide,param1.masterPlayerId);
         }
      }
      
      private function confirmInviteRide(param1:Object) : void
      {
         var _loc2_:PlayerProcessInviteRideRequestReply = new PlayerProcessInviteRideRequestReply();
         _loc2_.isAgreed = param1.confirm;
         _loc2_.masterPlayerId = param1.par;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      private function obf_U_0_2632(param1:PlayerRideItemCheckNotify) : void
      {
         if(obf_K_e_3075.rideBoxUI.selectedRideId == param1.ride.rideId)
         {
            obf_K_e_3075.rideBoxUI.obf_Y_a_3517();
         }
      }
      
      private function obf_2_4_3396(param1:PlayerGoldChangeNotify) : void
      {
         if(param1.goldChanged > 0)
         {
            obf_6_D_3816.print(DiversityManager.getString("CommonPrompt","haveGold",[obf_a_f_2935.getGoldString(param1.goldChanged,true)]));
         }
         else if(param1.goldChanged < 0)
         {
            obf_6_D_3816.print(DiversityManager.getString("CommonPrompt","lostGold",[obf_a_f_2935.getGoldString(Math.abs(param1.goldChanged),true)]));
         }
         this.fullInfo.gold = param1.goldCurrent;
         if(obf_K_e_3075.playerBagUI)
         {
            obf_K_e_3075.playerBagUI.obf_S_L_1164();
         }
         if(obf_K_e_3075.obf_N_i_3901)
         {
            obf_K_e_3075.obf_N_i_3901.obf_8_4_3745();
         }
         if(obf_K_e_3075.newShopBoxUI)
         {
            obf_K_e_3075.newShopBoxUI.obf_8_4_3745();
         }
         if(obf_K_e_3075.fruitBoxUI)
         {
            obf_K_e_3075.fruitBoxUI.obf_S_L_1164();
         }
      }
      
      private function obf_j_Z_1504(param1:PlayerMoneyChangeNotify) : void
      {
         if(param1.moneyChanged > 0)
         {
            obf_6_D_3816.print(DiversityManager.getString("CommonPrompt","haveMoney",[obf_a_f_2935.getMoneyString(param1.moneyChanged)]));
         }
         else if(param1.moneyChanged < 0)
         {
            obf_6_D_3816.print(DiversityManager.getString("CommonPrompt","lostMoney",[obf_a_f_2935.getMoneyString(Math.abs(param1.moneyChanged))]));
         }
         this.fullInfo.money = param1.moneyCurrent;
         if(obf_K_e_3075.playerBagUI)
         {
            obf_K_e_3075.playerBagUI.obf_S_L_1164();
         }
         if(obf_K_e_3075.obf_N_i_3901)
         {
            obf_K_e_3075.obf_N_i_3901.obf_8_4_3745();
         }
         if(obf_K_e_3075.newShopBoxUI)
         {
            obf_K_e_3075.newShopBoxUI.obf_8_4_3745();
         }
         if(obf_K_e_3075.drgTreasureUI)
         {
            obf_K_e_3075.drgTreasureUI.obf_R_s_4398();
         }
         if(obf_K_e_3075.fruitBoxUI)
         {
            obf_K_e_3075.fruitBoxUI.obf_S_L_1164();
         }
      }
      
      private function obf_0_k_4282(param1:PlayerCoinChangeNotify) : void
      {
         if(param1.coinChanged > 0)
         {
            obf_6_D_3816.print(DiversityManager.getString("CommonPrompt","haveCoin",[param1.coinChanged]));
         }
         else if(param1.coinChanged < 0)
         {
            obf_6_D_3816.print(DiversityManager.getString("CommonPrompt","lostCoin",[Math.abs(param1.coinChanged)]));
         }
         this.fullInfo.coin = param1.coinCurrent;
         if(obf_K_e_3075.playerBagUI)
         {
            obf_K_e_3075.playerBagUI.obf_S_L_1164();
         }
         if(obf_K_e_3075.obf_N_i_3901)
         {
            obf_K_e_3075.obf_N_i_3901.obf_8_4_3745();
         }
         if(obf_K_e_3075.newShopBoxUI)
         {
            obf_K_e_3075.newShopBoxUI.obf_8_4_3745();
         }
      }
      
      private function obf_X_1316(param1:PlayerFarmSkillExpChangeNotify) : void
      {
         var _loc2_:String = "";
         var _loc3_:String = "";
         if(param1.kind == obf_3_U_4495.PLANT)
         {
            this.fullInfo.farmSkillExpArray[0] = param1.expCurrent;
            _loc2_ = obf_0_0_8_669.obf_0_0_C_314;
            _loc3_ = DiversityManager.getString("FarmSkillKindName","plant") + " +";
         }
         else if(param1.kind == obf_3_U_4495.obf_0___D_549)
         {
            this.fullInfo.farmSkillExpArray[1] = param1.expCurrent;
            _loc2_ = obf_0_0_8_669.obf_D_F_4414;
            _loc3_ = DiversityManager.getString("FarmSkillKindName","crop") + " +";
         }
         else if(param1.kind == obf_3_U_4495.obf_d_z_1837)
         {
            this.fullInfo.farmSkillExpArray[2] = param1.expCurrent;
            _loc2_ = obf_0_0_8_669.obf_d_c_2580;
            _loc3_ = DiversityManager.getString("FarmSkillKindName","animal") + " +";
         }
         else if(param1.kind == obf_3_U_4495.obf_A_q_1072)
         {
            this.fullInfo.farmSkillExpArray[3] = param1.expCurrent;
            _loc2_ = obf_0_0_8_669.obf_q_4633;
            _loc3_ = DiversityManager.getString("FarmSkillKindName","mine") + " +";
         }
         if(param1.expChanged > 0)
         {
            this.obf_0_1_S_307(param1.expChanged,_loc2_,_loc3_);
            obf_6_D_3816.print(DiversityManager.getString("CommonPrompt","haveFarmSkillExp",[FarmManager.getKindName(param1.kind),param1.expChanged]));
         }
         obf_K_e_3075.obf_P_r_4199(param1.kind,param1.expCurrent,NumberConfig.getSkillLevelNumber(this.fullInfo.getFarmSkillLevelByKind(param1.kind)));
      }
      
      private function obf_m_f_1847(param1:PlayerFarmSkillLevelUpNotify) : void
      {
         if(param1.kind == obf_3_U_4495.PLANT)
         {
            this.fullInfo.farmSkillLevelArray[0] = param1.newLevel;
         }
         else if(param1.kind == obf_3_U_4495.obf_0___D_549)
         {
            this.fullInfo.farmSkillLevelArray[1] = param1.newLevel;
         }
         else if(param1.kind == obf_3_U_4495.obf_d_z_1837)
         {
            this.fullInfo.farmSkillLevelArray[2] = param1.newLevel;
         }
         else if(param1.kind == obf_3_U_4495.obf_A_q_1072)
         {
            this.fullInfo.farmSkillLevelArray[3] = param1.newLevel;
         }
         obf_0_9_V_473.showEffectOnObject(GameContext.currentMap,this,"C_SkillLevelUp");
         obf_K_e_3075.obf_Y_N_3077(param1.kind,param1.newLevel);
         obf_K_e_3075.obf_P_r_4199(param1.kind,this.fullInfo.getFarmSkillExpByKind(param1.kind),NumberConfig.getSkillLevelNumber(param1.newLevel));
         PromptsManager.checkSkillLevelUp(param1.kind,param1.newLevel);
      }
      
      private function obf_8_G_988(param1:PlayerAttributesChangeNotify) : void
      {
         this.obf_Z_S_1751(this.fullInfo.attributes,param1.attributes);
         param1.attributes.obf_0_5_A_522(this.fullInfo.attributes);
         this.walkSpeed = this.fullInfo.attributes.walkSpeed;
         if(Boolean(obf_F_o_1931) && Boolean(this.trainerFullInfo))
         {
            obf_F_o_1931.walkSpeed = this.walkSpeed;
         }
         obf_K_e_3075.obf_T_w_922(this.fullInfo.attributes.hp,this.fullInfo.attributes.hpMax);
         obf_K_e_3075.obf_V_z_3564(this.fullInfo.attributes.mp,this.fullInfo.attributes.mpMax);
         obf_K_e_3075.obf_Q_Y_4182(this.fullInfo.attributes.sp,this.fullInfo.attributes.spMax);
         obf_K_e_3075.setPlayerAttr(this.fullInfo);
      }
      
      public function obf_Z_S_1751(param1:RoleAttributesInfo, param2:RoleAttributesInfo) : void
      {
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc3_:Number = 0;
         for(_loc5_ in obf_X_L_985.playerAttrIsPercentage)
         {
            if(param1[_loc5_] != param2[_loc5_])
            {
               if(_loc5_ == "castTimeModifier")
               {
                  _loc3_ = 1 / param2[_loc5_] - 1 / param1[_loc5_];
               }
               else
               {
                  _loc3_ = param2[_loc5_] - param1[_loc5_];
               }
               if(obf_K_e_3075.refineBoxUI.visible == true && obf_K_e_3075.refineBoxUI.cmdRefine.enabled == false)
               {
                  this.tempAttributes[_loc5_] = _loc3_;
               }
               else
               {
                  if(Boolean(this.tempAttributes[_loc5_]) && this.tempAttributes[_loc5_] != 0)
                  {
                     _loc3_ = this.tempAttributes[_loc5_] + _loc3_;
                     this.tempAttributes[_loc5_] = 0;
                  }
                  if(!_loc4_)
                  {
                     _loc4_ = new Object();
                  }
                  _loc4_[_loc5_] = _loc3_;
               }
            }
         }
         if(_loc4_)
         {
            obf_K_e_3075.playerAttrChangeUI.showAttrText(_loc4_);
         }
      }
      
      private function obf_3_J_2974(param1:PlayerLifeExpChangeNotify) : void
      {
         this.fullInfo.lifeExp = param1.expCurrent;
         if(param1.expChanged > 0)
         {
            obf_6_D_3816.print(DiversityManager.getString("CommonPrompt","haveLifeJobExp",[param1.expChanged]));
         }
      }
      
      private function obf_A_K_3552(param1:PlayerLifeJobChangeNotify) : void
      {
         this.fullInfo.lifeJob = param1.lifeJob;
         this.fullInfo.lifeExp = param1.lifeExp;
         this.fullInfo.lifeLevel = param1.lifeLevel;
      }
      
      private function obf_J_v_1439(param1:PlayerLifeLevelUpNotify) : void
      {
         this.fullInfo.lifeLevel = param1.lifeLevel;
         this.fullInfo.lifeExp = param1.lifeExp;
         obf_6_D_3816.print(DiversityManager.getString("LifeJob","levelUp",[LifeJobCode.getLifeJobRankName(param1.lifeLevel)]));
         obf_0_9_V_473.showEffectOnObject(GameContext.currentMap,this,"C_SkillLevelUp");
      }
      
      private function obf_y_8_2836(param1:PlayerPKModeChangeNotify) : void
      {
         this.pkMode = param1.pkMode;
         this.obf_G_p_757();
         obf_K_e_3075.setPKMode(pkMode);
      }
      
      private function obf_q_0_4382(param1:PlayerPKValueChangeNotify) : void
      {
         this.pkValue = param1.pkValueCurrent;
         this.fullInfo.pkValue = param1.pkValueCurrent;
         this.obf_G_p_757();
         obf_K_e_3075.playerFullInfoUI.obf_l_t_2376();
      }
      
      private function obf_j_X_2478(param1:PlayerSideChangeNotify) : void
      {
         this.side = param1.side;
      }
      
      private function obf_7_v_2482(param1:PlayerUseMotionNotify) : void
      {
         if(!GameContext.currentMap)
         {
            return;
         }
         var _loc2_:MapInteractiveObject = GameContext.currentMap.getObjectById(param1.targetId);
         MagicMotionManager.showMagicMotion(this,_loc2_,param1.motionCode);
      }
      
      private function obf_0_1_u_503(param1:PlayerViewRemoteAnswer) : void
      {
         obf_K_e_3075.openRemoteView(param1.remotePlayerInfo);
      }
      
      private function obf_q_q_2506(param1:PlayerDoClientMacroNotify) : void
      {
         var _loc2_:String = null;
         for each(_loc2_ in param1.macroList)
         {
            obf_F_2_2975.obf_O_p_3236(_loc2_);
         }
      }
      
      private function obf_k_C_2828(param1:PlayerCounterCheckNotify) : void
      {
         var _loc2_:PeriodCounterItemInfo = null;
         if(param1.isCheckAll)
         {
            obf_Y_F_1424.setCounterMap(param1.counterItems);
         }
         else
         {
            for each(_loc2_ in param1.counterItems)
            {
               obf_Y_F_1424.setOneCounter(_loc2_);
            }
         }
         obf_K_e_3075.activityUI.refreshList();
      }
      
      private function obf_T_f_3573(param1:PlayerExtAttrIntChangeNotify) : void
      {
         if(param1.attr == obf_C_C_3211.obf_N_1_3754)
         {
            this.fullInfo.bkHp = param1.valueCurrent;
            obf_K_e_3075.playerInfoUI.obf_l_1_3544(this.fullInfo.bkHp,this.fullInfo.bkHpMax);
            if(param1.valueChanged < 0)
            {
               obf_K_e_3075.playerInfoUI.obf_f_k_1032 = new TimeLimiter(WorldConfig.getValue("bkHpMp","cdTimeInMS"));
            }
         }
         else if(param1.attr == obf_C_C_3211.obf_G_2199)
         {
            this.fullInfo.bkHpMax = param1.valueCurrent;
            obf_K_e_3075.playerInfoUI.obf_l_1_3544(this.fullInfo.bkHp,this.fullInfo.bkHpMax);
         }
         else if(param1.attr == obf_C_C_3211.obf_B_4_1548)
         {
            this.fullInfo.bkMp = param1.valueCurrent;
            obf_K_e_3075.playerInfoUI.obf_t_s_1612(this.fullInfo.bkMp,this.fullInfo.bkMpMax);
            if(param1.valueChanged < 0)
            {
               obf_K_e_3075.playerInfoUI.obf_x_q_3716 = new TimeLimiter(WorldConfig.getValue("bkHpMp","cdTimeInMS"));
            }
         }
         else if(param1.attr == obf_C_C_3211.obf_0_2_1_301)
         {
            this.fullInfo.bkMpMax = param1.valueCurrent;
            obf_K_e_3075.playerInfoUI.obf_t_s_1612(this.fullInfo.bkMp,this.fullInfo.bkMpMax);
         }
         else if(param1.attr == obf_C_C_3211.obf_U_b_2807)
         {
            this.fullInfo.petBkHp = param1.valueCurrent;
            obf_K_e_3075.playerInfoUI.obf_h_6_1233(this.fullInfo.petBkHp,this.fullInfo.petBkHpMax);
            if(param1.valueChanged < 0)
            {
               obf_K_e_3075.playerInfoUI.obf_0___C_332 = new TimeLimiter(WorldConfig.getValue("petBkHpMp","cdTimeInMS"));
            }
         }
         else if(param1.attr == obf_C_C_3211.obf_P_S_1514)
         {
            this.fullInfo.petBkHpMax = param1.valueCurrent;
            obf_K_e_3075.playerInfoUI.obf_h_6_1233(this.fullInfo.petBkHp,this.fullInfo.petBkHpMax);
         }
         else if(param1.attr == obf_C_C_3211.obf_f_e_3666)
         {
            this.fullInfo.petBkMp = param1.valueCurrent;
            obf_K_e_3075.playerInfoUI.obf_J_R_3179(this.fullInfo.petBkMp,this.fullInfo.petBkMpMax);
            if(param1.valueChanged < 0)
            {
               obf_K_e_3075.playerInfoUI.obf_G_g_1104 = new TimeLimiter(WorldConfig.getValue("petBkHpMp","cdTimeInMS"));
            }
         }
         else if(param1.attr == obf_C_C_3211.obf_v_4_1863)
         {
            this.fullInfo.petBkMpMax = param1.valueCurrent;
            obf_K_e_3075.playerInfoUI.obf_J_R_3179(this.fullInfo.petBkMp,this.fullInfo.petBkMpMax);
         }
         else if(param1.attr == obf_C_C_3211.obf_p_n_4458)
         {
            this.fullInfo.honorValue = param1.valueCurrent;
            obf_6_D_3816.print(DiversityManager.getString("CommonPrompt","haveHonor",[param1.valueChanged]));
            obf_K_e_3075.playerFullInfoUI.setRoleAttr(this.fullInfo);
         }
         else if(param1.attr == obf_C_C_3211.obf_0___X_500)
         {
            this.fullInfo.honorLevel = param1.valueCurrent;
            obf_K_e_3075.playerFullInfoUI.setRoleAttr(this.fullInfo);
         }
         else if(param1.attr == obf_C_C_3211.obf_R_r_4418)
         {
            this.fullInfo.freeAttrPt = param1.valueCurrent;
            obf_K_e_3075.playerFullInfoUI.setRoleAttr(this.fullInfo);
            obf_X_t_4110.showPlayerAttrUI();
         }
         else if(param1.attr == obf_C_C_3211.VIP_EXP)
         {
            this.fullInfo.vipExp = param1.valueCurrent;
            obf_K_e_3075.dayBonusUI.obf_e_9_2604();
            obf_K_e_3075.obf_1_p_1763.obf_e_9_2604();
         }
         else if(param1.attr == obf_C_C_3211.obf_p_M_4572)
         {
            this.fullInfo.rebornTimes = param1.valueCurrent;
            obf_K_e_3075.skillBookUI.obf_0_5_m_711();
         }
         else if(param1.attr == obf_C_C_3211.obf_Y_J_2124)
         {
            this.fullInfo.payMarks = param1.valueCurrent;
            obf_K_e_3075.obf_N_i_3901.obf_d_6_3571();
            obf_K_e_3075.newShopBoxUI.obf_d_6_3571();
         }
         else if(param1.attr == obf_C_C_3211.obf_d_o_3645)
         {
            this.fullInfo.charmValue = param1.valueCurrent;
            obf_6_D_3816.print(DiversityManager.getString("BlessUI","prompt_AddCharmValue",[param1.valueChanged]));
            obf_K_e_3075.playerFullInfoUI.setRoleAttr(this.fullInfo);
         }
         else if(param1.attr == obf_C_C_3211.obf_s_d_3496)
         {
            this.fullInfo.charmInt = param1.valueCurrent;
            obf_K_e_3075.playerFullInfoUI.setRoleAttr(this.fullInfo);
         }
         else if(param1.attr == obf_C_C_3211.obf_v_f_1150)
         {
            this.fullInfo.maxLevel = param1.valueCurrent;
            obf_K_e_3075.playerFullInfoUI.setRoleAttr(this.fullInfo);
         }
      }
      
      private function obf_R_C_1485(param1:PlayerVipCheckNotify) : void
      {
         this.fullInfo.vipLevel = param1.vipLevel;
         this.fullInfo.vipExp = param1.vipExp;
         this.obf_G_p_757();
         obf_K_e_3075.dayBonusUI.obf_e_9_2604(param1);
         obf_K_e_3075.obf_1_p_1763.obf_e_9_2604();
      }
      
      private function obf_1_k_4149(param1:PetHpChangeNotify) : void
      {
         if(!this.petFullInfo || !this.obf_r_h_2193)
         {
            return;
         }
         this.petFullInfo.hp = param1.hpCurrent;
      }
      
      private function obf_A_n_3641(param1:AnimalHpChangeNotify) : void
      {
         if(!this.trainerFullInfo || !this.obf_v_H_3187)
         {
            return;
         }
         this.trainerFullInfo.animalAtr.hp = param1.hpCurrent;
      }
      
      private function obf_C_T_3158(param1:PlayerTitleCheckNotify) : void
      {
         this.fullInfo.titleIndex = param1.titleIndex;
         playerTitleId = param1.titleIndex;
         this.obf_G_p_757();
         obf_K_e_3075.playerTitleUI.obf_B_J_3258();
      }
      
      private function obf_s_U_4433(param1:PlayerKitTitleCheckNotify) : void
      {
         this.fullInfo.kitTitleIndex = param1.titleIndex;
         obf_K_e_3075.playerTitleUI.obf_B_J_3258();
      }
      
      private function obf_0_6_I_504(param1:PlayerTitleListCheckNotify) : void
      {
         this.playerTitleList = param1.titleList;
         obf_K_e_3075.playerTitleUI.obf_s_w_i_t_c_h_41();
      }
      
      private function obf_z_J_1950(param1:PlayerBeliefCheckNotify) : void
      {
         this.fullInfo.beliefGod = param1.beliefGod;
         this.fullInfo.beliefLevel = param1.beliefLevel;
         if(obf_K_e_3075.playerBlessUI)
         {
            if(obf_K_e_3075.playerBlessUI.obf_g_C_2812 != param1.beliefGod)
            {
               obf_K_e_3075.playerBlessUI.setGodType(param1.beliefGod);
            }
            else
            {
               obf_K_e_3075.playerBlessUI.obf_H_P_2879();
            }
            obf_K_e_3075.playerBlessUI.obf_0_6_e_338();
         }
      }
      
      private function obf_A_r_2888(param1:PlayerMapHonorCheckNotify) : void
      {
         this.fullInfo.mapHonorValues[param1.mapid] = param1.mapHonorCurrent;
      }
      
      private function obf_d_e_2670(param1:PlayerCallTrainerNotify) : void
      {
         this.trainerFullInfo = param1.animal;
         if(!param1.animal)
         {
            this.obf_F_o_1931.die();
            if(obf_K_e_3075.obf_G_K_2049)
            {
               obf_K_e_3075.closeUI(obf_K_e_3075.obf_G_K_2049);
               obf_K_e_3075.obf_G_K_2049.setHp(0,0);
            }
         }
         else
         {
            this.obf_f_s_1651();
            if(obf_K_e_3075.obf_G_K_2049)
            {
               obf_K_e_3075.closeUI(obf_K_e_3075.obf_G_K_2049);
               obf_K_e_3075.showUI(obf_K_e_3075.obf_G_K_2049);
               obf_K_e_3075.obf_G_K_2049.setHp(param1.animal.animalAtr.hp,param1.animal.animalAtr.hpMax);
            }
         }
         if(obf_K_e_3075.animalBoxUI)
         {
            obf_K_e_3075.animalBoxUI.updataBaseAnimal(param1.animal);
         }
      }
      
      private function obf_Y_A_3009(param1:PlayerChangeModelNotify) : void
      {
         GameContext.localPlayer.fullInfo.modelCode = param1.modelCode;
         if(!obf_L_l_4100.isEmpty(param1.modelCode))
         {
            if(GameContext.localPlayer.isActiveOrPassiveRiding)
            {
               obf_K_e_3075.showTipInfo("obf__________33");
               return;
            }
            if(obf_K_e_3075.druidBoxUI)
            {
               obf_K_e_3075.closeUI(obf_K_e_3075.druidBoxUI);
            }
            obf_K_e_3075.showUI(obf_K_e_3075.druidBoxUI);
            GameContext.localPlayer.setMonsterModelCode(param1.modelCode);
            obf_K_e_3075.druidBoxUI.showSkill(param1.modelCode);
         }
         else
         {
            if(obf_K_e_3075.druidBoxUI)
            {
               obf_K_e_3075.closeUI(obf_K_e_3075.druidBoxUI);
            }
            GameContext.localPlayer.setPlayerModelCode(obf_I_5_1944.getJobName(GameContext.localPlayer.fullInfo.jobCode,GameContext.localPlayer.fullInfo.sex));
            obf_K_e_3075.playerFullInfoUI.obf_K_1_4353();
         }
         PlayerSkillManager.obf_y_m_873();
         PlayerSkillManager.obf_G_D_4059();
      }
      
      private function obf_U_I_3979(param1:PlayerEquipSkillNotify) : void
      {
         PlayerSkillManager.obf_y_V_1989 = param1.skillMap;
         PlayerSkillManager.obf_y_m_873();
      }
   }
}

