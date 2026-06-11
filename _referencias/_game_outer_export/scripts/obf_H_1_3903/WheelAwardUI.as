package obf_H_1_3903
{
   import obf_b_P_3069.obf_A_A_2045;
   import obf_b_P_3069.obf_n_x_1562;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemBriefInfo;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import playerUI.WheelAwardUIMC;
   
   public class WheelAwardUI extends WheelAwardUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      private var obf_O_V_2592:Array;
      
      private var obf_W_P_1610:Array;
      
      private var obf_t_i_2753:Array;
      
      private var obf_l_7_1453:Array;
      
      private var currentGambleRuleConfig:Object;
      
      private var currentStakeLevelConfig:Object;
      
      private var currentStakeLevelIndex:int;
      
      private var currentResultItemList:Array;
      
      private var obf_0_2_k_525:Array;
      
      private var cursorActionList:Array;
      
      private var startButtonActTimeInv:TimeLimiter;
      
      private var obf_O_W_1440:TimeLimiter;
      
      private var cursorActTimeInv:TimeLimiter;
      
      public function WheelAwardUI()
      {
         var _loc4_:MovieClip = null;
         var _loc5_:IconItemBag = null;
         var _loc6_:MovieClip = null;
         var _loc7_:IconItemBag = null;
         var _loc8_:MovieClip = null;
         var _loc9_:IconItemBag = null;
         this.obf_O_W_1440 = new TimeLimiter(500);
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         obf_J_b_4585.mouseEnabled = false;
         this.obf_0_2_k_525 = [cmdStakeLevel1,cmdStakeLevel2,cmdStakeLevel3,cmdStakeLevel4];
         this.bags = new Array();
         this.obf_W_P_1610 = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            _loc4_ = this["bagShowItem" + _loc1_];
            if(_loc4_)
            {
               _loc5_ = new IconItemBag(_loc4_,this,_loc1_);
               _loc5_.addValidType(GameItemType.ALL);
               _loc5_.lockDrag = true;
               this.obf_W_P_1610.push(_loc5_);
               this.bags.push(_loc5_);
            }
            _loc1_++;
         }
         this.obf_t_i_2753 = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < 8)
         {
            _loc6_ = this["bagHaveItem" + _loc2_];
            if(_loc6_)
            {
               _loc7_ = new IconItemBag(_loc6_,this,_loc2_);
               _loc7_.addValidType(GameItemType.ALL);
               _loc7_.lockDrag = true;
               this.obf_t_i_2753.push(_loc7_);
               this.bags.push(_loc7_);
            }
            _loc2_++;
         }
         this.obf_O_V_2592 = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < 24)
         {
            _loc8_ = this["bag" + _loc3_];
            if(_loc8_)
            {
               _loc9_ = new IconItemBag(_loc8_,this,_loc3_);
               _loc9_.addValidType(GameItemType.ALL);
               _loc9_.lockDrag = true;
               this.obf_O_V_2592.push(_loc9_);
               this.bags.push(_loc9_);
            }
            _loc3_++;
         }
         this.obf_l_7_1453 = new Array();
         this.setChildIndex(pointCursorEffect,this.numChildren - 1);
         this.addListener();
         this.setGembleRule("t0001");
         obf_G_W_823.obf_n_S_1442 = this.obf_O_V_2592;
         obf_G_W_823.obf_0_4_k_446 = pointCursorEffect;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"WheelGambleUI","txtTitle");
         cmdGetAward.label = DiversityManager.getString("WheelGambleUI","cmdGetAward");
         t0001.label = DiversityManager.getString("WheelGambleUI","cmdt0001");
         t0002.label = DiversityManager.getString("WheelGambleUI","cmdt0002");
         t0003.label = DiversityManager.getString("WheelGambleUI","cmdt0003");
         t0006.label = DiversityManager.getString("WheelGambleUI","cmdt0006");
      }
      
      public function get obf_n_S_1442() : Array
      {
         return this.obf_O_V_2592;
      }
      
      public function get obf_I_E_3420() : String
      {
         return JSONUtil.getStr(this.currentGambleRuleConfig,["ruleId"]);
      }
      
      public function get haveResult() : Boolean
      {
         return Boolean(this.currentResultItemList) && this.currentResultItemList.length > 0;
      }
      
      private function addListener() : void
      {
         var _loc1_:InteractiveObject = null;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         cmdStart.addEventListener(MouseEvent.CLICK,this.obf_P_C_2096);
         cmdGetAward.addEventListener(MouseEvent.CLICK,this.onClickGetItems);
         t0001.addEventListener(MouseEvent.CLICK,this.obf_i_Y_980);
         t0002.addEventListener(MouseEvent.CLICK,this.obf_i_Y_980);
         t0003.addEventListener(MouseEvent.CLICK,this.obf_i_Y_980);
         t0006.addEventListener(MouseEvent.CLICK,this.obf_i_Y_980);
         for each(_loc1_ in this.obf_0_2_k_525)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.obf_Z_p_1403);
         }
      }
      
      private function removeListener() : void
      {
         var _loc1_:InteractiveObject = null;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         cmdStart.removeEventListener(MouseEvent.CLICK,this.obf_P_C_2096);
         cmdGetAward.removeEventListener(MouseEvent.CLICK,this.onClickGetItems);
         t0001.removeEventListener(MouseEvent.CLICK,this.obf_i_Y_980);
         t0002.removeEventListener(MouseEvent.CLICK,this.obf_i_Y_980);
         t0003.removeEventListener(MouseEvent.CLICK,this.obf_i_Y_980);
         t0006.removeEventListener(MouseEvent.CLICK,this.obf_i_Y_980);
         for each(_loc1_ in this.obf_0_2_k_525)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.obf_Z_p_1403);
         }
      }
      
      private function obf_m_r_2254(param1:Event) : void
      {
         while(pointCursorEffect.numChildren > 0)
         {
            pointCursorEffect.removeChildAt(0);
         }
         this.obf_l_7_1453 = new Array();
         this.cursorActionList = obf_n_d_1903.get1CursorActionList(Math.random() * this.obf_O_V_2592.length,this.obf_O_V_2592.length);
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
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:obf_G_W_823 = null;
         var _loc3_:Boolean = false;
         var _loc4_:obf_G_W_823 = null;
         for each(_loc2_ in this.obf_l_7_1453)
         {
            if(_loc2_)
            {
               _loc2_.obf_m_3205();
            }
         }
         if(this.obf_O_W_1440.checkTimeout() && Boolean(this.cursorActionList))
         {
            _loc3_ = true;
            for each(_loc4_ in this.obf_l_7_1453)
            {
               if(!_loc4_.isDone)
               {
                  _loc3_ = false;
               }
            }
            if(Boolean(this.cursorActTimeInv) && Boolean(this.cursorActTimeInv.checkTimeout()) || _loc3_)
            {
               this.obf_z_e_4625();
            }
         }
         if(Boolean(this.startButtonActTimeInv) && this.startButtonActTimeInv.checkTimeout())
         {
            this.startButtonActTimeInv = null;
            cmdStart.visible = true;
         }
      }
      
      public function obf_z_e_4625() : void
      {
         var _loc1_:obf_n_d_1903 = null;
         if(Boolean(this.cursorActionList) && this.cursorActionList.length > 0)
         {
            _loc1_ = this.cursorActionList.shift();
         }
         if(_loc1_)
         {
            this.obf_3_Q_777(_loc1_);
         }
         else
         {
            this.showResultItems();
         }
      }
      
      private function obf_3_Q_777(param1:obf_n_d_1903) : void
      {
         var _loc2_:obf_G_W_823 = null;
         if(param1.timeInvLimit > 0)
         {
            this.cursorActTimeInv = new TimeLimiter(param1.timeInvLimit);
         }
         for each(_loc2_ in param1.removeCursor)
         {
            this.obf_l_7_1453.splice(this.obf_l_7_1453.indexOf(_loc2_),1);
         }
         this.obf_l_7_1453 = this.obf_l_7_1453.concat(param1.getInsertCursors());
      }
      
      public function setGembleRule(param1:String) : void
      {
         var _loc4_:IconItemBag = null;
         var _loc5_:IconItem = null;
         this.currentGambleRuleConfig = obf_n_x_1562.getGembleConfig(param1);
         if(!this.currentGambleRuleConfig)
         {
            return;
         }
         drgBG.gotoAndStop(param1);
         var _loc2_:Array = JSONUtil.getObject(this.currentGambleRuleConfig,["demoItemList"]) as Array;
         var _loc3_:int = 0;
         while(_loc3_ < this.obf_W_P_1610.length)
         {
            _loc4_ = this.obf_W_P_1610[_loc3_];
            if(_loc4_)
            {
               _loc4_.dropIconItem();
               if(!(!_loc2_ || _loc3_ >= _loc2_.length))
               {
                  _loc5_ = IconItemManager.getIconItemByCode(_loc2_[_loc3_],"");
                  if(_loc5_)
                  {
                     _loc4_.pushIconItem(_loc5_);
                  }
               }
            }
            _loc3_++;
         }
         this.setStakeLevel(0);
      }
      
      public function setStakeLevel(param1:int) : void
      {
         this.currentStakeLevelConfig = JSONUtil.getObject(this.currentGambleRuleConfig,["stakeLevelList",param1]);
         if(!this.currentStakeLevelConfig)
         {
            return;
         }
         this.currentStakeLevelIndex = param1;
         txtStakeLabel.htmlText = JSONUtil.getStr(this.currentStakeLevelConfig,["stakeLabel"]);
         obf_J_b_4585.visible = false;
         var _loc2_:DisplayObject = JSONUtil.getObject(this.obf_0_2_k_525,[param1]) as DisplayObject;
         if(_loc2_)
         {
            obf_J_b_4585.x = _loc2_.x;
            obf_J_b_4585.y = _loc2_.y;
            obf_J_b_4585.visible = true;
         }
      }
      
      public function getResultItemIndex() : Array
      {
         var _loc2_:GameItemBriefInfo = null;
         var _loc3_:int = 0;
         if(!this.currentResultItemList || this.currentResultItemList.length <= 0)
         {
            return null;
         }
         var _loc1_:Array = new Array();
         for each(_loc2_ in this.currentResultItemList)
         {
            _loc3_ = this.getItemIndexInWheel(_loc2_.itemCode,_loc2_.itemCount);
            _loc1_.push(Math.max(_loc3_,0));
         }
         return _loc1_;
      }
      
      public function getItemIndexInWheel(param1:String, param2:int) : int
      {
         var _loc4_:IconItemBag = null;
         if(!this.obf_O_V_2592)
         {
            return -1;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this.obf_O_V_2592.length)
         {
            _loc4_ = this.obf_O_V_2592[_loc3_];
            if(Boolean(_loc4_.haveIconItem) && Boolean(_loc4_.haveIconItem.itemCode == param1) && _loc4_.haveIconItem.itemCount == param2)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function getItemIndexInResult(param1:String) : IconItemBag
      {
         var _loc3_:IconItemBag = null;
         if(!this.obf_t_i_2753)
         {
            return null;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.obf_t_i_2753.length)
         {
            _loc3_ = this.obf_t_i_2753[_loc2_];
            if(Boolean(_loc3_.haveIconItem) && _loc3_.haveIconItem.itemCode == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function startWheel(param1:Array, param2:Array) : void
      {
         var _loc4_:IconItemBag = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:IconItemBag = null;
         var _loc9_:Array = null;
         var _loc10_:IconItem = null;
         var _loc11_:DisplayObject = null;
         var _loc3_:Array = [0,12,6,18,3,9,15,21];
         for each(_loc4_ in this.obf_O_V_2592)
         {
            _loc4_.dropIconItem();
         }
         _loc5_ = 0;
         _loc6_ = 0;
         for(; _loc6_ < param1.length; _loc6_++)
         {
            if(_loc6_ < _loc3_.length)
            {
               _loc8_ = this.obf_O_V_2592[_loc3_[_loc6_]];
            }
            else
            {
               if(++_loc5_ >= this.obf_O_V_2592.length)
               {
                  continue;
               }
               while(_loc3_.indexOf(_loc5_) > -1)
               {
                  _loc5_++;
               }
               _loc8_ = this.obf_O_V_2592[_loc5_];
            }
            if(_loc8_)
            {
               _loc9_ = String(param1[_loc6_]).split(":");
               _loc10_ = IconItemManager.getIconItemByCode(_loc9_[0],"");
               if(_loc10_)
               {
                  if(_loc9_.length >= 2)
                  {
                     _loc10_.itemCount = _loc9_[1];
                  }
                  _loc8_.pushIconItem(_loc10_);
                  if(_loc6_ < _loc3_.length)
                  {
                     _loc11_ = GameItemManager.getItemIcon(_loc9_[0]);
                     _loc11_.x = -16;
                     _loc11_.y = -16;
                     obf_K_e_3075.showUITween(_loc11_,1,_loc8_.x,_loc8_.y,this);
                  }
               }
               else
               {
                  obf_6_D_3816.print("obf_____4833 " + param1[_loc6_] + " obf___4949！");
               }
            }
         }
         this.currentResultItemList = param2;
         this.obf_l_7_1453 = new Array();
         this.cursorActionList = null;
         var _loc7_:Array = this.getResultItemIndex();
         if(!_loc7_)
         {
            return;
         }
         if(_loc7_.length >= 8)
         {
            this.cursorActionList = obf_n_d_1903.get8CursorActionList(_loc7_,this.obf_O_V_2592.length);
         }
         else if(_loc7_.length >= 4)
         {
            this.cursorActionList = obf_n_d_1903.get4CursorActionList(_loc7_,this.obf_O_V_2592.length);
         }
         else if(_loc7_.length >= 2)
         {
            this.cursorActionList = obf_n_d_1903.get2CursorActionList(_loc7_,this.obf_O_V_2592.length);
         }
         else if(_loc7_.length >= 1)
         {
            this.cursorActionList = obf_n_d_1903.get1CursorActionList(_loc7_[0],this.obf_O_V_2592.length);
         }
      }
      
      public function showResultItems() : void
      {
         var _loc2_:IconItemBag = null;
         var _loc3_:GameItemBriefInfo = null;
         var _loc4_:IconItem = null;
         this.obf_l_7_1453 = new Array();
         this.cursorActionList = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.obf_t_i_2753.length)
         {
            _loc2_ = this.obf_t_i_2753[_loc1_];
            _loc2_.dropIconItem();
            if(!(!this.currentResultItemList || _loc1_ >= this.currentResultItemList.length))
            {
               _loc3_ = this.currentResultItemList[_loc1_];
               _loc4_ = IconItemManager.getIconItemByCode(_loc3_.itemCode,_loc3_.itemId);
               _loc4_.itemCount = _loc3_.itemCount;
               _loc2_.pushIconItem(_loc4_);
            }
            _loc1_++;
         }
      }
      
      public function clearResultItems() : void
      {
         var _loc1_:IconItemBag = null;
         for each(_loc1_ in this.obf_t_i_2753)
         {
            _loc1_.dropIconItem();
         }
      }
      
      public function showGetResultEffect() : void
      {
         var _loc1_:GameItemBriefInfo = null;
         var _loc2_:IconItemBag = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         if(!this.currentResultItemList || this.currentResultItemList.length <= 0)
         {
            return;
         }
         for each(_loc1_ in this.currentResultItemList)
         {
            _loc2_ = this.getItemIndexInResult(_loc1_.itemCode);
            _loc3_ = GameItemManager.getItemIcon(_loc1_.itemCode);
            if(!(!_loc2_ || !_loc3_))
            {
               _loc4_ = _loc2_.localToGlobal(new Point());
               _loc3_.x = _loc4_.x;
               _loc3_.y = _loc4_.y;
               _loc5_ = obf_K_e_3075.obf_a_S_1814.cmdBag.localToGlobal(new Point(-16,-16));
               obf_K_e_3075.showUITween(_loc3_,1,_loc5_.x,_loc5_.y);
            }
         }
      }
      
      private function obf_Z_p_1403(param1:Event) : void
      {
         if(Boolean(this.obf_0_2_k_525) && this.obf_0_2_k_525.indexOf(param1.currentTarget) > -1)
         {
            this.setStakeLevel(this.obf_0_2_k_525.indexOf(param1.currentTarget));
         }
      }
      
      private function onClickGetItems(param1:Event) : void
      {
         if(Boolean(this.cursorActionList || this.obf_l_7_1453.length > 0) || Boolean(!this.currentResultItemList) || this.currentResultItemList.length <= 0)
         {
            return;
         }
         obf_n_x_1562.sendStopGamble(JSONUtil.getStr(this.currentGambleRuleConfig,["ruleId"]));
      }
      
      private function obf_i_Y_980(param1:Event) : void
      {
         this.setGembleRule(param1.currentTarget.name);
      }
      
      private function obf_P_C_2096(param1:Event) : void
      {
         if(!this.currentGambleRuleConfig || !this.currentStakeLevelConfig)
         {
            return;
         }
         if(Boolean(this.cursorActionList) || JSONUtil.getInt(this.obf_l_7_1453,["length"]) > 0)
         {
            return;
         }
         if(!ConditionScript.checkCondition(JSONUtil.getObject(this.currentGambleRuleConfig,["condition"]),null,true))
         {
            return;
         }
         if(this.currentGambleRuleConfig.stakeType == obf_A_A_2045.obf_d_Y_2785)
         {
            if(obf_K_e_3075.playerBagUI.getItemCount(this.currentGambleRuleConfig.stakeItemCode) < this.currentStakeLevelConfig.stakeNumber)
            {
               WindowManager.showMessageBox(DiversityManager.getString("WheelGambleUI","prompt_NoMoreStake_Item",[GameItemManager.getItemName(this.currentGambleRuleConfig.stakeItemCode) + " x" + this.currentStakeLevelConfig.stakeNumber]));
               return;
            }
         }
         else if(this.currentGambleRuleConfig.stakeType == obf_A_A_2045.obf_H_z_1106)
         {
            if(GameContext.localPlayer.fullInfo.money < this.currentStakeLevelConfig.stakeNumber)
            {
               obf_K_e_3075.showShortOfMoney();
               return;
            }
         }
         else if(this.currentGambleRuleConfig.stakeType == obf_A_A_2045.GOLD)
         {
            if(GameContext.localPlayer.fullInfo.gold < this.currentStakeLevelConfig.stakeNumber)
            {
               WindowManager.showMessageBox(DiversityManager.getString("WheelGambleUI","prompt_NoMoreStake_Gold",[obf_a_f_2935.getGoldString(this.currentStakeLevelConfig.stakeNumber)]));
               return;
            }
         }
         else if(this.currentGambleRuleConfig.stakeType == obf_A_A_2045.obf_J_3_1454)
         {
            if(GameContext.localPlayer.dynamicVars.intVarLT(this.currentGambleRuleConfig.stakeVarName,this.currentStakeLevelConfig.stakeNumber))
            {
               WindowManager.showMessageBox(DiversityManager.getString("WheelGambleUI","prompt_NoMoreStake_Var",[DiversityManager.getString("varPlace",this.currentGambleRuleConfig.stakeVarName)]));
               return;
            }
         }
         obf_n_x_1562.sendStartGamble(this.currentGambleRuleConfig.ruleId,this.currentStakeLevelIndex,false);
         cmdStart.visible = false;
         this.startButtonActTimeInv = new TimeLimiter(2000);
         while(pointCursorEffect.numChildren > 0)
         {
            pointCursorEffect.removeChildAt(0);
         }
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return bgBox.getBounds(bgBox).contains(bgBox.mouseX,bgBox.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         this.visible = true;
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
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

