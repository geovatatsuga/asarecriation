package obf_0_8_3_434
{
   import obf_a_F_1055.obf_b_p_3604;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.gameItem.obf_x_c_2855;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.lifeJob.LifeJobCode;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.ItemShowBoxUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import fl.data.DataProvider;
   import fl.events.ScrollEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import playerUI.AssembleBoxUIMC;
   
   public class AssembleBoxUI extends AssembleBoxUIMC implements IPlayerUI, IIconItemUI
   {
      
      private var assembleListBags:Array = new Array();
      
      private var materialsBags:Array = new Array();
      
      private var obf_c_g_4007:Array = new Array();
      
      private var productBags:Array = new Array();
      
      private var _type:String;
      
      private var _npcFunctionIndex:Array;
      
      private var _npcId:String;
      
      private var selectedAssembleItem:ItemShowBoxUI;
      
      private var obf_0_V_1315:Object = new Object();
      
      private var assembleTimeLimit:TimeLimiter;
      
      private var readyAssistList:Array;
      
      private var readyRuleIndex:int;
      
      private var assembleCount:int;
      
      private var countUpTimeInv:TimeLimiter;
      
      private var countDownTimeInv:TimeLimiter;
      
      public function AssembleBoxUI()
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         titleBox.mouseEnabled = false;
         this.visible = false;
         assembleBar.gotoAndStop(1);
         assembleBar.visible = false;
         this.initBags();
         this.swapChildren(txtAssist,this.getChildAt(this.numChildren - 1));
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"AssembleBoxUI","txtTitle");
         DiversityManager.setTextField(txtDeyTopType,"AssembleBoxUI","txtTopType");
         DiversityManager.setTextField(txtDeyType,"AssembleBoxUI","txtType");
         DiversityManager.setTextField(txtDeyMainMaiter,"AssembleBoxUI","txtMainMater");
         DiversityManager.setTextField(txtDeyAidMater,"AssembleBoxUI","txtAidMater");
         DiversityManager.setTextField(txtDeyProduct,"AssembleBoxUI","txtProduct");
         DiversityManager.setTextField(txtDeyLifeJob,"AssembleBoxUI","txtLifeJob");
         DiversityManager.setTextField(txtDeyLifeJobExp,"AssembleBoxUI","txtLifeJobExp");
         DiversityManager.setTextField(txtDeyChance,"AssembleBoxUI","txtChance");
         DiversityManager.setTextField(txtDeyGoldCost,"AssembleBoxUI","txtGoldCost");
         DiversityManager.setTextField(txtDeyAssCount,"AssembleBoxUI","txtAssemberCount");
         cmdMakeButton.label = DiversityManager.getString("AssembleBoxUI","cmdAssember");
         cmdCloseButton.label = DiversityManager.getString("AssembleBoxUI","cmdClose");
         chkEqualItem.label = DiversityManager.getString("AssembleBoxUI","chkEqualItem");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdCloseButton.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdMakeButton.addEventListener(MouseEvent.CLICK,this.obf_W_j_2205);
         scrollAssembleList.addEventListener(ScrollEvent.SCROLL,this.obf_8_l_4241);
         scrollProduct.addEventListener(ScrollEvent.SCROLL,this.obf_H_N_1161);
         listType.addEventListener(Event.CHANGE,this.obf_e_x_t_e_n_d_s_32);
         listTopType.addEventListener(Event.CHANGE,this.obf_U_7_2662);
         txtAssist.addEventListener(TextEvent.LINK,this.onClickLink);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         cmdCountUp.addEventListener(MouseEvent.CLICK,this.obf_I_W_2053);
         cmdCountDown.addEventListener(MouseEvent.CLICK,this.obf_T_S_2829);
         cmdCountUp.addEventListener(MouseEvent.MOUSE_DOWN,this.obf_g_V_1348);
         cmdCountDown.addEventListener(MouseEvent.MOUSE_DOWN,this.obf_g_V_1348);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdCloseButton.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdMakeButton.removeEventListener(MouseEvent.CLICK,this.obf_W_j_2205);
         scrollAssembleList.removeEventListener(ScrollEvent.SCROLL,this.obf_8_l_4241);
         scrollProduct.removeEventListener(ScrollEvent.SCROLL,this.obf_H_N_1161);
         listType.removeEventListener(Event.CHANGE,this.obf_e_x_t_e_n_d_s_32);
         listTopType.removeEventListener(Event.CHANGE,this.obf_U_7_2662);
         txtAssist.removeEventListener(TextEvent.LINK,this.onClickLink);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         cmdCountUp.removeEventListener(MouseEvent.CLICK,this.obf_I_W_2053);
         cmdCountDown.removeEventListener(MouseEvent.CLICK,this.obf_T_S_2829);
         cmdCountUp.removeEventListener(MouseEvent.MOUSE_DOWN,this.obf_g_V_1348);
         cmdCountDown.removeEventListener(MouseEvent.MOUSE_DOWN,this.obf_g_V_1348);
      }
      
      private function initBags() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:IconItemBag = null;
         var _loc5_:MovieClip = null;
         var _loc6_:IconItemBag = null;
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            _loc3_ = this["mBag" + _loc1_];
            if(_loc3_)
            {
               _loc4_ = new IconItemBag(_loc3_,this,0);
               _loc4_.lockDrag = true;
               _loc4_.addValidType(GameItemType.ALL);
               this.materialsBags.push(_loc4_);
            }
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < 6)
         {
            _loc5_ = this["aBag" + _loc2_];
            if(_loc5_)
            {
               _loc6_ = new IconItemBag(_loc5_,this,0);
               _loc6_.isLocked = true;
               _loc6_.addValidType(GameItemType.ALL);
               this.obf_c_g_4007.push(_loc6_);
            }
            _loc2_++;
         }
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
         this.countUpTimeInv = null;
         this.countDownTimeInv = null;
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function obf_I_W_2053(param1:Event) : void
      {
         ++this.assembleCount;
         txtAssembleCount.text = this.assembleCount + "";
      }
      
      private function obf_T_S_2829(param1:Event) : void
      {
         --this.assembleCount;
         if(this.assembleCount < 1)
         {
            this.assembleCount = 1;
         }
         txtAssembleCount.text = this.assembleCount + "";
      }
      
      private function obf_g_V_1348(param1:Event) : void
      {
         if(param1.currentTarget == cmdCountUp)
         {
            this.countUpTimeInv = new TimeLimiter(500);
         }
         else if(param1.currentTarget == cmdCountDown)
         {
            this.countDownTimeInv = new TimeLimiter(500);
         }
      }
      
      private function onClickLink(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      private function obf_8_l_4241(param1:ScrollEvent) : void
      {
         assembleListPoint.scrollRect = new Rectangle(0,param1.position,scrollAssembleList.x - assembleListPoint.x,scrollAssembleList.height);
      }
      
      private function obf_H_N_1161(param1:ScrollEvent) : void
      {
         productPoint.scrollRect = new Rectangle(0,param1.position,scrollProduct.x - productPoint.x,scrollProduct.height);
      }
      
      private function obf_U_7_2662(param1:Event) : void
      {
         if(!listTopType.selectedItem)
         {
            return;
         }
         this._type = listTopType.selectedItem.data;
         listType.dataProvider = new DataProvider([DiversityManager.getString("AssembleBoxUI","canAssember")].concat(obf_x_c_2855.getSubtypeList(listTopType.selectedItem.data)));
         listType.selectedIndex = 0;
         this.showCanAssembelList();
      }
      
      private function obf_e_x_t_e_n_d_s_32(param1:Event) : void
      {
         if(listType.selectedIndex == 0)
         {
            this.showCanAssembelList();
         }
         else
         {
            this.showAssembleList(obf_x_c_2855.getConfigsByType(this._type,listType.selectedItem.data));
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(this.visible && Boolean(this.assembleTimeLimit))
         {
            _loc2_ = this.assembleTimeLimit.totalTimeInMS / this.assembleTimeLimit.timelimit * 100;
            assembleBar.gotoAndStop(_loc2_);
            if(this.assembleTimeLimit.checkTimeout())
            {
               obf_x_c_2855.sendAssemble(this._npcId,this._npcFunctionIndex,this.readyRuleIndex,this.readyAssistList,chkEqualItem.selected);
               this.assembleTimeLimit = null;
               assembleBar.visible = false;
               --this.assembleCount;
               txtAssembleCount.text = this.assembleCount + "";
            }
         }
         if(this.visible)
         {
            if(Boolean(this.countUpTimeInv) && this.countUpTimeInv.checkTimeout(true))
            {
               ++this.assembleCount;
               txtAssembleCount.text = this.assembleCount + "";
            }
            if(Boolean(this.countDownTimeInv) && this.countDownTimeInv.checkTimeout(true))
            {
               --this.assembleCount;
               this.assembleCount = Math.max(1,this.assembleCount);
               txtAssembleCount.text = this.assembleCount + "";
            }
         }
      }
      
      private function obf_W_j_2205(param1:Event) : void
      {
         this.startAssemble();
      }
      
      public function startAssemble() : void
      {
         var _loc3_:String = null;
         var _loc6_:IconItemBag = null;
         var _loc7_:String = null;
         if(Boolean(this.assembleTimeLimit) || this.assembleCount < 1)
         {
            return;
         }
         if(!this.selectedAssembleItem || !obf_K_e_3075.playerBagUI || !GameContext.currentMap)
         {
            return;
         }
         var _loc1_:Object = this.selectedAssembleItem.assembleConfig;
         if(!_loc1_)
         {
            return;
         }
         if(!obf_L_l_4100.isEmpty(this._npcId) && !obf_b_p_3604.checkNpcDistance(this._npcId,true))
         {
            return;
         }
         if(JSONUtil.getInt(_loc1_,["lifeJob"]) > 0)
         {
            if(GameContext.localPlayer.fullInfo.lifeJob != JSONUtil.getInt(_loc1_,["lifeJob"]) || GameContext.localPlayer.fullInfo.lifeLevel < JSONUtil.getInt(_loc1_,["lifeLevel"]))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("AssembleBoxUI","promptAssemberError_NeedLifeJob",[LifeJobCode.getLifeJobName(_loc1_.lifeJob),LifeJobCode.getLifeJobRankName(_loc1_.lifeLevel)]));
               return;
            }
         }
         var _loc2_:int = 0;
         for(_loc3_ in _loc1_.targetItems)
         {
            _loc2_++;
         }
         if(!obf_K_e_3075.playerBagUI.haveEmptyBag(_loc2_))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","nomoreEmptyBag"));
            return;
         }
         if(!obf_x_c_2855.obf_C_e_1742(_loc1_))
         {
            return;
         }
         if(GameContext.localPlayer.fullInfo.gold < JSONUtil.getInt(_loc1_,["costGold"]))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("AssembleBoxUI","promptAssemberError_NoMoreGold"));
            return;
         }
         var _loc4_:Array = new Array();
         var _loc5_:Object = new Object();
         for each(_loc6_ in this.obf_c_g_4007)
         {
            if(_loc6_.haveIconItem)
            {
               _loc4_.push(_loc6_.haveIconItem.itemCode);
               _loc5_[_loc6_.haveIconItem.itemCode] += 1;
            }
         }
         for(_loc7_ in _loc5_)
         {
            if(obf_K_e_3075.playerBagUI.getItemCount(_loc7_) < _loc5_[_loc7_])
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("AssembleBoxUI","promptAssemberError_NoMoreMaterial"));
               return;
            }
         }
         this.readyAssistList = _loc4_;
         this.readyRuleIndex = _loc1_.ruleIndex;
         this.assembleTimeLimit = new TimeLimiter(JSONUtil.getInt(_loc1_,["costTimeInSec"],1) * 1000);
         assembleBar.visible = true;
      }
      
      public function show(param1:String, param2:String, param3:Array, param4:Array = null) : void
      {
         if((!param2 || param2 == "") && (!param4 || param4.length == 0))
         {
            return;
         }
         this._npcId = param1;
         this._type = param2;
         this._npcFunctionIndex = param3;
         if(!param4)
         {
            param4 = [param2];
         }
         listTopType.dataProvider = new DataProvider(param4);
         listTopType.selectedIndex = 0;
         this.obf_U_7_2662(null);
         obf_K_e_3075.showUI(this);
      }
      
      public function showAssembleList(param1:Array) : void
      {
         var _loc5_:Object = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:ItemShowBoxUI = null;
         var _loc9_:String = null;
         if(!param1)
         {
            return;
         }
         this.assembleListBags = new Array();
         this.clearAssembleList();
         this.obf_l_s_4125();
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = -1;
         for each(_loc5_ in param1)
         {
            _loc4_++;
            if(JSONUtil.getStr(_loc5_,["mainTargetItem"]) != "")
            {
               _loc6_ = _loc5_.mainTargetItem;
            }
            else
            {
               var _loc12_:int = 0;
               var _loc13_:* = _loc5_.targetItems;
               for(_loc9_ in _loc13_)
               {
                  _loc6_ = _loc9_;
               }
            }
            _loc7_ = int(_loc5_.targetItems[_loc6_]);
            _loc8_ = new ItemShowBoxUI(_loc6_,_loc7_);
            _loc8_.dockParentUI(this,this.assembleListBags);
            _loc8_.assembleConfig = _loc5_;
            _loc8_.addEventListener(MouseEvent.CLICK,this.obf_O_R_1524);
            _loc8_.x = (_loc4_ + 2) % 2 * _loc8_.width;
            _loc8_.y = _loc2_;
            _loc3_ = _loc8_.height;
            assembleListPoint.addChild(_loc8_);
            if((_loc4_ + 2) % 2 == 1)
            {
               _loc2_ += _loc8_.height;
            }
         }
         _loc2_ += _loc3_;
         scrollAssembleList.minScrollPosition = 1;
         scrollAssembleList.maxScrollPosition = 1;
         assembleListPoint.scrollRect = new Rectangle(0,0,scrollAssembleList.x - assembleListPoint.x,scrollAssembleList.height);
         if(_loc2_ > scrollAssembleList.height)
         {
            scrollAssembleList.pageSize = scrollAssembleList.height;
            scrollAssembleList.minScrollPosition = 1;
            scrollAssembleList.maxScrollPosition = _loc2_ - scrollAssembleList.height;
         }
         scrollAssembleList.visible = scrollAssembleList.enabled;
      }
      
      public function showCanAssembelList() : void
      {
         this.showAssembleList(obf_x_c_2855.getCanAssembleList(obf_x_c_2855.getConfigsByType(this._type)));
      }
      
      private function obf_O_R_1524(param1:Event) : void
      {
         if(!(param1.currentTarget is ItemShowBoxUI))
         {
            return;
         }
         if(this.selectedAssembleItem)
         {
            this.selectedAssembleItem.selected = false;
         }
         this.selectedAssembleItem = param1.currentTarget as ItemShowBoxUI;
         this.selectedAssembleItem.selected = true;
         this.assembleCount = 1;
         txtAssembleCount.text = this.assembleCount + "";
         this.showAssembleContent();
      }
      
      public function showAssembleContent() : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:IconItemBag = null;
         var _loc13_:IconItem = null;
         var _loc14_:ItemShowBoxUI = null;
         if(!this.selectedAssembleItem)
         {
            return;
         }
         var _loc1_:Object = this.selectedAssembleItem.assembleConfig;
         if(!_loc1_)
         {
            return;
         }
         this.obf_l_s_4125();
         txtRemark.htmlText = JSONUtil.getStr(_loc1_,["remark"]);
         var _loc2_:Array = new Array();
         for(_loc3_ in _loc1_.baseItems)
         {
            _loc2_.push({
               "itemCode":_loc3_,
               "itemCount":_loc1_.baseItems[_loc3_]
            });
         }
         _loc2_.sortOn("itemCode");
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            if(_loc4_ >= this.materialsBags.length)
            {
               break;
            }
            _loc12_ = this.materialsBags[_loc4_];
            _loc13_ = IconItemManager.getIconItemByCode(_loc2_[_loc4_].itemCode,"");
            _loc13_.itemCount = _loc2_[_loc4_].itemCount;
            if(obf_K_e_3075.playerBagUI.getItemCount(_loc13_.itemCode) < _loc13_.itemCount)
            {
               _loc13_.countTextColor = 16711680;
            }
            _loc12_.pushIconItem(_loc13_);
            _loc4_++;
         }
         var _loc5_:String = "";
         for(_loc6_ in _loc1_.addedItems)
         {
            this.obf_0_V_1315[_loc6_] = _loc1_.addedItems[_loc6_];
            _loc5_ += (_loc5_ != "" ? "、" : "") + obf_7_6_4416.getItemLinkA(_loc6_,"") + "+" + Number(this.obf_0_V_1315[_loc6_] * 100).toFixed(1) + "%";
         }
         txtAssist.htmlText = _loc5_;
         _loc7_ = 0;
         while(_loc7_ < JSONUtil.getInt(_loc1_,["maxAddedItemNumber"]))
         {
            if(_loc7_ >= this.obf_c_g_4007.length)
            {
               break;
            }
            (this.obf_c_g_4007[_loc7_] as IconItemBag).isLocked = false;
            _loc7_++;
         }
         if(JSONUtil.getInt(_loc1_,["lifeJob"]) > 0)
         {
            txtLifeJob.text = LifeJobCode.getLifeJobName(JSONUtil.getInt(_loc1_,["lifeJob"])) + "-" + LifeJobCode.getLifeJobRankName(JSONUtil.getInt(_loc1_,["lifeLevel"]));
            txtLifeExp.text = JSONUtil.getInt(_loc1_,["lifeExp"]) + "";
         }
         txtChance.text = Number(JSONUtil.getNumber(_loc1_,["baseChance"],1) * 100).toFixed(1) + "%";
         costPoint.addChild(obf_a_f_2935.getGoldDisplay(JSONUtil.getInt(_loc1_,["costGold"])));
         var _loc8_:Array = new Array();
         for(_loc9_ in _loc1_.targetItems)
         {
            _loc8_.push({
               "itemCode":_loc9_,
               "itemCount":_loc1_.targetItems[_loc9_]
            });
         }
         _loc8_.sortOn("itemCode");
         _loc10_ = 0;
         _loc11_ = 0;
         while(_loc11_ < _loc8_.length)
         {
            _loc14_ = new ItemShowBoxUI(_loc8_[_loc11_].itemCode,_loc8_[_loc11_].itemCount);
            _loc14_.dockParentUI(this,this.productBags);
            _loc14_.x = (_loc11_ + 2) % 2 * _loc14_.width;
            _loc14_.y = _loc10_;
            productPoint.addChild(_loc14_);
            if((_loc11_ + 2) % 2 == 1)
            {
               _loc10_ += _loc14_.height;
            }
            _loc11_++;
         }
         scrollProduct.minScrollPosition = 1;
         scrollProduct.maxScrollPosition = 1;
         productPoint.scrollRect = new Rectangle(0,0,scrollProduct.x - productPoint.x,scrollProduct.height);
         if(_loc10_ > scrollProduct.height)
         {
            scrollProduct.pageSize = scrollProduct.height;
            scrollProduct.minScrollPosition = 1;
            scrollProduct.maxScrollPosition = _loc10_ - scrollProduct.height;
         }
         scrollProduct.visible = scrollProduct.enabled;
      }
      
      private function obf_l_s_4125() : void
      {
         var _loc1_:IconItemBag = null;
         var _loc2_:IconItemBag = null;
         var _loc3_:ItemShowBoxUI = null;
         for each(_loc1_ in this.materialsBags)
         {
            _loc1_.dropIconItem();
         }
         txtAssist.htmlText = "";
         this.obf_0_V_1315 = new Object();
         for each(_loc2_ in this.obf_c_g_4007)
         {
            _loc2_.dropIconItem();
            _loc2_.isLocked = true;
         }
         DiversityManager.setTextField(txtLifeJob,"AssembleBoxUI","noLifeJob",null,true);
         txtLifeExp.text = "";
         this.productBags = new Array();
         txtChance.text = "";
         while(costPoint.numChildren > 0)
         {
            costPoint.removeChildAt(0);
         }
         while(productPoint.numChildren > 0)
         {
            _loc3_ = productPoint.getChildAt(0) as ItemShowBoxUI;
            if(_loc3_)
            {
               _loc3_.destroy();
               productPoint.removeChild(_loc3_);
            }
         }
         productPoint.scrollRect = new Rectangle(0,0,scrollProduct.x - productPoint.x,scrollProduct.height);
         scrollProduct.visible = false;
      }
      
      private function clearAssembleList() : void
      {
         var _loc1_:ItemShowBoxUI = null;
         this.selectedAssembleItem = null;
         while(assembleListPoint.numChildren > 0)
         {
            _loc1_ = assembleListPoint.getChildAt(0) as ItemShowBoxUI;
            if(_loc1_)
            {
               _loc1_.removeEventListener(MouseEvent.CLICK,this.obf_O_R_1524);
               _loc1_.destroy();
            }
            assembleListPoint.removeChildAt(0);
         }
      }
      
      private function obf_j_H_3519() : void
      {
         var _loc2_:IconItemBag = null;
         if(!this.selectedAssembleItem)
         {
            return;
         }
         var _loc1_:Number = JSONUtil.getNumber(this.selectedAssembleItem.assembleConfig,["baseChance"],1);
         for each(_loc2_ in this.obf_c_g_4007)
         {
            if(_loc2_.haveIconItem)
            {
               _loc1_ += JSONUtil.getNumber(this.obf_0_V_1315,[_loc2_.haveIconItem.itemCode]);
            }
         }
         txtChance.text = Number(_loc1_ * 100).toFixed(1) + "%";
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.assembleCount = 1;
         txtAssembleCount.text = this.assembleCount + "";
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.assembleTimeLimit = null;
         assembleBar.visible = false;
         this.assembleCount = 0;
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this.clearAssembleList();
         this.obf_l_s_4125();
         this.selectedAssembleItem = null;
         this._npcId = "";
         this._type = "";
         this._npcFunctionIndex = null;
         this.assembleListBags = new Array();
         this.obf_c_g_4007 = new Array();
         this.materialsBags = new Array();
         this.productBags = new Array();
      }
      
      public function getIconItemBags() : Array
      {
         return this.obf_c_g_4007.concat(this.materialsBags,this.productBags,this.assembleListBags);
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         var _loc5_:IconItemBag = null;
         if(!param1 || !this.selectedAssembleItem)
         {
            return;
         }
         if(param3.parentIconUI != obf_K_e_3075.playerBagUI)
         {
            return;
         }
         if(!this.obf_0_V_1315.hasOwnProperty(param2.itemCode))
         {
            return;
         }
         var _loc4_:Number = JSONUtil.getNumber(this.selectedAssembleItem.assembleConfig,["baseChance"],1);
         for each(_loc5_ in this.obf_c_g_4007)
         {
            if(_loc5_.haveIconItem == null && !_loc5_.isLocked)
            {
               _loc5_.pushIconItem(IconItemManager.getIconItemByCode(param2.itemCode,""));
               break;
            }
         }
         this.obf_j_H_3519();
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         param1.dropIconItem();
         this.obf_j_H_3519();
      }
   }
}

