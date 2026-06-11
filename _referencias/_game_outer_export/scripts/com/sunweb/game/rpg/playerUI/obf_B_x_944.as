package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.animal.AnimalActionMode;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.netRole.obf_1_R_3404;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.utils.obf_9_V_1635;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import playerUI.ControlPanelBoxUIMC;
   
   public class obf_B_x_944 extends ControlPanelBoxUIMC implements IPlayerUI
   {
      
      private var obf_0_5_I_285:Dictionary;
      
      private var _hp:Number;
      
      private var obf_r_W_3377:Number;
      
      private var obf_z_S_3535:BuffUI;
      
      private var _debuffUI:BuffUI;
      
      public function obf_B_x_944()
      {
         super();
         this.initDiversity();
         txtHp.mouseEnabled = false;
         this.visible = false;
         this.onResize(null);
         this.obf_0_5_I_285 = new Dictionary();
         this.obf_0_5_I_285[followBut] = AnimalActionMode.DEFENSE;
         this.obf_0_5_I_285[attackBut] = AnimalActionMode.ACTIVE_ATTACK;
         this.obf_0_5_I_285[recoveryBut] = AnimalActionMode.PASSIVE_ATTACK;
         this.obf_z_S_3535 = new BuffUI(true);
         buffPoint.addChild(this.obf_z_S_3535);
         this._debuffUI = new BuffUI(true);
         this._debuffUI.y = 18;
         buffPoint.addChild(this._debuffUI);
         recoveryBut.gotoAndStop(2);
         this.obf_q_N_2525();
      }
      
      private function obf_q_N_2525() : void
      {
         var _loc1_:* = undefined;
         titleBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         attributeBut.addEventListener(MouseEvent.CLICK,this.obf_n_1_3748);
         for(_loc1_ in this.obf_0_5_I_285)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.onClickTableButton);
         }
         obf_K_e_3075.addUIMouseToolTip(followBut,"followBut");
         obf_K_e_3075.addUIMouseToolTip(attackBut,"attackBut");
         obf_K_e_3075.addUIMouseToolTip(recoveryBut,"recoveryBut");
         obf_K_e_3075.addUIMouseToolTip(attributeBut,"attributeBut");
         animalHpBar2.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         animalHpBar2.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
      }
      
      private function removerListem() : void
      {
         var _loc1_:* = undefined;
         titleBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         attributeBut.removeEventListener(MouseEvent.CLICK,this.obf_n_1_3748);
         for(_loc1_ in this.obf_0_5_I_285)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onClickTableButton);
         }
         obf_K_e_3075.removeUIMouseToolTip(followBut);
         obf_K_e_3075.removeUIMouseToolTip(attackBut);
         obf_K_e_3075.removeUIMouseToolTip(recoveryBut);
         obf_K_e_3075.removeUIMouseToolTip(attributeBut);
         animalHpBar2.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         animalHpBar2.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
      }
      
      private function onStartDrag(param1:MouseEvent) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      public function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = obf_K_e_3075.shortcutUI.y - obf_K_e_3075.shortcutUI.obf_d_g_1136;
      }
      
      public function get buffUI() : BuffUI
      {
         return this.obf_z_S_3535;
      }
      
      public function get debuffUI() : BuffUI
      {
         return this._debuffUI;
      }
      
      private function obf_n_1_3748(param1:MouseEvent) : void
      {
         obf_K_e_3075.showUI(obf_K_e_3075.playerBoxUI);
         obf_K_e_3075.playerBoxUI.showAnimalUI();
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("hpBar");
         _loc2_.addTipInfo("<P align=\'center\'>" + this._hp + "/" + this.obf_r_W_3377 + "</p>",100,0);
         GameTipManager.showTip(_loc2_);
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("hpBar");
      }
      
      private function onClickTableButton(param1:MouseEvent) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(!_loc2_)
         {
            return;
         }
         for(_loc3_ in this.obf_0_5_I_285)
         {
            if(_loc3_)
            {
               _loc3_.gotoAndStop(_loc3_ == _loc2_ ? 2 : 1);
            }
         }
         obf_1_R_3404.sendAnimalActionModeChange(this.obf_0_5_I_285[_loc2_]);
      }
      
      public function setHp(param1:Number, param2:Number) : void
      {
         this._hp = param1;
         this.obf_r_W_3377 = param2;
         txtHp.text = param1 + "/" + param2;
         var _loc3_:int = 100 * Number(param1 / param2);
         if(_loc3_ < 2)
         {
            _loc3_ = 2;
         }
         animalHpBar.gotoAndStop(_loc3_);
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         followBut.txtLable.text = DiversityManager.getString("animalUI","followBut");
         attackBut.txtLable.text = DiversityManager.getString("animalUI","attackBut");
         recoveryBut.txtLable.text = DiversityManager.getString("animalUI","recoveryBut");
         obf_9_V_1635.setSimpleButtonTooltip(attributeBut,DiversityManager.getString("animalUI","attributeBut"));
      }
      
      public function showUI() : void
      {
         var _loc1_:* = undefined;
         this.visible = true;
         for(_loc1_ in this.obf_0_5_I_285)
         {
            if(_loc1_)
            {
               _loc1_.gotoAndStop(_loc1_ == recoveryBut ? 2 : 1);
            }
         }
         this.onResize(null);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removerListem();
      }
   }
}

