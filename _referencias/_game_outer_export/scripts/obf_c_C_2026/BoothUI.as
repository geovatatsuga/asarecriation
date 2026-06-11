package obf_c_C_2026
{
   import obf_g_A_3629.obf_r_Y_1874;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.booth.BoothItemPurchaseInfo;
   import com.sunweb.game.rpg.booth.BoothItemSellInfo;
   import com.sunweb.game.rpg.booth.obf_c_o_n_t_i_n_u_e_24;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.obf_z_A_3653;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.map.MapManager;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import playerUI.BoothUIMC;
   
   public class BoothUI extends BoothUIMC implements IIconItemUI, obf_z_A_3653
   {
      
      private var obf_5_F_4317:Array;
      
      private var obf_0_5_I_285:Dictionary;
      
      public function BoothUI()
      {
         super();
         this.initDiversity();
         this.visible = false;
         titleBox.mouseEnabled = false;
         this.x = 250;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.obf_5_F_4317 = new Array();
         this.obf_0_5_I_285 = new Dictionary();
         this.obf_0_5_I_285[saleTab] = obf_K_e_3075.boothSellUI;
         this.obf_0_5_I_285[bfmTab] = obf_K_e_3075.boothBfmUI;
         obf_K_e_3075.showChildUI(this,this.obf_0_5_I_285[saleTab]);
         this.refreshTableButton();
         this.addListener();
      }
      
      private function addListener() : void
      {
         var _loc1_:* = undefined;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         inputBoothTitle.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputBoothTitle.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputBoothTitle.addEventListener(FocusEvent.FOCUS_OUT,this.obf_Y_m_4378);
         cmdAction.addEventListener(MouseEvent.CLICK,this.boothAction);
         for(_loc1_ in this.obf_0_5_I_285)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.onClickTableButton);
         }
      }
      
      private function removeListener() : void
      {
         var _loc1_:* = undefined;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         inputBoothTitle.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputBoothTitle.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputBoothTitle.removeEventListener(FocusEvent.FOCUS_OUT,this.obf_Y_m_4378);
         cmdAction.removeEventListener(MouseEvent.CLICK,this.boothAction);
         for(_loc1_ in this.obf_0_5_I_285)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onClickTableButton);
         }
      }
      
      private function refreshTableButton() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in this.obf_0_5_I_285)
         {
            if(_loc1_)
            {
               _loc1_.gotoAndStop(this.obf_5_F_4317.indexOf(this.obf_0_5_I_285[_loc1_]) > -1 ? 2 : 1);
            }
         }
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
      
      private function obf_m_I_3657(param1:Event) : void
      {
         param1.stopPropagation();
      }
      
      private function obf_Y_m_4378(param1:Event) : void
      {
         if(obf_L_l_4100.isEmpty(inputBoothTitle.text))
         {
            return;
         }
         if(obf_r_Y_1874.isUnlawful(inputBoothTitle.text))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("BoothUI","prompt_InvalidTitle"));
            return;
         }
         obf_c_o_n_t_i_n_u_e_24.sendChangeTitle(inputBoothTitle.text);
      }
      
      private function boothAction(param1:Event) : void
      {
         if(!GameContext.localPlayer.isBooth)
         {
            this.startBooth();
         }
         else
         {
            this.stopBooth();
         }
      }
      
      public function setBoothStatus(param1:Boolean) : void
      {
         if(param1)
         {
            cmdAction.label = DiversityManager.getString("BoothUI","cmdStopBooth");
            obf_K_e_3075.boothBfmUI.cmdBfmBuy.enabled = false;
         }
         else
         {
            cmdAction.label = DiversityManager.getString("BoothUI","cmdStartBooth");
            obf_K_e_3075.boothBfmUI.cmdBfmBuy.enabled = true;
         }
         obf_K_e_3075.boothBfmUI.setBoothAllay(param1);
      }
      
      private function onClickTableButton(param1:MouseEvent) : void
      {
         obf_K_e_3075.closeAllChildUI(this);
         var _loc2_:IPlayerUI = this.obf_0_5_I_285[param1.currentTarget] as IPlayerUI;
         if(_loc2_)
         {
            obf_K_e_3075.showChildUI(this,_loc2_);
         }
      }
      
      private function startBooth() : void
      {
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:obf_0_9_P_664 = null;
         var _loc9_:BoothItemSellInfo = null;
         var _loc10_:obf_0_9_P_664 = null;
         var _loc11_:BoothItemPurchaseInfo = null;
         if(!JSONUtil.getBoolean(MapManager.instance.mapInfo,["rules","commonRule","canBooth"]))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("BoothUI","prompt_CantBoothInMap"));
            return;
         }
         if(!ConditionScript.checkCondition(WorldConfig.getValue("booth","boothCond"),null,true))
         {
            return;
         }
         var _loc1_:String = inputBoothTitle.text;
         if(obf_L_l_4100.isEmpty(_loc1_))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("BoothUI","prompt_InputTitle"));
            return;
         }
         if(obf_r_Y_1874.isUnlawful(_loc1_))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("BoothUI","prompt_InvalidTitle"));
            return;
         }
         if(obf_K_e_3075.boothSellUI.pointItems.numChildren <= 0 && obf_K_e_3075.boothBfmUI.pointItems.numChildren <= 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("BoothUI","prompt_NoItems"));
            return;
         }
         if(obf_K_e_3075.boothBfmUI.allBfmGold > GameContext.localPlayer.fullInfo.gold)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMoreGold"));
            return;
         }
         var _loc2_:Array = new Array();
         var _loc3_:Object = new Object();
         var _loc4_:int = 0;
         while(_loc4_ < obf_K_e_3075.boothSellUI.pointItems.numChildren)
         {
            _loc8_ = obf_K_e_3075.boothSellUI.pointItems.getChildAt(_loc4_) as obf_0_9_P_664;
            if(!(!_loc8_ || !_loc8_.iconBag.haveIconItem))
            {
               if(obf_L_l_4100.isEmpty(_loc8_.iconBag.haveIconItem.itemId))
               {
                  if(!_loc3_[_loc8_.iconBag.haveIconItem.itemCode])
                  {
                     _loc3_[_loc8_.iconBag.haveIconItem.itemCode] = 0;
                  }
                  _loc3_[_loc8_.iconBag.haveIconItem.itemCode] += _loc8_.iconBag.haveIconItem.itemCount;
               }
               else if(!obf_K_e_3075.playerBagUI.getIconItemBagByID(_loc8_.iconBag.haveIconItem.itemId))
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("BoothUI","prompt_SellItemError",[GameItemManager.getItemName(_loc8_.iconBag.haveIconItem.itemCode)]));
                  return;
               }
               _loc9_ = new BoothItemSellInfo();
               _loc9_.itemCode = _loc8_.iconBag.haveIconItem.itemCode;
               _loc9_.itemId = _loc8_.iconBag.haveIconItem.itemId;
               _loc9_.itemCount = _loc8_.iconBag.haveIconItem.itemCount;
               _loc9_.itemPrice = _loc8_.gold;
               _loc9_.itemIndex = _loc4_;
               _loc2_.push(_loc9_);
            }
            _loc4_++;
         }
         for(_loc5_ in _loc3_)
         {
            if(obf_K_e_3075.playerBagUI.getItemCount(_loc5_) < _loc3_[_loc5_])
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("BoothUI","prompt_SellItemError",[GameItemManager.getItemName(_loc5_)]));
               return;
            }
         }
         _loc6_ = new Array();
         _loc7_ = 0;
         while(_loc7_ < obf_K_e_3075.boothBfmUI.pointItems.numChildren)
         {
            _loc10_ = obf_K_e_3075.boothBfmUI.pointItems.getChildAt(_loc7_) as obf_0_9_P_664;
            if(!(!_loc10_ || !_loc10_.iconBag.haveIconItem))
            {
               _loc11_ = new BoothItemPurchaseInfo();
               _loc11_.itemCode = _loc10_.iconBag.haveIconItem.itemCode;
               _loc11_.itemId = _loc10_.iconBag.haveIconItem.itemId;
               _loc11_.itemCount = _loc10_.iconBag.haveIconItem.itemCount;
               _loc11_.itemPrice = _loc10_.gold;
               _loc11_.itemIndex = _loc7_;
               _loc6_.push(_loc11_);
            }
            _loc7_++;
         }
         obf_c_o_n_t_i_n_u_e_24.sendStartBooth(_loc1_,_loc2_,_loc6_);
         obf_K_e_3075.closeUI(obf_K_e_3075.boothItemUI);
      }
      
      public function stopBooth() : void
      {
         obf_c_o_n_t_i_n_u_e_24.sendStopBooth();
      }
      
      public function getIconItemBags() : Array
      {
         var _loc2_:IPlayerUI = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in this.obf_5_F_4317)
         {
            if(Boolean(_loc2_) && _loc2_ is IIconItemUI)
            {
               _loc1_ = _loc1_.concat((_loc2_ as IIconItemUI).getIconItemBags());
            }
         }
         return _loc1_;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         if(this.obf_5_F_4317.indexOf(obf_K_e_3075.boothSellUI) > -1)
         {
            obf_K_e_3075.boothSellUI.onDragInIconItem(param1,param2,param3);
         }
         else
         {
            obf_K_e_3075.boothBfmUI.onDragInIconItem(param1,param2,param3);
         }
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
         DiversityManager.setTextField(inputBoothTitle,"BoothUI","txtBoothTitle",null,true);
         DiversityManager.setTextField(txtDeyTitle,"BoothUI","txtTitle");
         cmdAction.label = DiversityManager.getString("BoothUI","cmdStartBooth");
         DiversityManager.setTextField(saleTab.txtLabel,"BoothUI","saleTab");
         DiversityManager.setTextField(bfmTab.txtLabel,"BoothUI","bfmTab");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         obf_K_e_3075.closeAllChildUI(this);
         obf_K_e_3075.showChildUI(this,this.obf_0_5_I_285[saleTab]);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
      
      public function get obf_l_v_2495() : Array
      {
         return this.obf_5_F_4317;
      }
      
      public function get obf_R_4_1122() : DisplayObjectContainer
      {
         return pointUI;
      }
      
      public function obf_7_h_998(param1:IPlayerUI) : void
      {
         this.refreshTableButton();
      }
      
      public function removeChildPlayerUI(param1:IPlayerUI) : void
      {
         this.refreshTableButton();
      }
   }
}

