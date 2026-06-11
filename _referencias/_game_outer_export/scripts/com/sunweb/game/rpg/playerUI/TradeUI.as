package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemBriefInfo;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.netRole.RemotePlayer;
   import com.sunweb.game.rpg.playerBag.PlayerBagIndex;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.trade.TradeItemInfo;
   import com.sunweb.game.rpg.trade.obf_G_0_3203;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import playerUI.TradeUIMC;
   
   public class TradeUI extends TradeUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      private var tBags:Array;
      
      private var mBags:Array;
      
      private var obf_E_S_1388:String;
      
      private var tradeIsReady:Boolean;
      
      private var targetTradeIsReady:Boolean;
      
      private var targetTradeIsOK:Boolean;
      
      private var timeInv:TimeLimiter;
      
      public function TradeUI()
      {
         var _loc2_:IconItemBag = null;
         var _loc3_:IconItemBag = null;
         this.timeInv = new TimeLimiter(200);
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         this.bags = new Array();
         this.tBags = new Array();
         this.mBags = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 16)
         {
            _loc2_ = new IconItemBag(this["tBag" + _loc1_],this,_loc1_);
            _loc2_.addValidType(GameItemType.ALL);
            _loc2_.lockDrag = true;
            this.tBags.push(_loc2_);
            _loc3_ = new IconItemBag(this["mBag" + _loc1_],this,_loc1_);
            _loc3_.addValidType(GameItemType.ALL);
            this.mBags.push(_loc3_);
            this.bags.push(_loc2_);
            this.bags.push(_loc3_);
            _loc1_++;
         }
         obf_8_s_2454.gotoAndStop("None");
         obf_k_Q_2459.gotoAndStop("None");
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         txtPlayerName.mouseEnabled = false;
         DiversityManager.setTextField(txtDeyTargetItems,"TradeUI","txtTargetItems");
         DiversityManager.setTextField(txtDeyMyItems,"TradeUI","txtMyItems");
         cmdClear.label = DiversityManager.getString("TradeUI","cmdClear");
         cmdReady.label = DiversityManager.getString("TradeUI","cmdReady");
         cmdOK.label = DiversityManager.getString("TradeUI","cmdOK");
      }
      
      public function get targetPlayer() : String
      {
         return this.obf_E_S_1388;
      }
      
      public function set targetPlayer(param1:String) : void
      {
         this.obf_E_S_1388 = param1;
         txtPlayerName.text = param1;
      }
      
      public function get targetIsReady() : Boolean
      {
         return this.targetTradeIsReady;
      }
      
      public function set targetIsReady(param1:Boolean) : void
      {
         this.targetTradeIsReady = param1;
         obf_8_s_2454.gotoAndStop(this.targetTradeIsReady ? "TradeReady" : "None");
         this.setReadyConfirm();
      }
      
      public function get targetIsOK() : Boolean
      {
         return this.targetTradeIsOK;
      }
      
      public function set targetIsOK(param1:Boolean) : void
      {
         this.targetTradeIsOK = param1;
         obf_8_s_2454.gotoAndStop(this.targetTradeIsOK ? "TradeOK" : "TradeReady");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         inputDiamond.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_V_q_1657);
         inputGold.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_V_q_1657);
         inputSilver.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_V_q_1657);
         inputCopper.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_V_q_1657);
         cmdClear.addEventListener(MouseEvent.CLICK,this.obf_h_f_2486);
         cmdReady.addEventListener(MouseEvent.CLICK,this.obf_i_a_1766);
         cmdOK.addEventListener(MouseEvent.CLICK,this.obf_W_O_4415);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         inputDiamond.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_V_q_1657);
         inputGold.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_V_q_1657);
         inputSilver.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_V_q_1657);
         inputCopper.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_V_q_1657);
         cmdClear.removeEventListener(MouseEvent.CLICK,this.obf_h_f_2486);
         cmdReady.removeEventListener(MouseEvent.CLICK,this.obf_i_a_1766);
         cmdOK.removeEventListener(MouseEvent.CLICK,this.obf_W_O_4415);
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
         obf_G_0_3203.obf_D_E_3035(this.obf_E_S_1388);
         obf_K_e_3075.closeUI(this);
      }
      
      private function obf_h_f_2486(param1:Event) : void
      {
         this.obf_y_L_3289();
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(!this.visible || !this.timeInv.checkTimeout() || !GameContext.currentMap || !GameContext.localPlayer)
         {
            return;
         }
         if(GameContext.localPlayer.isDead)
         {
            this.onClose(null);
         }
         var _loc2_:RemotePlayer = GameContext.currentMap.remotePlayerSet.getObject(this.obf_E_S_1388) as RemotePlayer;
         if(!_loc2_ || GameContext.localPlayer.getLineDistance(_loc2_) > WorldConfig.obf_J_9_4148)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("TradeUI","error_OutOfDistance"));
            this.onClose(null);
         }
      }
      
      private function obf_i_a_1766(param1:Event) : void
      {
         var _loc4_:IconItemBag = null;
         var _loc5_:TradeItemInfo = null;
         var _loc6_:GameItemBriefInfo = null;
         var _loc2_:int = obf_a_f_2935.getGoldValue(int(inputDiamond.text),int(inputGold.text),int(inputSilver.text),int(inputCopper.text));
         if(!this.checkTradeItems())
         {
            return;
         }
         var _loc3_:Array = new Array();
         for each(_loc4_ in this.mBags)
         {
            if(_loc4_.haveIconItem)
            {
               _loc5_ = new TradeItemInfo();
               _loc5_.bagIndex = _loc4_.haveIconItem.par.bagType;
               _loc5_.itemIndex = _loc4_.haveIconItem.par.itemIndex;
               _loc6_ = new GameItemBriefInfo();
               _loc6_.itemCode = _loc4_.haveIconItem.itemCode;
               _loc6_.itemId = _loc4_.haveIconItem.itemId;
               _loc6_.itemCount = _loc4_.haveIconItem.itemCount;
               _loc5_.itemInfo = _loc6_;
               _loc3_.push(_loc5_);
            }
         }
         obf_G_0_3203.sendSubmitItems(this.obf_E_S_1388,_loc3_,_loc2_);
         this.setLockItemBag();
         obf_k_Q_2459.gotoAndStop("TradeReady");
         this.setReadyConfirm();
      }
      
      private function obf_W_O_4415(param1:Event) : void
      {
         if(!this.checkTradeItems())
         {
            return;
         }
         obf_k_Q_2459.gotoAndStop("TradeOK");
         cmdOK.enabled = false;
         obf_G_0_3203.obf_D_L_3792(this.obf_E_S_1388);
      }
      
      private function checkTradeItems() : Boolean
      {
         var _loc2_:IconItemBag = null;
         var _loc3_:IconItem = null;
         var _loc1_:int = obf_a_f_2935.getGoldValue(int(inputDiamond.text),int(inputGold.text),int(inputSilver.text),int(inputCopper.text));
         if(GameContext.localPlayer.fullInfo.gold < _loc1_)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMoreGold"));
            return false;
         }
         for each(_loc2_ in this.mBags)
         {
            if(_loc2_.haveIconItem)
            {
               if(_loc2_.haveIconItem.par.bagType == PlayerBagIndex.PLAYER_MAIN_BAG)
               {
                  _loc3_ = obf_K_e_3075.playerBagUI.getIconItemBag(_loc2_.haveIconItem.par.itemIndex).haveIconItem;
               }
               else if(_loc2_.haveIconItem.par.bagType == PlayerBagIndex.PLAYER_PET_BAG)
               {
                  _loc3_ = obf_K_e_3075.petBoxUI.getPetIconItemBagByIndex(_loc2_.haveIconItem.par.itemIndex).haveIconItem;
               }
               if(!_loc3_ || _loc3_.itemCode != _loc2_.haveIconItem.itemCode || _loc3_.itemId != _loc2_.haveIconItem.itemId || _loc3_.itemCount != _loc2_.haveIconItem.itemCount)
               {
                  _loc2_.dropIconItem();
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("TradeUI","prompt_TradeReadyError"));
                  return false;
               }
            }
         }
         return true;
      }
      
      public function showTargetPlayerItems(param1:Array, param2:int) : void
      {
         var _loc4_:GameItemBriefInfo = null;
         var _loc5_:IconItem = null;
         this.obf_K_m_2358();
         pointTargetGold.addChild(obf_a_f_2935.getGoldDisplay(param2));
         var _loc3_:int = 0;
         while(_loc3_ < param1.length && _loc3_ < this.tBags.length)
         {
            _loc4_ = param1[_loc3_];
            if(_loc4_)
            {
               _loc5_ = IconItemManager.getIconItemByCode(_loc4_.itemCode,_loc4_.itemId);
               _loc5_.itemCount = _loc4_.itemCount;
               (this.tBags[_loc3_] as IconItemBag).pushIconItem(_loc5_);
            }
            _loc3_++;
         }
      }
      
      public function showPlayerTrade(param1:String) : void
      {
         this.targetPlayer = param1;
         this.tradeIsReady = false;
         this.targetTradeIsOK = false;
         this.targetTradeIsReady = false;
         this.obf_K_m_2358();
         this.obf_y_L_3289();
         this.setFreeItemBag();
         obf_8_s_2454.gotoAndStop("None");
         obf_k_Q_2459.gotoAndStop("None");
         obf_K_e_3075.showUI(this);
      }
      
      public function setFreeItemBag() : void
      {
         cmdClear.enabled = true;
         cmdReady.enabled = true;
         cmdOK.enabled = false;
         inputDiamond.enabled = true;
         inputGold.enabled = true;
         inputSilver.enabled = true;
         inputCopper.enabled = true;
         this.tradeIsReady = false;
      }
      
      public function setLockItemBag() : void
      {
         cmdClear.enabled = false;
         cmdReady.enabled = false;
         cmdOK.enabled = false;
         inputDiamond.enabled = false;
         inputGold.enabled = false;
         inputSilver.enabled = false;
         inputCopper.enabled = false;
         this.tradeIsReady = true;
      }
      
      public function setReadyConfirm() : void
      {
         cmdOK.enabled = this.tradeIsReady && this.targetTradeIsReady;
      }
      
      private function obf_K_m_2358() : void
      {
         var _loc1_:IconItemBag = null;
         for each(_loc1_ in this.tBags)
         {
            _loc1_.dropIconItem();
         }
         while(pointTargetGold.numChildren > 0)
         {
            pointTargetGold.removeChildAt(0);
         }
      }
      
      private function obf_y_L_3289() : void
      {
         var _loc1_:IconItemBag = null;
         for each(_loc1_ in this.mBags)
         {
            _loc1_.dropIconItem();
         }
         inputDiamond.text = "";
         inputGold.text = "";
         inputSilver.text = "";
         inputCopper.text = "";
      }
      
      private function addMyItem(param1:int, param2:IconItem, param3:int) : void
      {
         var _loc4_:IconItemBag = null;
         var _loc5_:IconItemBag = null;
         param2.par = {
            "itemIndex":param1,
            "bagType":param3
         };
         for each(_loc4_ in this.mBags)
         {
            if(Boolean(_loc4_.haveIconItem) && _loc4_.haveIconItem.par == param1)
            {
               _loc4_.dropIconItem();
               _loc4_.pushIconItem(param2);
               return;
            }
         }
         for each(_loc5_ in this.mBags)
         {
            if(!_loc5_.haveIconItem)
            {
               _loc5_.pushIconItem(param2);
               return;
            }
         }
      }
      
      private function removeMyItem(param1:int) : void
      {
         if(param1 < 0 || param1 >= this.mBags.length)
         {
            return;
         }
         var _loc2_:IconItemBag = this.mBags[param1];
         _loc2_.dropIconItem();
      }
      
      private function obf_V_q_1657(param1:Event) : void
      {
         param1.stopPropagation();
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
      }
      
      public function closeUI() : void
      {
         this.obf_K_m_2358();
         this.obf_y_L_3289();
         this.visible = false;
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this.obf_K_m_2358();
         this.obf_y_L_3289();
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         var _loc5_:int = 0;
         var _loc6_:GameItemFullInfo = null;
         if(!param1)
         {
            return;
         }
         if(this.tradeIsReady)
         {
            return;
         }
         if(param3.parentIconUI != obf_K_e_3075.playerBagUI && param3.parentIconUI != obf_K_e_3075.petBoxUI)
         {
            return;
         }
         var _loc4_:Object = GameItemManager.getItemConfig(param2.itemCode);
         if(!GameItemManager.itemCanTrade(param2.itemCode))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("AgentUI","promptSellError_CantSellItem"));
            return;
         }
         if(!obf_L_l_4100.isEmpty(param2.itemId))
         {
            _loc6_ = GameItemInfoManager.getItemInfo(param2.itemId);
            if(!_loc6_)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","getItemInfo"));
               GameContext.bagItemManager.sendViewItem(param2.itemId);
               return;
            }
            if(!_loc6_.isEmpty && !_loc6_.canTrade)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("AgentUI","promptSellError_CantSellItem"));
               return;
            }
         }
         if(param3.parentIconUI == obf_K_e_3075.playerBagUI)
         {
            _loc5_ = PlayerBagIndex.PLAYER_MAIN_BAG;
         }
         else if(param3.parentIconUI == obf_K_e_3075.petBoxUI)
         {
            _loc5_ = PlayerBagIndex.PLAYER_PET_BAG;
         }
         this.addMyItem(param3.itemIndex,param2,_loc5_);
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         if(param3 == this || this.tradeIsReady)
         {
            return;
         }
         this.removeMyItem(param1.itemIndex);
      }
   }
}

