package com.sunweb.game.rpg.playerUI.mail
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.mail.obf_G_6_4257;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import playerUI.MailSendUIMC;
   
   public class MailSendUI extends MailSendUIMC implements IPlayerUI
   {
      
      private var obf_V_t_3465:int;
      
      public function MailSendUI()
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
         DiversityManager.setTextField(txtDeyTitle,"MailSendUI","txtTitle");
         DiversityManager.setTextField(txtDeyMailTitle,"MailSendUI","txtMailTitle");
         DiversityManager.setTextField(txtDeyTarget,"MailSendUI","txtTarget");
         cmdSend.label = DiversityManager.getString("MailSendUI","cmdSend");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdSend.addEventListener(MouseEvent.CLICK,this.onClickSend);
         inputTarget.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputTitle.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         txtContent.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputTarget.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputTitle.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         txtContent.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdSend.removeEventListener(MouseEvent.CLICK,this.onClickSend);
         inputTarget.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputTitle.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         txtContent.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputTarget.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputTitle.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         txtContent.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
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
      
      private function obf_m_I_3657(param1:KeyboardEvent) : void
      {
         param1.stopPropagation();
      }
      
      public function setSendMailType(param1:int, param2:String) : void
      {
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         this.obf_V_t_3465 = param1;
         inputTarget.text = param2;
         inputTarget.editable = param1 == obf_G_6_4257.obf_0_9_5_629;
         if(param1 == obf_G_6_4257.obf_0_9_5_629)
         {
            _loc3_ = WorldConfig.getObjectSetting("playerMailCond");
         }
         else if(param1 == obf_G_6_4257.obf_p_U_3894)
         {
            _loc3_ = WorldConfig.getObjectSetting("familyMailCond");
         }
         if(_loc3_)
         {
            _loc4_ = "";
            for(_loc5_ in _loc3_)
            {
               _loc4_ += ConditionScript.getConditionHTML(_loc5_,_loc3_[_loc5_]);
            }
            txtCost.htmlText = _loc4_;
         }
      }
      
      public function clearContent() : void
      {
         inputTitle.text = "";
         inputTarget.text = "";
         txtContent.text = "";
         this.obf_V_t_3465 = 0;
      }
      
      private function onClickSend(param1:Event) : void
      {
         var _loc2_:Object = null;
         if(obf_L_l_4100.isEmpty(inputTarget.text))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("MailSendUI","prompt_mustTarget"));
            return;
         }
         if(obf_L_l_4100.isEmpty(inputTitle.text))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("MailSendUI","prompt_mustMailTitle"));
            return;
         }
         if(obf_L_l_4100.isEmpty(txtContent.text))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("MailSendUI","prompt_mustMailContent"));
            return;
         }
         if(this.obf_V_t_3465 == obf_G_6_4257.obf_0_9_5_629)
         {
            _loc2_ = WorldConfig.getObjectSetting("playerMailCond");
         }
         else if(this.obf_V_t_3465 == obf_G_6_4257.obf_p_U_3894)
         {
            _loc2_ = WorldConfig.getObjectSetting("familyMailCond");
         }
         if(!ConditionScript.checkCondition(_loc2_,null,true))
         {
            return;
         }
         obf_G_6_4257.sendMail(inputTarget.text,this.obf_V_t_3465,inputTitle.text,txtContent.text);
         this.onClose(null);
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
         this.clearContent();
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

