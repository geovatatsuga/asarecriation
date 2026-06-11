package com.sunweb.game.rpg.playerUI.mapWrapper
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.script.DynamicVars;
   import com.sunweb.game.rpg.world.map.MapManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_l_y_733;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.CopyWorldInfoUIMC;
   
   public class CopyWorldInfoUI extends CopyWorldInfoUIMC implements IPlayerUI
   {
      
      private var obf_p_H_3325:String;
      
      private var timeInv:TimeLimiter = new TimeLimiter(500);
      
      public function CopyWorldInfoUI()
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2 + GameContext.gameStage.stageWidth / 4;
         this.y = GameContext.gameStage.stageHeight / 2 - GameContext.gameStage.stageHeight / 8;
         this.visible = false;
         this.alpha = 0.9;
         this.addListener();
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtTitle,"CopyWorldInfoUI","txtTitle");
         DiversityManager.setTextField(txtTimeTitle,"CopyWorldInfoUI","txtTimeTitle");
         DiversityManager.setTextField(txtMonsterTitle,"CopyWorldInfoUI","txtMonsterTitle");
         DiversityManager.setTextField(txtInfoTitle,"CopyWorldInfoUI","txtInfoTitle");
      }
      
      private function addListener() : void
      {
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
      }
      
      private function removeListener() : void
      {
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
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
         var _loc1_:int = 0;
         if(GameContext.currentMap)
         {
            txtMonster.htmlText = GameContext.currentMap.monsterSet.size + "";
         }
         if(this.obf_p_H_3325)
         {
            _loc1_ = DynamicVars.mapVar.getIntVar(this.obf_p_H_3325);
            txtTime.text = obf_l_y_733.getTimeStringHHMMSS(_loc1_ * 1000);
         }
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
         this.alpha = 0.5;
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
         this.alpha = 0.9;
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
      
      public function showUI() : void
      {
         this.obf_p_H_3325 = JSONUtil.getStr(MapManager.instance.mapInfo,["rules","copyInfoRule","leaveTimeVar"]);
         txtInfo.htmlText = JSONUtil.getStr(MapManager.instance.mapInfo,["rules","copyInfoRule","copyInfo"]);
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
      }
   }
}

