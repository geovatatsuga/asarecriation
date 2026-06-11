package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.shop.ShopManager;
   import com.sunweb.game.ui.IWindow;
   import com.sunweb.game.ui.WindowManager;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import playerUI.SplitBoxUIMC;
   
   public class SplitBoxUI extends SplitBoxUIMC implements IPlayerUI, IWindow
   {
      
      public static const obf_Q_T_4344:String = "price_mode_gold";
      
      public static const obf_x_x_1366:String = "price_mode_money";
      
      public static const obf_Y_z_2955:String = "price_mode_coin";
      
      private var doneFun:Function;
      
      private var doneFunPara:Array;
      
      private var countMin:int;
      
      private var countMax:int;
      
      private var countValue:int;
      
      private var obf_4_b_3131:String;
      
      private var _itemPrice:int;
      
      public function SplitBoxUI(param1:Function, param2:Array, param3:int = 1, param4:int = 1, param5:String = "", param6:int = 0)
      {
         super();
         this.initDiversity();
         this.doneFun = param1;
         this.doneFunPara = param2;
         this.countMin = param3;
         this.countMax = param4;
         this.countValue = this.countMin;
         this.obf_4_b_3131 = param5;
         this._itemPrice = param6;
         this.checkInputValue(this.countValue);
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         cmdOK.label = DiversityManager.getString("InputBox","ok");
         cmdCancle.label = DiversityManager.getString("InputBox","cancel");
      }
      
      private function addListener() : void
      {
         this.bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         cmdLeft.addEventListener(MouseEvent.CLICK,this.onClickLeft);
         cmdRight.addEventListener(MouseEvent.CLICK,this.onClickRight);
         cmdOK.addEventListener(MouseEvent.CLICK,this.onClickOK);
         cmdCancle.addEventListener(MouseEvent.CLICK,this.onClickCancle);
         txtInput.addEventListener(Event.CHANGE,this.onInputValue);
         txtInput.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         txtInput.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
      }
      
      private function removeListener() : void
      {
         this.bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         this.removeEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         try
         {
            this.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         }
         catch(e:Error)
         {
         }
         cmdLeft.removeEventListener(MouseEvent.CLICK,this.onClickLeft);
         cmdRight.removeEventListener(MouseEvent.CLICK,this.onClickRight);
         cmdOK.removeEventListener(MouseEvent.CLICK,this.onClickOK);
         cmdCancle.removeEventListener(MouseEvent.CLICK,this.onClickCancle);
         txtInput.removeEventListener(Event.CHANGE,this.onInputValue);
         txtInput.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         txtInput.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
      }
      
      private function onAddToStage(param1:Event) : void
      {
         this.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this.x = this.stage.mouseX;
         this.y = this.stage.mouseY;
      }
      
      private function obf_m_I_3657(param1:Event) : void
      {
         param1.stopPropagation();
      }
      
      private function checkInputValue(param1:int) : void
      {
         var _loc2_:DisplayObject = null;
         if(param1 < this.countMin)
         {
            param1 = this.countMin;
         }
         else if(param1 > this.countMax)
         {
            param1 = this.countMax;
         }
         this.countValue = param1;
         txtInput.text = param1 + "";
         while(goldPoint.numChildren > 0)
         {
            goldPoint.removeChildAt(0);
         }
         if(this.obf_4_b_3131 == obf_Q_T_4344)
         {
            _loc2_ = obf_a_f_2935.getGoldDisplay(this.countValue * this._itemPrice);
         }
         else if(this.obf_4_b_3131 == obf_x_x_1366)
         {
            _loc2_ = obf_a_f_2935.getMoneyDisplay(this.countValue * this._itemPrice);
         }
         else if(this.obf_4_b_3131 == obf_Y_z_2955)
         {
            _loc2_ = obf_a_f_2935.getCoinDisplay(this.countValue * this._itemPrice);
         }
         if(_loc2_)
         {
            _loc2_.x = -(_loc2_.width / 2);
            goldPoint.addChild(_loc2_);
         }
      }
      
      private function onInputValue(param1:Event) : void
      {
         this.checkInputValue(int(txtInput.text));
      }
      
      private function onClickLeft(param1:Event) : void
      {
         this.checkInputValue(this.countValue - 1);
      }
      
      private function onClickRight(param1:Event) : void
      {
         this.checkInputValue(this.countValue + 1);
      }
      
      private function onClickOK(param1:Event) : void
      {
         if(!this.doneFunPara)
         {
            this.doneFunPara = new Array();
         }
         if(this.doneFun != null)
         {
            ShopManager.obf_8_q_3951 = this.countValue * this._itemPrice;
            this.doneFun.apply(null,this.doneFunPara.concat(this.countValue));
         }
         WindowManager.closeWindow(this);
      }
      
      private function onClickCancle(param1:Event) : void
      {
         WindowManager.closeWindow(this);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function onMouseDown(param1:Event) : void
      {
         if(!this.contains(param1.target as DisplayObject))
         {
            WindowManager.closeWindow(this);
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
         this.doneFun = null;
         this.doneFunPara = null;
         this.removeListener();
      }
   }
}

