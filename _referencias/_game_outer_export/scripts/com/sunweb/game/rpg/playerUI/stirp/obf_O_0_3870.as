package com.sunweb.game.rpg.playerUI.stirp
{
   import com.sunweb.game.res.obf_0_P_4381;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_0_3_0_538;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.rpg.stirp.obf_x_B_2963;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import gs.TweenLite;
   import playerUI.RedEyesMC;
   import playerUI.StirpBoxUIMC;
   
   public class obf_O_0_3870 extends StirpBoxUIMC implements IPlayerUI
   {
      
      private static var mouseTipMap:Dictionary = new Dictionary();
      
      private static var mouseTipMapI:Dictionary = new Dictionary();
      
      private var obf_x_I_4151:String;
      
      private var time:TimeLimiter = new TimeLimiter(500);
      
      public function obf_O_0_3870()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         titleBox.mouseEnabled = false;
         stirpName.mouseEnabled = false;
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.underline = true;
         stripTxt.setTextFormat(_loc1_);
         this.setBlueLv(0);
         this.setRedLv(0);
         cmdStripLvs.enabled = false;
         cmdPotential.enabled = false;
         this.addListener();
      }
      
      private function addListener() : void
      {
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdStripLvs.addEventListener(MouseEvent.CLICK,this.obf_7_H_2114);
         cmdPotential.addEventListener(MouseEvent.CLICK,this.obf_G_E_2803);
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            this.addUIMouseToolTip(this["red" + _loc1_],0,_loc1_);
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < 9)
         {
            this.addUIMouseToolTip(this["bule" + _loc2_],1,_loc2_);
            _loc2_++;
         }
         this.addUIMouseToolTip(stirpButton,2,0);
         obf_K_e_3075.addUIMouseToolTip(stripTxt,"stripTxt");
      }
      
      private function removeListener() : void
      {
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdStripLvs.removeEventListener(MouseEvent.CLICK,this.obf_7_H_2114);
         cmdPotential.removeEventListener(MouseEvent.CLICK,this.obf_G_E_2803);
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            this.removeUIMouseToolTip(this["red" + _loc1_]);
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < 9)
         {
            this.removeUIMouseToolTip(this["bule" + _loc2_]);
            _loc2_++;
         }
         this.removeUIMouseToolTip(stirpButton);
         obf_K_e_3075.removeUIMouseToolTip(stripTxt);
      }
      
      public function refurbishStirp(param1:Boolean = false, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc6_:int = 0;
         var _loc10_:MovieClip = null;
         var _loc4_:int = GameContext.localPlayer.fullInfo.stirpLevel;
         var _loc5_:int = GameContext.localPlayer.fullInfo.potentialLevel;
         if(_loc4_ <= 0)
         {
            return;
         }
         this.setStirpName(JSONUtil.getStr(obf_x_B_2963.getStirpObject(_loc4_),["stirpName"]));
         this.setPotentialNum(GameContext.localPlayer.fullInfo.potentialValue);
         this.setRedLv(_loc5_);
         if(_loc4_ < obf_x_B_2963.getStirpBlueStar() + 2)
         {
            _loc6_ = 0;
         }
         else if(_loc4_ % (obf_x_B_2963.getStirpBlueStar() + 1) > 0)
         {
            _loc6_ = _loc4_ / (obf_x_B_2963.getStirpBlueStar() + 1);
         }
         else
         {
            _loc6_ = _loc4_ / (obf_x_B_2963.getStirpBlueStar() + 1) - 1;
         }
         var _loc7_:int = _loc6_ * (obf_x_B_2963.getStirpBlueStar() + 1);
         if(param3)
         {
            if(param2)
            {
               _loc10_ = this["bule" + (_loc4_ - _loc7_ - 2)];
               if(_loc10_)
               {
                  this.showEffer(_loc10_);
               }
               obf_x_B_2963.redAttrArr = [];
               obf_x_B_2963.obf_P_i_4116(_loc4_);
            }
            else
            {
               obf_x_B_2963.obf_x_6_4254(_loc4_,_loc5_);
            }
            if(param1)
            {
               this.showLvUpEffer();
               this.setBlueLv(_loc4_);
               obf_x_B_2963.redAttrArr = [];
               obf_x_B_2963.obf_P_i_4116(_loc4_);
            }
         }
         else
         {
            this.setBlueLv(_loc4_);
         }
         var _loc8_:Array = obf_x_B_2963.getStirpLvUpConfig() as Array;
         var _loc9_:Array = JSONUtil.getObject(obf_x_B_2963.getStirpObject(_loc4_),["stirpPotential"]) as Array;
         if(!_loc8_ || !_loc9_)
         {
            return;
         }
         if(_loc4_ >= _loc8_.length && _loc5_ >= _loc9_.length)
         {
            cmdStripLvs.visible = false;
            cmdPotential.visible = false;
         }
         else if(_loc4_ - _loc7_ == 10 && _loc5_ == 5)
         {
            cmdStripLvs.enabled = true;
            cmdPotential.enabled = false;
         }
         else
         {
            cmdStripLvs.enabled = false;
            cmdPotential.enabled = true;
         }
      }
      
      public function getRoleAttributesInfo() : void
      {
         obf_x_B_2963.getRoleAttributesInfo();
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
      
      private function obf_7_H_2114(param1:MouseEvent) : void
      {
         var _loc2_:int = GameContext.localPlayer.fullInfo.stirpLevel;
         var _loc3_:int = GameContext.localPlayer.fullInfo.potentialLevel;
         var _loc4_:Array = obf_x_B_2963.getStirpLvUpConfig() as Array;
         var _loc5_:Array = JSONUtil.getObject(obf_x_B_2963.getStirpObject(_loc2_),["stirpPotential"]) as Array;
         if(!_loc4_ || !_loc5_)
         {
            return;
         }
         if(_loc2_ >= _loc4_.length && _loc3_ >= _loc5_.length)
         {
            return;
         }
         if(!ConditionScript.checkCondition(JSONUtil.getObject(obf_x_B_2963.getStirpObject(GameContext.localPlayer.fullInfo.stirpLevel),["spirtCondition"]),null,true))
         {
            return;
         }
         obf_x_B_2963.sendStirpLvs(true);
      }
      
      private function obf_G_E_2803(param1:MouseEvent) : void
      {
         if(!this.time.checkTimeout())
         {
            return;
         }
         var _loc2_:int = JSONUtil.getInt(obf_x_B_2963.getStirpObject(GameContext.localPlayer.fullInfo.stirpLevel),["havePotential"]);
         if(GameContext.localPlayer.fullInfo.potentialValue < _loc2_)
         {
            WindowManager.showMessageBox(DiversityManager.getString("stirpBoxUI","noPotential",[_loc2_]));
            return;
         }
         if(!ConditionScript.checkCondition(JSONUtil.getObject(obf_x_B_2963.getStirpObject(GameContext.localPlayer.fullInfo.stirpLevel),["spirtCondition"]),null,true))
         {
            return;
         }
         obf_x_B_2963.sendStirpPotential(false,GameContext.localPlayer.fullInfo.stirpLevel);
      }
      
      private function setStirpName(param1:String) : void
      {
         stirpName.htmlText = param1;
         this.obf_x_I_4151 = param1;
      }
      
      public function setPotentialNum(param1:int) : void
      {
         obf_N_j_765.text = param1 + "";
      }
      
      public function setBlueLv(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         if(param1 < 1)
         {
            param1 = 1;
         }
         if(param1 < obf_x_B_2963.getStirpBlueStar() + 2)
         {
            _loc2_ = 0;
         }
         else if(param1 % (obf_x_B_2963.getStirpBlueStar() + 1) > 0)
         {
            _loc2_ = param1 / (obf_x_B_2963.getStirpBlueStar() + 1);
         }
         else
         {
            _loc2_ = param1 / (obf_x_B_2963.getStirpBlueStar() + 1) - 1;
         }
         var _loc3_:int = _loc2_ * (obf_x_B_2963.getStirpBlueStar() + 1);
         var _loc4_:int = 0;
         while(_loc4_ < 9)
         {
            _loc6_ = this["bule" + _loc4_];
            if(_loc6_)
            {
               _loc6_.visible = false;
            }
            _loc4_++;
         }
         var _loc5_:int = 0;
         while(_loc5_ < param1 - _loc3_ - 1)
         {
            _loc7_ = this["bule" + _loc5_];
            if(_loc7_)
            {
               _loc7_.visible = true;
            }
            _loc5_++;
         }
      }
      
      public function setRedLv(param1:int) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1)
         {
            _loc4_ = this["red" + _loc2_];
            if(_loc4_)
            {
               _loc4_.alpha = 1;
            }
            _loc2_++;
         }
         var _loc3_:int = param1;
         while(_loc3_ < 5)
         {
            _loc5_ = this["red" + _loc3_];
            if(_loc5_)
            {
               _loc5_.alpha = 0;
            }
            _loc3_++;
         }
      }
      
      private function showEffer(param1:MovieClip) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc2_:int = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = new RedEyesMC();
            _loc4_ = this["red" + _loc2_];
            _loc3_.x = _loc4_.x;
            _loc3_.y = _loc4_.y;
            obf_K_e_3075.showUITween(_loc3_,2,param1.x,param1.y,this,0.8,0.8,true);
            _loc2_++;
         }
      }
      
      public function showUITweenActs(param1:DisplayObject, param2:Array = null) : void
      {
         if(!param1 || !param2 || param2.length == 0)
         {
            return;
         }
         var _loc3_:Object = param2.shift();
         if(!_loc3_)
         {
            return;
         }
         _loc3_.onComplete = this.obf_r_o_3493;
         TweenLite.to(param1,_loc3_.showTimeSec,_loc3_);
      }
      
      private function obf_r_o_3493() : void
      {
      }
      
      private function showLvUpEffer() : void
      {
         while(rolePoint.numChildren > 0)
         {
            rolePoint.removeChildAt(0);
         }
         obf_0_P_4381.obf_m_X_1194("b00@f159",rolePoint);
      }
      
      private function addUIMouseToolTip(param1:InteractiveObject, param2:int, param3:int) : void
      {
         mouseTipMap[param1] = param2;
         mouseTipMapI[param1] = param3;
         param1.addEventListener(MouseEvent.MOUSE_OVER,this.obf_Z_l_1286);
         param1.addEventListener(MouseEvent.MOUSE_OUT,this.obf_0_6_9_109);
      }
      
      private function removeUIMouseToolTip(param1:InteractiveObject) : void
      {
         var mouseTipObj:InteractiveObject = param1;
         delete mouseTipMap[mouseTipObj];
         delete mouseTipMapI[mouseTipObj];
         try
         {
            mouseTipObj.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_Z_l_1286);
            mouseTipObj.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_0_6_9_109);
         }
         catch(e:Error)
         {
         }
      }
      
      private function obf_Z_l_1286(param1:MouseEvent) : void
      {
         var _loc4_:Array = null;
         var _loc5_:Object = null;
         var _loc6_:Number = NaN;
         var _loc7_:Object = null;
         var _loc8_:Number = NaN;
         var _loc9_:Object = null;
         var _loc10_:Number = NaN;
         var _loc2_:GameTipUI = new GameTipUI("StirpMouseTip");
         var _loc3_:int = 200;
         if(mouseTipMap[param1.currentTarget] == 0)
         {
            _loc3_ = 150;
            _loc4_ = obf_x_B_2963.getRedAttributesInfo(mouseTipMapI[param1.currentTarget]);
            if((Boolean(_loc4_)) && _loc4_.length > 0)
            {
               for each(_loc5_ in _loc4_)
               {
                  _loc6_ = GameItemManager.getItemQualityValue(_loc5_.value,0);
                  _loc2_.addTipInfo("<FONT color=\'#00FF00\'>" + RoleAttributesModifierEnum.getAttributesName(_loc5_.attr) + "</FONT>",_loc3_,_loc2_.maxRow + 1);
                  _loc2_.addTipInfo("<P align=\'right\'><FONT color=\'#00FF00\'>" + RoleAttributesModifierEnum.getAttributesValueString(_loc5_.attr,_loc6_) + "</FONT></P>",_loc3_,_loc2_.maxRow);
               }
               if(GameContext.localPlayer.fullInfo.potentialLevel <= mouseTipMapI[param1.currentTarget])
               {
                  _loc2_.addTipInfo("<P align=\'center\'><FONT color=\'#FF0000\'>" + DiversityManager.getString("stirpBoxUI","havePotential",[JSONUtil.getInt(obf_x_B_2963.getStirpObject(GameContext.localPlayer.fullInfo.stirpLevel),["havePotential"])]) + "</FONT></P>",_loc3_,_loc2_.maxRow + 1);
               }
            }
         }
         else if(mouseTipMap[param1.currentTarget] == 1)
         {
            _loc3_ = 150;
            _loc4_ = obf_x_B_2963.getBuleAttributesInfo(mouseTipMapI[param1.currentTarget]);
            if((Boolean(_loc4_)) && _loc4_.length > 0)
            {
               for each(_loc7_ in _loc4_)
               {
                  _loc8_ = GameItemManager.getItemQualityValue(_loc7_.value,0);
                  _loc2_.addTipInfo("<FONT color=\'#" + obf_0_3_0_538.obf_U_4665.toString(16) + "\'>" + RoleAttributesModifierEnum.getAttributesName(_loc7_.attr) + "</FONT>",_loc3_,_loc2_.maxRow + 1);
                  _loc2_.addTipInfo("<P align=\'right\'><FONT color=\'#" + obf_0_3_0_538.obf_U_4665.toString(16) + "\'>" + RoleAttributesModifierEnum.getAttributesValueString(_loc7_.attr,_loc8_) + "</FONT></P>",_loc3_,_loc2_.maxRow);
               }
            }
         }
         else
         {
            _loc4_ = obf_x_B_2963.allRoleAttrArr;
            _loc2_.addTipInfo("<P align=\'center\'>" + this.obf_x_I_4151 + "</P>",_loc3_,_loc2_.maxRow);
            if(Boolean(_loc4_) && _loc4_.length > 0)
            {
               for each(_loc9_ in _loc4_)
               {
                  _loc10_ = GameItemManager.getItemQualityValue(_loc9_.value,0);
                  _loc2_.addTipInfo("<FONT color=\'#" + obf_0_3_0_538.obf_T_N_2235.toString(16) + "\'>" + RoleAttributesModifierEnum.getAttributesName(_loc9_.attr) + "</FONT>",_loc3_,_loc2_.maxRow + 1);
                  _loc2_.addTipInfo("<P align=\'right\'><FONT color=\'#" + obf_0_3_0_538.obf_T_N_2235.toString(16) + "\'>" + RoleAttributesModifierEnum.getAttributesValueString(_loc9_.attr,_loc10_) + "</FONT></P>",_loc3_,_loc2_.maxRow);
               }
            }
         }
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_0_6_9_109(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("StirpMouseTip");
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
         DiversityManager.setTextField(txtDeyTitle,"stirpBoxUI","txtDeyTitle");
         DiversityManager.setTextField(potentialTxt,"stirpBoxUI","potentialTxt");
         stripTxt.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("stirpBoxUI","stripTxt") + "</a>";
         cmdStripLvs.label = DiversityManager.getString("stirpBoxUI","cmdStripLvs");
         cmdPotential.label = DiversityManager.getString("stirpBoxUI","cmdPotential");
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
         this.removeListener();
      }
   }
}

