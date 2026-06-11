package com.sunweb.game.rpg.playerUI.glyph
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.glyph.obf_Q_J_3925;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_0_3_0_538;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import playerUI.DepictBoxUIMC;
   
   public class obf_B_q_4166 extends DepictBoxUIMC implements IPlayerUI
   {
      
      private var masterObj:Dictionary;
      
      private var obf_I_r_3838:int = 0;
      
      private var obf_q_H_2064:Dictionary;
      
      private var obf_D_7_3171:int;
      
      public function obf_B_q_4166()
      {
         var _loc1_:MovieClip = null;
         super();
         this.visible = false;
         this.initDiversity();
         this.masterObj = new Dictionary();
         this.initMaster();
         this.obf_q_H_2064 = new Dictionary();
         this.obf_q_H_2064[obf_V_B_2959.obf_2_9_2578] = obf_x_u_1880;
         this.obf_q_H_2064[obf_V_B_2959.obf_7_r_1401] = obf_L_b_1645;
         this.obf_q_H_2064[obf_V_B_2959.obf_N_v_4048] = obf_0_9_L_212;
         this.obf_q_H_2064[obf_V_B_2959.obf_d_a_3579] = obf_p_s_2213;
         this.obf_q_H_2064[obf_V_B_2959.obf_E_g_1804] = obf_e_D_4578;
         for each(_loc1_ in this.obf_q_H_2064)
         {
            _loc1_.visible = false;
            _loc1_.gotoAndStop(1);
         }
         this.obf_x_v_2806();
      }
      
      private function obf_x_v_2806() : void
      {
         cmdDepict.addEventListener(MouseEvent.CLICK,this.onClick);
         txtName.addEventListener(MouseEvent.MOUSE_OVER,this.obf_y_K_1020);
         txtName.addEventListener(MouseEvent.MOUSE_OUT,this.obf_0_2_Z_608);
      }
      
      private function removerListen() : void
      {
         cmdDepict.removeEventListener(MouseEvent.CLICK,this.onClick);
         txtName.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_y_K_1020);
         txtName.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_0_2_Z_608);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(this.obf_I_r_3838 == 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("depictBoxUI","noGlyph"));
            return;
         }
         if(obf_K_e_3075.roomBoxUI.getCurrGlyph(this.obf_I_r_3838)._lv >= (JSONUtil.getObject(obf_Q_J_3925.getGlyphList(this.obf_I_r_3838),["levelList"]) as Array).length - 1)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("depictBoxUI","maxCharacter"));
            return;
         }
         if(GameContext.localPlayer.fullInfo.exp < obf_Q_J_3925.oneByExp)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("ConditionPrompt","roleExp>=",[obf_Q_J_3925.oneByExp]));
            return;
         }
         if(obf_Q_J_3925.obf_i_L_1797)
         {
            WindowManager.showDragonWin(DiversityManager.getString("depictBoxUI","onOk1",[obf_Q_J_3925.oneByExp]),this.obf_o_T_1638,2);
            return;
         }
         obf_Q_J_3925.sendGlyphUp(this.obf_I_r_3838,this.obf_9_u_2509);
      }
      
      private function obf_o_T_1638(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_Q_J_3925.sendGlyphUp(this.obf_I_r_3838,this.obf_9_u_2509);
         }
      }
      
      private function obf_y_K_1020(param1:MouseEvent) : void
      {
         var _loc8_:String = null;
         var _loc9_:Number = NaN;
         if(this.obf_I_r_3838 == 0)
         {
            return;
         }
         var _loc2_:obf_o_8_2436 = obf_K_e_3075.roomBoxUI.getRoomObj()[this.obf_I_r_3838] as obf_o_8_2436;
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:GameTipUI = new GameTipUI("depictMouseTip");
         var _loc4_:int = 200;
         var _loc5_:Object = obf_Q_J_3925.getGlyphList(this.obf_I_r_3838);
         if(!_loc5_)
         {
            return;
         }
         var _loc6_:Array = _loc5_.levelList;
         if(!_loc6_)
         {
            return;
         }
         var _loc7_:Object = JSONUtil.getObject(_loc6_[_loc2_._lv],["attr"]);
         if(!_loc7_)
         {
            return;
         }
         _loc3_.addTipInfo(JSONUtil.getStr(_loc5_,["name"]),_loc4_,0);
         for(_loc8_ in _loc7_)
         {
            _loc9_ = GameItemManager.getItemQualityValue(_loc7_[_loc8_],0);
            _loc3_.addTipInfo("<FONT color=\'#" + obf_0_3_0_538.obf_T_N_2235.toString(16) + "\'>" + RoleAttributesModifierEnum.getAttributesName(int(_loc8_)) + "</FONT>",_loc4_,_loc3_.maxRow + 1);
            _loc3_.addTipInfo("<P align=\'right\'><FONT color=\'#" + obf_0_3_0_538.obf_T_N_2235.toString(16) + "\'>" + RoleAttributesModifierEnum.getAttributesValueString(int(_loc8_),_loc9_) + "</FONT></P>",_loc4_,_loc3_.maxRow);
         }
         GameTipManager.showTip(_loc3_);
      }
      
      private function obf_0_2_Z_608(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("depictMouseTip");
      }
      
      private function initMaster() : void
      {
         var _loc2_:Object = null;
         var _loc3_:obf_0_5_L_659 = null;
         while(masterPonit.numChildren > 0)
         {
            masterPonit.removeChildAt(0);
         }
         var _loc1_:int = 0;
         for each(_loc2_ in obf_Q_J_3925.glyphMasterList)
         {
            _loc3_ = new obf_0_5_L_659(_loc2_.kind);
            _loc3_.setMasterLv(1,0);
            _loc3_.addEventListener(obf_0_5_L_659.MasterInvite,this.obf_u_W_2327);
            _loc3_.y = _loc3_.height * _loc1_;
            masterPonit.addChild(_loc3_);
            this.masterObj[_loc2_.kind] = _loc3_;
            _loc1_++;
         }
      }
      
      private function get obf_9_u_2509() : Array
      {
         var _loc2_:obf_0_5_L_659 = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in this.masterObj)
         {
            if(_loc2_.checkBox.selected)
            {
               _loc1_.push(_loc2_.masterKind);
            }
         }
         return _loc1_;
      }
      
      private function obf_u_W_2327(param1:Event) : void
      {
         var _loc2_:obf_0_5_L_659 = param1.target as obf_0_5_L_659;
         this.obf_D_7_3171 = _loc2_.masterKind;
         var _loc3_:Object = obf_Q_J_3925.getMasterLevel(this.obf_D_7_3171)[_loc2_.masterLv - 1];
         if(!_loc3_)
         {
            return;
         }
         if(_loc2_.timeNum >= _loc3_.maxNum)
         {
            return;
         }
         if(_loc3_.gold > GameContext.localPlayer.fullInfo.gold)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("ConditionPrompt","gold>=",[_loc3_.gold]));
            return;
         }
         if(this.obf_D_7_3171 == obf_A_g_902.obf_U_j_3267 && obf_Q_J_3925.masterOneTimes)
         {
            WindowManager.showDragonWin(DiversityManager.getString("depictBoxUI","masterSM1",[_loc3_.gold / 10000,_loc3_.name,_loc3_.num]),this.obf_0_2_r_105,3);
            return;
         }
         if(this.obf_D_7_3171 == obf_A_g_902.obf_Q_6_3805 && obf_Q_J_3925.masterTwoTimes)
         {
            WindowManager.showDragonWin(DiversityManager.getString("depictBoxUI","masterSM1",[_loc3_.gold / 10000,_loc3_.name,_loc3_.num]),this.obf_0_2_r_105,4);
            return;
         }
         if(this.obf_D_7_3171 == obf_A_g_902.obf_i_t_2341 && obf_Q_J_3925.masterThreeTimes)
         {
            WindowManager.showDragonWin(DiversityManager.getString("depictBoxUI","masterSM1",[_loc3_.gold / 10000,_loc3_.name,_loc3_.num]),this.obf_0_2_r_105,5);
            return;
         }
         obf_Q_J_3925.sendInviteMaster(_loc2_.masterKind);
      }
      
      private function obf_0_2_r_105(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_Q_J_3925.sendInviteMaster(this.obf_D_7_3171);
         }
      }
      
      public function obf_F_w_4031(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:obf_0_5_L_659 = this.masterObj[param1] as obf_0_5_L_659;
         if(_loc5_)
         {
            _loc5_.setMasterLv(param2,param3,param4);
         }
      }
      
      public function obf_w_G_1173(param1:int, param2:int) : void
      {
         var _loc3_:obf_0_5_L_659 = this.masterObj[param1] as obf_0_5_L_659;
         _loc3_.setMasterTimes(param2);
      }
      
      public function setCurrDepictGlyph(param1:int, param2:int, param3:int) : void
      {
         var _loc6_:MovieClip = null;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc11_:int = 0;
         txtName.text = JSONUtil.getStr(obf_Q_J_3925.getGlyphList(param1),["name"]);
         this.obf_I_r_3838 = param1;
         var _loc4_:Array = JSONUtil.getObject(obf_Q_J_3925.getGlyphList(param1),["levelList"]) as Array;
         if(!_loc4_)
         {
            return;
         }
         var _loc5_:int = JSONUtil.getInt(_loc4_[param2],["value"]);
         if(obf_K_e_3075.roomBoxUI.getCurrGlyph(param1)._lv >= _loc4_.length - 1)
         {
            param3 = _loc5_;
            this.obf_q_H_2064[param1].gotoAndStop(100);
         }
         else
         {
            _loc11_ = 100 * Number(param3 / _loc5_);
            this.obf_q_H_2064[param1].gotoAndStop(_loc11_);
         }
         DiversityManager.setTextField(txtStunted,"roomBoxUI","txtCurPullulate",[param3,_loc5_]);
         for each(_loc6_ in this.obf_q_H_2064)
         {
            if(this.obf_q_H_2064[param1] == _loc6_)
            {
               _loc6_.visible = true;
            }
            else
            {
               _loc6_.visible = false;
            }
         }
         _loc7_ = "";
         _loc8_ = 0;
         while(_loc8_ < param2)
         {
            _loc7_ += "★";
            _loc8_++;
         }
         var _loc9_:String = "";
         var _loc10_:int = param2;
         while(_loc10_ < (JSONUtil.getObject(obf_Q_J_3925.getGlyphList(param1),["levelList"]) as Array).length - 1)
         {
            _loc9_ += "☆";
            _loc10_++;
         }
         txtPentacle.htmlText = _loc7_ + "<font color=\'#999999\'>" + _loc9_ + "</font>";
      }
      
      public function obf_0_7_Q_154() : void
      {
      }
      
      public function get mouseOn() : Boolean
      {
         return false;
      }
      
      public function get uiIndex() : int
      {
         return 0;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtExplain,"depictBoxUI","txtExplain");
         cmdDepict.label = DiversityManager.getString("depictBoxUI","cmdDepict");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         obf_Q_J_3925.obf_i_L_1797 = true;
         obf_Q_J_3925.masterOneTimes = true;
         obf_Q_J_3925.masterThreeTimes = true;
         obf_Q_J_3925.masterTwoTimes = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         var _loc1_:obf_0_5_L_659 = null;
         this.removerListen();
         for each(_loc1_ in this.masterObj)
         {
            _loc1_.removeEventListener(obf_0_5_L_659.MasterInvite,this.obf_u_W_2327);
            _loc1_.destroy();
            _loc1_ = null;
         }
         while(masterPonit.numChildren > 0)
         {
            masterPonit.removeChildAt(0);
         }
      }
   }
}

