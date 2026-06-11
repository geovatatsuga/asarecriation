package com.sunweb.game.rpg.playerUI
{
   import obf_g_A_3629.ChatDecoder;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.util.TimeLimiter;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import playerUI.GameSystemInfoUIMC;
   
   public class obf_0_8_2_554 extends GameSystemInfoUIMC implements IPlayerUI
   {
      
      private var allMsg:Array = new Array();
      
      private var maxInfoCount:int = 50;
      
      private var clickToMap:Boolean;
      
      private var showTimeInv:TimeLimiter = new TimeLimiter(500);
      
      private var hideTime:TimeLimiter;
      
      private var obf_J_r_1849:TimeLimiter = new TimeLimiter(30000);
      
      public function obf_0_8_2_554()
      {
         super();
         bgBox.visible = false;
         scrollInfo.visible = false;
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
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.addEventListener(MouseEvent.CLICK,this.onMouseClick);
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         txtInfo.addEventListener(TextEvent.LINK,this.onClickLink);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         txtInfo.removeEventListener(TextEvent.LINK,this.onClickLink);
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth;
         this.y = GameContext.gameStage.stageHeight - 70;
      }
      
      private function onMouseOver(param1:Event) : void
      {
         bgBox.visible = true;
         scrollInfo.visible = true;
      }
      
      private function onMouseOut(param1:Event) : void
      {
         bgBox.visible = false;
         scrollInfo.visible = false;
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:MouseEvent = null;
         var _loc3_:Point = null;
         if(Boolean(GameContext.currentMap) && this.clickToMap)
         {
            _loc2_ = new MouseEvent(MouseEvent.CLICK,true,false,0,0,null,param1.ctrlKey,param1.altKey,param1.shiftKey);
            _loc3_ = GameContext.currentMap.globalToLocal(new Point(param1.stageX,param1.stageY));
            _loc2_.localX = _loc3_.x;
            _loc2_.localY = _loc3_.y;
            GameContext.currentMap.dispatchEvent(_loc2_);
         }
         this.clickToMap = true;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.showTimeInv.checkTimeout())
         {
            if(new Rectangle(bgBox.x,bgBox.y,bgBox.width,bgBox.height).contains(this.mouseX,this.mouseY))
            {
               this.visible = true;
               this.hideTime = new TimeLimiter(5000);
            }
         }
         if(Boolean(this.hideTime) && this.hideTime.checkTimeout())
         {
            this.hideTime = null;
            this.visible = false;
         }
         if(this.allMsg.length > this.maxInfoCount && this.obf_J_r_1849.checkTimeout())
         {
            this.obf_L_e_1857();
         }
      }
      
      private function onClickLink(param1:TextEvent) : void
      {
         this.clickToMap = false;
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      public function receiveMsg(param1:String, param2:String) : void
      {
         this.visible = true;
         this.hideTime = new TimeLimiter(5000);
         param1 = param2 + ":" + ChatDecoder.decode(param1) + "<BR>";
         this.allMsg.push(param1);
         this.addMsgToShow(param1);
      }
      
      private function obf_L_e_1857() : void
      {
         var _loc2_:String = null;
         if(this.allMsg.length <= this.maxInfoCount)
         {
            return;
         }
         this.allMsg.splice(0,this.allMsg.length - this.maxInfoCount);
         var _loc1_:String = "";
         for each(_loc2_ in this.allMsg)
         {
            _loc1_ += _loc2_;
         }
         txtInfo.htmlText = "";
         this.addMsgToShow(_loc1_);
      }
      
      private function addMsgToShow(param1:String) : void
      {
         var _loc2_:Boolean = txtInfo.scrollV == txtInfo.maxScrollV;
         txtInfo.htmlText += param1;
         if(_loc2_)
         {
            txtInfo.scrollV = txtInfo.maxScrollV;
         }
         scrollInfo.update();
      }
      
      public function get mouseOn() : Boolean
      {
         return false;
      }
      
      public function showUI() : void
      {
      }
      
      public function closeUI() : void
      {
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this.allMsg = null;
      }
   }
}

