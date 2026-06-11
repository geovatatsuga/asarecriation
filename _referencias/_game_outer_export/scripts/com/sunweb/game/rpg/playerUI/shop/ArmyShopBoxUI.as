package com.sunweb.game.rpg.playerUI.shop
{
   import obf_a_F_1055.obf_b_p_3604;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.obf_x_c_2855;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.ranking.RankingListType;
   import com.sunweb.game.rpg.world.map.WorldMapManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.ArmyShopBoxUIMC;
   
   public class ArmyShopBoxUI extends ArmyShopBoxUIMC implements IIconItemUI, IPlayerUI
   {
      
      private var bags:Array = new Array();
      
      private var _npcId:String;
      
      private var armyShopConfig:Object;
      
      private var obf_N_t_3283:int;
      
      private var pageSize:int = 12;
      
      private var obf_Y_n_3766:Array;
      
      private var timeInv:TimeLimiter = new TimeLimiter(300);
      
      public function ArmyShopBoxUI()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         titleBox.mouseEnabled = false;
         this.addListener();
      }
      
      private function addListener() : void
      {
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdPrvPage.addEventListener(MouseEvent.CLICK,this.obf_k_X_2379);
         cmdNextPage.addEventListener(MouseEvent.CLICK,this.obf_k_X_2379);
      }
      
      private function obf_I_g_2025() : void
      {
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdPrvPage.removeEventListener(MouseEvent.CLICK,this.obf_k_X_2379);
         cmdNextPage.removeEventListener(MouseEvent.CLICK,this.obf_k_X_2379);
      }
      
      public function get npcId() : String
      {
         return this._npcId;
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
      
      public function showArmyShop(param1:String, param2:String) : void
      {
         this._npcId = param1;
         var _loc3_:Array = obf_x_c_2855.getConfigsByType(param2) as Array;
         this.showItem(_loc3_);
         obf_K_e_3075.showUI(this);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(!this.visible || !this.timeInv.checkTimeout())
         {
            return;
         }
         if(!obf_b_p_3604.checkNpcDistance(this._npcId,false))
         {
            obf_K_e_3075.closeUI(this);
         }
      }
      
      private function obf_k_X_2379(param1:Event) : void
      {
         if(param1.currentTarget == cmdPrvPage)
         {
            this.showItem(this.obf_Y_n_3766,this.obf_N_t_3283 - 1);
         }
         else if(param1.currentTarget == cmdNextPage)
         {
            this.showItem(this.obf_Y_n_3766,this.obf_N_t_3283 + 1);
         }
      }
      
      private function showItem(param1:Array, param2:int = 1) : void
      {
         var _loc8_:String = null;
         var _loc9_:Object = null;
         var _loc10_:int = 0;
         var _loc11_:IconItem = null;
         var _loc12_:obf_s_0_2986 = null;
         var _loc13_:int = 0;
         var _loc14_:Object = null;
         var _loc15_:String = null;
         var _loc16_:Object = null;
         var _loc17_:String = null;
         var _loc18_:String = null;
         var _loc19_:int = 0;
         if(!param1)
         {
            return;
         }
         param1.sortOn("ruleIndex",Array.NUMERIC);
         this.obf_S_z_4502();
         this.obf_Y_n_3766 = param1;
         var _loc3_:int = param1.length / this.pageSize;
         if(param1.length % this.pageSize > 0)
         {
            _loc3_++;
         }
         if(_loc3_ < 1)
         {
            _loc3_ = 1;
         }
         if(param2 * this.pageSize > param1.length)
         {
            param2 = _loc3_;
         }
         if(param2 < 1)
         {
            param2 = 1;
         }
         this.obf_N_t_3283 = param2;
         param1 = param1.slice((this.obf_N_t_3283 - 1) * this.pageSize,this.obf_N_t_3283 * this.pageSize);
         DiversityManager.setTextField(txtPage,"ShopBoxUI","prompt_CurrentPage",[this.obf_N_t_3283,_loc3_],true);
         this.bags = new Array();
         var _loc4_:int = -1;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = -1;
         for each(_loc9_ in param1)
         {
            if(JSONUtil.getStr(_loc9_,["mainTargetItem"]) != "")
            {
               _loc8_ = _loc9_.mainTargetItem;
            }
            else
            {
               var _loc22_:int = 0;
               var _loc23_:* = _loc9_.targetItems;
               for(_loc18_ in _loc23_)
               {
                  _loc8_ = _loc18_;
               }
            }
            _loc10_ = int(_loc9_.targetItems[_loc8_]);
            _loc11_ = IconItemManager.getIconItemByCode(_loc8_,"");
            if(!_loc11_)
            {
               break;
            }
            _loc11_.itemCount = _loc10_;
            _loc12_ = new obf_s_0_2986(this);
            _loc12_.setReadyRuleIndex(int(_loc9_.ruleIndex));
            _loc12_.setConfig(_loc9_);
            _loc12_.setNpcId(this._npcId);
            _loc12_.iconBag.pushIconItem(_loc11_);
            this.bags.push(_loc12_.iconBag);
            _loc13_ = JSONUtil.getInt(_loc9_,["condition","sp>="]);
            _loc12_.setCharm(_loc13_);
            _loc14_ = JSONUtil.getObject(_loc9_,["baseItems"]);
            for(_loc15_ in _loc14_)
            {
               _loc12_.setMaterial(GameItemManager.getItemName(_loc15_),_loc14_[_loc15_]);
            }
            _loc12_.setRemark(JSONUtil.getStr(_loc9_,["subtype"]));
            _loc16_ = JSONUtil.getObject(_loc9_,["condition","mapHonorLevel>="]);
            for(_loc17_ in _loc16_)
            {
               _loc12_.setCondition(WorldMapManager.getMapName(_loc17_),_loc16_[_loc17_],1);
            }
            if(!_loc16_)
            {
               _loc19_ = JSONUtil.getInt(_loc9_,["condition","armyTitleLevel>="]);
               _loc12_.setCondition(RankingListType.getRankingTypeName(RankingListType.obf_J_I_1570),_loc19_,2);
            }
            if(++_loc4_ > 2)
            {
               _loc4_ = 0;
               _loc5_ += _loc12_.height + 7;
            }
            _loc12_.x = (_loc12_.width + 10) * _loc4_;
            _loc12_.y = _loc5_;
            _loc6_ = _loc12_.y + _loc12_.height;
            itemPoint.addChild(_loc12_);
         }
      }
      
      private function obf_S_z_4502() : void
      {
         var _loc1_:GoodsBoxUI = null;
         while(itemPoint.numChildren > 0)
         {
            _loc1_ = itemPoint.getChildAt(0) as GoodsBoxUI;
            if(_loc1_)
            {
               _loc1_.destroy();
            }
            itemPoint.removeChildAt(0);
         }
         this.bags = new Array();
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
         DiversityManager.setTextField(txtDeyTitle,"ShopBoxUI","titleBox");
         cmdPrvPage.label = DiversityManager.getString("ShopBoxUI","cmdPrvPage");
         cmdNextPage.label = DiversityManager.getString("ShopBoxUI","cmdNextPage");
      }
      
      public function showUI() : void
      {
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this._npcId = "";
         this.obf_S_z_4502();
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function destroy() : void
      {
         this.obf_I_g_2025();
         this.obf_S_z_4502();
         try
         {
            this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
         catch(e:Error)
         {
         }
      }
   }
}

