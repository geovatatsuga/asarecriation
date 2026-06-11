package com.sunweb.game.rpg.module
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.ui.IModalWindow;
   import com.sunweb.game.ui.WindowManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.PasswordChangeUIMC;
   
   public class PasswordChangeBox extends PasswordChangeUIMC implements IModalWindow
   {
      
      private var _par:Object;
      
      public function PasswordChangeBox(param1:Object)
      {
         super();
         this.initDiversity();
         this._par = param1;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"PasswordChangeBox","title");
         DiversityManager.setTextField(txtDeyOldPassword,"PasswordChangeBox","txtOldPass");
         DiversityManager.setTextField(txtDeyNewPassword1,"PasswordChangeBox","txtNewPass");
         DiversityManager.setTextField(txtDeyNewPassword2,"PasswordChangeBox","txtNewPass2");
         cmdOK.label = DiversityManager.getString("PasswordChangeBox","cmdOK");
         cmdCancel.label = DiversityManager.getString("PasswordChangeBox","cmdCancel");
      }
      
      private function addListener() : void
      {
         cmdOK.addEventListener(MouseEvent.CLICK,this.onClickOK);
         cmdCancel.addEventListener(MouseEvent.CLICK,this.obf_0_5_T_141);
      }
      
      private function removeListener() : void
      {
         cmdOK.removeEventListener(MouseEvent.CLICK,this.onClickOK);
         cmdCancel.removeEventListener(MouseEvent.CLICK,this.obf_0_5_T_141);
      }
      
      private function onClickOK(param1:Event) : void
      {
         WindowManager.closeWindow(this);
      }
      
      private function obf_0_5_T_141(param1:Event) : void
      {
         inputOldPassword.text = "";
         inputNewPassword1.text = "";
         inputNewPassword2.text = "";
         WindowManager.closeWindow(this);
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
      
      public function get returnValue() : Object
      {
         return {
            "oldPassword":inputOldPassword.text,
            "newPassword":inputNewPassword1.text,
            "newPassword2":inputNewPassword2.text,
            "par":this._par
         };
      }
   }
}

