package com.sunweb.game.rpg.module
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.buff.BuffInfo;
   import com.sunweb.game.rpg.buff.BuffManager;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.skill.obf_n_N_4152;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.map.MapManager;
   import com.sunweb.game.ui.IModalWindow;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.RebirthUIMC;
   
   public class obf_y_g_4410 extends RebirthUIMC implements IModalWindow
   {
      
      private var obf_s_n_4517:TimeLimiter = new TimeLimiter(500);
      
      public function obf_y_g_4410()
      {
         super();
         this.initDiversity();
         if(GameContext.localPlayer.fullInfo.level > WorldConfig.getNumberSetting("perfectRebirthFreeLevel"))
         {
            moneyPoint.addChild(obf_a_f_2935.getMoneyDisplay(WorldConfig.getNumberSetting("perfectRebirthMoney")));
         }
         cmdPerfectRebirth.enabled = ConditionScript.checkCondition(WorldConfig.getValue("perfectRebirthCond"));
         if(JSONUtil.getBoolean(MapManager.instance.mapInfo,["rules","commonRule","disablePerfectRebirth"]))
         {
            cmdPerfectRebirth.enabled = false;
         }
         this.addListener();
         this.obf_Z_C_2330();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"RebirthUI","txtTitle");
         DiversityManager.setTextField(txtPrompt,"RebirthUI","prompt",[WorldConfig.getNumberSetting("perfectRebirthFreeLevel")]);
         cmdPerfectRebirth.label = DiversityManager.getString("RebirthUI","cmdPerfectRebirth");
         cmdSkillRebirth.label = DiversityManager.getString("RebirthUI","cmdSkillRebirth");
         cmdRebirth.label = DiversityManager.getString("RebirthUI","cmdRebirth");
      }
      
      private function addListener() : void
      {
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdPerfectRebirth.addEventListener(MouseEvent.CLICK,this.obf_f_5_1753);
         cmdSkillRebirth.addEventListener(MouseEvent.CLICK,this.obf_U_C_2197);
         cmdRebirth.addEventListener(MouseEvent.CLICK,this.obf_k_n_2685);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdPerfectRebirth.removeEventListener(MouseEvent.CLICK,this.obf_f_5_1753);
         cmdSkillRebirth.removeEventListener(MouseEvent.CLICK,this.obf_U_C_2197);
         cmdRebirth.removeEventListener(MouseEvent.CLICK,this.obf_k_n_2685);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      public function obf_Z_C_2330() : void
      {
         var _loc1_:BuffInfo = null;
         var _loc2_:Object = null;
         cmdSkillRebirth.enabled = false;
         txtSkillRebirth.text = "";
         for each(_loc1_ in GameContext.localPlayer.buffList)
         {
            if(_loc1_)
            {
               _loc2_ = BuffManager.getBuffConfigById(_loc1_.buffId);
               if(_loc2_)
               {
                  if(JSONUtil.getBoolean(_loc2_,["isRebirthBuff"]))
                  {
                     txtSkillRebirth.text = _loc2_.buffName;
                     cmdSkillRebirth.enabled = true;
                     break;
                  }
               }
            }
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.obf_s_n_4517.checkTimeout())
         {
            this.obf_Z_C_2330();
         }
      }
      
      private function obf_f_5_1753(param1:Event) : void
      {
         if(GameContext.localPlayer.fullInfo.level > WorldConfig.getNumberSetting("perfectRebirthFreeLevel") && GameContext.localPlayer.fullInfo.money < WorldConfig.getNumberSetting("perfectRebirthMoney"))
         {
            obf_K_e_3075.showShortOfMoney();
            return;
         }
         GameContext.localPlayer.playerRebirthConfirm(obf_n_N_4152.obf_0_0_6_373);
      }
      
      private function obf_U_C_2197(param1:Event) : void
      {
         GameContext.localPlayer.playerRebirthConfirm(obf_n_N_4152.SKILL);
      }
      
      private function obf_k_n_2685(param1:Event) : void
      {
         GameContext.localPlayer.playerRebirthConfirm();
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
      
      public function get returnValue() : Object
      {
         return null;
      }
   }
}

