package com.sunweb.game.rpg.playerBag
{
   import obf_a_F_1055.obf_b_p_3604;
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemBriefInfo;
   import com.sunweb.game.rpg.gameItem.GameItemCDManager;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.map.MapInteractiveObject;
   import com.sunweb.game.rpg.map.obf_z_T_3316;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.fastApplyUI.obf_X_t_4110;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.task.TaskManager;
   import com.sunweb.game.rpg.world.PromptsManager;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.info.CDItemInfo;
   import com.sunweb.game.rpg.world.map.MapPoint;
   import com.sunweb.game.rpg.worldZone.command.playerBag.CommandCodeBag;
   import com.sunweb.game.rpg.worldZone.command.playerBag.PlayerBagCapacityChangeNotify;
   import com.sunweb.game.rpg.worldZone.command.playerBag.PlayerBagCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.playerBag.PlayerBagSortRequest;
   import com.sunweb.game.rpg.worldZone.command.playerBag.PlayerBuyAndUseItemRequest;
   import com.sunweb.game.rpg.worldZone.command.playerBag.PlayerDropItemRequest;
   import com.sunweb.game.rpg.worldZone.command.playerBag.PlayerItemAddedNotify;
   import com.sunweb.game.rpg.worldZone.command.playerBag.PlayerItemCDCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.playerBag.PlayerItemUsedNotify;
   import com.sunweb.game.rpg.worldZone.command.playerBag.PlayerMoveItemCrossBagRequest;
   import com.sunweb.game.rpg.worldZone.command.playerBag.PlayerMoveItemRequest;
   import com.sunweb.game.rpg.worldZone.command.playerBag.PlayerPickUpItemRequest;
   import com.sunweb.game.rpg.worldZone.command.playerBag.PlayerSplitItemRequest;
   import com.sunweb.game.rpg.worldZone.command.playerBag.PlayerUseItemRequest;
   import com.sunweb.game.rpg.worldZone.command.playerBag.PlayerViewBagRequest;
   import com.sunweb.game.rpg.worldZone.command.playerBag.PlayerViewItemAnswer;
   import com.sunweb.game.rpg.worldZone.command.playerBag.PlayerViewItemRequest;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.geom.Point;
   
   public class BagItemManager
   {
      
      public function BagItemManager()
      {
         super();
      }
      
      public function init() : void
      {
      }
      
      public function get getPlayerBagsNum() : int
      {
         if(!WorldConfig.getValue("playerMainBag"))
         {
            return 180;
         }
         return WorldConfig.getValue("playerMainBag");
      }
      
      public function getHaveItemCount(param1:String, param2:Boolean = false) : int
      {
         var _loc3_:int = 0;
         var _loc4_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc4_)
         {
            obf_x_0_1295.obf_r_w_3556("config item " + param1 + " is null!");
         }
         if(param2 && !obf_L_l_4100.isEmpty(JSONUtil.getStr(_loc4_,["equalItem"])))
         {
            _loc3_ = this.getHaveItemCount(_loc4_.equalItem);
         }
         if(obf_K_e_3075.playerBagUI)
         {
            _loc3_ += obf_K_e_3075.playerBagUI.getItemCount(param1);
         }
         if(obf_K_e_3075.rideBoxUI)
         {
            _loc3_ += obf_K_e_3075.rideBoxUI.getItemCount(param1);
         }
         if(obf_K_e_3075.petBoxUI)
         {
            _loc3_ += obf_K_e_3075.petBoxUI.getItemCount(param1);
         }
         if(obf_K_e_3075.genieBoxUI)
         {
            _loc3_ += obf_K_e_3075.genieBoxUI.getItemCount(param1);
         }
         if(obf_K_e_3075.playerDevilUI)
         {
            _loc3_ += obf_K_e_3075.playerDevilUI.getItemCount(param1);
         }
         return _loc3_;
      }
      
      public function sendItemMove(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:PlayerMoveItemRequest = new PlayerMoveItemRequest();
         _loc4_.bagIndex = param3;
         _loc4_.fromItemIndex = param1;
         _loc4_.toItemIndex = param2;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public function sendSplitItem(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:PlayerSplitItemRequest = new PlayerSplitItemRequest();
         _loc5_.bagIndex = param1;
         _loc5_.fromItemIndex = param2;
         _loc5_.toItemIndex = param3;
         _loc5_.splitNumber = param4;
         GameContext.worldClient.sendCommand(_loc5_);
      }
      
      public function sendItemMoveCrossBag(param1:int, param2:int, param3:int, param4:int, param5:String, param6:Array) : void
      {
         if(!obf_L_l_4100.isEmpty(param5) && !obf_b_p_3604.checkNpcDistance(param5,true))
         {
            return;
         }
         var _loc7_:PlayerMoveItemCrossBagRequest = new PlayerMoveItemCrossBagRequest();
         _loc7_.fromBagIndex = param1;
         _loc7_.fromItemIndex = param2;
         _loc7_.toBagIndex = param3;
         _loc7_.toItemIndex = param4;
         _loc7_.npcId = param5;
         _loc7_.funcMenuFullIndex = param6;
         GameContext.worldClient.sendCommand(_loc7_);
      }
      
      public function sendDropItem(param1:int, param2:int, param3:MapPoint) : void
      {
         if(GameContext.currentMap == null)
         {
            return;
         }
         var _loc4_:PlayerDropItemRequest = new PlayerDropItemRequest();
         _loc4_.bagIndex = param1;
         _loc4_.itemIndex = param2;
         _loc4_.targetPoint = param3;
         _loc4_.mapId = GameContext.currentMap.mapId;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public function sendPickUpItem(param1:String) : Boolean
      {
         if(!GameContext.currentMap || !GameContext.localPlayer || obf_L_l_4100.isEmpty(param1))
         {
            return false;
         }
         var _loc2_:obf_z_T_3316 = GameContext.currentMap.itemSet.getObject(param1) as obf_z_T_3316;
         if(!_loc2_)
         {
            return false;
         }
         if(_loc2_.isInProtection)
         {
            return false;
         }
         if(Boolean(obf_K_e_3075.playerBagUI) && !obf_K_e_3075.playerBagUI.haveEmptyBag(1))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","playerBagFull"));
            return false;
         }
         if(!_loc2_)
         {
            return false;
         }
         if(GameContext.localPlayer.getLineDistance(_loc2_) > WorldConfig.MAX_PICK_UP_ITEM_DISTANCE)
         {
            GameContext.localPlayer.obf_g_R_3687(new Point(_loc2_.rootPX,_loc2_.rootPY),WorldConfig.MAX_PICK_UP_ITEM_DISTANCE - 10,this.sendPickUpItem,[param1]);
            return false;
         }
         var _loc3_:PlayerPickUpItemRequest = new PlayerPickUpItemRequest();
         _loc3_.itemId = param1;
         _loc3_.mapId = GameContext.currentMap.mapId;
         GameContext.worldClient.sendCommand(_loc3_);
         return true;
      }
      
      public function sendViewBag(param1:int) : void
      {
         var _loc2_:PlayerViewBagRequest = new PlayerViewBagRequest();
         _loc2_.bagIndex = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public function sendUseItem(param1:String, param2:int, param3:int, param4:Point = null, param5:MapInteractiveObject = null, param6:Object = null) : Boolean
      {
         var _loc7_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc7_)
         {
            return false;
         }
         if(_loc7_.type == GameItemType.EXPENDABLE && !GameContext.localPlayer.obf_0_0_z_623())
         {
            return false;
         }
         if(!GameItemManager.obf_D_n_3089(param1,true))
         {
            return false;
         }
         var _loc8_:PlayerUseItemRequest = new PlayerUseItemRequest();
         _loc8_.bagIndex = param2;
         _loc8_.itemIndex = param3;
         _loc8_.mapId = GameContext.currentMap.mapId;
         _loc8_.targetPoint = MapPoint.PointToMapPoint(param4);
         _loc8_.parameters = param6;
         if(param5)
         {
            _loc8_.targetObjectId = param5.id;
         }
         if(Boolean(_loc7_.useSkillCode) && _loc7_.useSkillCode != "")
         {
            return GameContext.localPlayer.sendSkill(_loc7_.useSkillCode,param5 ? param5 : GameContext.localPlayer.obf_0_6_a_430,null,_loc8_,_loc7_.name);
         }
         GameContext.worldClient.sendCommand(_loc8_);
         return true;
      }
      
      public function sendBuyAndUseItem(param1:String, param2:Point = null, param3:MapInteractiveObject = null, param4:Object = null) : void
      {
         var _loc5_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc5_)
         {
            return;
         }
         if(_loc5_.type == GameItemType.EXPENDABLE && !GameContext.localPlayer.obf_0_0_z_623())
         {
            return;
         }
         if(!GameItemManager.obf_D_n_3089(param1,true))
         {
            return;
         }
         var _loc6_:PlayerBuyAndUseItemRequest = new PlayerBuyAndUseItemRequest();
         _loc6_.itemCode = param1;
         _loc6_.targetPoint = MapPoint.PointToMapPoint(param2);
         if(param3)
         {
            _loc6_.targetObjectId = param3.id;
         }
         _loc6_.parameters = param4;
         GameContext.worldClient.sendCommand(_loc6_);
      }
      
      public function sendViewItem(param1:String) : void
      {
         var _loc2_:PlayerViewItemRequest = new PlayerViewItemRequest();
         _loc2_.itemId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public function sendSortBag(param1:int) : void
      {
         var _loc2_:PlayerBagSortRequest = new PlayerBagSortRequest();
         _loc2_.bagIndex = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeBag.PLAYER_BAG_CAPACITY_CHANGE_NOTIFY)
         {
            this.onBagCapacityChange(param1 as PlayerBagCapacityChangeNotify);
         }
         else if(param1.code == CommandCodeBag.PLAYER_BAG_CHECK_NOTIFY)
         {
            this.onBagCheck(param1 as PlayerBagCheckNotify);
         }
         else if(param1.code == CommandCodeBag.PLAYER_ITEM_USED_NOTIFY)
         {
            this.onUsedItem(param1 as PlayerItemUsedNotify);
         }
         else if(param1.code == CommandCodeBag.PLAYER_ITEM_ADDED_NOTIFY)
         {
            this.onItemAdded(param1 as PlayerItemAddedNotify);
         }
         else if(param1.code == CommandCodeBag.PLAYER_ITEM_CD_CHECK_NOTIFY)
         {
            this.onItemCDCheck(param1 as PlayerItemCDCheckNotify);
         }
         else if(param1.code == CommandCodeBag.PLAYER_VIEW_ITEM_ANSWER)
         {
            this.onViewItemAnswer(param1 as PlayerViewItemAnswer);
         }
      }
      
      private function onBagCapacityChange(param1:PlayerBagCapacityChangeNotify) : void
      {
         var _loc3_:int = 0;
         var _loc4_:IconItemBag = null;
         var _loc2_:Array = PlayerBagIndex.getBags(param1.bagIndex);
         if(Boolean(_loc2_) && _loc2_.length > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc4_ = _loc2_[_loc3_];
               if(_loc3_ < param1.capacity)
               {
                  _loc4_.isLocked = false;
               }
               else
               {
                  _loc4_.isLocked = true;
               }
               _loc3_++;
            }
         }
         if(param1.bagIndex == PlayerBagIndex.PLAYER_PET_BAG)
         {
            obf_K_e_3075.petBoxUI.obf_0___U_74();
         }
      }
      
      private function onBagCheck(param1:PlayerBagCheckNotify) : void
      {
         var _loc3_:BagItemInfo = null;
         var _loc4_:IconItemBag = null;
         var _loc5_:IconItem = null;
         var _loc2_:Array = PlayerBagIndex.getBags(param1.bagIndex);
         if(_loc2_ != null && _loc2_.length > 0)
         {
            for each(_loc3_ in param1.changedItems)
            {
               if(_loc3_.itemIndex < _loc2_.length)
               {
                  _loc4_ = _loc2_[_loc3_.itemIndex];
               }
               if(_loc4_)
               {
                  _loc4_.dropIconItem();
                  _loc5_ = null;
                  if(_loc3_.gameItem)
                  {
                     _loc5_ = IconItemManager.getIconItemByCode(_loc3_.gameItem.itemCode,_loc3_.gameItem.itemId);
                  }
                  if(_loc5_ != null)
                  {
                     _loc5_.itemCount = _loc3_.gameItem.itemCount;
                     _loc5_.itemId = _loc3_.gameItem.itemId;
                     _loc4_.pushIconItem(_loc5_);
                  }
               }
            }
         }
         if(param1.bagIndex == PlayerBagIndex.PLAYER_MAIN_BAG)
         {
            if(obf_K_e_3075.shortcutUI)
            {
               obf_K_e_3075.shortcutUI.recheckIconItem();
            }
            if(obf_K_e_3075.obf_f_a_l_s_e_334)
            {
               obf_K_e_3075.obf_f_a_l_s_e_334.obf_n_E_2173();
            }
            obf_K_e_3075.playerBagUI.obf_A_X_3117 = true;
         }
         if(param1.bagIndex == PlayerBagIndex.PLAYER_PET_BAG && Boolean(obf_K_e_3075.petBoxUI))
         {
            obf_K_e_3075.petBoxUI.checkSummonAndSelectPetBag();
         }
         if(param1.bagIndex == PlayerBagIndex.obf_5_R_2566)
         {
            obf_K_e_3075.genieBoxUI.obf_R_F_1307();
         }
         if(param1.bagIndex == PlayerBagIndex.obf_w_y_3760)
         {
            obf_K_e_3075.playerDevilUI.obf_E_O_2743();
         }
         if(param1.bagIndex == PlayerBagIndex.PLAYER_RIDE_BAG)
         {
            obf_K_e_3075.rideBoxUI.obf_r_z_4549();
         }
         if(param1.bagIndex == PlayerBagIndex.obf_S_A_4615)
         {
            obf_K_e_3075.tempBagUI.obf_2_o_2324();
         }
         obf_K_e_3075.obf_L_s_2876();
         if(Boolean(obf_K_e_3075.assembleBoxUI) && obf_K_e_3075.assembleBoxUI.visible)
         {
            obf_K_e_3075.assembleBoxUI.showAssembleContent();
         }
      }
      
      private function onUsedItem(param1:PlayerItemUsedNotify) : void
      {
         GameItemCDManager.setItemCD(GameItemManager.getItemCDFlag(param1.itemCode),GameItemManager.getItemCDTimeInMS(param1.itemCode));
         obf_6_D_3816.print(DiversityManager.getString("CommonPrompt","useItem",[obf_7_6_4416.getItemLinkA(param1.itemCode,"")]));
         TaskManager.doAutoTask();
      }
      
      private function onItemAdded(param1:PlayerItemAddedNotify) : void
      {
         var _loc2_:GameItemBriefInfo = null;
         var _loc3_:GameItemBriefInfo = null;
         var _loc4_:String = null;
         var _loc5_:Object = null;
         for each(_loc2_ in param1.itemsAdded)
         {
            _loc4_ = "";
            _loc4_ = obf_7_6_4416.getItemLink(_loc2_.itemCode,_loc2_.itemId);
            obf_6_D_3816.print(DiversityManager.getString("CommonPrompt","haveItem",[_loc4_ + " x" + _loc2_.itemCount]));
            _loc5_ = GameItemManager.getItemConfig(_loc2_.itemCode);
            if(_loc5_)
            {
               GameContext.localPlayer.obf_3_w_1335(GameItemManager.getItemIcon(_loc2_.itemCode),"x" + _loc2_.itemCount);
            }
            PromptsManager.checkGainItem(_loc2_.itemCode);
         }
         obf_K_e_3075.refineBoxUI.obf_I_n_2839();
         TaskManager.doAutoTask();
         for each(_loc3_ in param1.itemsAdded)
         {
            obf_X_t_4110.obf_f_n_2108(_loc3_.itemCode,_loc3_.itemId);
         }
      }
      
      private function onItemCDCheck(param1:PlayerItemCDCheckNotify) : void
      {
         var _loc2_:CDItemInfo = null;
         for each(_loc2_ in param1.cdItems)
         {
            GameItemCDManager.setItemCD(_loc2_.code,_loc2_.cdTimeLeftInMS);
         }
      }
      
      private function onViewItemAnswer(param1:PlayerViewItemAnswer) : void
      {
         var _loc3_:Object = null;
         var _loc2_:String = "";
         if(param1.item)
         {
            _loc2_ = param1.item.itemId;
            _loc3_ = GameItemManager.getItemConfig(param1.item.itemCode);
         }
         else
         {
            _loc2_ = param1.itemId;
         }
         var _loc4_:int = 10000;
         if(Boolean(_loc3_) && Boolean(_loc3_.type == GameItemType.EXPENDABLE) && Boolean(obf_K_e_3075.playerBagUI.getIconItemBagByID(_loc2_)))
         {
            _loc4_ = 0;
         }
         GameItemInfoManager.addItemInfo(param1.item,_loc2_,_loc4_);
         if(_loc2_ != "" && GameTipManager.isShowing("Items"))
         {
            GameItemManager.refreshItemTipInfo();
         }
      }
      
      public function destroy() : void
      {
      }
   }
}

