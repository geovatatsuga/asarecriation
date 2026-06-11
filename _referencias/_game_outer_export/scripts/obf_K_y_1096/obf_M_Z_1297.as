package obf_K_y_1096
{
   import obf_0_2_o_501.obf_g_4_2381;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.WindowManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.BloodyWarChangeUIMC;
   
   public class obf_M_Z_1297 extends BloodyWarChangeUIMC implements IPlayerUI
   {
      
      private var type:int = 0;
      
      public function obf_M_Z_1297()
      {
         super();
         this.initDiversity();
         titleBox.mouseEnabled = false;
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2 + 300;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.addListener();
      }
      
      public function setType(param1:int) : void
      {
         this.type = param1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtTitle,"bloodyWarUI","txtChangeTitle");
      }
      
      public function addListener() : void
      {
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this["button" + _loc1_].addEventListener(MouseEvent.CLICK,this.onButton);
            this["button" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.obf_R_V_4247);
            this["button" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.obf_T_V_2010);
            _loc1_++;
         }
      }
      
      private function removeListener() : void
      {
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this["button" + _loc1_].removeEventListener(MouseEvent.CLICK,this.onButton);
            this["button" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,this.obf_R_V_4247);
            this["button" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,this.obf_T_V_2010);
            _loc1_++;
         }
      }
      
      private function obf_R_V_4247(param1:Event) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("buttonTip");
         _loc2_.addTipInfo(DiversityManager.getString("bloodyWarUI",param1.currentTarget.name),250,0);
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_T_V_2010(param1:Event) : void
      {
         GameTipManager.closeTip("buttonTip");
      }
      
      private function onButton(param1:Event) : void
      {
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc2_:int = -1;
         if(param1.currentTarget == button0)
         {
            _loc2_ = 0;
         }
         else if(param1.currentTarget == button1)
         {
            _loc2_ = 1;
         }
         else if(param1.currentTarget == button2)
         {
            _loc2_ = 2;
         }
         if(_loc2_ < 0)
         {
            return;
         }
         var _loc3_:int = 0;
         if(this.type == 1)
         {
            _loc4_ = obf_g_4_2381.changeAttack[_loc2_];
            if(obf_K_e_3075.bloodyWarUI.attackTemp < _loc4_.need)
            {
               WindowManager.showMessageBox(DiversityManager.getString("bloodyWarUI","noTempValue"));
               return;
            }
            if(obf_K_e_3075.bloodyWarUI.attack >= obf_g_4_2381.baseMax)
            {
               WindowManager.showMessageBox(DiversityManager.getString("bloodyWarUI","baseAttrMax"));
               return;
            }
            if(!obf_K_e_3075.playerBagUI || obf_K_e_3075.playerBagUI.getItemCount(obf_g_4_2381.itemCode) < _loc4_.itemNum)
            {
               WindowManager.showMessageBox(DiversityManager.getString("bloodyWarUI","noItems"));
               return;
            }
            _loc3_ = int(_loc4_.need);
         }
         else if(this.type == 2)
         {
            _loc5_ = obf_g_4_2381.changeDefense[_loc2_];
            if(obf_K_e_3075.bloodyWarUI.defenseTemp < _loc5_.need)
            {
               WindowManager.showMessageBox(DiversityManager.getString("bloodyWarUI","noTempValue"));
               return;
            }
            if(obf_K_e_3075.bloodyWarUI.defense >= obf_g_4_2381.baseMax)
            {
               WindowManager.showMessageBox(DiversityManager.getString("bloodyWarUI","baseAttrMax"));
               return;
            }
            if(!obf_K_e_3075.playerBagUI || obf_K_e_3075.playerBagUI.getItemCount(obf_g_4_2381.itemCode) < _loc5_.itemNum)
            {
               WindowManager.showMessageBox(DiversityManager.getString("bloodyWarUI","noItems"));
               return;
            }
            _loc3_ = int(_loc5_.need);
         }
         obf_g_4_2381.sendChange(this.type,_loc3_);
      }
      
      private function refresh() : void
      {
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:Array = null;
         if(this.type == 1)
         {
            _loc1_ = obf_K_e_3075.bloodyWarUI.attackTemp;
            _loc2_ = obf_g_4_2381.changeAttack;
         }
         else if(this.type == 2)
         {
            _loc1_ = obf_K_e_3075.bloodyWarUI.defenseTemp;
            _loc2_ = obf_g_4_2381.changeDefense;
         }
         var _loc3_:int = 0;
         while(_loc3_ < 3)
         {
            _loc4_ = int(_loc2_[_loc3_].need);
            this["button" + _loc3_].label = _loc4_ + "";
            if(_loc1_ < _loc4_)
            {
               this["button" + _loc3_].enabled = false;
            }
            else
            {
               this["button" + _loc3_].enabled = true;
            }
            _loc3_++;
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
         obf_K_e_3075.closeUI(this);
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return bg.getBounds(bg).contains(bg.mouseX,bg.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.refresh();
      }
      
      public function get uiIndex() : int
      {
         return -1;
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

