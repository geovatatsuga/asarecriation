package com.sunweb.game.rpg.module
{
   import obf_g_A_3629.obf_r_Y_1874;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.IModalWindow;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import mmorpg.InputAreaUIMC;
   
   public class obf_w_h_3726 extends InputAreaUIMC implements IModalWindow
   {
      
      private var _par:*;
      
      private var obf_x_Y_4361:int;
      
      private var obf_B_8_1456:Boolean;
      
      public function obf_w_h_3726(param1:String, param2:int = 0, param3:* = null, param4:Boolean = false)
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         txtPrompt.htmlText = param1;
         this.obf_x_Y_4361 = param2;
         this.obf_B_8_1456 = param4;
         this._par = param3;
         txtInput.text = "";
         if(param2 > 0)
         {
            txtInput.maxChars = param2;
         }
         cmdOK.addEventListener(MouseEvent.CLICK,this.onClickOK);
         cmdCancel.addEventListener(MouseEvent.CLICK,this.onClickCancle);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClickCancle);
         txtInput.addEventListener(MouseEvent.CLICK,this.include);
         txtInput.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_7_9_1915);
         txtInput.addEventListener(KeyboardEvent.KEY_UP,this.obf_7_9_1915);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"InputBox","title");
         cmdOK.label = DiversityManager.getString("InputBox","ok");
         cmdCancel.label = DiversityManager.getString("InputBox","cancel");
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function obf_7_9_1915(param1:Event) : void
      {
         param1.stopPropagation();
      }
      
      private function onClickOK(param1:Event) : void
      {
         if(this.obf_x_Y_4361 > 0 && txtInput.text.length > this.obf_x_Y_4361)
         {
            WindowManager.showMessageBox(DiversityManager.getString("InputBox","inputTooLong",[this.obf_x_Y_4361]));
            return;
         }
         if(this.obf_B_8_1456)
         {
            if(!obf_L_l_4100.checkNameString(txtInput.text))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("InputBox","prompt_HaveSymbol"));
               return;
            }
            if(obf_r_Y_1874.isUnlawful(txtInput.text))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("InputBox","prompt_InvalidContent"));
               return;
            }
         }
         WindowManager.closeWindow(this);
      }
      
      private function onClickCancle(param1:Event) : void
      {
         txtInput.text = "";
         WindowManager.closeWindow(this);
      }
      
      private function include(param1:Event) : void
      {
         GameContext.gameFocusManager.setFocus(txtInput);
      }
      
      public function destroy() : void
      {
         cmdOK.removeEventListener(MouseEvent.CLICK,this.onClickOK);
         cmdCancel.removeEventListener(MouseEvent.CLICK,this.onClickCancle);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClickCancle);
         txtInput.removeEventListener(MouseEvent.CLICK,this.include);
         txtInput.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_7_9_1915);
         txtInput.removeEventListener(KeyboardEvent.KEY_UP,this.obf_7_9_1915);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
      }
      
      public function get returnValue() : Object
      {
         return {
            "par":this._par,
            "content":txtInput.text
         };
      }
   }
}

