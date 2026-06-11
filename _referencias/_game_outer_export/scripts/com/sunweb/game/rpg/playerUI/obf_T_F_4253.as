package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.GameContext;
   import flash.events.Event;
   import playerUI.ExpBarUIMC;
   
   public class obf_T_F_4253 extends ExpBarUIMC implements IPlayerUI
   {
      
      public function obf_T_F_4253()
      {
         super();
         this.gotoAndStop(100);
         this.visible = false;
         this.onResize(null);
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
      }
      
      private function addListener() : void
      {
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
      }
      
      private function removeListener() : void
      {
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight - 6;
      }
      
      public function setExp(param1:Number, param2:Number) : void
      {
         var _loc3_:int = param1 / param2 * 100;
         this.gotoAndStop(_loc3_);
         txtExp.text = uint(param1) + " / " + uint(param2) + " (" + Number(param1 / param2 * 100).toFixed(2) + "%)";
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

