package com.sunweb.game.rpg.family
{
   import obf_d_v_1084.BossTypeList;
   import obf_g_A_3629.obf_r_Y_1874;
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.netRole.RemotePlayer;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.SkillConfig;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.script.DynamicVars;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.map.WorldMapManager;
   import com.sunweb.game.rpg.worldZone.command.family.*;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   
   public class obf_F_9_1495
   {
      
      private static var familyConfig:Object;
      
      private static var familySkills:Object;
      
      private static var $familyBoss:String = "$familyBoss";
      
      public function obf_F_9_1495()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         familyConfig = param1;
      }
      
      public static function get bossFeedConfig() : Array
      {
         return JSONUtil.getObject(familyConfig,["bossFeedInfo"]) as Array;
      }
      
      public static function getBossValue(param1:int) : int
      {
         var _loc3_:Object = null;
         if(param1 == 0)
         {
            return 0;
         }
         var _loc2_:int = 0;
         while(_loc2_ < bossFeedConfig.length)
         {
            _loc3_ = bossFeedConfig[_loc2_] as Object;
            if(JSONUtil.getInt(_loc3_,["bossGrow"]) > param1)
            {
               return _loc2_ - 1;
            }
            _loc2_++;
         }
         return bossFeedConfig.length - 1;
      }
      
      public static function get materialList() : Array
      {
         return JSONUtil.getObject(familyConfig,["materialList"]) as Array;
      }
      
      public static function get dayTimes() : int
      {
         return JSONUtil.getInt(familyConfig,["dayFeedTimes"]);
      }
      
      public static function get obf_n_R_3309() : int
      {
         var _loc1_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter($familyBoss);
         return dayTimes - JSONUtil.getInt(_loc1_,["numOfDay"]);
      }
      
      public static function obf_0___q_426(param1:Boolean = false) : Boolean
      {
         var _loc2_:Object = JSONUtil.getObject(familyConfig,["openBossCondition"]);
         if(!_loc2_)
         {
            return true;
         }
         if(!ConditionScript.checkCondition(_loc2_,null,param1))
         {
            return false;
         }
         return true;
      }
      
      public static function get callBossCondition() : Object
      {
         return JSONUtil.getObject(familyConfig,["callBossCondition"]);
      }
      
      public static function get allowCallInMapIDList() : Array
      {
         return JSONUtil.getObject(familyConfig,["allowCallInMapID"]) as Array;
      }
      
      public static function get maxFamilyLevel() : int
      {
         return JSONUtil.getInt(familyConfig,["maxFamilyLevel"]);
      }
      
      public static function get familyMaxLevel() : int
      {
         if(!familyConfig)
         {
            return 0;
         }
         return int(familyConfig["maxFamilyLevel"]) || 0;
      }
      
      public static function getFamilySkillLevel(param1:String) : int
      {
         if(!GameContext.localPlayer.hasFamily())
         {
            return 0;
         }
         return JSONUtil.getInt(familySkills,[param1]);
      }
      
      public static function getFamilySkillUpgradeCondition(param1:String, param2:int) : Object
      {
         return JSONUtil.getObject(SkillConfig.getSkillConfig(param1),["levelInfo",param2 - 1,"inventRule","condition"]);
      }
      
      public static function getLevelConfig(param1:int) : Object
      {
         if(!familyConfig)
         {
            return null;
         }
         param1--;
         param1 = int(Math.max(0,Math.min(param1,familyConfig.familyLevelInfo.length)));
         return familyConfig.familyLevelInfo[param1];
      }
      
      public static function getPostConfig(param1:int) : Object
      {
         if(!familyConfig || !familyConfig.postList)
         {
            return null;
         }
         param1 = Math.max(0,Math.min(param1,familyConfig.postList.length));
         return familyConfig.postList[param1];
      }
      
      public static function getDefaultPostName() : Array
      {
         var _loc2_:Object = null;
         if(!familyConfig || !familyConfig.postList)
         {
            return null;
         }
         var _loc1_:Array = new Array();
         for each(_loc2_ in familyConfig.postList)
         {
            _loc1_.push(_loc2_.postName);
         }
         return _loc1_;
      }
      
      public static function postLevelShow(param1:int) : Boolean
      {
         if(!familyConfig || !familyConfig.postList)
         {
            return false;
         }
         return param1 >= familyConfig.postList.length - 4;
      }
      
      public static function isLeaderPost(param1:int) : Boolean
      {
         if(!familyConfig || !familyConfig.postList)
         {
            return false;
         }
         return param1 >= familyConfig.postList.length - 1;
      }
      
      public static function obf_j_t_4601() : Boolean
      {
         if(!familyConfig)
         {
            return false;
         }
         return ConditionScript.checkCondition(familyConfig.createFamilyCondition,null,true);
      }
      
      public static function obf_P_B_1254(param1:String) : void
      {
         if(Boolean(param1) && param1.length > WorldConfig.obf_B_1_3500)
         {
            WindowManager.showMessageBox(DiversityManager.getString("CommonPrompt","nameTooLang",[WorldConfig.obf_B_1_3500]));
            return;
         }
         if(!obf_L_l_4100.checkNameString(param1))
         {
            WindowManager.showMessageBox(DiversityManager.getString("CommonPrompt","nameHaveSymbol"));
            return;
         }
         if(obf_r_Y_1874.isUnlawful(param1))
         {
            WindowManager.showMessageBox(DiversityManager.getString("CommonPrompt","invalidName"));
            return;
         }
         var _loc2_:PlayerCreateFamilyRequest = new PlayerCreateFamilyRequest();
         _loc2_.familyName = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function obf_0_8_x_487(param1:Object) : void
      {
         if(!obf_L_l_4100.isEmpty(param1.content))
         {
            obf_P_B_1254(param1.content);
            obf_K_e_3075.closeUI(obf_K_e_3075.familyListUI);
         }
      }
      
      public static function obf_f_4652() : void
      {
         var _loc1_:PlayerFamilyInfoCheckRequest = new PlayerFamilyInfoCheckRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function obf_Y_I_3589() : void
      {
         if(!GameContext.localPlayer.obf_O_l_2706(obf_Q_D_1342.obf_F_Z_2323))
         {
            return;
         }
         var _loc1_:PlayerUpgradeFamilyRequest = new PlayerUpgradeFamilyRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function confirmUpgradeFamily(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_Y_I_3589();
         }
      }
      
      public static function obf_T_Z_941() : void
      {
         if(!GameContext.localPlayer.obf_O_l_2706(obf_Q_D_1342.obf_u_1_2979))
         {
            return;
         }
         var _loc1_:PlayerDismissFamilyRequest = new PlayerDismissFamilyRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function confirmDismissFamily(param1:Object) : void
      {
         if(String(param1.content).toLowerCase() == "ok")
         {
            obf_T_Z_941();
         }
      }
      
      public static function obf_U_8_1446(param1:FamilyMemberInfo) : void
      {
         var _loc2_:PlayerSetFamilyMemberPostRequest = new PlayerSetFamilyMemberPostRequest();
         _loc2_.memberName = param1.name;
         _loc2_.postLevel = param1.postLevel + 1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function obf_m_M_3705(param1:FamilyMemberInfo) : void
      {
         var _loc2_:PlayerSetFamilyMemberPostRequest = new PlayerSetFamilyMemberPostRequest();
         _loc2_.memberName = param1.name;
         --param1.postLevel;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendMemberTitle(param1:String, param2:String) : void
      {
         var _loc3_:PlayerSetFamilyMemberTitleRequest = new PlayerSetFamilyMemberTitleRequest();
         _loc3_.memberName = param1;
         _loc3_.title = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function inputMemberTitle(param1:Object) : void
      {
         if(!obf_L_l_4100.isEmpty(param1.content))
         {
            sendMemberTitle(param1.par,param1.content);
         }
      }
      
      public static function obf_7_K_2984(param1:String) : void
      {
         if(!GameContext.localPlayer.obf_O_l_2706(obf_Q_D_1342.obf_j_d_1978))
         {
            return;
         }
         var _loc2_:PlayerKickFamilyMemberRequest = new PlayerKickFamilyMemberRequest();
         _loc2_.targetPlayerId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function confirmKickFamilyMember(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_7_K_2984(param1.par);
         }
      }
      
      public static function obf_y_N_742(param1:String) : void
      {
         var _loc2_:PlayerGiveFamilyLeaderRequest = new PlayerGiveFamilyLeaderRequest();
         _loc2_.targetPlayerId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function confirmGiveFamilyLeader(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_y_N_742(param1.par);
         }
      }
      
      public static function obf_0_8_z_87() : void
      {
         var _loc1_:PlayerQuitFamilyRequest = new PlayerQuitFamilyRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function confirmQuitFamily(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_0_8_z_87();
         }
      }
      
      public static function sendInviteFamily(param1:String) : void
      {
         var _loc2_:PlayerInviteFamilyRequest = new PlayerInviteFamilyRequest();
         _loc2_.targetPlayerId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function obf_1_c_1134(param1:String, param2:Boolean) : void
      {
         var _loc3_:PlayerProcessInviteFamilyRequestReply = new PlayerProcessInviteFamilyRequestReply();
         _loc3_.sourcePlayerId = param1;
         _loc3_.isAgreed = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function confirmProcessFamilyInvite(param1:Object) : void
      {
         obf_1_c_1134(param1.par,param1.confirm);
      }
      
      public static function sendFamilyList() : void
      {
         var _loc1_:PlayerListFamilyRequest = new PlayerListFamilyRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendViewFamily(param1:String) : void
      {
         var _loc2_:PlayerViewFamilyRequest = new PlayerViewFamilyRequest();
         _loc2_.familyName = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendEditNotice(param1:String) : void
      {
         var _loc2_:PlayerEditFamilyNoticeRequest = new PlayerEditFamilyNoticeRequest();
         _loc2_.notice = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendEditDeclaration(param1:String) : void
      {
         var _loc2_:PlayerEditFamilyDeclarationRequest = new PlayerEditFamilyDeclarationRequest();
         _loc2_.declaration = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendViewPost() : void
      {
         var _loc1_:PlayerViewFamilyPostRequest = new PlayerViewFamilyPostRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendEditPost(param1:Array) : void
      {
         var _loc2_:PlayerEditFamilyPostRequest = new PlayerEditFamilyPostRequest();
         _loc2_.postNameList = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendViewJoinList() : void
      {
         var _loc1_:PlayerViewJoinFamilyListRequest = new PlayerViewJoinFamilyListRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendProcessJoin(param1:String, param2:Boolean) : void
      {
         var _loc3_:PlayerProcessJoinFamilyRequestReply = new PlayerProcessJoinFamilyRequestReply();
         _loc3_.sourcePlayerId = param1;
         _loc3_.isAgreed = param2;
         GameContext.worldClient.sendCommand(_loc3_);
         sendViewJoinList();
      }
      
      public static function sendJoinRequest(param1:String, param2:String) : void
      {
         if(obf_r_Y_1874.isUnlawful(param2))
         {
            WindowManager.showMessageBox(DiversityManager.getString("CommonPrompt","invalidName"));
            return;
         }
         var _loc3_:PlayerJoinFamilyRequest = new PlayerJoinFamilyRequest();
         _loc3_.familyName = param1;
         _loc3_.msg = param2;
         GameContext.worldClient.sendCommand(_loc3_);
         WindowManager.showMessageBox(DiversityManager.getString("FamilyListUI","promptJoinRequestSended"));
      }
      
      public static function confirmJoinRequest(param1:Object) : void
      {
         if(!obf_L_l_4100.isEmpty(param1.content))
         {
            sendJoinRequest(param1.par,param1.content);
         }
      }
      
      public static function confirmJoinRequestFast(param1:Object) : void
      {
         if(param1.confirm)
         {
            sendJoinRequest(param1.par,"");
         }
      }
      
      public static function sendFamilyTaskList() : void
      {
         var _loc1_:PlayerListFamilyTaskRequest = new PlayerListFamilyTaskRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendGetFamilyTask(param1:int) : void
      {
         var _loc2_:PlayerGetFamilyTaskRequest = new PlayerGetFamilyTaskRequest();
         _loc2_.taskId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendFamilyVarList(param1:String, param2:String) : void
      {
         var _loc3_:ListFamilyIntVarRequest = new ListFamilyIntVarRequest();
         _loc3_.usage = param2;
         _loc3_.varName = param1;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendUpgradeFamilySkill(param1:String) : void
      {
         var _loc2_:PlayerFamilyInventSkillRequest = new PlayerFamilyInventSkillRequest();
         _loc2_.skillCode = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendBossFeed(param1:String) : void
      {
         var _loc2_:PlayerFamilyBossFeedRequest = new PlayerFamilyBossFeedRequest();
         _loc2_.itemCode = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendCallBoss() : void
      {
         var _loc1_:PlayerFamilyBossCallRequest = new PlayerFamilyBossCallRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerFamily.PLAYER_FAMILY_INFO_CHECK_NOTIFY)
         {
            obf_s_P_4547(param1 as PlayerFamilyInfoCheckNotify);
         }
         else if(param1.code == CommandCodePlayerFamily.PLAYER_FAMILY_MEMBER_LIST_CHECK_NOTIFY)
         {
            obf_0_9_Q_622(param1 as PlayerFamilyMemberListCheckNotify);
         }
         else if(param1.code == CommandCodePlayerFamily.PLAYER_FAMILY_MY_INFO_CHECK_NOTIFY)
         {
            obf_M_N_3101(param1 as PlayerFamilyMyInfoCheckNotify);
         }
         else if(param1.code == CommandCodePlayerFamily.PLAYER_FAMILY_MEMBER_ADDED_NOTIFY)
         {
            obf_3_q_1364(param1 as PlayerFamilyMemberAddedNotify);
         }
         else if(param1.code == CommandCodePlayerFamily.PLAYER_FAMILY_MEMBER_REMOVED_NOTIFY)
         {
            obf_0_1_k_598(param1 as PlayerFamilyMemberRemovedNotify);
         }
         else if(param1.code == CommandCodePlayerFamily.PLAYER_FAMILY_MEMBER_INFO_CHECK_NOTIFY)
         {
            obf_0_7_D_637(param1 as PlayerFamilyMemberInfoCheckNotify);
         }
         else if(param1.code == CommandCodePlayerFamily.PLAYER_INVITE_FAMILY_ANSWER)
         {
            obf_Q_9_827(param1 as PlayerInviteFamilyAnswer);
         }
         else if(param1.code == CommandCodePlayerFamily.PLAYER_RECEIVE_INVITE_FAMILY_REQUEST_NOTIFY)
         {
            obf_0_0_b_715(param1 as PlayerReceiveInviteFamilyRequestNotify);
         }
         else if(param1.code == CommandCodePlayerFamily.PLAYER_LIST_FAMILY_ANSWER)
         {
            obf_0_7_h_157(param1 as PlayerListFamilyAnswer);
         }
         else if(param1.code == CommandCodePlayerFamily.PLAYER_VIEW_FAMILY_ANSWER)
         {
            obf_V_I_2934(param1 as PlayerViewFamilyAnswer);
         }
         else if(param1.code == CommandCodePlayerFamily.PLAYER_FAMILY_NOTICE_CHECK_NOTIFY)
         {
            obf_1_E_951(param1 as PlayerFamilyNoticeCheckNotify);
         }
         else if(param1.code == CommandCodePlayerFamily.PLAYER_FAMILY_DECLARATION_CHECK_NOTIFY)
         {
            obf_P_x_4481(param1 as PlayerFamilyDeclarationCheckNotify);
         }
         else if(param1.code == CommandCodePlayerFamily.PLAYER_VIEW_FAMILY_POST_ANSWER)
         {
            onViewFamilyPost(param1 as PlayerViewFamilyPostAnswer);
         }
         else if(param1.code == CommandCodePlayerFamily.PLAYER_VIEW_JOIN_FAMILY_LIST_ANSWER)
         {
            obf_r_I_3237(param1 as PlayerViewJoinFamilyListAnswer);
         }
         else if(param1.code == CommandCodePlayerFamily.PLAYER_LIST_FAMILY_TASK_ANSWER)
         {
            onListFamilyTask(param1 as PlayerListFamilyTaskAnswer);
         }
         else if(param1.code == CommandCodePlayerFamily.PLAYER_FAMILY_VARS_CHECK_NOTIFY)
         {
            obf_L_k_791(param1 as PlayerFamilyVarsCheckNotify);
         }
         else if(param1.code == CommandCodePlayerFamily.PLAYER_FAMILY_VAR_CHANGE_NOTIFY)
         {
            obf_g_X_1841(param1 as PlayerFamilyVarChangeNotify);
         }
         else if(param1.code == CommandCodePlayerFamily.PLAYER_FAMILY_VAR_CLEAR_NOTIFY)
         {
            obf_i_8_2401(param1 as PlayerFamilyVarClearNotify);
         }
         else if(param1.code == CommandCodePlayerFamily.LIST_FAMILY_INT_VAR_ANSWER)
         {
            obf_j_9_3439(param1 as ListFamilyIntVarAnswer);
         }
         else if(param1.code == CommandCodePlayerFamily.PLAYER_FAMILY_INVENT_SKILL_NOTIFY)
         {
            obf_U_s_3714(param1 as PlayerFamilyInventSkillNotify);
         }
         else if(param1.code == CommandCodePlayerFamily.PLAYER_FAMILY_BOSS_CALL_NOTIFY)
         {
            onFamilyBossCall(param1 as PlayerFamilyBossCallNotify);
         }
      }
      
      private static function obf_s_P_4547(param1:PlayerFamilyInfoCheckNotify) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(Boolean(GameContext.localPlayer.familyInfo) && Boolean(param1.familyInfo) && GameContext.localPlayer.familyInfo.exp != param1.familyInfo.exp)
         {
            _loc2_ = param1.familyInfo.exp - GameContext.localPlayer.familyInfo.exp;
            obf_6_D_3816.print(DiversityManager.getString("FamilyBoxUI","prompt_familyExpChange",[_loc2_,param1.familyInfo.exp]));
         }
         if(Boolean(GameContext.localPlayer.familyInfo) && Boolean(param1.familyInfo) && param1.familyInfo.gold > GameContext.localPlayer.familyInfo.gold)
         {
            obf_6_D_3816.print(DiversityManager.getString("FamilyBoxUI","prompt_familyGoldChange",[obf_a_f_2935.getGoldString(param1.familyInfo.gold)]));
         }
         if(Boolean(GameContext.localPlayer.familyInfo) && Boolean(param1.familyInfo) && param1.familyInfo.bossGrow > GameContext.localPlayer.familyInfo.bossGrow)
         {
            _loc3_ = obf_F_9_1495.getBossValue(param1.familyInfo.bossGrow);
            if(_loc3_ < 0)
            {
               _loc3_ = 0;
            }
            _loc4_ = bossFeedConfig[bossFeedConfig.length - 1];
            _loc5_ = JSONUtil.getInt(_loc4_,["bossGrow"]);
            _loc6_ = param1.familyInfo.bossGrow;
            if(_loc6_ > _loc5_)
            {
               _loc6_ = _loc5_;
            }
            obf_6_D_3816.print(DiversityManager.getString("FamilyBoxUI","prompt_familyBossChange",[_loc6_,BossTypeList.getRankName(_loc3_)]));
         }
         GameContext.localPlayer.familyInfo = param1.familyInfo;
         if(obf_K_e_3075.familyBoxUI)
         {
            obf_K_e_3075.familyBoxUI.setFamilyInfo(param1.familyInfo);
         }
         if(Boolean(obf_K_e_3075.bossFeedUI) && Boolean(param1.familyInfo))
         {
            obf_K_e_3075.bossFeedUI.showBoss(param1.familyInfo.bossGrow);
         }
         familySkills = JSONUtil.getObject(param1.familyInfo,["skills"]);
         obf_K_e_3075.familyBoxUI.obf_u_H_2162();
      }
      
      private static function obf_0_9_Q_622(param1:PlayerFamilyMemberListCheckNotify) : void
      {
         var _loc2_:FamilyMemberInfo = null;
         var _loc3_:RemotePlayer = null;
         if(obf_K_e_3075.familyBoxUI)
         {
            obf_K_e_3075.familyBoxUI.setMemberList(param1.memberList);
         }
         if(!GameContext.currentMap)
         {
            return;
         }
         for each(_loc2_ in param1.memberList)
         {
            if(_loc2_.isOnline)
            {
               _loc3_ = GameContext.currentMap.remotePlayerSet.getObject(_loc2_.name) as RemotePlayer;
               if(_loc3_)
               {
                  _loc3_.obf_G_p_757();
               }
            }
         }
      }
      
      private static function obf_M_N_3101(param1:PlayerFamilyMyInfoCheckNotify) : void
      {
         var _loc2_:int = 0;
         if(Boolean(GameContext.localPlayer.familyMyInfo) && GameContext.localPlayer.familyMyInfo.thisFamilyGx != param1.myInfo.thisFamilyGx)
         {
            _loc2_ = param1.myInfo.thisFamilyGx - GameContext.localPlayer.familyMyInfo.thisFamilyGx;
            obf_6_D_3816.print(DiversityManager.getString("FamilyBoxUI","prompt_familyGxChange",[_loc2_,param1.myInfo.thisFamilyGx]));
         }
         GameContext.localPlayer.familyMyInfo = param1.myInfo;
         if(obf_K_e_3075.familyBoxUI)
         {
            if(isLeaderPost(param1.myInfo.postLevel))
            {
               obf_K_e_3075.familyBoxUI.familyLeader = GameContext.localPlayer.id;
            }
            obf_K_e_3075.familyBoxUI.obf_0_7_k_265();
            obf_K_e_3075.familyBoxUI.setFamilyMyInfo(param1.myInfo);
         }
         obf_K_e_3075.playerFullInfoUI.obf_f_p_3769();
      }
      
      private static function obf_3_q_1364(param1:PlayerFamilyMemberAddedNotify) : void
      {
         if(obf_K_e_3075.familyBoxUI)
         {
            obf_K_e_3075.familyBoxUI.obf_7_z_1853(param1.member);
         }
         obf_6_D_3816.print(DiversityManager.getString("FamilyBoxUI","prompt_MemberAdded",[param1.member.name]));
      }
      
      private static function obf_0_1_k_598(param1:PlayerFamilyMemberRemovedNotify) : void
      {
         if(obf_K_e_3075.familyBoxUI)
         {
            obf_K_e_3075.familyBoxUI.removeMember(param1.memberName);
         }
         obf_6_D_3816.print(DiversityManager.getString("FamilyBoxUI","prompt_MemberRemoved",[param1.memberName]));
      }
      
      private static function obf_0_7_D_637(param1:PlayerFamilyMemberInfoCheckNotify) : void
      {
         var _loc2_:FamilyMemberInfo = null;
         if(obf_K_e_3075.familyBoxUI)
         {
            _loc2_ = obf_K_e_3075.familyBoxUI.getMemberInfoByName(param1.member.name);
            if(Boolean(_loc2_) && _loc2_.postLevel != param1.member.postLevel)
            {
               obf_6_D_3816.print(DiversityManager.getString("FamilyBoxUI","prompt_MemberPostChange",[param1.member.name,param1.member.postName]));
            }
            obf_K_e_3075.familyBoxUI.setMemberInfo(param1.member);
         }
      }
      
      private static function obf_Q_9_827(param1:PlayerInviteFamilyAnswer) : void
      {
         if(!param1.isAgreed)
         {
            obf_6_D_3816.print(DiversityManager.getString("FamilyBoxUI","prompt_InviteNotAgreed",[param1.targetPlayerId]));
         }
      }
      
      private static function obf_0_0_b_715(param1:PlayerReceiveInviteFamilyRequestNotify) : void
      {
         WindowManager.showConfirmSmallBox(DiversityManager.getString("FamilyBoxUI","prompt_ConfirmFamilyInvite",[param1.sourcePlayerId,param1.familyName]),confirmProcessFamilyInvite,param1.sourcePlayerId);
      }
      
      private static function obf_0_7_h_157(param1:PlayerListFamilyAnswer) : void
      {
         if(obf_K_e_3075.familyListUI)
         {
            obf_K_e_3075.familyListUI.setFamilyList(param1.familyList);
         }
      }
      
      private static function obf_V_I_2934(param1:PlayerViewFamilyAnswer) : void
      {
         if(obf_K_e_3075.familyViewUI)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.familyViewUI);
            obf_K_e_3075.familyViewUI.setShowInfo(param1.familyInfo);
         }
      }
      
      private static function obf_1_E_951(param1:PlayerFamilyNoticeCheckNotify) : void
      {
         if(obf_K_e_3075.familyBoxUI)
         {
            obf_K_e_3075.familyBoxUI.familyNotice = param1.notice;
         }
      }
      
      private static function obf_P_x_4481(param1:PlayerFamilyDeclarationCheckNotify) : void
      {
         if(obf_K_e_3075.familyBoxUI)
         {
            obf_K_e_3075.familyBoxUI.familyDeclaration = param1.declaration;
         }
      }
      
      private static function onViewFamilyPost(param1:PlayerViewFamilyPostAnswer) : void
      {
         if(obf_K_e_3075.familyPostListUI)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.familyPostListUI);
            if(!param1.postNameList || param1.postNameList.length == 0)
            {
               obf_K_e_3075.familyPostListUI.setPostList(obf_F_9_1495.getDefaultPostName());
            }
            else
            {
               obf_K_e_3075.familyPostListUI.setPostList(param1.postNameList);
            }
         }
      }
      
      private static function obf_r_I_3237(param1:PlayerViewJoinFamilyListAnswer) : void
      {
         if(obf_K_e_3075.familyJoinListUI)
         {
            obf_K_e_3075.familyJoinListUI.setPlayerList(param1.joinRequestList);
            obf_K_e_3075.showUI(obf_K_e_3075.familyJoinListUI);
         }
      }
      
      private static function onListFamilyTask(param1:PlayerListFamilyTaskAnswer) : void
      {
         if(obf_K_e_3075.familyTaskListUI)
         {
            obf_K_e_3075.familyTaskListUI.setTaskList(param1.familyTaskList);
            obf_K_e_3075.showUI(obf_K_e_3075.familyTaskListUI);
         }
      }
      
      private static function obf_L_k_791(param1:PlayerFamilyVarsCheckNotify) : void
      {
         DynamicVars.familyVar = param1.familyVars;
         ConditionScript.updateDynamicVarsCondition();
      }
      
      private static function obf_g_X_1841(param1:PlayerFamilyVarChangeNotify) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(!DynamicVars.familyVar)
         {
            return;
         }
         for(_loc2_ in param1.boolVars)
         {
            DynamicVars.familyVar.addBoolVar(_loc2_,param1.boolVars[_loc2_]);
         }
         for(_loc3_ in param1.intVars)
         {
            DynamicVars.familyVar.addIntVar(_loc3_,param1.intVars[_loc3_]);
         }
      }
      
      private static function obf_i_8_2401(param1:PlayerFamilyVarClearNotify) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(!DynamicVars.familyVar)
         {
            return;
         }
         for each(_loc2_ in param1.boolVars)
         {
            DynamicVars.familyVar.delBoolVar(_loc2_);
         }
         for each(_loc3_ in param1.intVars)
         {
            DynamicVars.familyVar.delIntVar(_loc3_);
         }
      }
      
      private static function obf_j_9_3439(param1:ListFamilyIntVarAnswer) : void
      {
         if(obf_K_e_3075.familyVarListUI)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.familyVarListUI);
            obf_K_e_3075.familyVarListUI.setFamilyVarList(param1.familyList);
         }
      }
      
      private static function obf_U_s_3714(param1:PlayerFamilyInventSkillNotify) : void
      {
         familySkills = param1.familySkills;
         obf_K_e_3075.familyBoxUI.obf_u_H_2162();
      }
      
      private static function onFamilyBossCall(param1:PlayerFamilyBossCallNotify) : void
      {
         obf_6_D_3816.print(DiversityManager.getString("bossFeedUI","callBossMsg",[WorldMapManager.getMapName(param1.callMapID)]));
         obf_K_e_3075.showSystemInfo(DiversityManager.getString("bossFeedUI","callBossMsg",[WorldMapManager.getMapName(param1.callMapID)]));
      }
   }
}

