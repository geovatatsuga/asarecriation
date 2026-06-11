package com.sunweb.game.rpg.playerUI.dragon
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.dragon.obf_Y_1494;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemSkill;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.action.obf_6_t_3568;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_9_V_1635;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import playerUI.DragonBoxUIMC;
   import playerUI.NumExp;
   import playerUI.NumberDamage;
   import playerUI.NumberDamageCS;
   
   public class obf_p_k_2342 extends DragonBoxUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      public var isClew:Boolean = true;
      
      public var isClewTen:Boolean = true;
      
      private var time:TimeLimiter;
      
      public function obf_p_k_2342()
      {
         var _loc3_:IconItemBag = null;
         this.time = new TimeLimiter(500);
         super();
         this.initDiversity();
         titleBox.mouseEnabled = false;
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         if(obf_Y_1494.obf_E_x_3442)
         {
            lookLvUP.text = "";
         }
         this.bags = new Array();
         var _loc1_:int = 1;
         while(_loc1_ < 5)
         {
            _loc3_ = new IconItemBag(this.getChildByName("bag" + _loc1_) as MovieClip,this,_loc1_);
            _loc3_.lockDrag = true;
            _loc3_.addValidType(GameItemType.SKILL);
            this.bags.push(_loc3_);
            _loc1_++;
         }
         this.setChildIndex(obf_0_5_N_657,this.numChildren - 1);
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.underline = true;
         lookLvUP.setTextFormat(_loc2_);
         expBar.gotoAndStop(1);
         this.obf_E_P_1839();
         this.addListener();
      }
      
      private function addListener() : void
      {
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdLvUP.addEventListener(MouseEvent.CLICK,this.obf_6_i_1012);
         cmdTenLvUP.addEventListener(MouseEvent.CLICK,this.obf_3_t_4318);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdProbability.addEventListener(MouseEvent.CLICK,this.onProbability);
         cmdHide.addEventListener(MouseEvent.CLICK,this.obf_0_4_Q_158);
         if(!obf_Y_1494.obf_E_x_3442)
         {
            obf_K_e_3075.addUIMouseToolTip(lookLvUP,"lookLvUP");
         }
         obf_K_e_3075.addUIMouseToolTip(cmdProbability,"cmdProbability");
      }
      
      private function removeListener() : void
      {
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdLvUP.removeEventListener(MouseEvent.CLICK,this.obf_6_i_1012);
         cmdTenLvUP.removeEventListener(MouseEvent.CLICK,this.obf_3_t_4318);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdProbability.removeEventListener(MouseEvent.CLICK,this.onProbability);
         cmdHide.removeEventListener(MouseEvent.CLICK,this.obf_0_4_Q_158);
         if(!obf_Y_1494.obf_E_x_3442)
         {
            obf_K_e_3075.removeUIMouseToolTip(lookLvUP);
         }
         obf_K_e_3075.removeUIMouseToolTip(cmdProbability);
      }
      
      private function onClose(param1:MouseEvent) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function onStartDrag(param1:MouseEvent) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      private function obf_0_4_Q_158(param1:MouseEvent) : void
      {
         GameContext.userConfig.sst.hid = cmdHide.selected;
         GameContext.saveConfig();
         GameContext.localPlayer.obf_0_H_3969();
      }
      
      public function updateInfo() : void
      {
         this.upDataDragonBase(obf_Y_1494.obf_I_f_2441);
         this.expChange(obf_Y_1494.obf_0_6_N_262,obf_Y_1494.dragonMaxExp);
         this.upDataProbability();
         obf_Y_1494.agoLv = obf_Y_1494.obf_U_n_2740;
      }
      
      private function obf_D_N_3103() : Boolean
      {
         var _loc1_:Array = obf_Y_1494.getDragonUpgrade() as Array;
         if(!_loc1_)
         {
            return false;
         }
         if(obf_Y_1494.obf_U_n_2740 >= _loc1_.length)
         {
            WindowManager.showMessageBox(DiversityManager.getString("dragonBoxUI","dragonLv"));
            return false;
         }
         if(!obf_Y_1494.obf_E_x_3442)
         {
            if(!obf_Y_1494.getDragonMony())
            {
               return false;
            }
         }
         if(!ConditionScript.checkCondition(obf_Y_1494.dragonCondition,null,true))
         {
            return false;
         }
         return true;
      }
      
      private function obf_6_i_1012(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(this.time.checkTimeout())
         {
            if(!this.obf_D_N_3103())
            {
               return;
            }
            if(obf_Y_1494.obf_E_x_3442)
            {
               for(_loc2_ in obf_Y_1494.oneItem)
               {
                  if(obf_K_e_3075.playerBagUI.getEqualItemCount(_loc2_) < obf_Y_1494.oneItem[_loc2_])
                  {
                     WindowManager.showMessageBox(DiversityManager.getString("dragonBoxUI","noItem"));
                     return;
                  }
               }
               obf_Y_1494.sendDragonUpgradeExp();
            }
            else
            {
               if(obf_Y_1494.getDragonMony() > GameContext.localPlayer.fullInfo.money)
               {
                  WindowManager.showMessageBox(DiversityManager.getString("dragonBoxUI","lackMony",[obf_Y_1494.getDragonMony()]));
                  return;
               }
               if(this.isClew)
               {
                  WindowManager.showDragonWin(DiversityManager.getString("dragonBoxUI","onOk",[obf_Y_1494.getDragonMony()]),this.obf_o_T_1638);
                  return;
               }
               obf_Y_1494.sendDragonUpgradeExp();
            }
         }
      }
      
      private function obf_o_T_1638(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_Y_1494.sendDragonUpgradeExp();
         }
      }
      
      private function obf_3_t_4318(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!this.time.checkTimeout())
         {
            return;
         }
         if(!this.obf_D_N_3103())
         {
            return;
         }
         if(obf_Y_1494.obf_E_x_3442)
         {
            for(_loc2_ in obf_Y_1494.tenItem)
            {
               if(obf_K_e_3075.playerBagUI.getEqualItemCount(_loc2_) < obf_Y_1494.tenItem[_loc2_])
               {
                  WindowManager.showMessageBox(DiversityManager.getString("dragonBoxUI","noItem"));
                  return;
               }
            }
            obf_Y_1494.sendDragonUpgradeExp(10);
         }
         else
         {
            if(obf_Y_1494.getDragonMony() * 10 > GameContext.localPlayer.fullInfo.money)
            {
               WindowManager.showMessageBox(DiversityManager.getString("dragonBoxUI","lackMony",[obf_Y_1494.getDragonMony() * 10]));
               return;
            }
            if(!(obf_Y_1494.obf_X_R_4274 >= 10 || obf_Y_1494.obf_X_R_4274 == 0))
            {
               WindowManager.showConfirmBox(DiversityManager.getString("dragonBoxUI","makeSure"),this.obf_3_n_1089);
               return;
            }
            if(this.isClewTen)
            {
               WindowManager.showDragonWin(DiversityManager.getString("dragonBoxUI","onOk",[obf_Y_1494.getDragonMony() * 10]),this.obf_3_n_1089,1);
            }
            else
            {
               obf_Y_1494.sendDragonUpgradeExp(10);
            }
         }
      }
      
      private function obf_3_n_1089(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_Y_1494.sendDragonUpgradeExp(10);
         }
      }
      
      private function onProbability(param1:MouseEvent) : void
      {
         if(!this.time.checkTimeout())
         {
            return;
         }
         if(obf_Y_1494.obf_U_n_2740 <= 0)
         {
            return;
         }
         if(GameContext.localPlayer.fullInfo.money < obf_Y_1494.getDragonChanceMoney())
         {
            WindowManager.showMessageBox(DiversityManager.getString("dragonBoxUI","lackMony",[obf_Y_1494.getDragonChanceMoney()]));
            return;
         }
         if(obf_Y_1494.obf_X_R_4274 + obf_Y_1494.getDragonChanceNum() > obf_Y_1494.getDragonChanceNumUpper())
         {
            WindowManager.showMessageBox(DiversityManager.getString("dragonBoxUI","noExceed",[obf_Y_1494.getDragonChanceNumUpper()]));
            return;
         }
         WindowManager.showConfirmBox(DiversityManager.getString("dragonBoxUI","onProbability",[obf_Y_1494.getDragonChanceMoney(),obf_Y_1494.getDragonChanceNum()]),this.dragonBuy);
      }
      
      private function dragonBuy(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_Y_1494.sendDragonBuyUp(obf_Y_1494.obf_X_R_4274);
         }
      }
      
      public function expChange(param1:int, param2:int) : void
      {
         var _loc3_:Array = obf_Y_1494.getDragonUpgrade() as Array;
         if(!_loc3_)
         {
            return;
         }
         if(obf_Y_1494.obf_U_n_2740 >= _loc3_.length)
         {
            param1 = param2 = 0;
         }
         DiversityManager.setTextField(this.txtExp,"dragonBoxUI","upgradeExpValue",[param1,param2]);
         var _loc4_:int = 100 * Number(param1 / param2);
         if(_loc4_ < 2)
         {
            _loc4_ = 2;
         }
         expBar.gotoAndStop(_loc4_);
      }
      
      public function showEfect(param1:int, param2:int) : void
      {
         var tmc:obf_6_t_3568;
         var show:int = param1;
         var val:int = param2;
         var mc:MovieClip = null;
         if(show == 0)
         {
            mc = new NumExp();
         }
         else if(show == 1)
         {
            mc = new NumberDamageCS();
         }
         else
         {
            if(show != 2)
            {
               return;
            }
            mc = new NumberDamage();
         }
         mc.numberMC.numberLabel.text = val + "";
         tmc = new obf_6_t_3568(mc);
         tmc.allowRepeat = false;
         tmc.x = obf_0_5_N_657.x;
         tmc.y = obf_0_5_N_657.y;
         tmc.autoRemove = true;
         try
         {
            obf_0_5_N_657.addChild(tmc);
         }
         catch(e:Error)
         {
         }
      }
      
      public function upDataDragonBase(param1:Object) : void
      {
         var _loc4_:Object = null;
         if(!param1)
         {
            return;
         }
         this.obf_E_P_1839();
         txtName.htmlText = obf_Y_1494.dragonName(obf_Y_1494.obf_U_n_2740);
         var _loc2_:int = 0;
         var _loc3_:Array = param1 as Array;
         if(!_loc3_ || _loc3_.length <= 0)
         {
            return;
         }
         for each(_loc4_ in _loc3_)
         {
            _loc2_++;
            this["txt" + _loc2_].text = RoleAttributesModifierEnum.getAttributesName(_loc4_.attr) + ":";
            this["val" + _loc2_].text = _loc4_.value + "";
         }
         this.obf_0_3_I_164();
      }
      
      public function upDataProbability() : void
      {
         if(obf_Y_1494.obf_X_R_4274 > 0)
         {
            txtForceNum.text = obf_Y_1494.obf_8_f_2451 * 100 + "%";
            txtLuckNum.text = obf_Y_1494.obf_F_I_2544 * 100 + "%";
            txtForceNum.textColor = txtLuckNum.textColor = txtSpare.textColor = txtSpareNum.textColor = 16711935;
         }
         else
         {
            txtForceNum.text = obf_Y_1494.obf_V_E_3715 * 100 + "%";
            txtLuckNum.text = obf_Y_1494.obf_2_U_1276 * 100 + "%";
            txtForceNum.textColor = txtLuckNum.textColor = txtSpare.textColor = txtSpareNum.textColor = 16777215;
         }
         txtSpareNum.text = DiversityManager.getString("dragonBoxUI","spareNum",[obf_Y_1494.obf_X_R_4274]);
      }
      
      public function obf_0_3_I_164() : void
      {
         var _loc4_:IconItemSkill = null;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc1_:Array = obf_Y_1494.dragonSkills;
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:Array = obf_Y_1494.getDragonSkills() as Array;
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = IconItemSkill.getNewIconItem(_loc2_[_loc3_],1);
            if(_loc3_ < this.bags.length)
            {
               if(_loc4_)
               {
                  (this.bags[_loc3_] as IconItemBag).pushIconItem(_loc4_);
                  _loc5_ = false;
                  _loc6_ = 0;
                  while(_loc6_ < _loc1_.length)
                  {
                     if(_loc1_[_loc6_] == _loc2_[_loc3_])
                     {
                        _loc5_ = true;
                        break;
                     }
                     _loc6_++;
                  }
                  if(!_loc5_)
                  {
                     _loc4_.filters = [obf_9_V_1635.getGrayFilter()];
                  }
               }
            }
            _loc3_++;
         }
      }
      
      public function obf_E_P_1839() : void
      {
         var _loc2_:IconItemBag = null;
         txtName.text = "";
         var _loc1_:int = 1;
         while(_loc1_ < 7)
         {
            this["txt" + _loc1_].text = "";
            this["val" + _loc1_].text = "";
            _loc1_++;
         }
         for each(_loc2_ in this.bags)
         {
            _loc2_.obf_o_g_3238();
            _loc2_.dropIconItem();
         }
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
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
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
         DiversityManager.setTextField(txtDeyTitle,"dragonBoxUI","txtDeyTitle");
         DiversityManager.setTextField(txtForce,"dragonBoxUI","txtForce");
         DiversityManager.setTextField(txtLuck,"dragonBoxUI","txtLuck");
         DiversityManager.setTextField(txtSpare,"dragonBoxUI","txtSpare");
         DiversityManager.setTextField(lookLvUP,"dragonBoxUI","lookLvUP",null,true);
         cmdLvUP.label = DiversityManager.getString("dragonBoxUI","cmdLvUP");
         cmdTenLvUP.label = DiversityManager.getString("dragonBoxUI","cmdTenLvUP");
         cmdProbability.label = DiversityManager.getString("dragonBoxUI","cmdProbability");
         cmdHide.label = DiversityManager.getString("dragonBoxUI","cmdHide");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.isClew = true;
         this.isClewTen = true;
         cmdHide.selected = JSONUtil.getBoolean(GameContext.userConfig,["sst","hid"]);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.obf_E_P_1839();
         this.removeListener();
      }
   }
}

