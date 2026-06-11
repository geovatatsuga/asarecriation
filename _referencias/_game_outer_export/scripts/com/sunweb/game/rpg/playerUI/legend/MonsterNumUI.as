package com.sunweb.game.rpg.playerUI.legend
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.util.TimeLimiter;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.MonsterNumUIMC;
   
   public class MonsterNumUI extends MonsterNumUIMC implements IPlayerUI
   {
      
      private var timeInv:TimeLimiter = new TimeLimiter(500);
      
      public function MonsterNumUI()
      {
         super();
         this.initDiversity();
         titleBox.mouseEnabled = false;
         this.x = GameContext.gameStage.stageWidth / 2 + GameContext.gameStage.stageWidth / 4;
         this.y = GameContext.gameStage.stageHeight / 2 - GameContext.gameStage.stageHeight / 8;
         this.visible = false;
         cmdClose.visible = false;
         this.addListener();
      }
      
      private function addListener() : void
      {
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
      }
      
      private function removeListener() : void
      {
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
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
      
      private function obf_0_7_H_192(param1:Event) : void
      {
         if(this.timeInv.checkTimeout())
         {
            this.refreshTask();
         }
      }
      
      public function refreshTask() : void
      {
         if(GameContext.currentMap)
         {
            txtMon.htmlText = DiversityManager.getString("MonsterNumUI","txtConMonster",[GameContext.currentMap.monsterSet.size]);
         }
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
         DiversityManager.setTextField(txtDeyTitle,"MonsterNumUI","txtDeyTitle");
         DiversityManager.setTextField(txtDeyMon,"MonsterNumUI","txtDeyMon");
         DiversityManager.setTextField(txtDayRemark,"MonsterNumUI","txtDayRemark");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.addEventListener(Event.ENTER_FRAME,this.obf_0_7_H_192);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.obf_0_7_H_192);
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

