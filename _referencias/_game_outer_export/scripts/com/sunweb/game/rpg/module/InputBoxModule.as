package com.sunweb.game.rpg.module
{
   import obf_g_A_3629.obf_r_Y_1874;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.IModalWindow;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.obf_L_l_4100;
   import fl.data.DataProvider;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import mmorpg.InputBoxUI;
   
   public class InputBoxModule extends InputBoxUI implements IModalWindow
   {
      
      private var _par:*;
      
      private var obf_B_8_1456:Boolean;
      
      public function InputBoxModule(param1:String, param2:Array = null, param3:* = null, param4:int = 0, param5:Boolean = false, param6:Boolean = false)
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         txtPrompt.multiline = true;
         txtPrompt.mouseEnabled = false;
         txtPrompt.text = param1;
         this.obf_B_8_1456 = param5;
         this._par = param3;
         if(param4 > 0)
         {
            inputBox.textField.maxChars = param4;
         }
         inputBox.textField.displayAsPassword = param6;
         inputBox.dataProvider = new DataProvider(param2);
         inputBox.editable = true;
         this.addListener();
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
      
      private function addListener() : void
      {
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdCancel.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdOK.addEventListener(MouseEvent.CLICK,this.obf_K_p_2699);
         inputBox.textField.addEventListener(MouseEvent.CLICK,this.obf_i_e_4071);
         inputBox.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_7_9_1915);
         inputBox.addEventListener(KeyboardEvent.KEY_UP,this.obf_7_9_1915);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdCancel.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdOK.removeEventListener(MouseEvent.CLICK,this.obf_K_p_2699);
         inputBox.textField.removeEventListener(MouseEvent.CLICK,this.obf_i_e_4071);
         inputBox.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_7_9_1915);
         inputBox.removeEventListener(KeyboardEvent.KEY_UP,this.obf_7_9_1915);
      }
      
      private function obf_7_9_1915(param1:Event) : void
      {
         param1.stopPropagation();
      }
      
      private function obf_i_e_4071(param1:Event) : void
      {
         if(inputBox.focusManager)
         {
            inputBox.focusManager.setFocus(inputBox);
            inputBox.textField.setSelection(inputBox.text.length,inputBox.text.length);
         }
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
         inputBox.text = "";
         WindowManager.closeWindow(this);
      }
      
      private function obf_K_p_2699(param1:Event) : void
      {
         if(this.obf_B_8_1456)
         {
            if(!obf_L_l_4100.checkNameString(inputBox.text))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("InputBox","prompt_HaveSymbol"));
               return;
            }
            if(obf_r_Y_1874.isUnlawful(inputBox.text))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("InputBox","prompt_InvalidContent"));
               return;
            }
         }
         WindowManager.closeWindow(this);
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
      
      public function get returnValue() : Object
      {
         return {
            "par":this._par,
            "content":inputBox.text
         };
      }
   }
}

