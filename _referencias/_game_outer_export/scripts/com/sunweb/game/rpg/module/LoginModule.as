package com.sunweb.game.rpg.module
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.loginZone.obf_b_S_2328;
   import com.sunweb.game.rpg.loginZone.obf_o_V_2653;
   import com.sunweb.game.rpg.world.ui.MouseCursor;
   import com.sunweb.game.ui.IWindow;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.obf_e_P_918;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.net.SharedObject;
   import flash.ui.Keyboard;
   import mmorpg.LoginUI;
   
   public class LoginModule extends LoginUI implements IWindow
   {
      
      public function LoginModule()
      {
         var _loc1_:SharedObject = null;
         super();
         if(!GameContext.isSso())
         {
            _loc1_ = SharedObject.getLocal("Sunweb.Rpg.LocalAccount.SOMC");
            if(_loc1_.data.account)
            {
               txtUser.text = _loc1_.data.account + "";
               chkRemember.selected = true;
            }
            else
            {
               chkRemember.selected = false;
            }
         }
         this.initDiversity();
         this.addListeners();
         obf_e_P_918.useCursor(MouseCursor.CURSOR_DEFAULT);
         if(GameContext.isSso())
         {
            visible = false;
            this.submit();
         }
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         chkRemember.label = DiversityManager.getString("LoginPage","chkRemember");
         DiversityManager.setTextField(txtDeyLogin,"LoginPage","cmdLogin");
      }
      
      private function addListeners() : void
      {
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         cmdLogin.addEventListener(MouseEvent.CLICK,this.onClickSubmit);
         txtPassword.addEventListener(KeyboardEvent.KEY_DOWN,this.onEnterSubmit);
         txtUser.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_D_Z_1301);
         if(GameContext.loginClient == null)
         {
            GameContext.loginClient = new obf_b_S_2328(GameContext.loginServerIP,GameContext.loginServerPort);
         }
         GameContext.loginClient.addEventListener(obf_o_V_2653.obf_u_T_3112,this.onLoginOk);
         GameContext.loginClient.addEventListener(obf_o_V_2653.obf_k_u_2062,this.onLoginFailed);
      }
      
      private function removeListeners() : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         cmdLogin.removeEventListener(MouseEvent.CLICK,this.onClickSubmit);
         txtPassword.removeEventListener(KeyboardEvent.KEY_DOWN,this.onEnterSubmit);
         txtUser.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_D_Z_1301);
         GameContext.loginClient.removeEventListener(obf_o_V_2653.obf_u_T_3112,this.onLoginOk);
         GameContext.loginClient.removeEventListener(obf_o_V_2653.obf_k_u_2062,this.onLoginFailed);
      }
      
      private function onAddToStage(param1:Event) : void
      {
         this.x = this.stage.stageWidth / 2;
         this.y = this.stage.stageHeight / 2;
      }
      
      private function onEnterSubmit(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            this.submit();
         }
      }
      
      private function obf_D_Z_1301(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            txtPassword.focusManager.setFocus(txtPassword);
         }
      }
      
      private function onClickSubmit(param1:Event) : void
      {
         this.submit();
      }
      
      private function submit() : void
      {
         var _loc1_:SharedObject = null;
         GameContext.loadPolicyFile(GameContext.loginServerIP);
         if(!GameContext.isSso())
         {
            if(txtUser.text == "" || txtPassword.text == "")
            {
               WindowManager.showModalWindow(new MessageBoxModule(DiversityManager.getString("LoginPage","promptNoAccORPass")),null,true);
               return;
            }
            _loc1_ = SharedObject.getLocal("Sunweb.Rpg.LocalAccount.SOMC");
            if(chkRemember.selected)
            {
               _loc1_.data.account = txtUser.text;
            }
            else
            {
               _loc1_.data.account = "";
            }
            _loc1_.flush();
            cmdLogin.enabled = false;
            GameContext.obf_0_7_r_135 = txtUser.text;
            GameContext.loginClient.obf_m_L_3878(txtUser.text,txtPassword.text);
         }
         else
         {
            GameContext.loginClient.obf_m_L_3878(GameContext.sso,"");
         }
         WindowManager.showMessageBox(DiversityManager.getString("SystemPrompt","connecting"),null,"connectServer",true);
      }
      
      private function onLoginOk(param1:obf_o_V_2653) : void
      {
         WindowManager.closeWindow(WindowManager.getModalWindowByName("connectServer") as IWindow);
         WindowManager.closeWindow(this);
         WindowManager.showWindow(new ServerListModule());
      }
      
      private function onLoginFailed(param1:obf_o_V_2653) : void
      {
         WindowManager.closeWindow(WindowManager.getModalWindowByName("connectServer") as IWindow);
         cmdLogin.enabled = true;
         txtPassword.focusManager.setFocus(txtPassword);
         WindowManager.showMessageBox(DiversityManager.getString("LoginPage","promptLoginFailed",[param1.failureReason]),GameContext.ssoFailed);
      }
      
      public function destroy() : void
      {
         this.removeListeners();
      }
   }
}

