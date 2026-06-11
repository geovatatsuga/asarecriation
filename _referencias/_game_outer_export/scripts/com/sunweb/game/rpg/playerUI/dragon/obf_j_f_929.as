package com.sunweb.game.rpg.playerUI.dragon
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.glyph.obf_Q_J_3925;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.ride.obf_0___z_209;
   import com.sunweb.game.ui.IModalWindow;
   import com.sunweb.game.ui.WindowManager;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import playerUI.DragonWindowMC;
   
   public class obf_j_f_929 extends DragonWindowMC implements IModalWindow
   {
      
      private var returnObj:Object = new Object();
      
      private var obf_E_7_1061:int;
      
      public function obf_j_f_929(param1:int)
      {
         super();
         this.obf_E_7_1061 = param1;
         txtName.multiline = true;
         this.initDiversity();
         titleBox.mouseEnabled = false;
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.color = 65280;
         _loc2_.size = 13;
         _loc2_.font = "songti";
         checkBox.setStyle("textFormat",_loc2_);
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      private function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"dragonBoxUI","txtDeyTitle");
         DiversityManager.setTextField(txtName,"dragonBoxUI","txtName");
         checkBox.label = DiversityManager.getString("dragonBoxUI","checkBox");
         cmdButton.label = DiversityManager.getString("dragonBoxUI","cmdButton");
      }
      
      private function addListener() : void
      {
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdButton.addEventListener(MouseEvent.CLICK,this.onOk);
      }
      
      private function removeListener() : void
      {
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdButton.removeEventListener(MouseEvent.CLICK,this.onOk);
      }
      
      private function onStartDrag(param1:MouseEvent) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      private function onClose(param1:MouseEvent) : void
      {
         this.returnObj.confirm = false;
         WindowManager.closeWindow(this);
      }
      
      private function onOk(param1:MouseEvent) : void
      {
         this.returnObj.confirm = true;
         if(checkBox.selected)
         {
            if(this.obf_E_7_1061 == 0)
            {
               obf_K_e_3075.dragonBoxUI.isClew = false;
            }
            else if(this.obf_E_7_1061 == 1)
            {
               obf_K_e_3075.dragonBoxUI.isClewTen = false;
            }
            else if(this.obf_E_7_1061 == 2)
            {
               obf_Q_J_3925.obf_i_L_1797 = false;
            }
            else if(this.obf_E_7_1061 == 3)
            {
               obf_Q_J_3925.masterOneTimes = false;
            }
            else if(this.obf_E_7_1061 == 4)
            {
               obf_Q_J_3925.masterTwoTimes = false;
            }
            else if(this.obf_E_7_1061 == 5)
            {
               obf_Q_J_3925.masterThreeTimes = false;
            }
            else if(this.obf_E_7_1061 == 6)
            {
               obf_K_e_3075.rideEquipRecreateUI.isShowSoulTip = false;
            }
            else if(this.obf_E_7_1061 == 7)
            {
               obf_K_e_3075.rideEquipRecreateUI.isShowAttTip = false;
            }
            else if(this.obf_E_7_1061 == 8)
            {
               obf_0___z_209.isRideAss = false;
            }
            else if(this.obf_E_7_1061 == 9)
            {
               obf_0___z_209.isRideFusion = false;
            }
            else if(this.obf_E_7_1061 == 10)
            {
               obf_K_e_3075.rideEquipRefineUI.isShowRefineTip = false;
            }
         }
         WindowManager.closeWindow(this);
      }
      
      public function setTxt(param1:String) : void
      {
         txtName.htmlText = param1;
      }
      
      public function setDisCheckBox() : void
      {
         checkBox.selected = false;
      }
      
      public function get returnValue() : Object
      {
         return this.returnObj;
      }
      
      public function destroy() : void
      {
         this.returnObj = null;
         this.removeListener();
      }
   }
}

