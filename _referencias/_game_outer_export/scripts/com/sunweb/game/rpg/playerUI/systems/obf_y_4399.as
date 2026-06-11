package com.sunweb.game.rpg.playerUI.systems
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import playerUI.SystemAlwaysInfoUIMC;
   
   public class obf_y_4399 extends SystemAlwaysInfoUIMC implements IPlayerUI
   {
      
      public function obf_y_4399()
      {
         super();
         this.cacheAsBitmap = true;
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = 200;
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
         this.addEventListener(MouseEvent.CLICK,this.onMouseClick);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:MouseEvent = null;
         var _loc3_:Point = null;
         if(GameContext.currentMap)
         {
            _loc2_ = new MouseEvent(MouseEvent.CLICK,true,false,0,0,null,param1.ctrlKey,param1.altKey,param1.shiftKey);
            _loc3_ = GameContext.currentMap.globalToLocal(new Point(param1.stageX,param1.stageY));
            _loc2_.localX = _loc3_.x;
            _loc2_.localY = _loc3_.y;
            GameContext.currentMap.dispatchEvent(_loc2_);
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
         txtInfo.text = "";
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

