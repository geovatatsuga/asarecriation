package com.sunweb.game.rpg.playerUI.playerBook
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerBook.obf_E_1429;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.playerUI.skill.obf_b_5_962;
   import com.sunweb.game.rpg.role.SkillConfig;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.PlayerBookUIMC;
   import playerUI.SkillShowBoxUIMC;
   
   public class obf_g_b_924 extends PlayerBookUIMC implements IIconItemUI, IPlayerUI
   {
      
      private var bags:Array;
      
      private var skillShowBoxList:Array;
      
      private var bookSkillList:Array;
      
      private var autoBool:Boolean = false;
      
      private var upNeed:int = -1;
      
      private var maxExp:int;
      
      private var obf_T_6_2006:int;
      
      private var obf_o_K_795:int;
      
      private var _bookTimePoint:int;
      
      private var obf_m_5_901:Object;
      
      private var obf_M_5_956:TimeLimiter;
      
      public function obf_g_b_924()
      {
         var _loc2_:Object = null;
         var _loc3_:SkillShowBoxUIMC = null;
         var _loc4_:obf_b_5_962 = null;
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         titleBox.mouseEnabled = false;
         bgBox2.mouseEnabled = false;
         bgBox3.mouseEnabled = false;
         this.obf_E_P_1839();
         expBar.gotoAndStop(1);
         this.showLevelPic();
         this.setStars(0,10);
         this.bags = new Array();
         this.bookSkillList = JSONUtil.getObject(SkillConfig.skillConfig,["playerBookSkill"],[]) as Array;
         this.skillShowBoxList = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            _loc2_ = JSONUtil.getObject(this.bookSkillList,[_loc1_]);
            _loc3_ = this["skillBag" + _loc1_];
            if(!(!_loc3_ || !_loc2_))
            {
               _loc4_ = new obf_b_5_962(_loc3_,this,_loc2_.code);
               this.skillShowBoxList.push(_loc4_);
               this.bags.push(_loc4_.iconBag);
            }
            _loc1_++;
         }
         this.addListener();
      }
      
      private function addListener() : void
      {
         var _loc1_:obf_b_5_962 = null;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdUp.addEventListener(MouseEvent.CLICK,this.obf_e_s_3253);
         cmdAuto.addEventListener(MouseEvent.CLICK,this.obf_x_n_2899);
         for each(_loc1_ in this.skillShowBoxList)
         {
            _loc1_.addEventListener(obf_b_5_962.obf_F_c_4296,this.obf_X_s_1010);
         }
         picTips.addEventListener(MouseEvent.MOUSE_OVER,this.obf_V_b_3774);
         picTips.addEventListener(MouseEvent.MOUSE_OUT,this.obf_9_t_4509);
      }
      
      private function removeListener() : void
      {
         var _loc1_:obf_b_5_962 = null;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdUp.removeEventListener(MouseEvent.CLICK,this.obf_e_s_3253);
         cmdAuto.removeEventListener(MouseEvent.CLICK,this.obf_x_n_2899);
         for each(_loc1_ in this.skillShowBoxList)
         {
            _loc1_.removeEventListener(obf_b_5_962.obf_F_c_4296,this.obf_X_s_1010);
         }
         picTips.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_V_b_3774);
         picTips.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_9_t_4509);
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
         if(this.obf_T_6_2006 < 1)
         {
            WindowManager.showMessageBox(DiversityManager.getString("playerBookUI","warn_NotOpen"));
            return;
         }
         if(this._bookTimePoint < this.upNeed)
         {
            WindowManager.showMessageBox(DiversityManager.getString("playerBookUI","warn_NotTime"));
            return;
         }
         obf_E_1429.sendPlayerBookUpReq();
      }
      
      private function obf_x_n_2899(param1:Event) : void
      {
         if(this.obf_T_6_2006 < 1)
         {
            WindowManager.showMessageBox(DiversityManager.getString("playerBookUI","warn_NotOpen"));
            return;
         }
         if(this._bookTimePoint < this.upNeed)
         {
            WindowManager.showMessageBox(DiversityManager.getString("playerBookUI","warn_NotTime"));
            return;
         }
         this.obf_M_5_956 = new TimeLimiter(300);
         cmdAuto.enabled = false;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(Boolean(this.obf_M_5_956) && this.obf_M_5_956.checkTimeout())
         {
            obf_E_1429.sendPlayerBookUpReq();
         }
         if(this._bookTimePoint < this.upNeed || !this.obf_M_5_956)
         {
            this.obf_M_5_956 = null;
            cmdAuto.enabled = true;
         }
         if(this.obf_T_6_2006 >= obf_E_1429.bookConfig.length)
         {
            cmdUp.enabled = false;
            cmdAuto.enabled = false;
         }
      }
      
      private function obf_X_s_1010(param1:Event) : void
      {
         var _loc2_:obf_b_5_962 = param1.currentTarget as obf_b_5_962;
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:Object = PlayerSkillManager.getUpSkillCondition(_loc2_.itemCode,PlayerSkillManager.getSkillLevel(_loc2_.itemCode) + 1);
         if(ConditionScript.checkCondition(_loc3_,null,true))
         {
            WindowManager.showConfirmBox(DiversityManager.getString("playerBookUI","confirm_LearnSkill"),this.confirmUpSkill,_loc2_.itemCode);
         }
      }
      
      private function confirmUpSkill(param1:Object) : void
      {
         if(param1.confirm)
         {
            PlayerSkillManager.sendLearnSkill(param1.par,PlayerSkillManager.obf_n_4681);
         }
      }
      
      private function obf_V_b_3774(param1:Event) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("PlayerBookPicTips");
         _loc2_.addTipInfo("<P align=\'left\'><font color=\'#FFFF00\'>" + obf_E_1429.obf_0_9_E_277 + "</font></p>",200,0);
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_9_t_4509(param1:Event) : void
      {
         GameTipManager.closeTip("PlayerBookPicTips");
      }
      
      private function obf_E_P_1839() : void
      {
         txtName.text = "";
         txtAttrsName.text = "";
         txtAttrsValue.text = "";
         txtExp.text = "";
         txtNum.text = "";
      }
      
      private function showLevelPic(param1:int = 1) : void
      {
         if(param1 < 1)
         {
            param1 = 1;
         }
         picPoint.gotoAndStop(param1);
      }
      
      private function showExp(param1:int = 1, param2:int = 1) : void
      {
         var _loc3_:int = param1 / param2 * 100;
         expBar.gotoAndStop(_loc3_);
         txtExp.text = uint(param1) + " / " + uint(param2);
      }
      
      public function showPlayerBookInfo() : void
      {
         var _loc6_:* = undefined;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         this.obf_E_P_1839();
         var _loc1_:int = this.obf_T_6_2006;
         if(_loc1_ < 1)
         {
            return;
         }
         var _loc2_:Array = obf_E_1429.bookConfig;
         if(!_loc2_ || _loc1_ > _loc2_.length)
         {
            return;
         }
         var _loc3_:Object = _loc2_[_loc1_ - 1];
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:String = "";
         var _loc5_:String = "";
         for(_loc6_ in _loc3_.attr)
         {
            _loc9_ = Number(_loc3_.attr[_loc6_]);
            _loc4_ += RoleAttributesModifierEnum.getAttributesName(_loc6_) + "\n";
            _loc5_ += RoleAttributesModifierEnum.getAttributesValueString(_loc6_,_loc9_) + "\n";
         }
         txtAttrsName.text = _loc4_;
         txtAttrsValue.text = _loc5_;
         if(_loc1_ % 10 == 0)
         {
            _loc7_ = 10;
            _loc8_ = _loc1_ / 10;
         }
         else
         {
            _loc7_ = _loc1_ % 10;
            _loc8_ = _loc1_ / 10 + 1;
         }
         if(_loc7_ < 1)
         {
            _loc7_ = 1;
         }
         txtName.text = DiversityManager.getString("playerBookUI","txtStar",[_loc8_,_loc7_]);
         this.showLevelPic(_loc8_);
         this.setStars(_loc7_,10);
         this.showExp(this.obf_o_K_795,_loc3_.upExp);
         this.upNeed = _loc3_.upNeed;
         txtNum.text = this._bookTimePoint + "/" + this.upNeed;
      }
      
      public function setStars(param1:int, param2:int) : void
      {
         var _loc3_:String = "";
         var _loc4_:int = 0;
         while(_loc4_ < param1)
         {
            _loc3_ += "★";
            _loc4_++;
         }
         var _loc5_:String = "";
         var _loc6_:int = param1;
         while(_loc6_ < param2)
         {
            _loc5_ += "☆";
            _loc6_++;
         }
         txtBookStars.htmlText = _loc3_ + "<font color=\'#999999\'>" + _loc5_ + "</font>";
      }
      
      public function getBookLevel(param1:int) : void
      {
         this.obf_T_6_2006 = param1;
      }
      
      public function isOpenBook() : Boolean
      {
         return this.obf_T_6_2006 > 0 ? true : false;
      }
      
      public function getBookExp(param1:int) : void
      {
         this.obf_o_K_795 = param1;
      }
      
      public function getBookTimePoint(param1:int) : void
      {
         this._bookTimePoint = param1;
      }
      
      public function getBookSkillMap(param1:Object) : void
      {
         this.obf_m_5_901 = param1;
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
         var _loc1_:obf_b_5_962 = null;
         DiversityManager.setTextField(txtDeyTitle,"playerBookUI","txtDeyTitle");
         DiversityManager.setTextField(txtBookSkill,"playerBookUI","txtBookSkill");
         DiversityManager.setTextField(txtAttr,"playerBookUI","txtAttr");
         DiversityManager.setTextField(txtBookUp,"playerBookUI","txtBookUp");
         DiversityManager.setTextField(txtExpend,"playerBookUI","txtExpend");
         cmdUp.label = DiversityManager.getString("playerBookUI","cmdUp");
         cmdAuto.label = DiversityManager.getString("playerBookUI","cmdAuto");
         for each(_loc1_ in this.skillShowBoxList)
         {
            _loc1_.operationButton.label = DiversityManager.getString("playerBookUI","cmdSkillUpgrade");
         }
      }
      
      public function obf_0___f_619() : void
      {
         var _loc2_:Object = null;
         var _loc3_:obf_b_5_962 = null;
         var _loc4_:Object = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.bookSkillList.length)
         {
            _loc2_ = this.bookSkillList[_loc1_];
            _loc3_ = this.skillShowBoxList[_loc1_];
            if(!(!_loc2_ || !_loc3_))
            {
               _loc3_.obf_y_4_1171({});
               _loc4_ = SkillConfig.getSkillConfig(_loc3_.itemCode);
               if(_loc4_)
               {
                  if(!this.obf_m_5_901.hasOwnProperty(_loc3_.itemCode) || _loc4_.maxLevel == PlayerSkillManager.getSkillLevel(_loc3_.itemCode))
                  {
                     _loc3_.cmdUpButton.visible = false;
                  }
                  else
                  {
                     _loc3_.cmdUpButton.visible = true;
                  }
               }
            }
            _loc1_++;
         }
      }
      
      public function showUI() : void
      {
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.visible = true;
         this.obf_0___f_619();
         this.showPlayerBookInfo();
      }
      
      public function closeUI() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.visible = false;
         this.obf_M_5_956 = null;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

