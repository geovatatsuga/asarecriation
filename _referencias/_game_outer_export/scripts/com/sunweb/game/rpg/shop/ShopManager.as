package com.sunweb.game.rpg.shop
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.activity.obf_J_F_3431;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.worldZone.command.playerBag.PlayerRenewItemRequest;
   import com.sunweb.game.rpg.worldZone.command.shop.CommandCodeShop;
   import com.sunweb.game.rpg.worldZone.command.shop.ShopBuyItemRequest;
   import com.sunweb.game.rpg.worldZone.command.shop.ShopLeadBuyItemRequest;
   import com.sunweb.game.rpg.worldZone.command.shop.ShopLeadItemInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.shop.ShopLeadItemInfoRequest;
   import com.sunweb.game.rpg.worldZone.command.shop.ShopSellItemRequest;
   import com.sunweb.game.rpg.worldZone.command.shop.StoreBuyItemRequest;
   import com.sunweb.game.rpg.worldZone.command.shop.obf_8_R_2322;
   import com.sunweb.game.rpg.worldZone.command.shop.obf_J_q_3184;
   import com.sunweb.game.utils.JSONUtil;
   
   public class ShopManager
   {
      
      private static var storeObject:Object;
      
      private static var shopObject:Object;
      
      public static var obf_a_G_767:Boolean;
      
      public static var payGoodsObject:Object;
      
      public static var obf_4_E_4448:String;
      
      public static var obf_3_A_2009:String;
      
      public static var obf_8_q_3951:int;
      
      public static const obf_v_5_3425:int = 0;
      
      public static const obf_B_9_2165:int = 1;
      
      public static const obf_g_G_1313:int = 2;
      
      public static const obf_K_f_849:int = 3;
      
      public static const obf_t_m_4319:int = 4;
      
      public static const obf_R_c_3073:String = "_pay_Items";
      
      public static const obf_a_s_2956:String = "_costpay_Items";
      
      private static var leadItemList:Array = [];
      
      private static var hotType:String = "obf___4959";
      
      public function ShopManager()
      {
         super();
      }
      
      public static function initStore(param1:Object) : void
      {
         storeObject = param1;
         hotType = DiversityManager.getString("ShopBoxUI","hotType");
      }
      
      public static function initShop(param1:Object) : void
      {
         var _loc2_:Object = null;
         shopObject = new Object();
         for each(_loc2_ in param1.itemList)
         {
            if(_loc2_)
            {
               shopObject[_loc2_.kind] = _loc2_;
            }
         }
      }
      
      public static function getStoreLeadList() : Array
      {
         return leadItemList;
      }
      
      public static function getShopConfigByKind(param1:String) : Object
      {
         return shopObject[param1];
      }
      
      public static function getStoreHotItemList() : Array
      {
         if(Boolean(storeObject) && Boolean(storeObject.hotItemList))
         {
            return storeObject.hotItemList;
         }
         return [];
      }
      
      public static function getPayItemList() : Array
      {
         var _loc2_:String = null;
         if(!obf_a_G_767)
         {
            return [];
         }
         var _loc1_:Array = new Array();
         for(_loc2_ in payGoodsObject)
         {
            _loc1_.push(_loc2_);
         }
         _loc1_.sort();
         return _loc1_;
      }
      
      public static function getCostPayItemList() : Array
      {
         var _loc4_:* = undefined;
         var _loc1_:String = WorldConfig.getValue("consPointShop","activityCode");
         if(!obf_J_F_3431.obf_4_4696(_loc1_))
         {
            return [];
         }
         var _loc2_:Array = new Array();
         var _loc3_:Array = WorldConfig.getValue("consPointShop","shopConfig");
         for each(_loc4_ in _loc3_)
         {
            _loc2_.push(_loc4_.itemCode);
         }
         _loc2_.sort();
         return _loc2_;
      }
      
      public static function getItemPayCost(param1:String) : int
      {
         return JSONUtil.getInt(payGoodsObject,[param1]);
      }
      
      public static function getItemCostPayPrice(param1:String) : int
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = WorldConfig.getValue("consPointShop","shopConfig");
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.itemCode == param1)
            {
               return _loc3_.pice;
            }
         }
         return -1;
      }
      
      public static function getStoreKinds() : Array
      {
         var _loc2_:Object = null;
         if(!storeObject || !storeObject.normalItemList)
         {
            return [];
         }
         var _loc1_:Array = new Array();
         _loc1_.push(hotType);
         for each(_loc2_ in storeObject.normalItemList)
         {
            _loc1_.push(_loc2_.kind);
         }
         return _loc1_;
      }
      
      public static function getStoreItemListByKind(param1:String) : Array
      {
         var _loc2_:Object = null;
         if(param1 == obf_R_c_3073)
         {
            return getPayItemList();
         }
         if(param1 == obf_a_s_2956)
         {
            return getCostPayItemList();
         }
         if(!storeObject || !storeObject.normalItemList)
         {
            return [];
         }
         if(param1 == hotType)
         {
            return getStoreHotItemList();
         }
         for each(_loc2_ in storeObject.normalItemList)
         {
            if(_loc2_.kind == param1)
            {
               return _loc2_.items;
            }
         }
         return [];
      }
      
      public static function sendShopByItem(param1:String, param2:int, param3:String, param4:Array, param5:int) : void
      {
         if(param2 == ShopManager.obf_B_9_2165)
         {
            if(GameContext.localPlayer.fullInfo.money < GameItemManager.getItemMoneyBuy(param1) * param5)
            {
               obf_K_e_3075.showShortOfMoney();
               return;
            }
         }
         else if(param2 == ShopManager.obf_v_5_3425)
         {
            if(GameContext.localPlayer.fullInfo.gold < GameItemManager.getItemGoldBuy(param1) * param5)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMoreGold"));
               return;
            }
         }
         else if(param2 == ShopManager.obf_g_G_1313)
         {
            if(GameContext.localPlayer.fullInfo.coin < GameItemManager.getItemCoinBuy(param1) * param5)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMoreCoin"));
               return;
            }
         }
         else
         {
            if(param2 != ShopManager.obf_K_f_849)
            {
               return;
            }
            if(GameContext.localPlayer.fullInfo.payMarks < ShopManager.getItemPayCost(param1) * param5)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMorePay"));
               return;
            }
         }
         var _loc6_:ShopBuyItemRequest = new ShopBuyItemRequest();
         var _loc7_:BuyItemInfo = new BuyItemInfo();
         _loc7_.itemCode = param1;
         _loc7_.buyMode = param2;
         _loc7_.itemCount = param5;
         _loc6_.npcId = param3;
         _loc6_.funcMenuFullIndex = param4;
         _loc6_.buyItemList = [_loc7_];
         GameContext.worldClient.sendCommand(_loc6_);
      }
      
      public static function sendStoreLeadBuyItem(param1:String, param2:int, param3:String = "", param4:int = 1, param5:int = 0) : Boolean
      {
         var _loc6_:Object = new Object();
         _loc6_[param1] = param4;
         param5 = obf_8_q_3951;
         return sendStoreBuyItemObject(_loc6_,param2,param3,0,1,param5);
      }
      
      public static function sendStoreBuyItem(param1:String, param2:int, param3:String = "", param4:int = 1) : Boolean
      {
         var _loc5_:Object = new Object();
         _loc5_[param1] = param4;
         return sendStoreBuyItemObject(_loc5_,param2,param3);
      }
      
      public static function sendStoreBuyItemObject(param1:Object, param2:int, param3:String = "", param4:int = 0, param5:int = 0, param6:int = 0) : Boolean
      {
         var _loc8_:String = null;
         var _loc10_:* = undefined;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:BuyItemInfo = null;
         var _loc7_:int = param4;
         if(param2 == ShopManager.obf_B_9_2165)
         {
            for(_loc8_ in param1)
            {
               if(param5 == 1)
               {
                  _loc7_ += param6;
               }
               else
               {
                  _loc7_ += GameItemManager.getItemMoneyBuy(_loc8_) * param1[_loc8_];
               }
            }
            if(GameContext.localPlayer.fullInfo.money < _loc7_)
            {
               obf_K_e_3075.showShortOfMoney();
               return false;
            }
         }
         else if(param2 == ShopManager.obf_v_5_3425)
         {
            for(_loc8_ in param1)
            {
               if(param5 == 1)
               {
                  _loc7_ += param6;
               }
               else
               {
                  _loc7_ += GameItemManager.getItemGoldBuy(_loc8_) * param1[_loc8_];
               }
            }
            if(GameContext.localPlayer.fullInfo.gold < _loc7_)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMoreGold"));
               return false;
            }
         }
         else if(param2 == ShopManager.obf_g_G_1313)
         {
            for(_loc8_ in param1)
            {
               if(param5 == 1)
               {
                  _loc7_ += param6;
               }
               else
               {
                  _loc7_ += GameItemManager.getItemCoinBuy(_loc8_) * param1[_loc8_];
               }
            }
            if(GameContext.localPlayer.fullInfo.coin < _loc7_)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMoreCoin"));
               return false;
            }
         }
         else
         {
            if(param2 != ShopManager.obf_K_f_849)
            {
               return false;
            }
            for(_loc8_ in param1)
            {
               _loc7_ += ShopManager.getItemPayCost(_loc8_) * param1[_loc8_];
            }
            if(GameContext.localPlayer.fullInfo.payMarks < _loc7_)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMorePay"));
               return false;
            }
         }
         var _loc9_:int = 0;
         if(param5 == 0)
         {
            _loc10_ = new StoreBuyItemRequest();
         }
         else
         {
            _loc10_ = new ShopLeadBuyItemRequest();
         }
         _loc10_.buyItemList = new Array();
         for(_loc8_ in param1)
         {
            _loc13_ = Math.max(JSONUtil.getInt(GameItemManager.getItemConfig(_loc8_),["stackSize"]),1);
            _loc14_ = int(param1[_loc8_]);
            while(_loc14_ > 0)
            {
               _loc15_ = new BuyItemInfo();
               _loc15_.itemCode = _loc8_;
               _loc15_.itemCount = _loc14_ > _loc13_ ? _loc13_ : _loc14_;
               _loc15_.buyMode = param2;
               _loc10_.buyItemList.push(_loc15_);
               _loc14_ -= _loc14_ > _loc13_ ? _loc13_ : _loc14_;
               _loc9_++;
            }
         }
         if(Boolean(obf_K_e_3075.playerBagUI) && !obf_K_e_3075.playerBagUI.haveEmptyBag(_loc9_))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","needEmptyBag",[_loc9_ + ""]));
            return false;
         }
         var _loc11_:Object = GameItemManager.getItemConfig(_loc8_);
         var _loc12_:int = JSONUtil.getInt(_loc11_,["maxSize"]);
         if(_loc12_ > 0 && _loc12_ < obf_K_e_3075.playerBagUI.getItemCount(_loc8_) + param1[_loc8_])
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("MainBag","maxSize"));
            return false;
         }
         _loc10_.giveToPlayerId = param3;
         GameContext.worldClient.sendCommand(_loc10_ as obf_O_8_1034);
         return true;
      }
      
      public static function sendSellItem(param1:int, param2:int, param3:String, param4:Array) : void
      {
         var _loc5_:ShopSellItemRequest = new ShopSellItemRequest();
         _loc5_.bagIndex = param1;
         _loc5_.itemIndexList = [param2];
         _loc5_.npcId = param3;
         _loc5_.funcMenuFullIndex = param4;
         GameContext.worldClient.sendCommand(_loc5_);
      }
      
      public static function sendRenewItem(param1:int, param2:String) : void
      {
         var _loc3_:PlayerRenewItemRequest = new PlayerRenewItemRequest();
         _loc3_.renewRuleIndex = param1;
         _loc3_.itemId = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendCostPointBuyItem(param1:String, param2:int, param3:int = 1) : void
      {
         if(obf_K_e_3075.newShopBoxUI.getCostPointValue() < param2 * param3)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("ShopBoxUI","noCostPoint"));
            return;
         }
         sendConsPointShopBuyRequest(param1,param3);
      }
      
      public static function sendConsPointShopBuyRequest(param1:String, param2:int) : void
      {
         var _loc3_:obf_J_q_3184 = new obf_J_q_3184();
         _loc3_.itemCode = param1;
         _loc3_.num = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendLeadItemInfo() : void
      {
         var _loc1_:ShopLeadItemInfoRequest = new ShopLeadItemInfoRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         switch(param1.code)
         {
            case CommandCodeShop.LEAD_ITEM_INFO_NOTIFY:
               obf_0_1_v_541(param1 as ShopLeadItemInfoNotify);
               break;
            case CommandCodeShop.obf_d_9_3617:
               obf_W_T_1965(param1 as obf_8_R_2322);
         }
      }
      
      private static function obf_0_1_v_541(param1:ShopLeadItemInfoNotify) : void
      {
         if(!obf_K_e_3075.obf_N_i_3901)
         {
            return;
         }
         if(!obf_K_e_3075.newShopBoxUI)
         {
            return;
         }
         obf_K_e_3075.newShopBoxUI.showLeadShop(param1.leadItems,param1.nextRefreshTimes);
         leadItemList = param1.leadItems;
      }
      
      private static function obf_W_T_1965(param1:obf_8_R_2322) : void
      {
         if(!obf_K_e_3075.newShopBoxUI)
         {
            return;
         }
         obf_K_e_3075.newShopBoxUI.obf_d_6_3571();
      }
   }
}

