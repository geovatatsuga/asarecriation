package com.sunweb.game.rpg.loginZone
{
   import obf_o_M_4577.obf_0_4_A_326;
   import obf_o_M_4577.obf_l_N_3214;
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.loginZone.command.CommandCodeLogin;
   import com.sunweb.game.rpg.loginZone.command.LoginAnswer;
   import com.sunweb.game.rpg.loginZone.command.LoginRequest;
   import com.sunweb.game.rpg.loginZone.command.LogoutAnswer;
   import com.sunweb.game.rpg.loginZone.command.LogoutRequest;
   import com.sunweb.game.rpg.loginZone.command.ServerListAnswer;
   import com.sunweb.game.rpg.loginZone.command.ServerListRequest;
   import com.sunweb.game.rpg.loginZone.command.WelcomeNotify;
   import com.sunweb.game.util.obf_m_V_1111;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.events.EventDispatcher;
   
   public class obf_b_S_2328 extends EventDispatcher
   {
      
      private var _netClient:obf_0_4_A_326;
      
      private var _host:String = "127.0.0.1";
      
      private var _port:int = 9999;
      
      private var _user:String;
      
      private var obf_0_8_L_150:String;
      
      private var _sessionId:String;
      
      private var _lastLoginSuccessAnswer:LoginAnswer;
      
      public function obf_b_S_2328(param1:String, param2:int)
      {
         super();
         this._host = param1;
         this._port = param2;
         this._netClient = new obf_0_4_A_326(this._host,this._port);
         this._netClient.addEventListener(obf_l_N_3214.obf_R_4392,this.netEventHandler);
         this._netClient.addEventListener(obf_l_N_3214.obf_r_H_4569,this.netEventHandler);
         this._netClient.addEventListener(obf_l_N_3214.obf_N_7_3895,this.netEventHandler);
         this._netClient.addEventListener(obf_l_N_3214.obf_m_x_2716,this.netEventHandler);
         this._netClient.commandSet.addCommandClasses([WelcomeNotify,LoginRequest,LoginAnswer,LogoutRequest,LogoutAnswer,ServerListRequest,ServerListAnswer]);
      }
      
      public function get user() : String
      {
         return this._user;
      }
      
      public function get sessionId() : String
      {
         return this._sessionId;
      }
      
      public function getServerList() : void
      {
         if(!this._netClient.isConnected)
         {
            return;
         }
         this._netClient.sendCommand(new ServerListRequest());
      }
      
      public function obf_m_L_3878(param1:String, param2:String) : void
      {
         trace("connecting ...");
         this._user = param1;
         this.obf_0_8_L_150 = param2;
         this._netClient.connect();
      }
      
      public function logout() : void
      {
         this._netClient.sendCommand(new LogoutRequest());
      }
      
      public function close() : void
      {
         this._netClient.close();
      }
      
      public function obf_0_8_j_269() : void
      {
      }
      
      private function netEventHandler(param1:obf_l_N_3214) : void
      {
         var _loc2_:obf_o_V_2653 = null;
         var _loc3_:obf_o_V_2653 = null;
         var _loc4_:obf_C_m_1350 = null;
         if(param1.type != obf_l_N_3214.obf_R_4392)
         {
            if(param1.type == obf_l_N_3214.obf_r_H_4569)
            {
               _loc2_ = new obf_o_V_2653(obf_o_V_2653.obf_k_u_2062);
               _loc2_.failureReason = DiversityManager.getString("SystemPrompt","connect_failure");
               dispatchEvent(_loc2_);
            }
            else if(param1.type == obf_l_N_3214.obf_N_7_3895)
            {
               _loc3_ = new obf_o_V_2653(obf_o_V_2653.obf_0___R_732);
               _loc3_.failureReason = DiversityManager.getString("SystemPrompt","disconnected");
               dispatchEvent(_loc3_);
            }
            else if(param1.type == obf_l_N_3214.obf_m_x_2716)
            {
               _loc4_ = param1.command;
               this.onCommand(_loc4_);
            }
            else
            {
               trace("unkown event:" + param1.type);
            }
         }
      }
      
      private function onCommand(param1:obf_C_m_1350) : void
      {
         var _loc2_:LoginRequest = null;
         if(param1.code == CommandCodeLogin.ACCOUNT_WELCOME_NOTIFY)
         {
            _loc2_ = new LoginRequest();
            _loc2_.user = this._user;
            _loc2_.password = obf_L_l_4100.isEmpty(this.obf_0_8_L_150) ? "" : obf_m_V_1111.md5Str((param1 as WelcomeNotify).key + this.obf_0_8_L_150);
            this._netClient.sendCommand(_loc2_);
         }
         else if(param1.code == CommandCodeLogin.ACCOUNT_LOGIN_ANSWER)
         {
            this.obf_0___N_138(param1 as LoginAnswer);
         }
         else if(param1.code == CommandCodeLogin.ACCOUNT_LOGOUT_ANSWER)
         {
            this.obf_S_q_2111(param1 as LogoutAnswer);
         }
         else if(param1.code == CommandCodeLogin.SERVER_LIST_ANSWER)
         {
            this.obf_q_V_2854(param1 as ServerListAnswer);
         }
      }
      
      private function obf_0___N_138(param1:LoginAnswer) : void
      {
         var _loc2_:obf_o_V_2653 = null;
         if(param1.sessionId == null || param1.sessionId == "")
         {
            _loc2_ = new obf_o_V_2653(obf_o_V_2653.obf_k_u_2062);
            _loc2_.failureReason = param1.failureReason;
            dispatchEvent(_loc2_);
            this._netClient.close();
         }
         else
         {
            this._lastLoginSuccessAnswer = param1;
            this._sessionId = param1.sessionId;
            _loc2_ = new obf_o_V_2653(obf_o_V_2653.obf_u_T_3112);
            _loc2_.sessionId = param1.sessionId;
            dispatchEvent(_loc2_);
         }
      }
      
      private function obf_S_q_2111(param1:LogoutAnswer) : void
      {
         var _loc2_:obf_o_V_2653 = new obf_o_V_2653(obf_o_V_2653.obf_d_t_3108);
         _loc2_.sessionId = param1.sessionId;
         dispatchEvent(_loc2_);
      }
      
      private function obf_q_V_2854(param1:ServerListAnswer) : void
      {
         var _loc2_:obf_o_V_2653 = new obf_o_V_2653(obf_o_V_2653.obf_0_7_T_404);
         _loc2_.sessionId = this._sessionId;
         _loc2_.serverList = param1.serverList;
         _loc2_.selectedServer = param1.selectedServer;
         dispatchEvent(_loc2_);
      }
   }
}

