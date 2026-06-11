package com.sunweb.game.rpg.playerUI.angel
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.angel.AngelInfo;
   import com.sunweb.game.rpg.angel.obf_O_7_1100;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.ui.HeadIconCode;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.obf_9_V_1635;
   import fl.events.ScrollEvent;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   import playerUI.AngelUIMC;
   
   public class AngelBoxUI extends AngelUIMC implements IIconItemUI, IPlayerUI
   {
      
      private var bags:Array;
      
      private var openObiect:Array;
      
      private var angelEquBag:Array;
      
      private var _rankMap:Object;
      
      private var obf_t_p_4421:int;
      
      private var obf_i_V_2786:int;
      
      private var _angelList:Array;
      
      private var obf_K_5_2033:Number;
      
      private var roleAttrArr:Array;
      
      public function AngelBoxUI()
      {
         var _loc4_:MovieClip = null;
         var _loc5_:IconItemBag = null;
         var _loc6_:MovieClip = null;
         var _loc7_:TextField = null;
         super();
         this.x = GameContext.gameStage.stageWidth / 2 + 150;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         titleBox.mouseEnabled = false;
         this.bags = new Array();
         this.angelEquBag = new Array();
         this.openObiect = new Array();
         var _loc1_:Array = obf_O_7_1100.angelRank;
         if(!_loc1_)
         {
            return;
         }
         _loc1_.sortOn("level",Array.NUMERIC);
         var _loc2_:int = 0;
         while(_loc2_ < 9)
         {
            _loc4_ = this["icon" + _loc2_];
            if(_loc4_ != null)
            {
               _loc5_ = new IconItemBag(_loc4_,this,_loc2_);
               _loc5_.isLocked = true;
               _loc5_.showInfoTip = true;
               _loc5_.addValidType(GameItemType.ALL);
               this.angelEquBag.push(_loc5_);
               _loc6_ = this["open" + _loc2_];
               _loc6_.mouseEnabled = false;
               _loc6_.config = _loc1_[_loc2_];
               _loc6_.txt.mouseEnabled = false;
               _loc6_.txt.text = DiversityManager.getString("AngelBoxUI","angelBagLevelOpen",[_loc1_[_loc2_].openLv]);
               _loc7_ = this["txtAngel" + _loc2_];
               _loc7_.text = _loc1_[_loc2_].name;
               this.openObiect.push(_loc6_);
               this.bags.push(_loc5_);
            }
            this.setChildIndex(this["open" + _loc2_],this.numChildren - 1);
            _loc2_++;
         }
         this.initDiversity();
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.underline = true;
         txtExplain.setTextFormat(_loc3_);
         levelBar.gotoAndStop(1);
         this.addListener();
      }
      
      private function addListener() : void
      {
         var _loc1_:IconItemBag = null;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdUp.addEventListener(MouseEvent.CLICK,this.obf_e_s_3253);
         cmdGoto.addEventListener(MouseEvent.CLICK,this.obf_h_z_4608);
         cmdGoto.addEventListener(MouseEvent.MOUSE_OVER,this.obf_n_I_2361);
         cmdGoto.addEventListener(MouseEvent.MOUSE_OUT,this.obf_y_f_2202);
         obf_H_w_3575.addEventListener(ScrollEvent.SCROLL,this.obf_3_S_1490);
         for each(_loc1_ in this.angelEquBag)
         {
            _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.onShowAngelEquTip);
            _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this.obf_0_6_L_467);
         }
         obf_K_e_3075.addUIMouseToolTip(txtExplain,"AngelBoxUIExplain");
      }
      
      private function removeListener() : void
      {
         var _loc1_:IconItemBag = null;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdUp.removeEventListener(MouseEvent.CLICK,this.obf_e_s_3253);
         cmdGoto.removeEventListener(MouseEvent.CLICK,this.obf_h_z_4608);
         cmdGoto.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_n_I_2361);
         cmdGoto.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_y_f_2202);
         obf_H_w_3575.removeEventListener(ScrollEvent.SCROLL,this.obf_3_S_1490);
         for each(_loc1_ in this.angelEquBag)
         {
            _loc1_.removeEventListener(MouseEvent.MOUSE_OVER,this.onShowAngelEquTip);
            _loc1_.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_0_6_L_467);
         }
         obf_K_e_3075.removeUIMouseToolTip(txtExplain);
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
      
      private function obf_e_s_3253(param1:Event) : void
      {
         var _loc2_:Array = obf_O_7_1100.angelGodExpList;
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_.length <= this.obf_i_V_2786)
         {
            return;
         }
         if(this.obf_t_p_4421 < _loc2_[this.obf_i_V_2786])
         {
            WindowManager.showMessageBox(DiversityManager.getString("AngelBoxUI","noGodExp"));
            return;
         }
         obf_O_7_1100.sendPlayerAngelGodUpReq();
      }
      
      private function obf_h_z_4608(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(obf_O_7_1100.angelFreeDayTimes < 1)
         {
            if(obf_O_7_1100.angelChargeDayTimes < 1)
            {
               WindowManager.showMessageBox(DiversityManager.getString("AngelBoxUI","noTimes"));
               return;
            }
            _loc2_ = "";
            _loc3_ = obf_O_7_1100.angelItemCode;
            _loc4_ = "";
            if(obf_K_e_3075.playerBagUI.getEqualItemCount(_loc3_) < 1)
            {
               WindowManager.showMessageBox(DiversityManager.getString("AngelBoxUI","noItems",[GameItemManager.getItemName(_loc3_)]));
               return;
            }
            if(obf_K_e_3075.playerBagUI.getEqualItemCount(_loc3_) > 0)
            {
               _loc4_ = "00ff00";
            }
            else
            {
               _loc4_ = "ff0000";
            }
            _loc2_ += "<font color=\'#" + _loc4_ + "\'>" + GameItemManager.getItemName(_loc3_) + " " + "x1" + "</font>\n";
            WindowManager.showConfirmBox(DiversityManager.getString("AngelBoxUI","haveItems",[_loc2_]),this.obf_i_k_2402);
         }
         else
         {
            obf_O_7_1100.sendPlayerAngelEnterReq();
            this.onClose(null);
         }
      }
      
      private function obf_i_k_2402(param1:Object) : void
      {
         var _loc2_:String = null;
         if(param1.confirm)
         {
            _loc2_ = obf_O_7_1100.angelItemCode;
            obf_O_7_1100.sendPlayerAngelEnterReq();
            this.onClose(null);
         }
      }
      
      private function obf_n_I_2361(param1:MouseEvent) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("AngelGotoTip");
         var _loc3_:int = 200;
         _loc2_.addTipInfo(DiversityManager.getString("AngelBoxUI","enterTimes",[obf_O_7_1100.angelFreeDayTimes,obf_O_7_1100.angelChargeDayTimes]),_loc3_,1);
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_y_f_2202(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("AngelGotoTip");
      }
      
      private function onShowAngelEquTip(param1:MouseEvent) : void
      {
         var _loc9_:IconItemBag = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:String = null;
         var _loc13_:Object = null;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc17_:* = undefined;
         var _loc18_:Object = null;
         var _loc19_:* = undefined;
         var _loc20_:* = undefined;
         var _loc21_:Object = null;
         var _loc22_:* = undefined;
         var _loc23_:* = undefined;
         var _loc2_:GameTipUI = new GameTipUI("ShowAngelEquTip");
         var _loc3_:int = 200;
         if(!param1.currentTarget.haveIconItem)
         {
            return;
         }
         var _loc4_:String = param1.currentTarget.haveIconItem.itemCode;
         var _loc5_:Array = obf_O_7_1100.angelGetAngelConf;
         if(!_loc5_)
         {
            return;
         }
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         while(_loc7_ < 9)
         {
            _loc9_ = this.angelEquBag[_loc7_];
            if(_loc9_.haveIconItem)
            {
               if(_loc9_.haveIconItem.itemCode == _loc4_)
               {
                  _loc6_ = _loc9_.itemIndex + 1;
               }
            }
            _loc7_++;
         }
         var _loc8_:int = 0;
         while(_loc8_ < _loc5_.length)
         {
            if(_loc4_ == _loc5_[_loc8_].pic)
            {
               _loc10_ = 0;
               _loc11_ = 0;
               while(_loc11_ < this._angelList.length)
               {
                  if(this._angelList[_loc11_].id == _loc5_[_loc8_].id)
                  {
                     _loc10_ = int(this._angelList[_loc11_].level);
                  }
                  _loc11_++;
               }
               _loc12_ = "";
               _loc2_.addTipInfo("<p align=\'center\'>" + _loc5_[_loc8_].name + "</p>",_loc3_,0);
               _loc2_.addTipInfo(DiversityManager.getString("AngelBoxUI","txtIntelligence"),_loc3_,_loc2_.maxRow + 1);
               _loc2_.addTipInfo("<p align=\'right\'>" + _loc5_[_loc8_].grow + "</p>",_loc3_,_loc2_.maxRow);
               if(_loc5_[_loc8_].attr)
               {
                  _loc13_ = _loc5_[_loc8_].attr;
                  for(_loc14_ in _loc13_)
                  {
                     _loc15_ = _loc13_[_loc14_];
                     _loc16_ = _loc5_[_loc8_].grow;
                     _loc18_ = obf_O_7_1100.angelMulByLv;
                     for(_loc19_ in _loc18_)
                     {
                        if(_loc19_ == _loc14_)
                        {
                           _loc17_ = _loc18_[_loc19_];
                           break;
                        }
                     }
                     _loc21_ = obf_O_7_1100.angelMulByRa;
                     for(_loc22_ in _loc21_)
                     {
                        if(_loc22_ == _loc14_)
                        {
                           _loc20_ = _loc21_[_loc22_];
                           break;
                        }
                     }
                     _loc23_ = _loc15_ * _loc16_ * (1 + _loc10_ * _loc17_) * (1 + _loc6_ * _loc20_);
                     _loc2_.addTipInfo("<FONT color=\'#FFAE40\'>" + RoleAttributesModifierEnum.getAttributesName(_loc14_) + "</FONT>",_loc3_,_loc2_.maxRow + 1);
                     _loc2_.addTipInfo("<P align=\'right\'><FONT color=\'#FFAE40\'>" + Math.round(_loc23_) + "</FONT></P>",_loc3_,_loc2_.maxRow);
                  }
               }
            }
            _loc8_++;
         }
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_0_6_L_467(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("ShowAngelEquTip");
      }
      
      private function obf_3_S_1490(param1:ScrollEvent) : void
      {
         itemPoint.scrollRect = new Rectangle(0,param1.position,obf_H_w_3575.x - itemPoint.x,obf_H_w_3575.height);
         this.obf_K_5_2033 = param1.position;
      }
      
      private function headIconChange(param1:int) : void
      {
         while(headIconPoint.numChildren > 0)
         {
            headIconPoint.removeChildAt(0);
            txtRoleName.text = "";
         }
         var _loc2_:DisplayObject = HeadIconCode.getHeadIconByInt(param1);
         headIconPoint.addChild(_loc2_);
         txtRoleName.htmlText = DiversityManager.getString("AngelBoxUI","txtRoleName_") + GameContext.localPlayer.fullInfo.name;
      }
      
      private function obf_0_1_B_496() : void
      {
         var _loc2_:IconItemBag = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.angelEquBag.length)
         {
            _loc2_ = this.angelEquBag[_loc1_];
            if(_loc2_)
            {
               if(this.obf_i_V_2786 >= this.openObiect[_loc1_].config.openLv)
               {
                  _loc2_.isLocked = this.openObiect[_loc1_].visible = false;
               }
            }
            _loc1_++;
         }
      }
      
      private function clone(param1:*) : *
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      public function showAngelList() : void
      {
         var _loc8_:int = 0;
         var _loc9_:IconItem = null;
         var _loc10_:obf_K_q_2694 = null;
         var _loc11_:int = 0;
         this.obf_S_u_3322();
         var _loc1_:int = 0;
         itemPoint.scrollRect = new Rectangle(0,0,obf_H_w_3575.x - itemPoint.x,obf_H_w_3575.height);
         var _loc2_:Array = obf_O_7_1100.angelGetAngelConf;
         var _loc3_:Array = this.clone(_loc2_) as Array;
         if(!_loc2_)
         {
            return;
         }
         var _loc4_:Array = [];
         var _loc5_:int = 0;
         while(_loc5_ < this._angelList.length)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc3_.length)
            {
               if(_loc3_[_loc8_].id == (this._angelList[_loc5_] as AngelInfo).id)
               {
                  _loc4_.push(_loc3_[_loc8_]);
                  _loc3_.splice(_loc8_,1);
                  break;
               }
               _loc8_++;
            }
            _loc5_++;
         }
         _loc4_.sortOn("grow",Array.DESCENDING);
         _loc3_.sortOn("grow",Array.DESCENDING);
         var _loc6_:Array = _loc4_.concat(_loc3_);
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_.length)
         {
            _loc9_ = IconItemManager.getIconItemByCode(_loc6_[_loc7_].pic,"");
            if(_loc9_)
            {
               _loc10_ = new obf_K_q_2694(this);
               _loc10_.iconBag.pushIconItem(_loc9_);
               this.bags.push(_loc10_.iconBag);
               _loc10_.setConfig(_loc6_[_loc7_]);
               if(Boolean(this._angelList) && this._angelList.length > 0)
               {
                  _loc11_ = 0;
                  while(_loc11_ < this._angelList.length)
                  {
                     if(this._angelList[_loc11_].id == _loc6_[_loc7_].id)
                     {
                        _loc10_.bg.filters = [];
                        break;
                     }
                     _loc10_.bg.filters = [obf_9_V_1635.getGrayFilter()];
                     _loc11_++;
                  }
               }
               else
               {
                  _loc10_.bg.filters = [obf_9_V_1635.getGrayFilter()];
               }
               _loc10_.y = _loc1_;
               itemPoint.addChild(_loc10_);
               _loc1_ += _loc10_.height + 3;
            }
            _loc7_++;
         }
         if(_loc1_ <= obf_H_w_3575.height)
         {
            obf_H_w_3575.visible = false;
         }
         else
         {
            obf_H_w_3575.visible = true;
            obf_H_w_3575.maxScrollPosition = _loc1_ - obf_H_w_3575.height;
            obf_H_w_3575.scrollPosition = this.obf_K_5_2033;
         }
      }
      
      private function obf_S_u_3322() : void
      {
         var _loc1_:obf_K_q_2694 = null;
         while(itemPoint.numChildren > 0)
         {
            _loc1_ = itemPoint.getChildAt(0) as obf_K_q_2694;
            if(_loc1_)
            {
               _loc1_.destroy();
            }
            itemPoint.removeChildAt(0);
            obf_H_w_3575.maxScrollPosition = 0;
         }
      }
      
      private function showGodLevel(param1:int, param2:int) : void
      {
         var _loc3_:Array = obf_O_7_1100.angelGodExpList;
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:int = 100 * Number(param1 / _loc3_[param2]);
         if(_loc4_ < 2)
         {
            _loc4_ = 2;
         }
         levelBar.gotoAndStop(_loc4_);
         txtLevelValue.text = "";
         txtLevel.text = "";
         txtLevel.text = DiversityManager.getString("AngelBoxUI","godLevel",[param2]);
         if(param2 >= _loc3_.length)
         {
            cmdUp.label = DiversityManager.getString("AngelBoxUI","cmdUpMax");
            cmdUp.enabled = false;
            return;
         }
         txtLevelValue.text = param1 + "/" + _loc3_[param2];
      }
      
      public function angelEqu(param1:Object) : void
      {
         var _loc2_:IconItemBag = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:IconItem = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:Object = null;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc17_:Object = null;
         var _loc18_:* = undefined;
         var _loc19_:* = undefined;
         var _loc20_:Object = null;
         var _loc21_:* = undefined;
         var _loc22_:* = undefined;
         this._rankMap = param1;
         for each(_loc2_ in this.angelEquBag)
         {
            _loc2_.dropIconItem();
         }
         this.roleAttrArr = new Array();
         _loc3_ = obf_O_7_1100.angelRank;
         _loc4_ = obf_O_7_1100.angelGetAngelConf;
         if(!_loc3_ || !_loc4_)
         {
            return;
         }
         for(_loc5_ in param1)
         {
            _loc6_ = 0;
            while(_loc6_ < 9)
            {
               if(_loc5_ == _loc3_[this.angelEquBag[_loc6_].itemIndex].id)
               {
                  _loc7_ = 0;
                  while(_loc7_ < _loc4_.length)
                  {
                     if(_loc4_[_loc7_].id == param1[_loc5_])
                     {
                        _loc8_ = IconItemManager.getIconItemByCode(_loc4_[_loc7_].pic,"");
                        if(_loc8_)
                        {
                           (this.angelEquBag[_loc6_] as IconItemBag).pushIconItem(_loc8_);
                           _loc9_ = 0;
                           _loc10_ = this.angelEquBag[_loc6_].itemIndex + 1;
                           _loc11_ = 0;
                           while(_loc11_ < this._angelList.length)
                           {
                              if(this._angelList[_loc11_].id == _loc4_[_loc7_].id)
                              {
                                 _loc9_ = int(this._angelList[_loc11_].level);
                              }
                              _loc11_++;
                           }
                           _loc12_ = _loc4_[_loc7_].attr;
                           for(_loc13_ in _loc12_)
                           {
                              _loc14_ = _loc12_[_loc13_];
                              _loc15_ = _loc4_[_loc7_].grow;
                              _loc17_ = obf_O_7_1100.angelMulByLv;
                              for(_loc18_ in _loc17_)
                              {
                                 if(_loc18_ == _loc13_)
                                 {
                                    _loc16_ = _loc17_[_loc18_];
                                    break;
                                 }
                              }
                              _loc20_ = obf_O_7_1100.angelMulByRa;
                              for(_loc21_ in _loc20_)
                              {
                                 if(_loc21_ == _loc13_)
                                 {
                                    _loc19_ = _loc20_[_loc21_];
                                    break;
                                 }
                              }
                              _loc22_ = _loc14_ * _loc15_ * (1 + _loc9_ * _loc16_) * (1 + _loc10_ * _loc19_);
                              this.obf_e_F_3512(_loc13_,Math.round(_loc22_));
                           }
                        }
                        break;
                     }
                     _loc7_++;
                  }
               }
               _loc6_++;
            }
         }
      }
      
      private function obf_e_F_3512(param1:int, param2:Number) : void
      {
         var _loc5_:Object = null;
         var _loc6_:Array = null;
         var _loc9_:Object = null;
         var _loc3_:Boolean = false;
         var _loc4_:Object = new Object();
         for each(_loc5_ in this.roleAttrArr)
         {
            if(_loc5_.attr == param1)
            {
               _loc5_.value += param2;
               _loc3_ = true;
            }
         }
         if(!_loc3_)
         {
            _loc4_["attr"] = param1;
            _loc4_["value"] = param2;
            this.roleAttrArr.push(_loc4_);
         }
         _loc6_ = this.allRoleAttrArr;
         var _loc7_:String = txtAttrName.text = "";
         var _loc8_:String = txtAttrValue.text = "";
         if(Boolean(_loc6_) && _loc6_.length > 0)
         {
            for each(_loc9_ in _loc6_)
            {
               _loc7_ += RoleAttributesModifierEnum.getAttributesName(_loc9_.attr) + "\n";
               _loc8_ += RoleAttributesModifierEnum.getAttributesValueString(_loc9_.attr,_loc9_.value) + "\n";
            }
            txtAttrName.text = _loc7_;
            txtAttrValue.text = _loc8_;
         }
      }
      
      private function get allRoleAttrArr() : Array
      {
         var _loc2_:Object = null;
         var _loc3_:Boolean = false;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in this.roleAttrArr)
         {
            _loc3_ = false;
            _loc4_ = new Object();
            for each(_loc5_ in _loc1_)
            {
               if(_loc5_.attr == _loc2_.attr)
               {
                  _loc5_.value += _loc2_.value;
                  _loc3_ = true;
               }
            }
            if(!_loc3_)
            {
               _loc4_["attr"] = _loc2_.attr;
               _loc4_["value"] = _loc2_.value;
               _loc1_.push(_loc4_);
            }
         }
         return _loc1_;
      }
      
      public function angelGodExp(param1:int) : void
      {
         this.obf_t_p_4421 = param1;
         this.showGodLevel(param1,this.obf_i_V_2786);
      }
      
      public function angelGodLevel(param1:int) : void
      {
         this.obf_i_V_2786 = param1;
         this.obf_0_1_B_496();
         if(this.obf_i_V_2786 >= obf_O_7_1100.angelGodExpList.length)
         {
            cmdUp.enabled = false;
            cmdUp.label = DiversityManager.getString("AngelBoxUI","cmdCultivateMax");
         }
      }
      
      public function angelListInfo(param1:Array) : void
      {
         this._angelList = param1;
         this.angelEqu(this._rankMap);
         this.showAngelList();
      }
      
      public function isFullExp() : Boolean
      {
         var _loc1_:Array = obf_O_7_1100.angelGodExpList;
         if(!_loc1_)
         {
            return false;
         }
         return this.obf_t_p_4421 >= _loc1_[this.obf_i_V_2786] ? true : false;
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         if(!param1)
         {
            return;
         }
         if(param1.isLocked || param3.isLocked)
         {
            return;
         }
         if(Boolean(param1) && this.angelEquBag.indexOf(param1) == -1)
         {
            return;
         }
         var _loc4_:Array = obf_O_7_1100.angelRank;
         if(!_loc4_)
         {
            return;
         }
         var _loc5_:String = "";
         var _loc6_:String = "";
         _loc5_ = _loc4_[param1.itemIndex].id;
         var _loc7_:Array = obf_O_7_1100.angelGetAngelConf;
         if(!_loc7_)
         {
            return;
         }
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_.length)
         {
            if(_loc7_[_loc8_].pic == param2.itemCode)
            {
               _loc6_ = _loc7_[_loc8_].id;
               break;
            }
            _loc8_++;
         }
         obf_O_7_1100.sendPlayerAngelEquReq(_loc5_,_loc6_);
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return bgBox.getBounds(bgBox).contains(bgBox.mouseX,bgBox.mouseY);
         }
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"AngelBoxUI","txtDeyTitle");
         DiversityManager.setTextField(txtRoleAttr,"AngelBoxUI","txtRoleAttr");
         DiversityManager.setTextField(txtDeyTitle,"AngelBoxUI","txtDeyTitle");
         DiversityManager.setTextField(txtDeyTitle,"AngelBoxUI","txtDeyTitle");
         txtExplain.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("AngelBoxUI","txtExplain") + "</a>";
         cmdUp.label = DiversityManager.getString("AngelBoxUI","cmdUp");
         cmdGoto.label = DiversityManager.getString("AngelBoxUI","cmdGoto");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.headIconChange(GameContext.localPlayer.fullInfo.headIconIndex);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         var _loc1_:IconItemBag = null;
         this.removeListener();
         for each(_loc1_ in this.bags)
         {
            _loc1_.destroy();
         }
         this.bags = null;
      }
   }
}

