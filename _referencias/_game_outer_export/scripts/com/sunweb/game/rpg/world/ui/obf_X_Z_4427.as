package com.sunweb.game.rpg.world.ui
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.family.FamilyMemberInfo;
   import com.sunweb.game.rpg.family.obf_F_9_1495;
   import com.sunweb.game.rpg.family.obf_Q_D_1342;
   import com.sunweb.game.rpg.farm.FarmManager;
   import com.sunweb.game.rpg.module.InputBoxModule;
   import com.sunweb.game.rpg.netRole.obf_U_6_3454;
   import com.sunweb.game.rpg.playerUI.PlayerMenuItem;
   import com.sunweb.game.rpg.playerUI.PlayerMenuUI;
   import com.sunweb.game.rpg.playerUI.managers.VersionConfig;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.social.FriendInfo;
   import com.sunweb.game.rpg.social.FriendManager;
   import com.sunweb.game.rpg.team.TeamManager;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.geom.Point;
   
   public class obf_X_Z_4427
   {
      
      public function obf_X_Z_4427()
      {
         super();
      }
      
      public static function showRoleMenu(param1:String, param2:Point) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc3_:PlayerMenuUI = new PlayerMenuUI("roleMenu",160);
         _loc3_.addMenuItemByObject([{
            "id":"whisper",
            "value":{
               "label":DiversityManager.getString("MenuUI","whisper"),
               "fun":obf_K_e_3075.obf_e_q_2572.whisper,
               "par":[param1]
            }
         },{
            "id":"addFriend",
            "value":{
               "label":DiversityManager.getString("MenuUI","addFriend"),
               "fun":FriendManager.sendAddFriend,
               "par":[param1]
            }
         },{
            "id":"inviteFamily",
            "value":{
               "label":DiversityManager.getString("MenuUI","familyInvite"),
               "fun":obf_F_9_1495.sendInviteFamily,
               "par":[param1]
            }
         },{
            "id":"team",
            "value":{
               "label":DiversityManager.getString("MenuUI","inviteTeam"),
               "fun":TeamManager.sendAutoInvite,
               "par":[param1]
            }
         },{
            "id":"viewPlayer",
            "value":{
               "label":DiversityManager.getString("MenuUI","viewPlayer"),
               "fun":GameContext.localPlayer.sendViewRemote,
               "par":[param1]
            }
         },{
            "id":"badPlayer",
            "value":{
               "label":DiversityManager.getString("MenuUI","addBadPlayer"),
               "fun":FriendManager.addBadPlayer,
               "par":[param1]
            }
         },{
            "id":"cancelMenu",
            "value":{
               "label":DiversityManager.getString("MenuUI","cancelMenu"),
               "fun":PlayerMenuUI.closeMenuById,
               "par":["roleMenu"]
            }
         }]);
         if(!GameContext.localPlayer.obf_O_l_2706(obf_Q_D_1342.obf_P_3_810))
         {
            _loc3_.getMenuItem("inviteFamily").itemEnabled = false;
         }
         if(GameContext.localPlayer.fullInfo.isGM)
         {
            _loc3_.addMenuItemByObject([{
               "id":"GM_Gag",
               "value":{
                  "label":DiversityManager.getString("MenuUI","GM_Gag"),
                  "fun":obf_K_e_3075.gmControlBox.sendGMCommand,
                  "par":["dsp " + param1 + " 30"]
               }
            },{
               "id":"GM_CancelGag",
               "value":{
                  "label":DiversityManager.getString("MenuUI","GM_CancelGag"),
                  "fun":obf_K_e_3075.gmControlBox.sendGMCommand,
                  "par":["dsp " + param1 + " 0"]
               }
            },{
               "id":"GM_TeleportToPlayer",
               "value":{
                  "label":DiversityManager.getString("MenuUI","teleportTo"),
                  "fun":obf_K_e_3075.gmControlBox.sendGMCommand,
                  "par":["gp " + param1]
               }
            }]);
         }
         if(WorldConfig.getValue("reportSetting","canReport"))
         {
            _loc3_.addMenuItemByObject([{
               "id":"report",
               "value":{
                  "label":DiversityManager.getString("MenuUI","report"),
                  "fun":GameContext.localPlayer.sendReport,
                  "par":[param1,1]
               }
            }]);
            _loc4_ = false;
            _loc5_ = 0;
            while(_loc5_ < GameContext.localPlayer.reportTimeArr.length)
            {
               if(param1 == GameContext.localPlayer.reportTimeArr[_loc5_])
               {
                  _loc4_ = true;
                  break;
               }
               _loc5_++;
            }
            if(param1 == GameContext.localPlayer.id || _loc4_)
            {
               _loc3_.getMenuItem("report").itemEnabled = false;
            }
         }
         _loc3_.getMenuItem("whisper").itemEnabled = VersionConfig.enableWhisper;
         _loc3_.getMenuItem("whisper").visible = VersionConfig.enableWhisper;
         PlayerMenuUI.showMenu(_loc3_,param2.x,param2.y);
      }
      
      public static function showFriendMenu(param1:FriendInfo, param2:Point) : void
      {
         var _loc3_:PlayerMenuUI = new PlayerMenuUI("friendMenu",160);
         _loc3_.addMenuItemByObject([{
            "id":"whisper",
            "value":{
               "label":DiversityManager.getString("MenuUI","whisper"),
               "fun":obf_K_e_3075.obf_e_q_2572.whisper,
               "par":[param1.friendName]
            }
         },{
            "id":"team",
            "value":{
               "label":DiversityManager.getString("MenuUI","inviteTeam"),
               "fun":TeamManager.sendAutoInvite,
               "par":[param1.friendName]
            }
         },{
            "id":"inviteFamily",
            "value":{
               "label":DiversityManager.getString("MenuUI","familyInvite"),
               "fun":obf_F_9_1495.sendInviteFamily,
               "par":[param1.friendName]
            }
         },{
            "id":"viewPlayer",
            "value":{
               "label":DiversityManager.getString("MenuUI","viewPlayer"),
               "fun":GameContext.localPlayer.sendViewRemote,
               "par":[param1.friendName]
            }
         },{
            "id":"removeFriend",
            "value":{
               "label":DiversityManager.getString("MenuUI","removeFriend"),
               "fun":FriendManager.removeFriend,
               "par":[param1.friendName]
            }
         },{
            "id":"cancelMenu",
            "value":{
               "label":DiversityManager.getString("MenuUI","cancelMenu"),
               "fun":PlayerMenuUI.closeMenuById,
               "par":["friendMenu"]
            }
         }]);
         if(VersionConfig.enableFriendGift)
         {
            _loc3_.addMenuItemByObject([{
               "id":"gift",
               "value":{
                  "label":DiversityManager.getString("MenuUI","gift"),
                  "fun":FriendManager.sendGift,
                  "par":[param1.friendName]
               }
            }]);
         }
         if(!param1.isOnline)
         {
            _loc3_.getMenuItem("whisper").itemEnabled = false;
            _loc3_.getMenuItem("team").itemEnabled = false;
         }
         _loc3_.getMenuItem("whisper").itemEnabled = VersionConfig.enableWhisper;
         _loc3_.getMenuItem("whisper").visible = VersionConfig.enableWhisper;
         PlayerMenuUI.showMenu(_loc3_,param2.x,param2.y);
      }
      
      public static function showTeamMemberMenu(param1:String, param2:Point) : void
      {
         var _loc3_:PlayerMenuUI = new PlayerMenuUI("teamMemberMenu",160);
         _loc3_.addMenuItemByObject([{
            "id":"whisper",
            "value":{
               "label":DiversityManager.getString("MenuUI","whisper"),
               "fun":obf_K_e_3075.obf_e_q_2572.whisper,
               "par":[param1]
            }
         },{
            "id":"viewPlayer",
            "value":{
               "label":DiversityManager.getString("MenuUI","viewPlayer"),
               "fun":GameContext.localPlayer.sendViewRemote,
               "par":[param1]
            }
         },{
            "id":"addFriend",
            "value":{
               "label":DiversityManager.getString("MenuUI","addFriend"),
               "fun":FriendManager.sendAddFriend,
               "par":[param1]
            }
         },{
            "id":"inviteFamily",
            "value":{
               "label":DiversityManager.getString("MenuUI","familyInvite"),
               "fun":obf_F_9_1495.sendInviteFamily,
               "par":[param1]
            }
         }]);
         if(TeamManager.isLeader)
         {
            _loc3_.addMenuItemByObject([{
               "id":"kickTeam",
               "value":{
                  "label":DiversityManager.getString("MenuUI","kickTeam"),
                  "fun":TeamManager.sendKickTeamMember,
                  "par":[param1]
               }
            },{
               "id":"giveTeamLeader",
               "value":{
                  "label":DiversityManager.getString("MenuUI","giveTeamLeader"),
                  "fun":TeamManager.sendGiveTeamLeader,
                  "par":[param1]
               }
            }]);
         }
         _loc3_.getMenuItem("whisper").itemEnabled = VersionConfig.enableWhisper;
         _loc3_.getMenuItem("whisper").visible = VersionConfig.enableWhisper;
         PlayerMenuUI.showMenu(_loc3_,param2.x,param2.y);
      }
      
      public static function showTeamSelfMenu() : void
      {
         var _loc1_:PlayerMenuUI = new PlayerMenuUI("teamSelfMenu",160);
         _loc1_.addMenuItemByObject([{
            "id":"playerEqu",
            "value":{
               "label":DiversityManager.getString("MenuUI","playerEqu"),
               "fun":obf_K_e_3075.showUI,
               "par":[obf_K_e_3075.playerBoxUI]
            }
         }]);
         if(TeamManager.obf_r_f_4011 != "")
         {
            _loc1_.addMenuItem(new PlayerMenuItem(DiversityManager.getString("MenuUI","leaveTeam"),TeamManager.sendQuitTeam,[]),"quitTeam");
         }
         if(TeamManager.isLeader)
         {
            _loc1_.addMenuItem(new PlayerMenuItem(DiversityManager.getString("MenuUI","dismissTeam"),WindowManager.showConfirmBox,[DiversityManager.getString("TeamManagerUI","promptConfirmDismiss"),TeamManager.confirmDismissTeam]),"dismissTeam");
         }
         var _loc2_:Point = obf_K_e_3075.playerInfoUI.localToGlobal(new Point(obf_K_e_3075.playerInfoUI.mouseX,obf_K_e_3075.playerInfoUI.mouseY));
         PlayerMenuUI.showMenu(_loc1_,_loc2_.x,_loc2_.y);
      }
      
      public static function showFamilyMemberMenu(param1:FamilyMemberInfo) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:PlayerMenuUI = new PlayerMenuUI("familyMemberMenu",160);
         _loc2_.addMenuItemByObject([{
            "id":"whisper",
            "value":{
               "label":DiversityManager.getString("MenuUI","whisper"),
               "fun":obf_K_e_3075.obf_e_q_2572.whisper,
               "par":[param1.name]
            }
         },{
            "id":"viewPlayer",
            "value":{
               "label":DiversityManager.getString("MenuUI","viewPlayer"),
               "fun":GameContext.localPlayer.sendViewRemote,
               "par":[param1.name]
            }
         },{
            "id":"addFriend",
            "value":{
               "label":DiversityManager.getString("MenuUI","addFriend"),
               "fun":FriendManager.sendAddFriend,
               "par":[param1.name]
            }
         }]);
         if(obf_F_9_1495.isLeaderPost(GameContext.localPlayer.familyMyInfo.postLevel))
         {
            _loc2_.addMenuItemByObject([{
               "id":"giveFamilyLeader",
               "value":{
                  "label":DiversityManager.getString("MenuUI","familyGiveLader"),
                  "fun":WindowManager.showConfirmBox,
                  "par":[DiversityManager.getString("FamilyBoxUI","prompt_ConfirmGiveLeader",[param1.name]),obf_F_9_1495.confirmGiveFamilyLeader,param1.name]
               }
            }]);
         }
         if(GameContext.localPlayer.obf_O_l_2706(obf_Q_D_1342.obf_T_s_3521))
         {
            _loc2_.addMenuItemByObject([{
               "id":"setMemberTitle",
               "value":{
                  "label":DiversityManager.getString("MenuUI","familySetMemberTitle"),
                  "fun":WindowManager.showModalWindow,
                  "par":[new InputBoxModule(DiversityManager.getString("FamilyBoxUI","prompt_InputMemberTitle"),null,param1.name,WorldConfig.obf_P_7_1927,true),obf_F_9_1495.inputMemberTitle]
               }
            }]);
            if(!obf_L_l_4100.isEmpty(param1.familyTitle))
            {
               _loc2_.addMenuItemByObject([{
                  "id":"cancelMemberTitle",
                  "value":{
                     "label":DiversityManager.getString("MenuUI","familyCancelMemberTitle"),
                     "fun":obf_F_9_1495.sendMemberTitle,
                     "par":[param1.name,""]
                  }
               }]);
            }
         }
         if(JSONUtil.getInt(GameContext.localPlayer.familyMyInfo,["postLevel"]) > param1.postLevel + 1)
         {
            _loc2_.addMenuItemByObject([{
               "id":"upgradePost",
               "value":{
                  "label":DiversityManager.getString("MenuUI","familyUpgradePost"),
                  "fun":obf_F_9_1495.obf_U_8_1446,
                  "par":[param1]
               }
            }]);
         }
         if(JSONUtil.getInt(GameContext.localPlayer.familyMyInfo,["postLevel"]) > param1.postLevel)
         {
            if(param1.postLevel > 0)
            {
               _loc2_.addMenuItemByObject([{
                  "id":"downgradePost",
                  "value":{
                     "label":DiversityManager.getString("MenuUI","familyDowngradePost"),
                     "fun":obf_F_9_1495.obf_m_M_3705,
                     "par":[param1]
                  }
               }]);
            }
            if(GameContext.localPlayer.obf_O_l_2706(obf_Q_D_1342.obf_j_d_1978))
            {
               _loc2_.addMenuItemByObject([{
                  "id":"kickFamilyMember",
                  "value":{
                     "label":DiversityManager.getString("MenuUI","familyKickMember"),
                     "fun":WindowManager.showConfirmBox,
                     "par":[DiversityManager.getString("FamilyBoxUI","prompt_ConfirmKickMember",[param1.name]),obf_F_9_1495.confirmKickFamilyMember,param1.name]
                  }
               }]);
            }
         }
         _loc2_.addMenuItemByObject([{
            "id":"cancelMenu",
            "value":{
               "label":DiversityManager.getString("MenuUI","cancelMenu"),
               "fun":PlayerMenuUI.closeMenuById,
               "par":["familyMemberMenu"]
            }
         }]);
         _loc2_.getMenuItem("whisper").itemEnabled = VersionConfig.enableWhisper;
         _loc2_.getMenuItem("whisper").visible = VersionConfig.enableWhisper;
         PlayerMenuUI.showMenu(_loc2_,GameContext.gameStage.mouseX,GameContext.gameStage.mouseY);
      }
      
      public static function showFarmMenu(param1:String) : void
      {
         var _loc2_:Array = param1.split("@");
         if(_loc2_.length < 2)
         {
            return;
         }
         var _loc3_:PlayerMenuUI = new PlayerMenuUI("farmMenu");
         _loc3_.addMenuItemByObject([{
            "id":"teleport",
            "value":{
               "label":DiversityManager.getString("MenuUI","teleportToFarm"),
               "fun":FarmManager.teleportToFarm,
               "par":[param1,""]
            }
         },{
            "id":"moveTo",
            "value":{
               "label":DiversityManager.getString("MenuUI","moveToFarm"),
               "fun":GameContext.localPlayer.obf_0_8_r_450,
               "par":[_loc2_[1],obf_U_6_3454.obf_j_k_4275,_loc2_[0]]
            }
         },{
            "id":"cancelMenu",
            "value":{
               "label":DiversityManager.getString("MenuUI","cancelMenu"),
               "fun":PlayerMenuUI.closeMenuById,
               "par":["farmMenu"]
            }
         }]);
         PlayerMenuUI.showMenu(_loc3_,GameContext.gameStage.mouseX,GameContext.gameStage.mouseY);
      }
      
      public static function showMapMenu(param1:String, param2:int = undefined, param3:int = undefined) : void
      {
         var _loc5_:Point = null;
         var _loc4_:PlayerMenuUI = new PlayerMenuUI("mapMenu");
         if(Boolean(param2) && Boolean(param3))
         {
            _loc5_ = new Point(param2,param3);
         }
         _loc4_.addMenuItemByObject([{
            "id":"teleport",
            "value":{
               "label":DiversityManager.getString("MenuUI","teleportTo"),
               "fun":GameContext.localPlayer.sendTeleportMapMove,
               "par":[param1,obf_U_6_3454.obf_L_K_2966,_loc5_]
            }
         },{
            "id":"moveTo",
            "value":{
               "label":DiversityManager.getString("MenuUI","moveTo"),
               "fun":GameContext.localPlayer.obf_0_8_r_450,
               "par":[param1,obf_U_6_3454.obf_L_K_2966,_loc5_]
            }
         },{
            "id":"cancelMenu",
            "value":{
               "label":DiversityManager.getString("MenuUI","cancelMenu"),
               "fun":PlayerMenuUI.closeMenuById,
               "par":["mapMenu"]
            }
         }]);
         PlayerMenuUI.showMenu(_loc4_,GameContext.gameStage.mouseX,GameContext.gameStage.mouseY);
      }
   }
}

