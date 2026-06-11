package com.sunweb.game.rpg.module
{
   import obf_g_A_3629.obf_r_Y_1874;
   import obf_o_M_4577.obf_l_N_3214;
   import com.adobe.serialization.json.JSON;
   import com.brokenfunction.json.*;
   import com.sunweb.game.res.ResourceBag;
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.res.obf_J_Y_3494;
   import com.sunweb.game.res.obf_e_4650;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_0_1_2695;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.farm.obf_0_1_1_203;
   import com.sunweb.game.rpg.farm.obf_j_1_3698;
   import com.sunweb.game.rpg.module.CreateRole.obf_E_9_2246;
   import com.sunweb.game.rpg.netRole.obf_Y_E_3667;
   import com.sunweb.game.rpg.playerUI.obf_C_o_3363;
   import com.sunweb.game.rpg.playerUI.managers.VersionConfig;
   import com.sunweb.game.rpg.playerUI.roles.obf_h_a_2268;
   import com.sunweb.game.rpg.role.RoleModel;
   import com.sunweb.game.rpg.role.RoleSystemInfo;
   import com.sunweb.game.rpg.role.obf_E_k_1445;
   import com.sunweb.game.rpg.role.obf_I_5_1944;
   import com.sunweb.game.rpg.role.obf_e_1465;
   import com.sunweb.game.rpg.role.obf_l_4_4027;
   import com.sunweb.game.rpg.roleZone.RoleEventType;
   import com.sunweb.game.rpg.roleZone.command.DeleteRoleAnswer;
   import com.sunweb.game.rpg.roleZone.command.DeleteRoleRequest;
   import com.sunweb.game.rpg.roleZone.command.RoleListAnswer;
   import com.sunweb.game.rpg.roleZone.command.RoleListRequest;
   import com.sunweb.game.rpg.roleZone.command.SelectRoleAnswer;
   import com.sunweb.game.rpg.roleZone.command.SelectRoleRequest;
   import com.sunweb.game.rpg.roleZone.command.SetRolePasswordAnswer;
   import com.sunweb.game.rpg.roleZone.command.SetRolePasswordRequest;
   import com.sunweb.game.rpg.settingConfig.NumberConfig;
   import com.sunweb.game.rpg.sound.obf_q_6_3634;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.worldZone.WorldEventType;
   import com.sunweb.game.rpg.worldZone.command.WorldLoginAnswer;
   import com.sunweb.game.rpg.worldZone.command.WorldLoginRequest;
   import com.sunweb.game.rpg.worldZone.command.system.WorldPVEMapsNotify;
   import com.sunweb.game.ui.IWindow;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mmorpg.RoleListUI;
   
   public class RoleListModule extends RoleListUI implements IWindow
   {
      
      private var progressBox:ProgressBoxModule;
      
      private var commonBag:ResourceBag;
      
      private var selectedRole:RoleSystemInfo;
      
      private var roles:Array;
      
      private var roleList:Array;
      
      public function RoleListModule()
      {
         this.commonBag = ResourceManager.instance.getBag("commonInf",true);
         super();
         if(!GameContext.worldClient)
         {
            this.backToServerList();
         }
         this.initDiversity();
         VersionConfig.pveMaps = null;
         cmdMusic.gotoAndStop(obf_q_6_3634.obf_T_T_4349.volume > 0 ? 1 : 2);
         this.addListener();
         if(!GameContext.worldClient.isConnected)
         {
            GameContext.worldClient.connect();
         }
         else
         {
            this.onConnectSuccess(null);
         }
         WindowManager.showMessageBox(DiversityManager.getString("RoleListPage","getRoleList"),null,"RoleListMessage",true);
         try
         {
            obf_H_l_800.call("onServerData",GameContext.obf_N_G_4080,GameContext.obf_0_7_r_135);
         }
         catch(e:Error)
         {
         }
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyCreateRole,"RoleListPage","cmdCreateRole");
         DiversityManager.setTextField(txtDeyDeleteRole,"RoleListPage","cmdDeleteRole");
         DiversityManager.setTextField(txtDeyEnterWorld,"RoleListPage","cmdEnterWorld");
         DiversityManager.setTextField(txtDeySetRolePassword,"RoleListPage","cmdSetRolePass");
      }
      
      private function onConnectSuccess(param1:obf_l_N_3214) : void
      {
         if(this.commonBag.loader.loadingState == obf_e_4650.obf_D_b_3365)
         {
            this.commonBag.loader.addEventListener(obf_J_Y_3494.COMPLETE,this.commonLoadCompleteHandler);
            this.progressBox = WindowManager.showProgressBox([this.commonBag.loader],"");
         }
         else
         {
            this.initializeModels();
            this.loginWorldServer();
         }
      }
      
      private function commonLoadCompleteHandler(param1:obf_J_Y_3494) : void
      {
         WindowManager.closeWindow(this.progressBox);
         this.commonBag.loader.removeEventListener(obf_J_Y_3494.COMPLETE,this.commonLoadCompleteHandler);
         this.initializeModels();
         this.loginWorldServer();
      }
      
      private function onLogin(param1:obf_0_1_2695) : void
      {
         var _loc2_:WorldLoginAnswer = param1.cmd as WorldLoginAnswer;
         if(_loc2_.isDone)
         {
            GameContext.worldClient.sendCommand(new RoleListRequest());
         }
         else
         {
            WindowManager.showMessageBox(_loc2_.failureReason);
         }
      }
      
      private function onConnectFailure(param1:obf_l_N_3214) : void
      {
         WindowManager.closeWindow(WindowManager.getModalWindowByName("RoleListMessage") as IWindow);
         WindowManager.showMessageBox(DiversityManager.getString("SystemPrompt","connect_failure"),GameContext.ssoFailed);
         this.backToServerList();
      }
      
      private function onDisconnected(param1:obf_l_N_3214) : void
      {
         WindowManager.closeWindow(WindowManager.getModalWindowByName("RoleListMessage") as IWindow);
         if(GameContext.worldClient.online)
         {
            WindowManager.showMessageBox(DiversityManager.getString("SystemPrompt","disconnected"),GameContext.ssoFailed);
         }
         this.backToServerList();
      }
      
      private function loginWorldServer() : void
      {
         var _loc1_:WorldLoginRequest = null;
         if(GameContext.worldClient.online)
         {
            GameContext.worldClient.sendCommand(new RoleListRequest());
         }
         else
         {
            _loc1_ = new WorldLoginRequest();
            _loc1_.sessionId = GameContext.loginClient.sessionId;
            _loc1_.serverId = GameContext.obf_N_G_4080;
            GameContext.worldClient.sendCommand(_loc1_);
         }
      }
      
      private function addListener() : void
      {
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         cmdEnterWorld.addEventListener(MouseEvent.CLICK,this.obf_N_K_2767);
         cmdCreateRole.addEventListener(MouseEvent.CLICK,this.obf_d_i_3391);
         cmdDeleteRole.addEventListener(MouseEvent.CLICK,this.obf_S_X_2204);
         cmdSetRolePassword.addEventListener(MouseEvent.CLICK,this.obf_8_X_1565);
         cmdMusic.addEventListener(MouseEvent.CLICK,this.obf_l_k_4340);
         GameContext.worldClient.addEventListener(obf_l_N_3214.obf_R_4392,this.onConnectSuccess);
         GameContext.worldClient.addEventListener(obf_l_N_3214.obf_r_H_4569,this.onConnectFailure);
         GameContext.worldClient.addEventListener(obf_l_N_3214.obf_N_7_3895,this.onDisconnected);
         GameContext.worldClient.addEventListener(WorldEventType.LOGIN_WORLD_ANSWER,this.onLogin);
         GameContext.worldClient.addEventListener(RoleEventType.ROLE_LIST_ANSWER,this.onRoleList);
         GameContext.worldClient.addEventListener(RoleEventType.DELETE_ROLE_ANSWER,this.obf_H_2_2034);
         GameContext.worldClient.addEventListener(RoleEventType.SELECT_ROLE_ANSWER,this.selectRoleAnswer);
         GameContext.worldClient.addEventListener(RoleEventType.SET_ROLE_PW_ANSWER,this.setRolePassAnswer);
         GameContext.worldClient.addEventListener(WorldEventType.WORLD_PVE_MAPS_NOTIFY,this.obf_E_s_3853);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         cmdEnterWorld.removeEventListener(MouseEvent.CLICK,this.obf_N_K_2767);
         cmdCreateRole.removeEventListener(MouseEvent.CLICK,this.obf_d_i_3391);
         cmdDeleteRole.removeEventListener(MouseEvent.CLICK,this.obf_S_X_2204);
         cmdSetRolePassword.removeEventListener(MouseEvent.CLICK,this.obf_8_X_1565);
         cmdMusic.removeEventListener(MouseEvent.CLICK,this.obf_l_k_4340);
         GameContext.worldClient.removeEventListener(obf_l_N_3214.obf_R_4392,this.onConnectSuccess);
         GameContext.worldClient.removeEventListener(obf_l_N_3214.obf_r_H_4569,this.onConnectFailure);
         GameContext.worldClient.removeEventListener(obf_l_N_3214.obf_N_7_3895,this.onDisconnected);
         GameContext.worldClient.removeEventListener(WorldEventType.LOGIN_WORLD_ANSWER,this.onLogin);
         GameContext.worldClient.removeEventListener(RoleEventType.ROLE_LIST_ANSWER,this.onRoleList);
         GameContext.worldClient.removeEventListener(RoleEventType.DELETE_ROLE_ANSWER,this.obf_H_2_2034);
         GameContext.worldClient.removeEventListener(RoleEventType.SELECT_ROLE_ANSWER,this.selectRoleAnswer);
         GameContext.worldClient.removeEventListener(RoleEventType.SET_ROLE_PW_ANSWER,this.setRolePassAnswer);
         GameContext.worldClient.removeEventListener(WorldEventType.WORLD_PVE_MAPS_NOTIFY,this.obf_E_s_3853);
      }
      
      private function onAddToStage(param1:Event) : void
      {
         this.x = this.stage.stageWidth / 2;
         this.y = this.stage.stageHeight / 2;
      }
      
      private function backToServerList() : void
      {
         if(GameContext.isSso())
         {
            return;
         }
         WindowManager.closeWindow(WindowManager.getModalWindowByName("RoleListMessage") as IWindow);
         WindowManager.closeWindow(this);
         WindowManager.showWindow(new ServerListModule());
      }
      
      private function obf_l_k_4340(param1:Event) : void
      {
         if(obf_q_6_3634.obf_T_T_4349.volume > 0)
         {
            obf_q_6_3634.obf_T_T_4349.volume = 0;
            cmdMusic.gotoAndStop(2);
         }
         else
         {
            obf_q_6_3634.obf_T_T_4349.volume = 0.5;
            cmdMusic.gotoAndStop(1);
         }
         obf_q_6_3634.updateMusicVolume();
      }
      
      private function onRoleList(param1:obf_0_1_2695) : void
      {
         var resBag:ResourceBag;
         var resList2:Array;
         var res:String = null;
         var thisAnswer:RoleListAnswer = null;
         var autoSelectRoleInfo:RoleSystemInfo = null;
         var r:int = 0;
         var roleBox:obf_h_a_2268 = null;
         var cont:DisplayObjectContainer = null;
         var e:obf_0_1_2695 = param1;
         WindowManager.closeWindow(WindowManager.getModalWindowByName("RoleListMessage") as IWindow);
         resBag = ResourceManager.instance.getBag("common",true);
         resBag.loader.maxConn = 1;
         resList2 = WorldConfig.getResList("res2");
         for each(res in resList2)
         {
            resBag.obf_z_U_2156(res);
         }
         resBag.load();
         thisAnswer = e.cmd as RoleListAnswer;
         this.roles = thisAnswer.roles;
         this.selectedRole = null;
         if(this.roles.length > 0)
         {
            this.destroyRoleList();
            this.roleList = new Array();
            r = 0;
            while(r < 3 && r < this.roles.length)
            {
               GameContext.obf_0_7_r_135 = JSONUtil.getStr(this.roles,[r,"accountId"]);
               roleBox = new obf_h_a_2268(this.roles[r]);
               roleBox.addEventListener(MouseEvent.DOUBLE_CLICK,this.obf_0_4_v_452);
               roleBox.addEventListener(MouseEvent.CLICK,this.obf_g_9_1354);
               cont = this["pointRoleBox" + r] as DisplayObjectContainer;
               if(cont)
               {
                  cont.addChild(roleBox);
               }
               this.roleList.push(roleBox);
               if(GameContext.autoSelectRole == this.roles[r].name)
               {
                  this.selectRole(this.roles[r]);
               }
               r++;
            }
         }
         else
         {
            this.obf_d_i_3391(null);
         }
         try
         {
            obf_H_l_800.call("onRoleList",this.roles.length);
         }
         catch(e:Error)
         {
         }
      }
      
      private function obf_H_2_2034(param1:obf_0_1_2695) : void
      {
         var _loc2_:DeleteRoleAnswer = param1.cmd as DeleteRoleAnswer;
         GameContext.worldClient.sendCommand(new RoleListRequest());
      }
      
      private function obf_d_i_3391(param1:Event) : void
      {
         WindowManager.closeWindow(this);
         WindowManager.showWindow(new obf_E_9_2246());
      }
      
      private function obf_S_X_2204(param1:Event) : void
      {
         if(!this.selectedRole)
         {
            return;
         }
         if(this.selectedRole.hasRolePassword)
         {
            WindowManager.showInputBox(DiversityManager.getString("RoleListPage","prompt_InputRolePass"),null,this.selectedRole.name,0,false,this.confirmPasswordDelete,true);
         }
         else
         {
            WindowManager.showModalWindow(new InputBoxModule(DiversityManager.getString("RoleListPage","confirmDeleteRole",[this.selectedRole.name]),null,this.selectedRole.name),this.confirmDelete);
         }
      }
      
      private function confirmDelete(param1:Object) : void
      {
         var _loc2_:DeleteRoleRequest = null;
         if(String(param1.content).toUpperCase() == "DELETE")
         {
            _loc2_ = new DeleteRoleRequest();
            _loc2_.name = param1.par;
            GameContext.worldClient.sendCommand(_loc2_);
         }
      }
      
      private function confirmPasswordDelete(param1:Object) : void
      {
         if(obf_L_l_4100.isEmpty(param1.content))
         {
            return;
         }
         var _loc2_:DeleteRoleRequest = new DeleteRoleRequest();
         _loc2_.name = param1.par;
         _loc2_.password = param1.content;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      private function obf_8_X_1565(param1:Event) : void
      {
         if(!this.selectedRole)
         {
            return;
         }
         var _loc2_:PasswordChangeBox = new PasswordChangeBox(this.selectedRole.name);
         WindowManager.showModalWindow(_loc2_,this.inputNewPass,true);
      }
      
      private function inputNewPass(param1:Object) : void
      {
         if(obf_L_l_4100.isEmpty(param1.oldPassword) && obf_L_l_4100.isEmpty(param1.newPassword))
         {
            return;
         }
         if(param1.newPassword != param1.newPassword2)
         {
            WindowManager.showMessageBox(DiversityManager.getString("RoleListPage","prompt_NewPasswordError"));
            return;
         }
         var _loc2_:SetRolePasswordRequest = new SetRolePasswordRequest();
         _loc2_.roleName = param1.par;
         _loc2_.oldPassword = param1.oldPassword;
         _loc2_.password = param1.newPassword;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      private function obf_N_K_2767(param1:Event) : void
      {
         if(!this.selectedRole)
         {
            return;
         }
         this.selectRole(this.selectedRole);
      }
      
      private function obf_0_4_v_452(param1:Event) : void
      {
         var _loc2_:obf_h_a_2268 = param1.currentTarget as obf_h_a_2268;
         if(_loc2_)
         {
            this.selectRole(_loc2_.roleInfo);
         }
      }
      
      private function obf_g_9_1354(param1:Event) : void
      {
         var _loc2_:obf_h_a_2268 = null;
         this.selectedRole = param1.currentTarget.roleInfo;
         for each(_loc2_ in this.roleList)
         {
            if(_loc2_)
            {
               _loc2_.selected = _loc2_ == param1.currentTarget;
            }
         }
      }
      
      private function selectRole(param1:RoleSystemInfo, param2:Boolean = true) : void
      {
         var _loc6_:String = null;
         var _loc7_:SelectRoleRequest = null;
         var _loc3_:String = DiversityManager.getString("RoleListPage","confirm_SelectRole");
         if(!obf_L_l_4100.isEmpty(_loc3_) && param2 && param1.level > 20)
         {
            WindowManager.showConfirmBox(_loc3_,this.confirmSelectRole,param1);
            return;
         }
         var _loc4_:ResourceBag = ResourceManager.instance.getBag("common",true);
         var _loc5_:Array = obf_Y_E_3667.getEquipmentImageRes(obf_E_k_1445.HAT,obf_Y_E_3667.getHairModelCode(param1.jobCode,param1.sex,param1.hairStyleIndex),obf_I_5_1944.getJobName(param1.jobCode,param1.sex));
         for each(_loc6_ in _loc5_)
         {
            _loc4_.obf_z_U_2156(_loc6_);
         }
         _loc4_.obf_z_U_2156(JSONUtil.getStr(RoleModel.getPlayerModel(obf_I_5_1944.getJobName(param1.jobCode,param1.sex)),["res"]));
         if(param1.hasRolePassword)
         {
            WindowManager.showInputBox(DiversityManager.getString("RoleListPage","prompt_InputRolePass"),null,param1.name,0,false,this.confirmPasswordSelectRole,true);
         }
         else
         {
            _loc7_ = new SelectRoleRequest();
            _loc7_.name = param1.name;
            GameContext.worldClient.sendCommand(_loc7_);
         }
      }
      
      private function confirmSelectRole(param1:Object) : void
      {
         if(param1.confirm)
         {
            this.selectRole(param1.par,false);
         }
      }
      
      private function confirmPasswordSelectRole(param1:Object) : void
      {
         if(obf_L_l_4100.isEmpty(param1.content))
         {
            return;
         }
         var _loc2_:SelectRoleRequest = new SelectRoleRequest();
         _loc2_.name = param1.par;
         _loc2_.password = param1.content;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      private function enterWorld() : void
      {
         GameContext.loginClient.close();
         WindowManager.destroyWindow();
         var _loc1_:ResLoadModule = new ResLoadModule();
         _loc1_.name = "ResLoadModule";
         WindowManager.showWindow(_loc1_);
      }
      
      private function selectRoleAnswer(param1:obf_0_1_2695) : void
      {
         var _loc2_:SelectRoleAnswer = param1.cmd as SelectRoleAnswer;
         if(_loc2_.isDone)
         {
            this.enterWorld();
         }
         else
         {
            WindowManager.showMessageBox(_loc2_.failureReason);
         }
      }
      
      private function setRolePassAnswer(param1:obf_0_1_2695) : void
      {
         var _loc2_:SetRolePasswordAnswer = param1.cmd as SetRolePasswordAnswer;
         if(_loc2_.isDone)
         {
            GameContext.worldClient.sendCommand(new RoleListRequest());
            WindowManager.showMessageBox(DiversityManager.getString("RoleListPage","prompt_RolePassChanged"));
         }
         else
         {
            WindowManager.showMessageBox(_loc2_.failureReason);
         }
      }
      
      private function obf_E_s_3853(param1:obf_0_1_2695) : void
      {
         var _loc2_:WorldPVEMapsNotify = param1.cmd as WorldPVEMapsNotify;
         VersionConfig.pveMaps = _loc2_.pveMapIds;
      }
      
      private function initializeModels() : void
      {
         WorldConfig.init(com.adobe.serialization.json.JSON.decode(ResourceManager.instance.getText("iss")));
         cmdDeleteRole.visible = !WorldConfig.getValue("functionSwitch","deleteRole");
         txtDeyDeleteRole.visible = !WorldConfig.getValue("functionSwitch","deleteRole");
         cmdSetRolePassword.visible = !WorldConfig.getValue("functionSwitch","roleLock");
         txtDeySetRolePassword.visible = !WorldConfig.getValue("functionSwitch","roleLock");
         if(GameContext.infConfigInit)
         {
            return;
         }
         obf_r_Y_1874.init(ResourceManager.instance.getText("idw").split("\r\n"));
         obf_l_4_4027.obf_i_A_4163 = "nff";
         obf_e_1465.obf_M_o_2357 = "cff";
         obf_0_1_1_203.obf_K_0_1105 = "c9@o3";
         obf_j_1_3698.obf_Y_5_1487 = "b9@o3";
         RoleModel.playerModelList = decodeJson(ResourceManager.instance.getText("ipm"));
         obf_Y_E_3667.initHairConfig(com.adobe.serialization.json.JSON.decode(ResourceManager.instance.getText("ihc")));
         obf_E_k_1445.equipmentModelMap = decodeJson(ResourceManager.instance.getText("iem"));
         NumberConfig.init(com.adobe.serialization.json.JSON.decode(ResourceManager.instance.getText("ins")));
         obf_C_o_3363.loadUrlConfig(GameContext.getFullResUrl(WorldConfig.getStringSetting("remoteUrlConfig")));
         var _loc1_:String = obf_r_8_1121.getParameter(["fb"]);
         if(_loc1_ == "1")
         {
            VersionConfig.enableR2_Facebook = true;
         }
         var _loc2_:String = obf_r_8_1121.getParameter(["fc"]);
         if(_loc2_ == "1")
         {
            VersionConfig.enableR2_Free = true;
         }
         GameContext.infConfigInit = true;
      }
      
      private function destroyRoleList() : void
      {
         var r:obf_h_a_2268 = null;
         if(!this.roleList || this.roleList.length == 0)
         {
            return;
         }
         for each(r in this.roleList)
         {
            if(r)
            {
               try
               {
                  r.removeEventListener(MouseEvent.DOUBLE_CLICK,this.obf_0_4_v_452);
                  r.removeEventListener(MouseEvent.CLICK,this.obf_g_9_1354);
               }
               catch(e:Error)
               {
               }
               if(r.parent)
               {
                  r.parent.removeChild(r);
               }
               r.destroy();
            }
         }
      }
      
      public function destroy() : void
      {
         this.destroyRoleList();
         this.removeListener();
      }
   }
}

