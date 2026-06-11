package com.sunweb.game.rpg.playerUI.glyph
{
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.glyph.obf_Q_J_3925;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.MasterBoxMC;
   
   public class obf_0_5_L_659 extends MasterBoxMC
   {
      
      public static var MasterInvite:String = "MasterInvite";
      
      public var masterLv:int;
      
      public var masterKind:int;
      
      public var obf_Q_H_1866:int;
      
      public var obf_h_E_2115:int;
      
      public function obf_0_5_L_659(param1:int)
      {
         super();
         this.initDiversity();
         this.obf_x_v_2806();
         checkBox.selected = true;
         this.masterKind = param1;
      }
      
      private function initDiversity() : void
      {
         cmdInvite.label = DiversityManager.getString("depictBoxUI","cmdInvite");
         checkBox.label = DiversityManager.getString("depictBoxUI","checkBox");
      }
      
      private function obf_x_v_2806() : void
      {
         cmdInvite.addEventListener(MouseEvent.CLICK,this.onClick);
         headIconPoint.addEventListener(MouseEvent.MOUSE_OVER,this.obf_N_N_1987);
         headIconPoint.addEventListener(MouseEvent.MOUSE_OUT,this.obf_k_a_2234);
      }
      
      private function removerListen() : void
      {
         cmdInvite.removeEventListener(MouseEvent.CLICK,this.onClick);
         headIconPoint.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_N_N_1987);
         headIconPoint.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_k_a_2234);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         dispatchEvent(new Event(MasterInvite));
      }
      
      private function obf_N_N_1987(param1:MouseEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:GameTipUI = new GameTipUI("masterTips");
         var _loc3_:int = this.masterLv;
         var _loc4_:Array = obf_Q_J_3925.getMasterLevel(this.masterKind);
         if(!_loc4_)
         {
            return;
         }
         if(this.masterLv >= _loc4_.length)
         {
            _loc2_.addTipInfo(DiversityManager.getString("depictBoxUI","maxMaster"),150,0);
         }
         else
         {
            _loc5_ = int(_loc4_[this.masterLv].upNum);
            _loc2_.addTipInfo(DiversityManager.getString("depictBoxUI","haveNextLv",[_loc5_ - this.obf_h_E_2115]),150,0);
         }
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_k_a_2234(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("masterTips");
      }
      
      public function setMasterLv(param1:int, param2:int, param3:int = 0) : void
      {
         while(headIconPoint.numChildren > 0)
         {
            headIconPoint.removeChildAt(0);
         }
         txtName.text = "";
         txtExplain.text = "";
         var _loc4_:int = param1 - 1;
         this.masterLv = param1;
         this.obf_h_E_2115 = param3;
         var _loc5_:Array = obf_Q_J_3925.getMasterLevel(this.masterKind);
         if(!_loc5_)
         {
            return;
         }
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         if(_loc4_ > _loc5_.length - 1)
         {
            _loc4_ = _loc5_.length - 1;
         }
         var _loc6_:Object = _loc5_[_loc4_];
         txtName.htmlText = _loc6_.name;
         txtExplain.htmlText = _loc6_.tips;
         var _loc7_:DisplayObject = ResourceManager.instance.getDisplayObject(_loc6_.image);
         if(_loc7_)
         {
            headIconPoint.addChild(_loc7_);
         }
         this.setMasterTimes(param2);
      }
      
      public function setMasterTimes(param1:int) : void
      {
         this.obf_Q_H_1866 = param1;
         var _loc2_:Object = obf_Q_J_3925.getMasterLevel(this.masterKind)[this.masterLv - 1];
         if(_loc2_)
         {
            txtTimes.htmlText = DiversityManager.getString("depictBoxUI","txtTimes",[param1,_loc2_.maxNum]);
         }
      }
      
      public function get timeNum() : int
      {
         return this.obf_Q_H_1866;
      }
      
      override public function get height() : Number
      {
         return 82;
      }
      
      public function destroy() : void
      {
         this.removerListen();
      }
   }
}

