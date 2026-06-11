package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.agent.AgentEvent;
   import com.sunweb.game.rpg.agent.AgentItemInfo;
   import com.sunweb.game.rpg.agent.AgentState;
   import com.sunweb.game.rpg.agent.obf_Y_6_1629;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemSubtype;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerBag.PlayerBagIndex;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import fl.data.DataProvider;
   import fl.events.ScrollEvent;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.ui.Keyboard;
   import playerUI.AgentUIMC;
   
   public class AgentUI extends AgentUIMC implements IIconItemUI
   {
      
      private var _npcId:String;
      
      private var _npcMenuIndex:Array;
      
      private var sellBag:IconItemBag;
      
      private var itemBags:Array;
      
      private var obf_w_N_1324:Array;
      
      private var selectedListItem:AgentItemUI;
      
      private var sellItemIndex:int;
      
      private var sellItemCode:String;
      
      private var sellItemId:String;
      
      private var sellItemCount:int;
      
      private var itemTypeObj:Object;
      
      private var itemListPage:int;
      
      public function AgentUI()
      {
         super();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         txtDeyTitle.mouseEnabled = false;
         this.sellBag = new IconItemBag(bagSell,this,0);
         this.sellBag.lockDrag = true;
         this.sellBag.addValidType(GameItemType.ALL);
         this.initDiversity();
         this.initItemType();
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"AgentUI","title");
         DiversityManager.setTextField(txtDeyType,"AgentUI","type");
         DiversityManager.setTextField(txtDeySubtype,"AgentUI","subtype");
         DiversityManager.setTextField(txtDeySearch,"AgentUI","textSearch");
         cmdSearch.label = DiversityManager.getString("AgentUI","cmdSearch");
         DiversityManager.setTextField(txtDeyMySell,"AgentUI","txtMySell");
         DiversityManager.setTextField(txtDeySellTotleGold,"AgentUI","txtSellItemTotleValue");
         DiversityManager.setTextField(txtDeySellSingleGold,"AgentUI","txtSellItemPrice");
         DiversityManager.setTextField(txtDeySellPrompt,"AgentUI","txtSellPrompt");
         cmdBuy.label = DiversityManager.getString("AgentUI","cmdBuy");
         cmdSell.label = DiversityManager.getString("AgentUI","cmdSell");
      }
      
      private function initItemType() : void
      {
         this.itemTypeObj = {
            (GameItemType.COLLECTION + ""):[{
               "label":GameItemSubtype.getSubTypeName(GameItemSubtype.COLLECTION_FARM_PRODUCT),
               "data":GameItemSubtype.COLLECTION_FARM_PRODUCT
            },{
               "label":GameItemSubtype.getSubTypeName(GameItemSubtype.COLLECTION_MATERIAL),
               "data":GameItemSubtype.COLLECTION_MATERIAL
            },{
               "label":GameItemSubtype.getSubTypeName(GameItemSubtype.COLLECTION_GEM),
               "data":GameItemSubtype.COLLECTION_GEM
            },{
               "label":GameItemSubtype.getSubTypeName(GameItemSubtype.COLLECTION_QUEST),
               "data":GameItemSubtype.COLLECTION_QUEST
            },{
               "label":GameItemSubtype.getSubTypeName(GameItemSubtype.COLLECTION_OTHER),
               "data":GameItemSubtype.COLLECTION_OTHER
            }],
            (GameItemType.EQUIPMENT + ""):[{
               "label":GameItemSubtype.getSubTypeName(GameItemSubtype.EQUIPMENT_ACCESSORY),
               "data":GameItemSubtype.EQUIPMENT_ACCESSORY
            },{
               "label":GameItemSubtype.getSubTypeName(GameItemSubtype.EQUIPMENT_AMULET),
               "data":GameItemSubtype.EQUIPMENT_AMULET
            },{
               "label":GameItemSubtype.getSubTypeName(GameItemSubtype.EQUIPMENT_CLOTHES),
               "data":GameItemSubtype.EQUIPMENT_CLOTHES
            },{
               "label":GameItemSubtype.getSubTypeName(GameItemSubtype.EQUIPMENT_GLOVE),
               "data":GameItemSubtype.EQUIPMENT_GLOVE
            },{
               "label":GameItemSubtype.getSubTypeName(GameItemSubtype.EQUIPMENT_HAT),
               "data":GameItemSubtype.EQUIPMENT_HAT
            },{
               "label":GameItemSubtype.getSubTypeName(GameItemSubtype.EQUIPMENT_RING),
               "data":GameItemSubtype.EQUIPMENT_RING
            },{
               "label":GameItemSubtype.getSubTypeName(GameItemSubtype.EQUIPMENT_SHOES),
               "data":GameItemSubtype.EQUIPMENT_SHOES
            },{
               "label":GameItemSubtype.getSubTypeName(GameItemSubtype.EQUIPMENT_WEAPON),
               "data":GameItemSubtype.EQUIPMENT_WEAPON
            },{
               "label":GameItemSubtype.getSubTypeName(GameItemSubtype.EQUIPMENT_WING),
               "data":GameItemSubtype.EQUIPMENT_WING
            },{
               "label":GameItemSubtype.getSubTypeName(GameItemSubtype.EQUIPMENT_FASHION_CLOTHES),
               "data":GameItemSubtype.EQUIPMENT_FASHION_CLOTHES
            },{
               "label":GameItemSubtype.getSubTypeName(GameItemSubtype.EQUIPMENT_FASHION_HAT),
               "data":GameItemSubtype.EQUIPMENT_FASHION_HAT
            }],
            (GameItemType.EXPENDABLE + ""):[{
               "label":GameItemSubtype.getSubTypeName(GameItemSubtype.EXPENDABLE_FARM_BUILDING),
               "data":GameItemSubtype.EXPENDABLE_FARM_BUILDING
            },{
               "label":GameItemSubtype.getSubTypeName(GameItemSubtype.EXPENDABLE_FARM_SEED),
               "data":GameItemSubtype.EXPENDABLE_FARM_SEED
            },{
               "label":GameItemSubtype.getSubTypeName(GameItemSubtype.obf_W_o_4335),
               "data":GameItemSubtype.obf_W_o_4335
            },{
               "label":GameItemSubtype.getSubTypeName(GameItemSubtype.EXPENDABLE_DRUG),
               "data":GameItemSubtype.EXPENDABLE_DRUG
            },{
               "label":GameItemSubtype.getSubTypeName(GameItemSubtype.obf_z_W_2499),
               "data":GameItemSubtype.obf_z_W_2499
            }]
         };
         var _loc1_:Array = [{
            "label":DiversityManager.getString("AgentUI","txtSelectType"),
            "data":-1
         },{
            "label":GameItemType.getTypeName(GameItemType.EQUIPMENT),
            "data":GameItemType.EQUIPMENT
         },{
            "label":GameItemType.getTypeName(GameItemType.EXPENDABLE),
            "data":GameItemType.EXPENDABLE
         },{
            "label":GameItemType.getTypeName(GameItemType.COLLECTION),
            "data":GameItemType.COLLECTION
         }];
         obf_C_9_2232.dataProvider = new DataProvider(_loc1_);
      }
      
      private function addListener() : void
      {
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         inputSellDiamond.addEventListener(Event.CHANGE,this.obf_Z_Z_3963);
         inputGold.addEventListener(Event.CHANGE,this.obf_Z_Z_3963);
         inputSilver.addEventListener(Event.CHANGE,this.obf_Z_Z_3963);
         inputCopper.addEventListener(Event.CHANGE,this.obf_Z_Z_3963);
         inputSellDiamond.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_V_q_1657);
         inputGold.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_V_q_1657);
         inputSilver.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_V_q_1657);
         inputCopper.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_V_q_1657);
         inputSearch.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_V_q_1657);
         inputSearch.addEventListener(KeyboardEvent.KEY_UP,this.obf_t_U_2971);
         cmdSell.addEventListener(MouseEvent.CLICK,this.sendSellItem);
         obf_5_A_3345.addEventListener(ScrollEvent.SCROLL,this.obf_K_7_4147);
         scrollItemList.addEventListener(ScrollEvent.SCROLL,this.obf_D_x_950);
         obf_C_9_2232.addEventListener(Event.CHANGE,this.obf_b_R_3900);
         comboBoxSubtype.addEventListener(Event.CHANGE,this.obf_w_u_1597);
         cmdSearch.addEventListener(MouseEvent.CLICK,this.obf_0_f_2404);
         cmdPrvPage.addEventListener(MouseEvent.CLICK,this.obf_4_6_3384);
         cmdNextPage.addEventListener(MouseEvent.CLICK,this.obf_h_U_2686);
         cmdBuy.addEventListener(MouseEvent.CLICK,this.onClickBuy);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         inputSellDiamond.removeEventListener(Event.CHANGE,this.obf_Z_Z_3963);
         inputGold.removeEventListener(Event.CHANGE,this.obf_Z_Z_3963);
         inputSilver.removeEventListener(Event.CHANGE,this.obf_Z_Z_3963);
         inputCopper.removeEventListener(Event.CHANGE,this.obf_Z_Z_3963);
         inputSellDiamond.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_V_q_1657);
         inputGold.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_V_q_1657);
         inputSilver.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_V_q_1657);
         inputCopper.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_V_q_1657);
         inputSearch.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_V_q_1657);
         inputSearch.removeEventListener(KeyboardEvent.KEY_UP,this.obf_t_U_2971);
         cmdSell.removeEventListener(MouseEvent.CLICK,this.sendSellItem);
         obf_5_A_3345.removeEventListener(ScrollEvent.SCROLL,this.obf_K_7_4147);
         scrollItemList.removeEventListener(ScrollEvent.SCROLL,this.obf_D_x_950);
         obf_C_9_2232.removeEventListener(Event.CHANGE,this.obf_b_R_3900);
         comboBoxSubtype.removeEventListener(Event.CHANGE,this.obf_w_u_1597);
         cmdSearch.removeEventListener(MouseEvent.CLICK,this.obf_0_f_2404);
         cmdPrvPage.removeEventListener(MouseEvent.CLICK,this.obf_4_6_3384);
         cmdNextPage.removeEventListener(MouseEvent.CLICK,this.obf_h_U_2686);
         cmdBuy.removeEventListener(MouseEvent.CLICK,this.onClickBuy);
      }
      
      private function obf_V_q_1657(param1:Event) : void
      {
         param1.stopPropagation();
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
      
      private function obf_K_7_4147(param1:ScrollEvent) : void
      {
         mySellPoint.scrollRect = new Rectangle(0,param1.position,obf_5_A_3345.x - mySellPoint.x,obf_5_A_3345.height);
      }
      
      private function obf_D_x_950(param1:ScrollEvent) : void
      {
         itemListPoint.scrollRect = new Rectangle(0,param1.position,scrollItemList.x - itemListPoint.x,scrollItemList.height);
      }
      
      private function obf_4_6_3384(param1:Event) : void
      {
         this.searchItemList(this.itemListPage - 1,inputSearch.text);
      }
      
      private function obf_h_U_2686(param1:Event) : void
      {
         if(itemListPoint.numChildren <= 0)
         {
            return;
         }
         this.searchItemList(this.itemListPage + 1,inputSearch.text);
      }
      
      private function obf_b_R_3900(param1:Event) : void
      {
         if(!obf_C_9_2232.selectedItem || obf_C_9_2232.selectedItem.data < 0)
         {
            return;
         }
         var _loc2_:Array = [{
            "label":DiversityManager.getString("AgentUI","txtSelectType"),
            "data":-1
         }].concat(this.itemTypeObj[obf_C_9_2232.selectedItem.data + ""]);
         comboBoxSubtype.dataProvider = new DataProvider(_loc2_);
      }
      
      private function obf_w_u_1597(param1:Event) : void
      {
         if(!comboBoxSubtype.selectedItem || comboBoxSubtype.selectedItem.data < 0)
         {
            return;
         }
         this.searchItemList(1,inputSearch.text);
      }
      
      private function obf_t_U_2971(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            this.searchItemList(1,inputSearch.text);
         }
         param1.stopPropagation();
      }
      
      private function obf_0_f_2404(param1:Event) : void
      {
         this.searchItemList(1,inputSearch.text);
      }
      
      private function searchItemList(param1:int, param2:String) : void
      {
         if(param1 < 1)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("AgentUI","promptCantPrevious"));
            return;
         }
         if(!comboBoxSubtype.selectedItem || comboBoxSubtype.selectedItem.data < 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("AgentUI","promptTypeError"));
            return;
         }
         obf_Y_6_1629.obf_Z_4684(this._npcId,this._npcMenuIndex,param1,comboBoxSubtype.selectedItem.data,param2);
      }
      
      public function setItemList(param1:Array, param2:int) : void
      {
         var _loc5_:AgentItemInfo = null;
         var _loc6_:AgentItemUI = null;
         this.clearItemList();
         this.itemListPage = param2;
         DiversityManager.setTextField(txtPage,"AgentUI","txtPage",[param2],true);
         if(!param1 || param1.length == 0)
         {
            return;
         }
         itemListPoint.scrollRect = new Rectangle(0,0,scrollItemList.x - itemListPoint.x,scrollItemList.height);
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = param1[_loc4_];
            _loc6_ = new AgentItemUI(this,_loc5_);
            this.itemBags.push(_loc6_.itemBag);
            _loc6_.x = (_loc4_ + 2) % 2 * _loc6_.width;
            _loc6_.y = _loc3_;
            _loc6_.addEventListener(MouseEvent.CLICK,this.onSelectListItem);
            _loc6_.addEventListener(MouseEvent.DOUBLE_CLICK,this.onClickBuy);
            if((_loc4_ + 2) % 2 == 1 || _loc4_ == param1.length - 1)
            {
               _loc3_ += _loc6_.cmdCancelSell.y;
            }
            itemListPoint.addChild(_loc6_);
            _loc4_++;
         }
         scrollItemList.maxScrollPosition = 0;
         scrollItemList.pageSize = scrollItemList.height;
         if(_loc3_ > scrollItemList.height)
         {
            scrollItemList.maxScrollPosition = _loc3_ - scrollItemList.height;
         }
      }
      
      private function onClickBuy(param1:Event) : void
      {
         if(!this.selectedListItem)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("AgentUI","promptBuyError_NoItem"));
            return;
         }
         if(this.selectedListItem.state != AgentState.SELLING)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("AgentUI","promptBuyError_State"));
            return;
         }
         if(GameContext.localPlayer.fullInfo.gold < this.selectedListItem.obf_i_5_3631)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("AgentUI","promptBuyError_NoMoreGold"));
            return;
         }
         WindowManager.showConfirmBox(DiversityManager.getString("AgentUI","promptConfigBuy",[obf_a_f_2935.getGoldString(this.selectedListItem.obf_i_5_3631),this.selectedListItem.itemBag.haveIconItem.itemName,this.selectedListItem.itemBag.haveIconItem.itemCount]),this.confirmBuy);
      }
      
      private function confirmBuy(param1:Object) : void
      {
         if(!param1.confirm || !this.selectedListItem)
         {
            return;
         }
         if(GameContext.localPlayer.fullInfo.gold < this.selectedListItem.obf_i_5_3631)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("AgentUI","promptBuyError_NoMoreGold"));
            return;
         }
         obf_Y_6_1629.sendBuyItem(this._npcId,this._npcMenuIndex,this.selectedListItem.agentRecId);
         this.searchItemList(this.itemListPage,inputSearch.text);
         obf_Y_6_1629.obf_P_L_4425(this._npcId,this._npcMenuIndex);
      }
      
      private function onSelectListItem(param1:Event) : void
      {
         var _loc2_:AgentItemUI = param1.currentTarget as AgentItemUI;
         if(!_loc2_)
         {
            return;
         }
         if(this.selectedListItem)
         {
            this.selectedListItem.isSelected = false;
         }
         this.selectedListItem = _loc2_;
         _loc2_.isSelected = true;
      }
      
      private function clearItemList() : void
      {
         var _loc1_:AgentItemUI = null;
         this.selectedListItem = null;
         while(itemListPoint.numChildren > 0)
         {
            _loc1_ = itemListPoint.getChildAt(0) as AgentItemUI;
            if(_loc1_)
            {
               _loc1_.removeEventListener(MouseEvent.CLICK,this.onSelectListItem);
               _loc1_.removeEventListener(MouseEvent.DOUBLE_CLICK,this.onClickBuy);
               _loc1_.destroy();
            }
            itemListPoint.removeChildAt(0);
         }
         scrollItemList.maxScrollPosition = 0;
         this.itemBags = new Array();
      }
      
      private function obf_Z_Z_3963(param1:Event) : void
      {
         if(!this.sellBag.haveIconItem)
         {
            return;
         }
         while(sellTotleGoldPoint.numChildren > 0)
         {
            sellTotleGoldPoint.removeChildAt(0);
         }
         sellTotleGoldPoint.addChild(obf_a_f_2935.getGoldDisplay(obf_a_f_2935.getGoldValue(int(inputSellDiamond.text),int(inputGold.text),int(inputSilver.text),int(inputCopper.text)) * this.sellItemCount));
      }
      
      private function sendSellItem(param1:Event) : void
      {
         if(!this.sellBag.haveIconItem || !obf_K_e_3075.playerBagUI)
         {
            return;
         }
         var _loc2_:IconItem = (obf_K_e_3075.playerBagUI.getIconItemBags()[this.sellItemIndex] as IconItemBag).haveIconItem;
         if(!_loc2_ || _loc2_.itemCode != this.sellBag.haveIconItem.itemCode || _loc2_.itemId != this.sellBag.haveIconItem.itemId)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("AgentUI","promptSellError_ItemError"));
            return;
         }
         var _loc3_:Number = obf_a_f_2935.getGoldValue(int(inputSellDiamond.text),int(inputGold.text),int(inputSilver.text),int(inputCopper.text));
         if(_loc3_ * this.sellItemCount > int.MAX_VALUE)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("AgentUI","promptSellError_PriceTooHigh"));
            return;
         }
         if(_loc3_ <= 0)
         {
            WindowManager.showMessageBox(DiversityManager.getString("AgentUI","promptSellError_NoPrice"));
            return;
         }
         var _loc4_:Object = GameItemManager.getItemConfig(_loc2_.itemCode);
         WindowManager.showConfirmBox(DiversityManager.getString("AgentUI","promptConfigSell",[obf_a_f_2935.getGoldString(_loc3_),GameItemManager.getItemName(_loc2_.itemCode),this.sellItemCount]),this.confirmSellItem,_loc3_);
      }
      
      private function confirmSellItem(param1:Object) : void
      {
         if(!param1.confirm)
         {
            return;
         }
         obf_Y_6_1629.sendSellItem(param1.par,this.sellItemIndex,PlayerBagIndex.PLAYER_MAIN_BAG,this._npcId,this._npcMenuIndex);
         this.obf_A_R_3627();
         obf_Y_6_1629.obf_P_L_4425(this._npcId,this._npcMenuIndex);
      }
      
      private function obf_y_e_2099(param1:AgentEvent) : void
      {
         if(param1.itemUI.state == AgentState.SELLING)
         {
            WindowManager.showConfirmBox(DiversityManager.getString("AgentUI","promptConfigCancelSell"),this.confirmCancelSell,param1.itemUI.agentRecId);
         }
         else if(param1.itemUI.state == AgentState.TIMEOUT || param1.itemUI.state == AgentState.SOLD)
         {
            obf_Y_6_1629.obf_U_p_4284(this._npcId,this._npcMenuIndex,param1.itemUI.agentRecId);
            obf_Y_6_1629.obf_P_L_4425(this._npcId,this._npcMenuIndex);
         }
         else if(param1.itemUI.state == AgentState.WAITING)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("AgentUI","promptCancelSellError_State"));
         }
      }
      
      private function confirmCancelSell(param1:Object) : void
      {
         if(!param1.confirm)
         {
            return;
         }
         obf_Y_6_1629.obf_G_V_2425(param1.par,this._npcId,this._npcMenuIndex);
         obf_Y_6_1629.obf_P_L_4425(this._npcId,this._npcMenuIndex);
      }
      
      public function showMySell(param1:Array) : void
      {
         var _loc3_:AgentItemInfo = null;
         var _loc4_:AgentItemUI = null;
         this.clearMySellList();
         obf_5_A_3345.pageSize = obf_5_A_3345.height;
         mySellPoint.scrollRect = new Rectangle(0,0,obf_5_A_3345.x - mySellPoint.x,obf_5_A_3345.height);
         var _loc2_:int = 0;
         for each(_loc3_ in param1)
         {
            _loc4_ = new AgentItemUI(this,_loc3_,true);
            this.obf_w_N_1324.push(_loc4_.itemBag);
            _loc4_.y = _loc2_;
            _loc4_.addEventListener(AgentEvent.CLICK_CONTROL,this.obf_y_e_2099);
            mySellPoint.addChild(_loc4_);
            _loc2_ += _loc4_.cmdCancelSell.y + 24;
         }
         obf_5_A_3345.maxScrollPosition = 0;
         if(_loc2_ > obf_5_A_3345.height)
         {
            obf_5_A_3345.maxScrollPosition = _loc2_ - obf_5_A_3345.height;
         }
      }
      
      public function clearMySellList() : void
      {
         var _loc1_:AgentItemUI = null;
         while(mySellPoint.numChildren > 0)
         {
            _loc1_ = mySellPoint.getChildAt(0) as AgentItemUI;
            if(_loc1_)
            {
               _loc1_.removeEventListener(AgentEvent.CLICK_CONTROL,this.obf_y_e_2099);
               _loc1_.destroy();
            }
            mySellPoint.removeChildAt(0);
         }
         obf_5_A_3345.maxScrollPosition = 0;
         this.obf_w_N_1324 = new Array();
      }
      
      public function showAgent(param1:String, param2:Array) : void
      {
         this._npcId = param1;
         this._npcMenuIndex = param2;
         obf_K_e_3075.showUI(this);
         if(obf_K_e_3075.playerBagUI)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.playerBagUI);
         }
      }
      
      private function obf_v_S_2417(param1:Event) : void
      {
         this.obf_A_R_3627();
      }
      
      private function obf_A_R_3627() : void
      {
         this.sellBag.dropIconItem();
         this.sellItemCode = "";
         this.sellItemCount = 0;
         this.sellItemId = "";
         this.sellItemIndex = -1;
         while(sellTotleGoldPoint.numChildren > 0)
         {
            sellTotleGoldPoint.removeChildAt(0);
         }
         inputSellDiamond.text = "";
         inputGold.text = "";
         inputSilver.text = "";
         inputCopper.text = "";
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
         obf_C_9_2232.selectedIndex = 0;
         comboBoxSubtype.dataProvider = new DataProvider();
         this.obf_A_R_3627();
         obf_Y_6_1629.obf_P_L_4425(this._npcId,this._npcMenuIndex);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.clearItemList();
         inputSearch.text = "";
         this._npcId = "";
         this._npcMenuIndex = null;
      }
      
      public function getIconItemBags() : Array
      {
         return [this.sellBag].concat(this.itemBags,this.obf_w_N_1324);
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this.clearMySellList();
         this.obf_A_R_3627();
         this.clearItemList();
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
         if(param1 != this.sellBag || param3.parentIconUI != obf_K_e_3075.playerBagUI)
         {
            return;
         }
         var _loc4_:Object = GameItemManager.getItemConfig(param2.itemCode);
         if(!JSONUtil.getBoolean(_loc4_,["canTrade"],true))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("AgentUI","promptSellError_CantSellItem"));
            return;
         }
         var _loc5_:IconItem = param2.clone();
         _loc5_.itemCount = param3.haveIconItem.itemCount;
         param1.dropIconItem();
         param1.pushIconItem(_loc5_);
         this.sellItemId = _loc5_.itemId;
         this.sellItemCode = _loc5_.itemCode;
         this.sellItemCount = _loc5_.itemCount;
         this.sellItemIndex = param3.itemIndex;
         inputSellDiamond.text = "";
         inputGold.text = "";
         inputSilver.text = "";
         inputCopper.text = "";
         while(sellTotleGoldPoint.numChildren > 0)
         {
            sellTotleGoldPoint.removeChildAt(0);
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
   }
}

