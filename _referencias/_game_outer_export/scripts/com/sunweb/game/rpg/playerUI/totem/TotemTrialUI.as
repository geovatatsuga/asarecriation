package com.sunweb.game.rpg.playerUI.totem
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.totem.obf_J_w_1685;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.TotemTrialUIMC;
   
   public class TotemTrialUI extends TotemTrialUIMC implements IPlayerUI
   {
      
      public function TotemTrialUI()
      {
         super();
         this.visible = false;
         this.initDiversity();
         this.addListener();
      }
      
      private function addListener() : void
      {
         cmdEnter.addEventListener(MouseEvent.CLICK,this.onEnter);
         cmdEnter.addEventListener(MouseEvent.MOUSE_OVER,this.obf_G_k_3294);
         cmdEnter.addEventListener(MouseEvent.MOUSE_OUT,this.obf_6_b_2643);
      }
      
      private function removeListener() : void
      {
         cmdEnter.removeEventListener(MouseEvent.CLICK,this.onEnter);
         cmdEnter.addEventListener(MouseEvent.MOUSE_OVER,this.obf_G_k_3294);
         cmdEnter.addEventListener(MouseEvent.MOUSE_OUT,this.obf_6_b_2643);
      }
      
      private function onEnter(param1:Event) : void
      {
         if(!obf_J_w_1685.isOpen)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("TotemTrialUI","noActivation"));
            return;
         }
         if(GameContext.currentMap.mapId == "z64")
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("TotemTrialUI","currMap"));
            return;
         }
         if(!ConditionScript.checkCondition(obf_J_w_1685.obf_R_I_2427,null,true))
         {
            return;
         }
         if(GameContext.localPlayer.fullInfo.level < obf_J_w_1685.playerLv)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("TotemTrialUI","maxLv"));
            return;
         }
         obf_J_w_1685.sendEnterMapRequest();
      }
      
      private function obf_G_k_3294(param1:MouseEvent) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("totemTrialUITip");
         var _loc3_:int = 150;
         var _loc4_:String = DiversityManager.getString("TotemTrialUI","cmdEnter2");
         _loc2_.addTipInfo(_loc4_,_loc3_,0);
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_6_b_2643(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("totemTrialUITip");
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         cmdEnter.label = DiversityManager.getString("TotemTrialUI","cmdEnter");
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

