package com.sunweb.game.rpg.playerUI.team
{
   import obf_g_A_3629.obf_r_Y_1874;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.netRole.RemotePlayer;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.VersionConfig;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.team.TeamManager;
   import com.sunweb.game.rpg.team.obf_4_e_1169;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.obf_L_l_4100;
   import fl.data.DataProvider;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import playerUI.TeamManagerUIMC;
   
   public class TeamManagerUI extends TeamManagerUIMC implements IPlayerUI
   {
      
      public function TeamManagerUI()
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2 - 200;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         titleBox.mouseEnabled = false;
         inputTeamName.maxChars = VersionConfig.teamNameLength;
         var _loc1_:String = GameItemRank.getRankName(GameItemRank.MAGIC);
         var _loc2_:String = GameItemRank.getRankName(GameItemRank.FANTASY);
         var _loc3_:String = GameItemRank.getRankName(GameItemRank.LEGEND);
         var _loc4_:String = GameItemRank.getRankName(GameItemRank.EPIC);
         var _loc5_:DataProvider = new DataProvider([{
            "label":(_loc1_ == "" ? DiversityManager.getString("TeamManagerUI","loot_ItemRank1") : _loc1_),
            "data":GameItemRank.MAGIC
         },{
            "label":(_loc2_ == "" ? DiversityManager.getString("TeamManagerUI","loot_ItemRank2") : _loc2_),
            "data":GameItemRank.FANTASY
         },{
            "label":(_loc3_ == "" ? DiversityManager.getString("TeamManagerUI","loot_ItemRank3") : _loc3_),
            "data":GameItemRank.LEGEND
         },{
            "label":(_loc4_ == "" ? DiversityManager.getString("TeamManagerUI","loot_ItemRank4") : _loc4_),
            "data":GameItemRank.EPIC
         }]);
         listTeamModeRank.dataProvider = _loc5_;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"TeamManagerUI","txtTitle");
         DiversityManager.setTextField(txtDeyMapTeam,"TeamManagerUI","txtMapTeam");
         DiversityManager.setTextField(txtDeyTeam,"TeamManagerUI","txtTeamName");
         DiversityManager.setTextField(txtDeyTeamItemMode,"TeamManagerUI","txtTeamItemMode");
         cmdJoinTeam.label = DiversityManager.getString("TeamManagerUI","cmdJoinTeam");
         cmdCreateTeam.label = DiversityManager.getString("TeamManagerUI","cmdCreateTeam");
         cmdDismissTeam.label = DiversityManager.getString("TeamManagerUI","cmdDismissTeam");
         cmdQuitTeam.label = DiversityManager.getString("TeamManagerUI","cmdQuitTeam");
         cmdRefreshTeam.label = DiversityManager.getString("TeamManagerUI","cmdRefreshTeam");
         chkFreeMode.label = DiversityManager.getString("TeamManagerUI","chkFreeMode");
         chkTeamMode.label = DiversityManager.getString("TeamManagerUI","chkTeamMode");
         cmdTeamItemModeOK.label = DiversityManager.getString("TeamManagerUI","cmdTeamItemModeOK");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdCreateTeam.addEventListener(MouseEvent.CLICK,this.obf_0_0_x_349);
         cmdQuitTeam.addEventListener(MouseEvent.CLICK,this.obf_p_e_3164);
         cmdDismissTeam.addEventListener(MouseEvent.CLICK,this.obf_0_0_o_439);
         cmdJoinTeam.addEventListener(MouseEvent.CLICK,this.obf_v_w_2298);
         cmdRefreshTeam.addEventListener(MouseEvent.CLICK,this.onRefreshTeamList);
         inputTeamName.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputTeamName.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         chkFreeMode.addEventListener(MouseEvent.CLICK,this.obf_D_k_2187);
         chkTeamMode.addEventListener(MouseEvent.CLICK,this.obf_D_k_2187);
         cmdTeamItemModeOK.addEventListener(MouseEvent.CLICK,this.obf_8_H_3936);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdCreateTeam.removeEventListener(MouseEvent.CLICK,this.obf_0_0_x_349);
         cmdQuitTeam.removeEventListener(MouseEvent.CLICK,this.obf_p_e_3164);
         cmdDismissTeam.removeEventListener(MouseEvent.CLICK,this.obf_0_0_o_439);
         cmdJoinTeam.removeEventListener(MouseEvent.CLICK,this.obf_v_w_2298);
         cmdRefreshTeam.removeEventListener(MouseEvent.CLICK,this.onRefreshTeamList);
         inputTeamName.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputTeamName.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         chkFreeMode.removeEventListener(MouseEvent.CLICK,this.obf_D_k_2187);
         chkTeamMode.removeEventListener(MouseEvent.CLICK,this.obf_D_k_2187);
         cmdTeamItemModeOK.removeEventListener(MouseEvent.CLICK,this.obf_8_H_3936);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function obf_m_I_3657(param1:KeyboardEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function onRefreshTeamList(param1:Event) : void
      {
         this.refreshTeamList();
      }
      
      private function obf_D_k_2187(param1:Event) : void
      {
         chkFreeMode.selected = chkFreeMode == param1.currentTarget;
         chkTeamMode.selected = chkTeamMode == param1.currentTarget;
         listTeamModeRank.enabled = param1.currentTarget == chkTeamMode;
      }
      
      private function obf_8_H_3936(param1:Event) : void
      {
         if(!TeamManager.isLeader)
         {
            return;
         }
         var _loc2_:int = obf_4_e_1169.obf_0_0_5_249;
         if(chkTeamMode.selected)
         {
            _loc2_ = obf_4_e_1169.obf_R_x_1589;
         }
         TeamManager.sendTeamItemMode(_loc2_,listTeamModeRank.selectedItem.data);
      }
      
      public function obf_f_r_2576() : void
      {
         inputTeamName.editable = obf_L_l_4100.isEmpty(TeamManager.obf_r_f_4011);
         cmdCreateTeam.enabled = obf_L_l_4100.isEmpty(TeamManager.obf_r_f_4011);
         cmdQuitTeam.enabled = !obf_L_l_4100.isEmpty(TeamManager.obf_r_f_4011);
         cmdJoinTeam.enabled = obf_L_l_4100.isEmpty(TeamManager.obf_r_f_4011);
         cmdDismissTeam.enabled = TeamManager.isLeader;
         chkFreeMode.enabled = TeamManager.isLeader;
         chkTeamMode.enabled = TeamManager.isLeader;
         listTeamModeRank.enabled = TeamManager.isLeader;
         cmdTeamItemModeOK.enabled = TeamManager.isLeader;
      }
      
      public function obf_9_b_2537() : void
      {
         var _loc2_:Object = null;
         chkFreeMode.selected = TeamManager.teamItemMode == obf_4_e_1169.obf_0_0_5_249;
         chkTeamMode.selected = TeamManager.teamItemMode == obf_4_e_1169.obf_R_x_1589;
         listTeamModeRank.enabled = TeamManager.teamItemMode == obf_4_e_1169.obf_R_x_1589;
         txtDeyTeamItemRank.text = "";
         if(TeamManager.teamItemMode == obf_4_e_1169.obf_R_x_1589)
         {
            txtDeyTeamItemRank.textColor = GameItemRank.getRankColor(TeamManager.teamItemRank);
            txtDeyTeamItemRank.text = GameItemRank.getRankName(TeamManager.teamItemRank);
         }
         var _loc1_:int = 0;
         while(_loc1_ < listTeamModeRank.dataProvider.length)
         {
            _loc2_ = listTeamModeRank.dataProvider.getItemAt(_loc1_);
            if(_loc2_.data == TeamManager.teamItemRank)
            {
               listTeamModeRank.selectedIndex = _loc1_;
               break;
            }
            _loc1_++;
         }
      }
      
      public function refreshTeamList() : void
      {
         var _loc2_:String = null;
         var _loc3_:RemotePlayer = null;
         if(!GameContext.currentMap)
         {
            return;
         }
         var _loc1_:Array = new Array();
         for(_loc2_ in GameContext.currentMap.remotePlayerSet.obf_0_678)
         {
            _loc3_ = GameContext.currentMap.remotePlayerSet.getObject(_loc2_) as RemotePlayer;
            if(Boolean(_loc3_) && Boolean(_loc3_.obf_I_0_1698.teamName != "") && _loc1_.indexOf(_loc3_.obf_I_0_1698.teamName) == -1)
            {
               _loc1_.push(_loc3_.obf_I_0_1698.teamName);
            }
         }
         listTeam.dataProvider = new DataProvider(_loc1_);
      }
      
      private function obf_0_0_x_349(param1:Event) : void
      {
         var _loc2_:String = obf_L_l_4100.obf_I_C_3435(inputTeamName.text);
         if(_loc2_ == "")
         {
            inputTeamName.text = GameContext.localPlayer.id;
            _loc2_ = GameContext.localPlayer.id;
         }
         if(TeamManager.obf_r_f_4011 != "")
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("TeamManagerUI","promptCreateError_HavedTeam"));
            return;
         }
         if(obf_r_Y_1874.isUnlawful(_loc2_,true))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("TeamManagerUI","promptCreateError_InvalidChar"));
            return;
         }
         TeamManager.sendCreateTeam(_loc2_);
      }
      
      private function obf_p_e_3164(param1:Event) : void
      {
         if(TeamManager.obf_r_f_4011 == "")
         {
            return;
         }
         TeamManager.sendQuitTeam();
      }
      
      private function obf_0_0_o_439(param1:Event) : void
      {
         if(TeamManager.obf_r_f_4011 != GameContext.localPlayer.id)
         {
            return;
         }
         WindowManager.showConfirmBox(DiversityManager.getString("TeamManagerUI","promptConfirmDismiss"),TeamManager.confirmDismissTeam);
      }
      
      private function obf_v_w_2298(param1:Event) : void
      {
         if(listTeam.selectedItem == null)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("TeamManagerUI","promptJoinError_NoTeam"));
            return;
         }
         if(TeamManager.obf_r_f_4011 != "")
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("TeamManagerUI","promptJoinError_HavedTeam"));
            return;
         }
         TeamManager.sendJoin(listTeam.selectedItem.data);
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         this.refreshTeamList();
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

