package com.sunweb.game.rpg.module
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.loginZone.obf_o_V_2653;
   import com.sunweb.game.rpg.loginZone.info.ServerInfo;
   import com.sunweb.game.rpg.worldZone.obf_u_d_1452;
   import com.sunweb.game.ui.IWindow;
   import com.sunweb.game.ui.WindowManager;
   import fl.data.DataProvider;
   import fl.events.ListEvent;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mmorpg.ServerListUI;
   
   public class ServerListModule extends ServerListUI implements IWindow
   {
      
      public function ServerListModule()
      {
         super();
         if(!GameContext.loginClient.sessionId || GameContext.loginClient.sessionId == "")
         {
            return;
         }
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         GameContext.loginClient.addEventListener(obf_o_V_2653.obf_0_7_T_404,this.onServerListHandler);
         GameContext.loginClient.addEventListener(obf_o_V_2653.obf_k_u_2062,this.onServerFailedHandler);
         GameContext.loginClient.addEventListener(obf_o_V_2653.obf_0___R_732,this.onDisconnected);
         GameContext.loginClient.getServerList();
         flListBox.cmdSelect.addEventListener(MouseEvent.CLICK,this.onSelect);
         flListBox.cmdBack.addEventListener(MouseEvent.CLICK,this.onBack);
         flListBox.lstServer.labelFunction = this.serverListLabel;
         flListBox.lstServer.iconFunction = this.serverListIcon;
         flListBox.lstServer.addEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.onSelect);
         flListBox.lstServer.rowHeight = 30;
         if(GameContext.isSso())
         {
            flListBox.visible = false;
         }
         this.initDiversity();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(flListBox.txtDeyTitle,"ServerListPage","title",null,true);
         DiversityManager.setTextField(flListBox.txtDeySelect,"ServerListPage","cmdSelect");
         DiversityManager.setTextField(flListBox.txtDeyBack,"ServerListPage","cmdBack");
      }
      
      private function serverListLabel(param1:ServerInfo) : String
      {
         return param1.serverName;
      }
      
      private function serverListIcon(param1:ServerInfo) : DisplayObject
      {
         return null;
      }
      
      private function onDisconnected(param1:obf_o_V_2653) : void
      {
         WindowManager.showMessageBox(param1.failureReason,GameContext.ssoFailed);
         this.onBack(null);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         GameContext.loginClient.removeEventListener(obf_o_V_2653.obf_0_7_T_404,this.onServerListHandler);
         GameContext.loginClient.removeEventListener(obf_o_V_2653.obf_k_u_2062,this.onServerFailedHandler);
         GameContext.loginClient.removeEventListener(obf_o_V_2653.obf_0___R_732,this.onDisconnected);
         flListBox.cmdSelect.removeEventListener(MouseEvent.CLICK,this.onSelect);
         flListBox.cmdBack.removeEventListener(MouseEvent.CLICK,this.onBack);
         flListBox.lstServer.removeEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.onSelect);
      }
      
      private function onAddToStage(param1:Event) : void
      {
         this.x = this.stage.stageWidth / 2;
         this.y = this.stage.stageHeight / 2;
      }
      
      private function onSelect(param1:Event) : void
      {
         if(flListBox.lstServer.selectedItem)
         {
            this.connectServer(flListBox.lstServer.selectedItem as ServerInfo);
         }
      }
      
      private function connectServer(param1:ServerInfo) : void
      {
         if(!param1)
         {
            return;
         }
         GameContext.loadPolicyFile(param1.serverIP);
         GameContext.obf_N_G_4080 = param1.serverId;
         GameContext.worldClient = new obf_u_d_1452(param1.serverIP,param1.serverPort);
         this.showRoleModule();
      }
      
      private function onBack(param1:Event) : void
      {
         this.removeListener();
         if(GameContext.isSso())
         {
            return;
         }
         WindowManager.closeWindow(this);
         WindowManager.showWindow(new LoginModule());
      }
      
      private function showRoleModule() : void
      {
         WindowManager.closeWindow(this);
         WindowManager.showWindow(new RoleListModule());
      }
      
      private function onServerListHandler(param1:obf_o_V_2653) : void
      {
         var _loc4_:ServerInfo = null;
         var _loc2_:DataProvider = new DataProvider(param1.serverList);
         flListBox.lstServer.dataProvider = _loc2_;
         var _loc3_:String = obf_r_8_1121.getParameter(["sid"]);
         for each(_loc4_ in param1.serverList)
         {
            if(_loc4_.serverName == param1.selectedServer)
            {
               flListBox.lstServer.selectedItem = _loc4_;
            }
            if(_loc4_.serverId == _loc3_)
            {
               this.connectServer(_loc4_);
               return;
            }
         }
      }
      
      private function onServerFailedHandler(param1:obf_o_V_2653) : void
      {
         WindowManager.showMessageBox(param1.failureReason,GameContext.ssoFailed);
         this.onBack(null);
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

