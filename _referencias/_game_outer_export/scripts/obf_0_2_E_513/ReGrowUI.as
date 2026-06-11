package obf_0_2_E_513
{
   import obf_0_2_t_601.obf_o_H_2969;
   import com.sunweb.game.rpg.GameContext;
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
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import playerUI.ReGrowUIMC;
   
   public class ReGrowUI extends ReGrowUIMC implements IPlayerUI, IIconItemUI
   {
      
      private var bags:Array;
      
      private var obf_0_5_7_110:Array;
      
      private var obf_0_9_O_472:IconItemBag;
      
      private var obf_n_l_2101:IconItemBag;
      
      private var currntExpBall:uint;
      
      private var obf_F_n_4581:int;
      
      private const dayFusionTime:String = "\t$rgmi_day";
      
      private const obf_0_7_d_221:int = 1000000000;
      
      public function ReGrowUI()
      {
         super();
         this.cacheAsBitmap = true;
         this.initDiversity();
         this.visible = false;
         txtDeyTitle.mouseEnabled = false;
         titleBox.mouseEnabled = false;
         this.onResize(null);
         this.init();
         this.addListener();
      }
      
      private function init() : void
      {
         var _loc2_:IconItemBag = null;
         this.bags = new Array();
         this.obf_0_5_7_110 = new Array();
         var _loc1_:int = 1;
         while(_loc1_ <= 6)
         {
            _loc2_ = new IconItemBag(this["icon" + _loc1_],this,_loc1_);
            _loc2_.addValidType(GameItemType.ALL);
            _loc2_.isLocked = false;
            this.obf_0_5_7_110.push(_loc2_);
            this.bags.push(_loc2_);
            _loc1_++;
         }
         this.obf_0_9_O_472 = new IconItemBag(fusionIcon,this,0);
         this.obf_0_9_O_472.addValidType(GameItemType.ALL);
         this.obf_0_9_O_472.isLocked = false;
         this.bags.push(this.obf_0_9_O_472);
         this.obf_n_l_2101 = new IconItemBag(fusionCodIcon,this,0);
         this.obf_n_l_2101.addValidType(GameItemType.ALL);
         this.obf_n_l_2101.isLocked = false;
         this.bags.push(this.obf_n_l_2101);
      }
      
      private function addListener() : void
      {
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         expBall.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseUpExpBall);
         expBall.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutExpBall);
         cmdReset.addEventListener(MouseEvent.CLICK,this.obf_W_g_1639);
         cmdInputExp.addEventListener(MouseEvent.CLICK,this.obf_k_1264);
         cmdPickExp.addEventListener(MouseEvent.CLICK,this.obf_f_M_1518);
         cmdFusion.addEventListener(MouseEvent.CLICK,this.obf_B_b_1530);
         obf_K_e_3075.addUIMouseToolTip(txtExplain,"ReGrowUI_txtExplain");
      }
      
      private function removeListener() : void
      {
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         expBall.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseUpExpBall);
         expBall.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutExpBall);
         cmdReset.removeEventListener(MouseEvent.CLICK,this.obf_W_g_1639);
         cmdInputExp.removeEventListener(MouseEvent.CLICK,this.obf_k_1264);
         cmdPickExp.removeEventListener(MouseEvent.CLICK,this.obf_f_M_1518);
         cmdFusion.removeEventListener(MouseEvent.CLICK,this.obf_B_b_1530);
         obf_K_e_3075.removeUIMouseToolTip(txtExplain);
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth / 2 - 150;
         this.y = GameContext.gameStage.stageHeight / 2 - 50;
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function showResetCondition() : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:IconItemBag = null;
         var _loc6_:IconItem = null;
         var _loc1_:Object = obf_o_H_2969.obf_I_3_3228;
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:int = 0;
         for(_loc3_ in _loc1_.itemsInBag)
         {
            if(_loc2_ > this.obf_0_5_7_110.length)
            {
               break;
            }
            _loc5_ = this.obf_0_5_7_110[_loc2_];
            _loc6_ = IconItemManager.getIconItemByCode(_loc3_,"");
            if(_loc6_)
            {
               _loc6_.itemCount = _loc1_.itemsInBag[_loc3_];
               _loc5_.pushIconItem(_loc6_);
               _loc2_++;
            }
         }
         _loc4_ = JSONUtil.getInt(_loc1_,["gold>="]);
         inputDiamond1.text = int(_loc4_ / 1000000) + "";
         inputGold1.text = int(_loc4_ % 1000000 / 10000) + "";
         inputSilver1.text = int(_loc4_ % 1000000 % 10000 / 100) + "";
         inputCopper1.text = int(_loc4_ % 1000000 % 10000 % 100) + "";
      }
      
      private function obf_Q_w_2181() : void
      {
         var _loc1_:IconItemBag = null;
         txtCurrentLv.text = txtNextLv.text = "";
         currentAttrsName.text = currentAttrsValue.text = txtDeyAttrPoint1.text = txtAttrPoint1.text = "";
         nextAttrsName.text = nextAttrsValue.text = txtDeyAttrPoint2.text = txtAttrPoint2.text = "";
         cmdReset.enabled = false;
         for each(_loc1_ in this.obf_0_5_7_110)
         {
            _loc1_.dropIconItem();
            _loc1_.obf_o_g_3238();
            _loc1_.isLocked = false;
         }
         inputDiamond1.text = "";
         inputGold1.text = "";
         inputSilver1.text = "";
         inputCopper1.text = "";
      }
      
      public function showAttrs(param1:int) : void
      {
         var _loc8_:String = null;
         var _loc9_:String = null;
         this.obf_F_n_4581 = param1;
         this.obf_Q_w_2181();
         txtCurrentLv.text = DiversityManager.getString("ReGrowUI","txtLevel",[param1]);
         txtNextLv.text = DiversityManager.getString("ReGrowUI","txtLevel",[param1 + 1]);
         DiversityManager.setTextField(txtDeyAttrPoint1,"ReGrowUI","txtDeyAttrPoint");
         DiversityManager.setTextField(txtDeyAttrPoint2,"ReGrowUI","txtDeyAttrPoint");
         txtAttrPoint1.text = obf_o_H_2969.obf_p_x_1964 * param1 + "";
         txtAttrPoint2.text = obf_o_H_2969.obf_p_x_1964 * (param1 + 1) + "";
         var _loc2_:String = "";
         var _loc3_:String = "";
         var _loc4_:String = "";
         var _loc5_:String = "";
         var _loc6_:Array = obf_o_H_2969.obf_2_2_1859;
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_.length)
         {
            _loc8_ = "";
            _loc9_ = "";
            if(param1 > 0)
            {
               _loc8_ = RoleAttributesModifierEnum.getAttributesValueString(_loc6_[_loc7_].attr,_loc6_[_loc7_].value * param1);
            }
            else
            {
               _loc8_ = 0 + "";
            }
            _loc9_ = RoleAttributesModifierEnum.getAttributesValueString(_loc6_[_loc7_].attr,_loc6_[_loc7_].value * (param1 + 1));
            _loc2_ += RoleAttributesModifierEnum.getAttributesName(_loc6_[_loc7_].attr) + "\n";
            _loc3_ += _loc8_ + "\n";
            _loc4_ += RoleAttributesModifierEnum.getAttributesName(_loc6_[_loc7_].attr) + "\n";
            _loc5_ += _loc9_ + "\n";
            _loc7_++;
         }
         if(this.obf_F_n_4581 >= obf_o_H_2969.obf_3_z_2032)
         {
            currentAttrsName.text = _loc2_;
            currentAttrsValue.text = _loc3_;
            txtCurrentLv.text = txtNextLv.text = DiversityManager.getString("ReGrowUI","txtMaxLevel");
            nextAttrsName.text = nextAttrsValue.text = txtDeyAttrPoint2.text = txtAttrPoint2.text = "";
         }
         else
         {
            this.showResetCondition();
            cmdReset.enabled = true;
            currentAttrsName.text = _loc2_;
            currentAttrsValue.text = _loc3_;
            nextAttrsName.text = _loc4_;
            nextAttrsValue.text = _loc5_;
         }
      }
      
      public function setExp(param1:uint, param2:uint) : void
      {
         var _loc3_:int = param1 / param2 * 100;
         if(_loc3_ < 1)
         {
            _loc3_ = 1;
         }
         this.expBar.gotoAndStop(_loc3_);
         txtExp.text = uint(param1) + " / " + uint(param2);
      }
      
      public function setExpBall(param1:uint) : void
      {
         this.currntExpBall = param1;
         var _loc2_:uint = obf_o_H_2969.obf_m_u_3166;
         var _loc3_:int = param1 / _loc2_ * 100;
         if(_loc3_ < 1)
         {
            _loc3_ = 1;
         }
         else
         {
            _loc3_++;
         }
         this.expBall.gotoAndStop(_loc3_);
         this.fusionCondition();
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function onMouseUpExpBall(param1:Event) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("ReGrowExpBallTip");
         var _loc3_:int = 180;
         _loc2_.addTipInfo("<p align=\'center\'>" + DiversityManager.getString("ReGrowUI","txtDeyExp") + "</p>",_loc3_,0);
         _loc2_.addTipInfo(this.currntExpBall + "/" + obf_o_H_2969.obf_m_u_3166,_loc3_,_loc2_.maxRow + 1);
         GameTipManager.showTip(_loc2_);
      }
      
      private function onMouseOutExpBall(param1:Event) : void
      {
         GameTipManager.closeTip("ReGrowExpBallTip");
      }
      
      private function obf_W_g_1639(param1:Event) : void
      {
         if(this.obf_F_n_4581 >= obf_o_H_2969.obf_3_z_2032)
         {
            WindowManager.showMessageBox(DiversityManager.getString("ReGrowUI","maxLevel"));
            return;
         }
         if(!ConditionScript.checkCondition(obf_o_H_2969.obf_I_3_3228,null,true))
         {
            return;
         }
         obf_o_H_2969.sendPlayerReGrowRequest();
      }
      
      private function obf_k_1264(param1:Event) : void
      {
         if(!ConditionScript.checkCondition(obf_o_H_2969.obf_R_o_2175,null,true))
         {
            return;
         }
         cmdInputExp.enabled = false;
         setTimeout(this.showCmdInputExp,30 * 1000);
         obf_o_H_2969.sendPlayerInOutExpRequest(1);
      }
      
      private function showCmdInputExp() : void
      {
         cmdInputExp.enabled = true;
      }
      
      private function obf_f_M_1518(param1:Event) : void
      {
         if(!ConditionScript.checkCondition(obf_o_H_2969.obf_R_o_2175,null,true))
         {
            return;
         }
         cmdPickExp.enabled = false;
         setTimeout(this.showCmdPickExp,30 * 1000);
         obf_o_H_2969.sendPlayerInOutExpRequest(2);
      }
      
      private function showCmdPickExp() : void
      {
         cmdPickExp.enabled = true;
      }
      
      private function obf_B_b_1530(param1:Event) : void
      {
         var _loc6_:String = null;
         var _loc7_:int = 0;
         if(!ConditionScript.checkCondition(obf_o_H_2969.obf_O_v_3554,null,true))
         {
            return;
         }
         var _loc2_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter(this.dayFusionTime);
         var _loc3_:int = JSONUtil.getInt(_loc2_,["numOfDay"]);
         var _loc4_:Array = obf_o_H_2969.regrowAlchemyNeed;
         var _loc5_:Object = _loc4_[_loc3_];
         if(_loc3_ >= _loc4_.length)
         {
            _loc5_ = _loc4_[_loc4_.length - 1];
         }
         else
         {
            _loc5_ = _loc4_[_loc3_];
         }
         for(_loc6_ in _loc5_.items)
         {
            if(obf_K_e_3075.playerBagUI.getEqualItemCount(_loc6_) < _loc5_.items[_loc6_])
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ReGrowUI","prompt_NoMoreMaterial",[GameItemManager.getItemName(_loc6_)]));
               return;
            }
         }
         _loc7_ = JSONUtil.getInt(_loc5_,["gold"]);
         if(GameContext.localPlayer.fullInfo.gold < _loc7_)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMoreGold"));
            return;
         }
         if(this.currntExpBall < this.obf_0_7_d_221)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("ReGrowUI","noEXP",[this.obf_0_7_d_221]));
            return;
         }
         obf_o_H_2969.sendPlayerMakeItemRequest();
      }
      
      private function fusionCondition() : void
      {
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:IconItem = null;
         var _loc1_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter(this.dayFusionTime);
         var _loc2_:int = JSONUtil.getInt(_loc1_,["numOfDay"]);
         var _loc3_:IconItem = IconItemManager.getIconItemByCode(obf_o_H_2969.obf_h_M_2790,"");
         if(_loc3_)
         {
            this.obf_0_9_O_472.pushIconItem(_loc3_);
         }
         var _loc4_:Array = obf_o_H_2969.regrowAlchemyNeed;
         var _loc5_:Object = _loc4_[_loc2_];
         if(_loc2_ >= _loc4_.length)
         {
            _loc5_ = _loc4_[_loc4_.length - 1];
         }
         else
         {
            _loc5_ = _loc4_[_loc2_];
         }
         for(_loc6_ in _loc5_.items)
         {
            _loc8_ = IconItemManager.getIconItemByCode(_loc6_,"");
            if(_loc8_)
            {
               _loc8_.itemCount = _loc5_.items[_loc6_];
               this.obf_n_l_2101.pushIconItem(_loc8_);
            }
         }
         _loc7_ = JSONUtil.getInt(_loc5_,["gold"]);
         inputDiamond2.text = int(_loc7_ / 1000000) + "";
         inputGold2.text = int(_loc7_ % 1000000 / 10000) + "";
         inputSilver2.text = int(_loc7_ % 1000000 % 10000 / 100) + "";
         inputCopper2.text = int(_loc7_ % 1000000 % 10000 % 100) + "";
      }
      
      public function getReGrowLevel() : int
      {
         return this.obf_F_n_4581;
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
         DiversityManager.setTextField(txtDeyTitle,"ReGrowUI","txtDeyTitle");
         DiversityManager.setTextField(txtName,"ReGrowUI","txtName");
         DiversityManager.setTextField(txtCurrentLevel,"ReGrowUI","txtCurrentLevel");
         DiversityManager.setTextField(txtNextLevelCond,"ReGrowUI","txtNextLevelCond");
         DiversityManager.setTextField(txtNextLevel,"ReGrowUI","txtNextLevel");
         DiversityManager.setTextField(txtDeyExp,"ReGrowUI","txtDeyExp");
         DiversityManager.setTextField(fusionCond,"ReGrowUI","fusionCond");
         DiversityManager.setTextField(txtExplain,"ReGrowUI","txtExplain",null,true);
         cmdReset.label = DiversityManager.getString("ReGrowUI","cmdReset");
         cmdInputExp.label = DiversityManager.getString("ReGrowUI","cmdInputExp");
         cmdPickExp.label = DiversityManager.getString("ReGrowUI","cmdPickExp");
         cmdFusion.label = DiversityManager.getString("ReGrowUI","cmdFusion");
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
         var _loc1_:IconItemBag = null;
         for each(_loc1_ in this.bags)
         {
            _loc1_.destroy();
         }
         this.removeListener();
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
   }
}

