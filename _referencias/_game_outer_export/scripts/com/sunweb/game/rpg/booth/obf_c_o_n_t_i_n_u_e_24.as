package com.sunweb.game.rpg.booth
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.map.MapInteractiveObject;
   import com.sunweb.game.rpg.netRole.RemotePlayer;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.worldZone.command.booth.BoothBuyItemRequest;
   import com.sunweb.game.rpg.worldZone.command.booth.BoothCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.booth.BoothItemPurchasedNotify;
   import com.sunweb.game.rpg.worldZone.command.booth.BoothItemSoldNotify;
   import com.sunweb.game.rpg.worldZone.command.booth.BoothPurchaseItemRequest;
   import com.sunweb.game.rpg.worldZone.command.booth.BoothSetTitleRequest;
   import com.sunweb.game.rpg.worldZone.command.booth.BoothStartRequest;
   import com.sunweb.game.rpg.worldZone.command.booth.BoothStopRequest;
   import com.sunweb.game.rpg.worldZone.command.booth.BoothVisitAnswer;
   import com.sunweb.game.rpg.worldZone.command.booth.BoothVisitRequest;
   import com.sunweb.game.rpg.worldZone.command.booth.CommandCodePlayerBooth;
   import com.sunweb.game.ui.WindowManager;
   
   public class obf_c_o_n_t_i_n_u_e_24
   {
      
      public static var upItemList:Array = new Array();
      
      public static var upBfmItemList:Array = new Array();
      
      public function obf_c_o_n_t_i_n_u_e_24()
      {
         super();
      }
      
      public static function sendStartBooth(param1:String, param2:Array, param3:Array) : void
      {
         var _loc4_:BoothStartRequest = new BoothStartRequest();
         _loc4_.boothTitle = param1;
         _loc4_.itemList = param2;
         _loc4_.purchaseItemList = param3;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public static function sendStopBooth() : void
      {
         var _loc1_:BoothStopRequest = new BoothStopRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendChangeTitle(param1:String) : void
      {
         if(!GameContext.localPlayer.isBooth)
         {
            return;
         }
         var _loc2_:BoothSetTitleRequest = new BoothSetTitleRequest();
         _loc2_.boothTitle = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendViewBooth(param1:String) : void
      {
         if(!GameContext.currentMap)
         {
            return;
         }
         var _loc2_:MapInteractiveObject = GameContext.currentMap.remotePlayerSet.getObject(param1);
         if(!_loc2_ || GameContext.localPlayer.getLineDistance(_loc2_) > WorldConfig.getValue("booth","visitDistance"))
         {
            return;
         }
         var _loc3_:RemotePlayer = _loc2_ as RemotePlayer;
         if(!_loc2_ || _loc3_.obf_I_0_1698.level < WorldConfig.getValue("booth","visitLevel"))
         {
            WindowManager.showMessageBox(DiversityManager.getString("ConditionPrompt","roleLevel>=",[WorldConfig.getValue("booth","visitLevel")]));
            return;
         }
         var _loc4_:BoothVisitRequest = new BoothVisitRequest();
         _loc4_.boothOwnerId = param1;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public static function sendBuyItem(param1:String, param2:BoothItemBuyInfo) : void
      {
         var _loc3_:BoothBuyItemRequest = new BoothBuyItemRequest();
         _loc3_.boothOwnerId = param1;
         _loc3_.buyItemInfo = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendSellItem(param1:String, param2:BoothItemPurchaseInfo) : void
      {
         var _loc3_:BoothPurchaseItemRequest = new BoothPurchaseItemRequest();
         _loc3_.boothOwnerId = param1;
         _loc3_.purchaseItemInfo = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerBooth.BOOTH_CHECK_NOTIFY)
         {
            obf_M_H_1771(param1 as BoothCheckNotify);
         }
         else if(param1.code == CommandCodePlayerBooth.BOOTH_VISIT_ANSWER)
         {
            obf_j_5_3659(param1 as BoothVisitAnswer);
         }
         else if(param1.code == CommandCodePlayerBooth.BOOTH_ITEM_SOLD_NOTIFY)
         {
            obf_0_2_H_447(param1 as BoothItemSoldNotify);
         }
         else if(param1.code == CommandCodePlayerBooth.BOOTH_ITEM_PURCHASED_NOTIFY)
         {
            onPurchased(param1 as BoothItemPurchasedNotify);
         }
      }
      
      private static function obf_M_H_1771(param1:BoothCheckNotify) : void
      {
         GameContext.localPlayer.setBooth(param1.isBooth,param1.boothTitle);
         obf_K_e_3075.boothUI.setBoothStatus(param1.isBooth);
         if(param1.isBooth)
         {
            obf_K_e_3075.boothSellUI.setSellItems(param1.itemList);
            obf_K_e_3075.boothBfmUI.setBfmItems(param1.purchaseItemList);
            upItemList = param1.itemList;
            upBfmItemList = param1.purchaseItemList;
         }
         else
         {
            obf_K_e_3075.boothSellUI.setSellItems(upItemList);
            obf_K_e_3075.boothBfmUI.setBfmItems(upBfmItemList);
         }
      }
      
      private static function obf_j_5_3659(param1:BoothVisitAnswer) : void
      {
         if(param1.isBooth)
         {
            obf_K_e_3075.boothSellViewUI.setBoothContent(param1.itemList,param1.boothOwnerId);
            obf_K_e_3075.boothBfmViewUI.setBoothBfmContent(param1.purchaseItemList);
            if(!obf_K_e_3075.boothViewUI.visible)
            {
               obf_K_e_3075.showUI(obf_K_e_3075.boothViewUI);
            }
         }
         else if(obf_K_e_3075.boothViewUI.playerName == param1.boothOwnerId)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.boothViewUI);
         }
      }
      
      private static function obf_0_2_H_447(param1:BoothItemSoldNotify) : void
      {
         obf_6_D_3816.print(DiversityManager.getString("BoothUI","prompt_ItemSold",[obf_7_6_4416.getItemLinkA(param1.soldItemInfo.itemCode,param1.soldItemInfo.itemId) + " x" + param1.soldItemInfo.itemCount]));
      }
      
      private static function onPurchased(param1:BoothItemPurchasedNotify) : void
      {
         obf_6_D_3816.print(DiversityManager.getString("BoothUI","prompt_ItemBfm",[obf_7_6_4416.getItemLinkA(param1.purchaseItemInfo.itemCode,param1.purchaseItemInfo.itemId),param1.purchaseItemInfo.itemCount]));
      }
   }
}

