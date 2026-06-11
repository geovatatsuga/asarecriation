package com.sunweb.game.rpg.playerUI.systems
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.StatusButton;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.obf_9_V_1635;
   import com.sunweb.game.utils.obf_l_y_733;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.SystemTipUIMC;
   
   public class SystemTipUI extends SystemTipUIMC implements IPlayerUI
   {
      
      private var iconSysMsg:StatusButton;
      
      private var iconLocationTag:StatusButton;
      
      private var iconMail:StatusButton;
      
      private var onlineBonusTimeLimit:TimeLimiter;
      
      private var frameTimeInv:TimeLimiter = new TimeLimiter(200);
      
      public function SystemTipUI()
      {
         super();
         this.initDiversity();
         this.disableOnlineBonus();
         this.y = 90;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         obf_9_V_1635.setSimpleButtonTooltip(iconDaysPrompt,DiversityManager.getString("SystemTipUI","daysAct"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdRanking,DiversityManager.getString("SystemTipUI","ranking"));
         this.iconSysMsg = new StatusButton(obf_7_g_3652);
         this.iconSysMsg.obf_S_F_2079 = DiversityManager.getString("SystemTipUI","sysMsg");
         this.iconLocationTag = new StatusButton(obf_0___v_633);
         this.iconLocationTag.obf_S_F_2079 = DiversityManager.getString("SystemTipUI","locationTag");
         this.iconMail = new StatusButton(obf_m_l_4322);
         this.iconMail.obf_S_F_2079 = DiversityManager.getString("SystemTipUI","mail");
      }
      
      private function addListener() : void
      {
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.iconSysMsg.addEventListener(MouseEvent.CLICK,this.obf_5_n_1720);
         iconOnlineBonus.addEventListener(MouseEvent.CLICK,this.obf_0_2_G_443);
         iconDaysPrompt.addEventListener(MouseEvent.CLICK,this.obf_e_0_802);
         this.iconLocationTag.addEventListener(MouseEvent.CLICK,this.obf_Q_u_1916);
         cmdRanking.addEventListener(MouseEvent.CLICK,this.obf_f_E_2982);
         this.iconMail.addEventListener(MouseEvent.CLICK,this.obf_X_q_4051);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.iconSysMsg.removeEventListener(MouseEvent.CLICK,this.obf_5_n_1720);
         iconOnlineBonus.removeEventListener(MouseEvent.CLICK,this.obf_0_2_G_443);
         iconDaysPrompt.removeEventListener(MouseEvent.CLICK,this.obf_e_0_802);
         this.iconLocationTag.removeEventListener(MouseEvent.CLICK,this.obf_Q_u_1916);
         cmdRanking.removeEventListener(MouseEvent.CLICK,this.obf_f_E_2982);
         this.iconMail.removeEventListener(MouseEvent.CLICK,this.obf_X_q_4051);
      }
      
      private function obf_5_n_1720(param1:Event) : void
      {
         obf_K_e_3075.showUI(obf_K_e_3075.obf_L_9_3749);
      }
      
      public function setNewSysmsg(param1:Boolean) : void
      {
         this.iconSysMsg.obf_f_C_851 = param1 ? uint(StatusButton.STATUS_1) : uint(StatusButton.obf_F_z_2485);
      }
      
      public function setLocationTagPrompt(param1:Boolean) : void
      {
         this.iconLocationTag.obf_f_C_851 = param1 ? uint(StatusButton.STATUS_1) : uint(StatusButton.obf_F_z_2485);
      }
      
      public function setMail(param1:Boolean) : void
      {
         this.iconMail.obf_f_C_851 = param1 ? uint(StatusButton.STATUS_1) : uint(StatusButton.obf_F_z_2485);
      }
      
      private function obf_X_q_4051(param1:Event) : void
      {
         obf_K_e_3075.showUI(obf_K_e_3075.mailListUI);
         this.setMail(false);
      }
      
      private function obf_e_0_802(param1:Event) : void
      {
         obf_K_e_3075.showUI(obf_K_e_3075.daysActPromptUI);
      }
      
      private function obf_Q_u_1916(param1:Event) : void
      {
         obf_K_e_3075.showUI(obf_K_e_3075.locationTagUI);
      }
      
      private function obf_f_E_2982(param1:Event) : void
      {
         if(obf_K_e_3075.rankingUI)
         {
            obf_K_e_3075.rankingUI.showRanking("",null);
         }
      }
      
      public function showOnlineBonus(param1:int) : void
      {
         iconOnlineBonus.gotoAndStop(2);
         this.onlineBonusTimeLimit = new TimeLimiter(param1 * 1000);
      }
      
      public function disableOnlineBonus() : void
      {
         iconOnlineBonus.gotoAndStop(1);
         iconOnlineBonus.txtTime.text = "";
         this.onlineBonusTimeLimit = null;
      }
      
      private function obf_q_C_4496() : void
      {
         if(!this.onlineBonusTimeLimit)
         {
            return;
         }
         if(this.onlineBonusTimeLimit.totalTimeInMS < this.onlineBonusTimeLimit.timelimit)
         {
            iconOnlineBonus.txtTime.text = obf_l_y_733.getTimeStringHHMMSS(this.onlineBonusTimeLimit.timelimit - this.onlineBonusTimeLimit.totalTimeInMS);
         }
         else
         {
            DiversityManager.setTextField(iconOnlineBonus.txtTime,"OnlineBonusUI","canGetBonus",null,true);
            iconOnlineBonus.gotoAndStop(3);
         }
      }
      
      private function obf_0_2_G_443(param1:Event) : void
      {
         if(!this.onlineBonusTimeLimit || this.onlineBonusTimeLimit.totalTimeInMS < this.onlineBonusTimeLimit.timelimit)
         {
            return;
         }
         if(obf_K_e_3075.onlineBonusUI)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.onlineBonusUI);
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.frameTimeInv.checkTimeout())
         {
            this.obf_q_C_4496();
         }
      }
      
      public function get mouseOn() : Boolean
      {
         return false;
      }
      
      public function showUI() : void
      {
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

