package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import flash.events.Event;
   import playerUI.SpBarUIMC;
   
   public class obf_L_W_1229 extends SpBarUIMC implements IPlayerUI
   {
      
      public function obf_L_W_1229()
      {
         super();
         this.gotoAndStop(1);
         this.onResize(null);
         addSpNumber.mouseChildren = false;
         addSpNumber.mouseEnabled = false;
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
         obf_K_e_3075.addUIMouseToolTip(txtSP,"SingeSP");
      }
      
      private function removeListener() : void
      {
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         obf_K_e_3075.removeUIMouseToolTip(txtSP);
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight - 10;
      }
      
      public function refresh() : void
      {
         var _loc1_:int = GameContext.localPlayer.fullInfo.attributes.sp / GameContext.localPlayer.fullInfo.attributes.spMax * 100;
         this.gotoAndStop(_loc1_);
         txtSP.text = GameContext.localPlayer.fullInfo.attributes.sp + "/" + GameContext.localPlayer.fullInfo.attributes.spMax;
      }
      
      public function showAddSpEffect(param1:int) : void
      {
         addSpEffect.gotoAndPlay(1);
         var _loc2_:String = param1 > 0 ? "+" + param1 : param1 + "";
         addSpNumber.gotoAndPlay(1);
         addSpNumber.txtSp.text = _loc2_;
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
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

