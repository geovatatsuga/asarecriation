package com.sunweb.game.rpg.playerUI.mail
{
   import obf_g_A_3629.obf_r_Y_1874;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.mail.MailContentInfo;
   import com.sunweb.game.rpg.mail.obf_G_6_4257;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import playerUI.MailViewUIMC;
   
   public class MailViewUI extends MailViewUIMC implements IPlayerUI
   {
      
      private var obf_0_6_U_574:int;
      
      private var obf_c_E_1280:String;
      
      public function MailViewUI()
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"MailViewUI","txtTitle");
         DiversityManager.setTextField(txtDeyMailTitle,"MailViewUI","txtMailTitle");
         DiversityManager.setTextField(txtDeySender,"MailViewUI","txtMailSender");
         DiversityManager.setTextField(txtDeyDate,"MailViewUI","txtMailDate");
         DiversityManager.setTextField(txtDeyContent,"MailViewUI","txtMailContent");
         cmdReply.label = DiversityManager.getString("MailViewUI","cmdReply");
         cmdDelete.label = DiversityManager.getString("MailViewUI","cmdDelete");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         txtSender.addEventListener(TextEvent.LINK,this.obf_8_N_2134);
         cmdDelete.addEventListener(MouseEvent.CLICK,this.obf_S_X_2204);
         cmdReply.addEventListener(MouseEvent.CLICK,this.obf_Z_F_2035);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         txtSender.removeEventListener(TextEvent.LINK,this.obf_8_N_2134);
         cmdDelete.removeEventListener(MouseEvent.CLICK,this.obf_S_X_2204);
         cmdReply.removeEventListener(MouseEvent.CLICK,this.obf_Z_F_2035);
      }
      
      private function obf_8_N_2134(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      private function obf_S_X_2204(param1:Event) : void
      {
         WindowManager.showConfirmBox(DiversityManager.getString("MailListUI","prompt_DeleteConfirm"),this.confirmDelete,this.obf_0_6_U_574);
      }
      
      private function confirmDelete(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_G_6_4257.sendDeleteMail(param1.par);
            obf_K_e_3075.closeUI(this);
         }
      }
      
      private function obf_Z_F_2035(param1:Event) : void
      {
         if(obf_L_l_4100.isEmpty(this.obf_c_E_1280))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("MailViewUI","prompt_contReplySysMail"));
            return;
         }
         obf_G_6_4257.showSendMailUI(obf_G_6_4257.obf_0_9_5_629,this.obf_c_E_1280);
      }
      
      public function obf_M_Y_822() : void
      {
         txtMailTitle.text = "";
         txtSender.text = "";
         txtDate.text = "";
         txtContent.htmlText = "";
         this.obf_0_6_U_574 = 0;
      }
      
      public function setMailContent(param1:MailContentInfo) : void
      {
         var _loc2_:String = null;
         this.obf_0_6_U_574 = param1.mailId;
         this.obf_c_E_1280 = param1.sender;
         txtMailTitle.text = param1.mailTitle;
         txtDate.text = param1.mailDate;
         if(obf_L_l_4100.isEmpty(this.obf_c_E_1280))
         {
            txtSender.htmlText = "<font color=\'#FF0000\'>" + DiversityManager.getString("CommonPrompt","system") + "</font>";
            txtContent.htmlText = param1.mailContent;
         }
         else
         {
            txtSender.htmlText = obf_7_6_4416.getRoleLinkA(param1.sender);
            txtContent.text = obf_r_Y_1874.replaceText(param1.mailContent);
         }
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
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
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.obf_M_Y_822();
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

