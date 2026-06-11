package com.sunweb.game.rpg.module
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.ui.IWindow;
   import com.sunweb.game.ui.WindowManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import playerUI.GoldBoxUIMC;
   
   public class obf_o_9_2147 extends GoldBoxUIMC implements IWindow
   {
      
      private var gold:int;
      
      private var _fun:Function;
      
      private var _para:Array;
      
      public function obf_o_9_2147(param1:Function, param2:Array, param3:String = "")
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.mouseX;
         this.y = GameContext.gameStage.mouseY;
         txtTitle.htmlText = param3;
         txtTitle.mouseEnabled = false;
         this._fun = param1;
         this._para = param2;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         cmdOK.label = DiversityManager.getString("InputBox","ok");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdOK.addEventListener(MouseEvent.CLICK,this.onClickOK);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClickClose);
         inputDiamond.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputDiamond.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputSilver.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputSilver.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputGold.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputGold.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputCopper.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputCopper.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdOK.removeEventListener(MouseEvent.CLICK,this.onClickOK);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClickClose);
         inputDiamond.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputDiamond.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputSilver.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputSilver.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputGold.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputGold.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputCopper.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputCopper.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
      }
      
      private function obf_m_I_3657(param1:Event) : void
      {
         param1.stopPropagation();
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function onClickOK(param1:Event) : void
      {
         this.gold = int(inputDiamond.text) * 1000000 + int(inputGold.text) * 10000 + int(inputSilver.text) * 100 + int(inputCopper.text);
         if(this._fun != null)
         {
            this._fun.apply(null,[].concat(this.gold,this._para));
         }
         WindowManager.closeWindow(this);
      }
      
      private function onClickClose(param1:Event) : void
      {
         this.gold = 0;
         WindowManager.closeWindow(this);
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this._fun = null;
         this._para = null;
      }
   }
}

