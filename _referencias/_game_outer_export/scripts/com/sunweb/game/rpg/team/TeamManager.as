package com.sunweb.game.rpg.team
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.social.FriendManager;
   import com.sunweb.game.rpg.worldZone.command.team.*;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.obf_L_l_4100;
   
   public class TeamManager
   {
      
      public static var obf_r_f_4011:String;
      
      public static var teamName:String;
      
      private static var teamPlayers:Array;
      
      private static var obf_0_2_Y_184:Boolean;
      
      public static var teamItemMode:int;
      
      public static var teamItemRank:int;
      
      public function TeamManager()
      {
         super();
      }
      
      public static function get isLeader() : Boolean
      {
         return obf_0_2_Y_184;
      }
      
      public static function get teamMembers() : Array
      {
         return teamPlayers;
      }
      
      public static function sendCreateTeam(param1:String) : void
      {
         var _loc2_:PlayerCreateTeamRequest = new PlayerCreateTeamRequest();
         _loc2_.teamName = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendQuitTeam() : void
      {
         var _loc1_:PlayerQuitTeamRequest = new PlayerQuitTeamRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendInvite(param1:String) : void
      {
         var _loc2_:PlayerInviteTeamRequest = new PlayerInviteTeamRequest();
         _loc2_.targetPlayerId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendJoin(param1:String) : void
      {
         var _loc2_:PlayerJoinTeamRequest = new PlayerJoinTeamRequest();
         _loc2_.teamName = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendAutoInvite(param1:String) : void
      {
         var _loc2_:PlayerAutoTeamRequest = new PlayerAutoTeamRequest();
         _loc2_.targetPlayerId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendDismissTeam() : void
      {
         var _loc1_:PlayerDismissTeamRequest = new PlayerDismissTeamRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function confirmDismissTeam(param1:Object) : void
      {
         if(param1.confirm)
         {
            sendDismissTeam();
         }
      }
      
      public static function sendGiveTeamLeader(param1:String) : void
      {
         var _loc2_:PlayerGiveTeamLeaderRequest = new PlayerGiveTeamLeaderRequest();
         _loc2_.targetPlayerId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendKickTeamMember(param1:String) : void
      {
         var _loc2_:PlayerKickTeamMemberRequest = new PlayerKickTeamMemberRequest();
         _loc2_.targetPlayerId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendProcessInviteReply(param1:Boolean, param2:String) : void
      {
         var _loc3_:PlayerProcessInviteTeamRequestReply = new PlayerProcessInviteTeamRequestReply();
         _loc3_.isAgreed = param1;
         _loc3_.teamName = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendProcessJoinReply(param1:Boolean, param2:String) : void
      {
         var _loc3_:PlayerProcessJoinTeamRequestReply = new PlayerProcessJoinTeamRequestReply();
         _loc3_.isAgreed = param1;
         _loc3_.sourcePlayerId = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendTeamItemMode(param1:int, param2:int) : void
      {
         var _loc3_:PlayerSetTeamItemModeRequest = new PlayerSetTeamItemModeRequest();
         _loc3_.teamItemMode = param1;
         _loc3_.teamItemRollingRank = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendRollItem(param1:String, param2:Boolean) : void
      {
         var _loc3_:PlayerRollItemRequest = new PlayerRollItemRequest();
         _loc3_.itemId = param1;
         _loc3_.isGiveUp = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeTeam.PLAYER_TEAM_CHECK_NOTIFY)
         {
            obf_0_0_G_497(param1 as PlayerTeamCheckNotify);
         }
         else if(param1.code == CommandCodeTeam.PLAYER_INVITE_TEAM_ANSWER)
         {
            obf_0_1_X_402(param1 as PlayerInviteTeamAnswer);
         }
         else if(param1.code == CommandCodeTeam.PLAYER_JOIN_TEAM_ANSWER)
         {
            obf_K_d_3545(param1 as PlayerJoinTeamAnswer);
         }
         else if(param1.code == CommandCodeTeam.PLAYER_RECEIVE_INVITE_TEAM_REQUEST_NOTIFY)
         {
            onReceiveInvite(param1 as PlayerReceiveInviteTeamRequestNotify);
         }
         else if(param1.code == CommandCodeTeam.PLAYER_RECEIVE_JOIN_TEAM_REQUEST_NOTIFY)
         {
            obf_0_5_3_565(param1 as PlayerReceiveJoinTeamRequestNotify);
         }
         else if(param1.code == CommandCodeTeam.PLAYER_TEAM_LEADER_CHANGE_NOTIFY)
         {
            obf_0_7_b_488(param1 as PlayerTeamLeaderChangeNotify);
         }
         else if(param1.code == CommandCodeTeam.PLAYER_TEAM_MEMBER_CHECK_NOTIFY)
         {
            obf_0_8_W_617(param1 as PlayerTeamMemberCheckNotify);
         }
         else if(param1.code == CommandCodeTeam.PLAYER_TEAM_MEMBER_HP_CHANGE_NOTIFY)
         {
            obf_H_o_1686(param1 as PlayerTeamMemberHpChangeNotify);
         }
         else if(param1.code == CommandCodeTeam.PLAYER_TEAM_MEMBER_MP_CHANGE_NOTIFY)
         {
            obf_L_3_2447(param1 as PlayerTeamMemberMpChangeNotify);
         }
         else if(param1.code == CommandCodeTeam.PLAYER_TEAM_ITEM_MODE_CHECK_NOTIFY)
         {
            obf_c_T_1078(param1 as PlayerTeamItemModeCheckNotify);
         }
         else if(param1.code == CommandCodeTeam.PLAYER_TEAM_ROLL_ITEMS_CHECK_NOTIFY)
         {
            obf_M_b_771(param1 as PlayerTeamRollItemsCheckNotify);
         }
         else if(param1.code == CommandCodeTeam.PLAYER_TEAM_ROLL_ITEM_ADDED_NOTIFY)
         {
            obf_n_r_2853(param1 as PlayerTeamRollItemAddedNotify);
         }
         else if(param1.code == CommandCodeTeam.PLAYER_TEAM_ROLL_RESULT_NOTIFY)
         {
            onTeamRollResult(param1 as PlayerTeamRollResultNotify);
         }
         else if(param1.code == CommandCodeTeam.PLAYER_ROLL_ITEM_ANSWER)
         {
            obf_9_6_967(param1 as PlayerRollItemAnswer);
         }
      }
      
      private static function obf_0_0_G_497(param1:PlayerTeamCheckNotify) : void
      {
         var _loc2_:TeamMemberInfo = null;
         if(obf_L_l_4100.isEmpty(obf_r_f_4011) && param1.leader != "")
         {
            obf_6_D_3816.print(DiversityManager.getString("TeamManagerUI","joinTeam"));
         }
         else if(!obf_L_l_4100.isEmpty(obf_r_f_4011) && param1.leader == "")
         {
            obf_6_D_3816.print(DiversityManager.getString("TeamManagerUI","leaveTeam"));
         }
         obf_r_f_4011 = param1.leader;
         teamName = param1.teamName;
         teamPlayers = param1.members;
         obf_0_2_Y_184 = obf_r_f_4011 == GameContext.localPlayer.id;
         GameContext.localPlayer.teamName = param1.teamName;
         GameContext.localPlayer.teamMemberList = new Array();
         for each(_loc2_ in param1.members)
         {
            GameContext.localPlayer.teamMemberList.push(_loc2_.name);
         }
         GameContext.localPlayer.obf_G_p_757();
         if(obf_K_e_3075.teamUI)
         {
            obf_K_e_3075.teamUI.showTeamBox(param1.members,param1.leader);
         }
         if(obf_K_e_3075.teamManagerUI)
         {
            if(obf_r_f_4011 != "")
            {
               obf_K_e_3075.teamManagerUI.inputTeamName.text = teamName;
            }
            else
            {
               obf_K_e_3075.teamManagerUI.inputTeamName.text = "";
            }
            obf_K_e_3075.teamManagerUI.obf_f_r_2576();
         }
      }
      
      private static function obf_0_1_X_402(param1:PlayerInviteTeamAnswer) : void
      {
         if(param1.isAgreed)
         {
            obf_6_D_3816.print(DiversityManager.getString("TeamManagerUI","agreeYourInvite",[param1.targetPlayerId]));
         }
         else
         {
            obf_6_D_3816.print(DiversityManager.getString("TeamManagerUI","denyYourInvite",[param1.targetPlayerId]));
         }
      }
      
      private static function obf_K_d_3545(param1:PlayerJoinTeamAnswer) : void
      {
         if(param1.isAgreed)
         {
            obf_6_D_3816.print(DiversityManager.getString("TeamManagerUI","agreeJoin",[param1.targetPlayerId]));
         }
         else
         {
            obf_6_D_3816.print(DiversityManager.getString("TeamManagerUI","denyJoin",[param1.targetPlayerId]));
         }
      }
      
      private static function onReceiveInvite(param1:PlayerReceiveInviteTeamRequestNotify) : void
      {
         if(FriendManager.obf_0_2_R_182(param1.sourcePlayerId))
         {
            return;
         }
         WindowManager.showConfirmSmallBox(DiversityManager.getString("TeamManagerUI","inviteConfirm",[param1.sourcePlayerId]),confirmInvite,param1.teamName);
      }
      
      private static function confirmInvite(param1:Object) : void
      {
         sendProcessInviteReply(param1.confirm,param1.par);
      }
      
      private static function obf_0_5_3_565(param1:PlayerReceiveJoinTeamRequestNotify) : void
      {
         WindowManager.showConfirmSmallBox(DiversityManager.getString("TeamManagerUI","joinConfirm",[param1.sourcePlayerId]),confirmJoin,param1.sourcePlayerId);
      }
      
      private static function confirmJoin(param1:Object) : void
      {
         sendProcessJoinReply(param1.confirm,param1.par);
      }
      
      private static function obf_0_7_b_488(param1:PlayerTeamLeaderChangeNotify) : void
      {
         obf_6_D_3816.print(DiversityManager.getString("TeamManagerUI","nowIsTeamLeader",[param1.leaderName]));
         if(obf_K_e_3075.teamUI)
         {
            obf_K_e_3075.teamUI.obf_9_3_4210(obf_r_f_4011,param1.leaderName);
         }
         obf_r_f_4011 = param1.leaderName;
         obf_0_2_Y_184 = obf_r_f_4011 == GameContext.localPlayer.id;
         GameContext.localPlayer.obf_G_p_757();
         obf_K_e_3075.teamManagerUI.obf_f_r_2576();
      }
      
      private static function obf_0_8_W_617(param1:PlayerTeamMemberCheckNotify) : void
      {
         var _loc3_:TeamMemberInfo = null;
         var _loc2_:int = 0;
         while(_loc2_ < teamPlayers.length)
         {
            _loc3_ = teamPlayers[_loc2_];
            if(_loc3_.name == param1.member.name)
            {
               teamPlayers[_loc2_] = param1.member;
            }
            _loc2_++;
         }
         if(obf_K_e_3075.teamUI)
         {
            obf_K_e_3075.teamUI.obf_0_2_M_210(param1.member);
         }
      }
      
      private static function obf_H_o_1686(param1:PlayerTeamMemberHpChangeNotify) : void
      {
         var _loc2_:TeamMemberInfo = null;
         for each(_loc2_ in teamPlayers)
         {
            if(_loc2_.name == param1.memberName)
            {
               _loc2_.hp = param1.hp;
               _loc2_.hpMax = param1.hpMax;
            }
         }
         if(obf_K_e_3075.teamUI)
         {
            obf_K_e_3075.teamUI.obf_6_E_2559(param1.memberName,param1.hp,param1.hpMax);
         }
      }
      
      private static function obf_L_3_2447(param1:PlayerTeamMemberMpChangeNotify) : void
      {
         var _loc2_:TeamMemberInfo = null;
         for each(_loc2_ in teamPlayers)
         {
            if(_loc2_.name == param1.memberName)
            {
               _loc2_.mp = param1.mp;
               _loc2_.mpMax = param1.mpMax;
            }
         }
         if(obf_K_e_3075.teamUI)
         {
            obf_K_e_3075.teamUI.obf_G_w_2136(param1.memberName,param1.mp,param1.mpMax);
         }
      }
      
      private static function obf_c_T_1078(param1:PlayerTeamItemModeCheckNotify) : void
      {
         teamItemMode = param1.teamItemMode;
         teamItemRank = param1.teamItemRollingRank;
         var _loc2_:String = "";
         var _loc3_:String = "";
         if(param1.teamItemMode == obf_4_e_1169.obf_0_0_5_249)
         {
            _loc2_ = DiversityManager.getString("TeamItemRollUI","itemModeFree");
         }
         else if(param1.teamItemMode == obf_4_e_1169.obf_R_x_1589)
         {
            _loc2_ = DiversityManager.getString("TeamItemRollUI","itemModeTeam");
            _loc3_ = "<font color=\'#" + GameItemRank.getRankColor(param1.teamItemRollingRank).toString(16) + "\'>[" + GameItemRank.getRankName(param1.teamItemRollingRank) + "]</font>";
         }
         obf_6_D_3816.print(DiversityManager.getString("TeamItemRollUI","itemModeChange",[_loc2_,_loc3_]));
         obf_K_e_3075.teamManagerUI.obf_9_b_2537();
      }
      
      private static function obf_M_b_771(param1:PlayerTeamRollItemsCheckNotify) : void
      {
         var _loc2_:TeamRollItemInfo = null;
         if(!obf_K_e_3075.itemRollUI)
         {
            return;
         }
         obf_K_e_3075.itemRollUI.obf_M_9_3076();
         for each(_loc2_ in param1.rollItems)
         {
            obf_K_e_3075.itemRollUI.obf_v_L_4021(_loc2_);
         }
         if(Boolean(param1.rollItems) && param1.rollItems.length > 0)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.itemRollUI);
         }
         else
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.itemRollUI);
         }
      }
      
      private static function obf_n_r_2853(param1:PlayerTeamRollItemAddedNotify) : void
      {
         obf_K_e_3075.itemRollUI.obf_v_L_4021(param1.rollItemAdded);
         obf_K_e_3075.showUI(obf_K_e_3075.itemRollUI);
      }
      
      private static function onTeamRollResult(param1:PlayerTeamRollResultNotify) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = DiversityManager.getString("TeamItemRollUI","teamRollItem_Title",[obf_7_6_4416.getItemLinkA(param1.itemCode,param1.itemId) + " x" + param1.itemCount]);
         for(_loc3_ in param1.rollPlayers)
         {
            if(param1.rollPlayers[_loc3_] > 0)
            {
               _loc2_ += "\n     " + DiversityManager.getString("TeamItemRollUI","teamRollItem_Need",[_loc3_,param1.rollPlayers[_loc3_]]);
            }
            else
            {
               _loc2_ += "\n     " + DiversityManager.getString("TeamItemRollUI","teamRollItem_Quit",[_loc3_]);
            }
         }
         _loc2_ += "\n     " + DiversityManager.getString("TeamItemRollUI","teamRollItem_GiveUp",[param1.ownerPlayerId,obf_7_6_4416.getItemLinkA(param1.itemCode,param1.itemId) + " x" + param1.itemCount]);
         obf_6_D_3816.print(_loc2_);
      }
      
      private static function obf_9_6_967(param1:PlayerRollItemAnswer) : void
      {
         if(param1.rollResult > 0)
         {
            obf_K_e_3075.itemRollUI.showRollPoint(param1.itemId,param1.rollResult);
         }
         obf_K_e_3075.itemRollUI.removeRollBoxByTween(param1.itemId);
      }
   }
}

