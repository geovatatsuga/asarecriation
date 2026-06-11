package com.sunweb.game.rpg.playerUI.extractant
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.extractant.obf_t_f_2299;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.extractant.playerExtractantUplvAnswer;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import playerUI.ExtractantUpUIMC;
   
   public class obf_f_d_4224 extends ExtractantUpUIMC implements IPlayerUI
   {
      
      private var upButtons:Array;
      
      private var lvArr:Array;
      
      private var upConsumeArr:Array;
      
      private var obf_e_V_2014:int;
      
      public function obf_f_d_4224()
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         txtTitle.mouseEnabled = false;
         title.mouseEnabled = false;
         txtAbility.mouseEnabled = false;
         var _loc1_:int = 1;
         while(_loc1_ <= 4)
         {
            (this["txtRemark" + _loc1_] as TextField).mouseEnabled = false;
            (this["lv" + _loc1_] as TextField).mouseEnabled = false;
            _loc1_++;
         }
         this.initDiversity();
         this.upButtons = [up1,up2,up3,up4];
         this.addListener();
      }
      
      private function addListener() : void
      {
         var _loc1_:* = undefined;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         for each(_loc1_ in this.upButtons)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.onClickUpLv);
            _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.obf_N_N_1987);
            _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this.obf_k_a_2234);
         }
      }
      
      private function removeListener() : void
      {
         var _loc1_:* = undefined;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         for each(_loc1_ in this.upButtons)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onClickUpLv);
            _loc1_.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_N_N_1987);
            _loc1_.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_k_a_2234);
         }
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
         obf_K_e_3075.closeUI(this);
      }
      
      private function onClickUpLv(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = this.upButtons.indexOf(param1.currentTarget);
         var _loc3_:Object = obf_t_f_2299.getUpLvTypeConfig(_loc2_);
         if(_loc3_)
         {
            this.upConsumeArr = _loc3_.upConsume;
         }
         if(this.lvArr == null)
         {
            return;
         }
         if(this.lvArr[_loc2_] < _loc3_.upLvMax)
         {
            _loc4_ = int(this.upConsumeArr[this.lvArr[_loc2_]]);
            if(this.obf_e_V_2014 < _loc4_)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("extractantUI","noAbility"));
               return;
            }
            obf_t_f_2299.sendExtractantUpLvRequest(_loc2_);
            return;
         }
         obf_K_e_3075.showTipInfo(DiversityManager.getString("extractantUI","mxLv"));
      }
      
      private function obf_N_N_1987(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:GameTipUI = null;
         var _loc2_:int = this.upButtons.indexOf(param1.currentTarget);
         var _loc3_:Object = obf_t_f_2299.getUpLvTypeConfig(_loc2_);
         if(_loc3_)
         {
            this.upConsumeArr = _loc3_.upConsume;
         }
         if(this.lvArr)
         {
            _loc4_ = int(this.upConsumeArr[this.lvArr[_loc2_]]);
            _loc5_ = new GameTipUI("extractant");
            _loc5_.addTipInfo(DiversityManager.getString("extractantUI","upConsume",[_loc4_]),150,0);
            GameTipManager.showTip(_loc5_);
         }
      }
      
      private function obf_k_a_2234(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("extractant");
      }
      
      private function showInfo() : void
      {
         this.clear();
         txtAbility.text = DiversityManager.getString("extractantUI","txtAbility",[this.obf_e_V_2014]);
         var _loc1_:Array = obf_t_f_2299.getUpConfig();
         if(!_loc1_)
         {
            return;
         }
         if(!this.lvArr)
         {
            return;
         }
         var _loc2_:int = 1;
         while(_loc2_ <= _loc1_.length)
         {
            (this["txtRemark" + _loc2_] as TextField).text = _loc1_[_loc2_ - 1].remark;
            (this["lv" + _loc2_] as TextField).text = this.lvArr[_loc2_ - 1] + "/" + _loc1_[_loc2_ - 1].upLvMax;
            _loc2_++;
         }
      }
      
      public function getValue(param1:playerExtractantUplvAnswer) : void
      {
         this.obf_e_V_2014 = param1.ability;
         this.lvArr = param1.upLvs;
         this.showInfo();
      }
      
      public function getAbility(param1:int) : void
      {
         this.obf_e_V_2014 = param1;
         this.showInfo();
      }
      
      private function clear() : void
      {
         lv1.text = "";
         lv2.text = "";
         lv3.text = "";
         lv4.text = "";
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
         DiversityManager.setTextField(txtTitle,"extractantUI","txtTitle2");
         up1.label = DiversityManager.getString("extractantUI","up");
         up2.label = DiversityManager.getString("extractantUI","up");
         up3.label = DiversityManager.getString("extractantUI","up");
         up4.label = DiversityManager.getString("extractantUI","up");
      }
      
      public function showUI() : void
      {
         this.showInfo();
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

