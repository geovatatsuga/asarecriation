package com.sunweb.game.rpg.iconItem
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.farm.FarmManager;
   import com.sunweb.game.rpg.farm.obf_0_1_N_478;
   import com.sunweb.game.rpg.gameItem.GameItemCDManager;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.netRole.obf_T_L_801;
   import com.sunweb.game.rpg.playerBag.PlayerBagIndex;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.PlayerBagUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.world.map.MapManager;
   import com.sunweb.game.rpg.world.map.WorldMapManager;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.obf_e_P_918;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_A_x_3023;
   import com.sunweb.game.utils.obf_L_l_4100;
   import cursor.CursorTargetToDo;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class IconItemExpendable extends IconItem
   {
      
      public static const obf_0_5_Q_714:int = 0;
      
      public static const obf_y_5_2720:int = 1;
      
      public static const obf_y_2_2660:int = 2;
      
      public static const obf_k_p_2306:int = 3;
      
      public static const obf_F_4692:int = 4;
      
      public static const obf_n_D_4460:int = 5;
      
      public static const obf_w_o_1953:int = 6;
      
      public static const obf_L_8_3610:int = 7;
      
      public static const RELEASE_MONSTERS:int = 8;
      
      public static const obf_d_2_4006:int = 9;
      
      public static const obf_a_O_4582:int = 10;
      
      public static const obf_i_Z_1618:int = 11;
      
      public static const obf_0_4_c_428:int = 12;
      
      public static const obf_0_N_972:int = 13;
      
      public static const obf_j_I_2593:int = 14;
      
      public static const obf_A_7_2068:int = 15;
      
      public function IconItemExpendable(param1:DisplayObject, param2:String)
      {
         super(param1);
         itemCode = param2;
         addType(GameItemType.EXPENDABLE);
      }
      
      public static function getNewIconItem(param1:String, param2:String) : IconItemExpendable
      {
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc3_)
         {
            obf_x_0_1295.obf_r_w_3556("obf____4852(" + param1 + ")obf___4949！");
            return null;
         }
         var _loc4_:IconItemExpendable = new IconItemExpendable(GameItemManager.getItemIcon(param1),param1);
         _loc4_.itemName = _loc3_.name;
         _loc4_.itemId = param2;
         _loc4_.rankMask = GameItemRank.getRankIcon(_loc3_.rank);
         _loc4_.iconItemRank = _loc3_.rank;
         _loc4_.iconMask = GameItemCDManager.getCDBitmap(GameItemManager.getItemCDFlag(param1));
         return _loc4_;
      }
      
      public static function showTip(param1:String, param2:String) : void
      {
         var _loc6_:GameItemFullInfo = null;
         var _loc7_:String = null;
         var _loc8_:Array = null;
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:int = 220;
         var _loc5_:GameTipUI = new GameTipUI("Items");
         GameItemManager.obf_4_G_4299(_loc3_.name,_loc3_.rank,_loc5_,_loc4_);
         GameItemManager.obf_o_l_1634(_loc3_,_loc5_,_loc4_);
         if(!obf_L_l_4100.isEmpty(param2) && JSONUtil.getStr(_loc3_,["properties","usePlaceGroup"]) != "")
         {
            _loc6_ = GameItemInfoManager.getItemInfo(param2);
            _loc7_ = DiversityManager.getString("ItemPrompt","getItemInfo");
            if(Boolean(_loc6_) && Boolean(_loc6_.expendableInfo))
            {
               _loc8_ = _loc6_.expendableInfo.usePlace.split("@");
               _loc7_ = DiversityManager.getString("ItemPrompt","useItemLocation",[WorldMapManager.getLandName(WorldMapManager.getMapInLandCode(_loc8_[1])) + "-" + WorldMapManager.getMapName(_loc8_[1])]);
               if(JSONUtil.getBoolean(_loc3_,["properties","showPlace"]))
               {
                  _loc7_ += "(" + _loc8_[0] + ")";
               }
            }
            _loc5_.addTipInfo("<font color=\'#0099CC\'>" + _loc7_ + "</font>",_loc4_,_loc5_.maxRow + 2);
         }
         if(JSONUtil.getStr(_loc3_,["remark"]) != "")
         {
            _loc5_.addTipInfo(_loc3_.remark,_loc4_,_loc5_.maxRow + 2);
         }
         GameItemManager.obf_7_0_2420(_loc3_,_loc5_,_loc4_);
         GameItemManager.obf_J_l_4537(_loc3_,_loc5_,_loc4_);
         GameItemManager.setItemTipValidTime(param1,param2,_loc5_,_loc4_);
         GameTipManager.showTip(_loc5_);
      }
      
      override public function useIcon(param1:* = null) : Boolean
      {
         var _loc2_:Object = null;
         var _loc3_:obf_0_1_N_478 = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc10_:Object = null;
         var _loc11_:String = null;
         var _loc12_:GameItemFullInfo = null;
         var _loc13_:Array = null;
         var _loc14_:Point = null;
         var _loc15_:Rectangle = null;
         var _loc16_:Point = null;
         var _loc17_:Point = null;
         var _loc18_:Number = NaN;
         var _loc19_:String = null;
         var _loc20_:int = 0;
         var _loc21_:String = null;
         var _loc22_:obf_T_L_801 = null;
         var _loc23_:Array = null;
         var _loc24_:Object = null;
         var _loc25_:Object = null;
         var _loc26_:obf_T_L_801 = null;
         var _loc27_:Array = null;
         if(itemCount <= 0)
         {
            return false;
         }
         if(Boolean(this.parent) && Boolean(this.parent is IconItemBag) && IconItemBag(this.parent).parentIconUI is PlayerBagUI)
         {
            _loc2_ = GameItemManager.getItemConfig(itemCode);
            if(!_loc2_)
            {
               return false;
            }
            if(!ConditionScript.checkCondition(JSONUtil.getObject(_loc2_,["properties","useCondition"]),null,true))
            {
               return false;
            }
            if(!MapManager.instance.checkExpendableRule(itemCode))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_CantUseInMap"));
               return false;
            }
            if(_loc2_.properties)
            {
               if(Boolean(_loc2_.properties.enabledMapIds) && Boolean(_loc2_.properties.enabledMapIds.length > 0) && _loc2_.properties.enabledMapIds.indexOf(GameContext.currentMap.mapId) == -1)
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_CantUseInMap"));
                  return false;
               }
               if(Boolean(_loc2_.properties.disabledMapIds) && Boolean(_loc2_.properties.disabledMapIds.length > 0) && _loc2_.properties.disabledMapIds.indexOf(GameContext.currentMap.mapId) > -1)
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_CantUseInMap"));
                  return false;
               }
               if(_loc2_.properties.cost)
               {
                  for(_loc4_ in _loc2_.properties.cost)
                  {
                     _loc5_ = int(_loc2_.properties.cost[_loc4_]);
                     if(obf_K_e_3075.playerBagUI.getItemCount(_loc4_) < _loc5_)
                     {
                        _loc6_ = GameItemManager.getItemConfig(_loc4_);
                        if(_loc6_)
                        {
                           obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_Cost",[_loc6_.name + "x" + _loc5_]));
                        }
                        return false;
                     }
                  }
               }
               _loc3_ = GameContext.localPlayer.getFarm();
               if(_loc2_.properties.result)
               {
                  _loc7_ = 0;
                  _loc8_ = 0;
                  if(_loc2_.properties.result[obf_k_p_2306 + ""])
                  {
                     for(_loc9_ in _loc2_.properties.result[obf_k_p_2306 + ""].items)
                     {
                        _loc10_ = GameItemManager.getItemConfig(_loc9_);
                        if(_loc10_)
                        {
                           if(_loc10_.type == GameItemType.RIDE)
                           {
                              _loc8_++;
                           }
                           else
                           {
                              _loc7_++;
                           }
                        }
                     }
                  }
                  if(_loc2_.properties.result[obf_F_4692 + ""])
                  {
                     for(_loc11_ in _loc2_.properties.result[obf_F_4692 + ""].items)
                     {
                        _loc7_ += _loc2_.properties.result[obf_F_4692 + ""].items.dropGroups.length;
                     }
                  }
                  if(Boolean(_loc7_ > 0) && Boolean(obf_K_e_3075.playerBagUI) && !obf_K_e_3075.playerBagUI.haveEmptyBag(_loc7_))
                  {
                     obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","needEmptyBag",[_loc7_]));
                     return false;
                  }
                  if(Boolean(_loc8_ > 0) && Boolean(obf_K_e_3075.rideBoxUI) && !obf_K_e_3075.rideBoxUI.haveEmptyBag(_loc8_))
                  {
                     obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","needEmptyRideBag",[_loc8_]));
                     return false;
                  }
               }
               if(_loc2_.properties.onlyInMyFarm)
               {
                  if(!_loc3_ || _loc3_.ownerId != GameContext.localPlayer.id)
                  {
                     obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_MustInMyFarm"));
                     return false;
                  }
               }
               if(Boolean(_loc2_.properties.result) && Boolean(_loc2_.properties.result[obf_d_2_4006 + ""]))
               {
                  if(Boolean(_loc2_.properties.result[obf_d_2_4006 + ""].condition) && !ConditionScript.checkCondition(_loc2_.properties.result[obf_d_2_4006 + ""].condition,null,true))
                  {
                     return false;
                  }
               }
               if(Boolean(_loc2_.properties.result) && Boolean(_loc2_.properties.result[obf_0_4_c_428 + ""]))
               {
                  if(_loc2_.properties.result[obf_0_4_c_428 + ""].condition)
                  {
                     ConditionScript.petInfoForCondition = obf_K_e_3075.petBoxUI.obf_O_O_3039;
                     if(!ConditionScript.checkCondition(_loc2_.properties.result[obf_0_4_c_428 + ""].condition,null,true))
                     {
                        return false;
                     }
                  }
               }
               if(Boolean(_loc2_.properties.result) && Boolean(_loc2_.properties.result[obf_0_N_972 + ""]))
               {
                  if(_loc2_.properties.result[obf_0_N_972 + ""].condition)
                  {
                     ConditionScript.rideInfoForCondition = obf_K_e_3075.rideBoxUI.obf_H_1999;
                     if(!ConditionScript.checkCondition(_loc2_.properties.result[obf_0_N_972 + ""].condition,null,true))
                     {
                        return false;
                     }
                  }
               }
               if(Boolean(_loc2_.properties.result) && Boolean(_loc2_.properties.result[obf_j_I_2593 + ""]))
               {
                  if(_loc2_.properties.result[obf_j_I_2593 + ""].condition)
                  {
                     ConditionScript.genieInfoForCondition = obf_K_e_3075.genieBoxUI.obf_7_e_2722;
                     if(!ConditionScript.checkCondition(_loc2_.properties.result[obf_j_I_2593 + ""].condition,null,true))
                     {
                        return false;
                     }
                  }
               }
               if(Boolean(_loc2_.properties.result) && Boolean(_loc2_.properties.result[obf_A_7_2068 + ""]))
               {
                  if(_loc2_.properties.result[obf_A_7_2068 + ""].condition)
                  {
                     ConditionScript.devilInfoForCondition = obf_K_e_3075.playerDevilUI.obf_X_h_2915;
                     if(!ConditionScript.checkCondition(_loc2_.properties.result[obf_A_7_2068 + ""].condition,null,true))
                     {
                        return false;
                     }
                  }
               }
               if(!obf_L_l_4100.isEmpty(itemId) && JSONUtil.getStr(_loc2_,["properties","usePlaceGroup"]) != "")
               {
                  _loc12_ = GameItemInfoManager.getItemInfo(itemId);
                  if(!_loc12_ || !_loc12_.expendableInfo)
                  {
                     obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","getItemInfo"));
                     return false;
                  }
                  _loc13_ = _loc12_.expendableInfo.usePlace.split("@");
                  if(GameContext.currentMap.mapId != _loc13_[1])
                  {
                     obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_MustInMap",[WorldMapManager.getMapName(_loc13_[1])]));
                     return false;
                  }
                  _loc14_ = new Point(_loc13_[0].split(",")[0],_loc13_[0].split(",")[1]);
                  _loc15_ = new Rectangle(_loc14_.x,_loc14_.y,1,1);
                  _loc15_.inflate(JSONUtil.getInt(_loc2_,["properties","placeRange"]),JSONUtil.getInt(_loc2_,["properties","placeRange"]));
                  _loc16_ = new Point(GameContext.localPlayer.rootX,int(GameContext.localPlayer.rootY / 2));
                  if(!_loc15_.containsPoint(_loc16_))
                  {
                     _loc17_ = _loc14_.subtract(_loc16_);
                     _loc18_ = obf_A_x_3023.getPointInScreenAngle(_loc17_);
                     _loc19_ = "→";
                     if(_loc18_ <= 20)
                     {
                        _loc19_ = "→";
                     }
                     else if(_loc18_ <= 60)
                     {
                        _loc19_ = "↗";
                     }
                     else if(_loc18_ <= 110)
                     {
                        _loc19_ = "↑";
                     }
                     else if(_loc18_ <= 160)
                     {
                        _loc19_ = "↖";
                     }
                     else if(_loc18_ <= 200)
                     {
                        _loc19_ = "←";
                     }
                     else if(_loc18_ <= 250)
                     {
                        _loc19_ = "↙";
                     }
                     else if(_loc18_ <= 290)
                     {
                        _loc19_ = "↓";
                     }
                     else if(_loc18_ <= 340)
                     {
                        _loc19_ = "↘";
                     }
                     _loc20_ = Point.distance(_loc16_,_loc14_);
                     _loc21_ = DiversityManager.getString("ItemPrompt","useItemDistance1");
                     if(_loc20_ <= 15)
                     {
                        _loc21_ = DiversityManager.getString("ItemPrompt","useItemDistance5");
                     }
                     else if(_loc20_ <= 35)
                     {
                        _loc21_ = DiversityManager.getString("ItemPrompt","useItemDistance4");
                     }
                     else if(_loc20_ <= 65)
                     {
                        _loc21_ = DiversityManager.getString("ItemPrompt","useItemDistance3");
                     }
                     else if(_loc20_ <= 100)
                     {
                        _loc21_ = DiversityManager.getString("ItemPrompt","useItemDistance2");
                     }
                     obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","showUseItemDirection",[_loc19_,_loc21_]));
                     return false;
                  }
               }
               if(Boolean(_loc2_.properties.result) && Boolean(_loc2_.properties.result[obf_n_D_4460 + ""]))
               {
                  GameContext.localPlayer.obf_F_S_2208(FarmManager.sendUseImproveItem,[itemCode,PlayerBagIndex.PLAYER_MAIN_BAG,IconItemBag(this.parent).itemIndex,_loc2_.properties.result[obf_n_D_4460 + ""].harvestKind,_loc2_.properties.result[obf_n_D_4460 + ""].scope]);
                  obf_e_P_918.setDefaultCursor(new CursorTargetToDo());
                  return false;
               }
               if(Boolean(_loc2_.properties.result) && Boolean(_loc2_.properties.result[obf_a_O_4582 + ""]))
               {
                  _loc22_ = GameContext.localPlayer.obf_0_6_a_430 as obf_T_L_801;
                  if(!_loc22_)
                  {
                     obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_NeedMonster"));
                     return false;
                  }
                  _loc23_ = JSONUtil.getObject(_loc2_,["properties","result",obf_a_O_4582 + "","monsterList"]) as Array;
                  if(!_loc23_)
                  {
                     return false;
                  }
                  for each(_loc25_ in _loc23_)
                  {
                     if(_loc25_.monsterCode == _loc22_.monsterCode)
                     {
                        _loc24_ = _loc25_;
                        break;
                     }
                  }
                  if(!_loc24_)
                  {
                     obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_NeedMonster"));
                     return false;
                  }
                  if(_loc22_.hpPercent > _loc24_.monsterHpRate * 100)
                  {
                     obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_MonsterHP",[_loc24_.monsterHpRate * 100]));
                     return false;
                  }
                  return GameContext.bagItemManager.sendUseItem(itemCode,PlayerBagIndex.PLAYER_MAIN_BAG,IconItemBag(this.parent).itemIndex,null,_loc22_);
               }
               if(Boolean(_loc2_.properties.result) && Boolean(_loc2_.properties.result[obf_i_Z_1618 + ""]))
               {
                  if(obf_K_e_3075.petBoxUI.getEnptyBag() <= 0)
                  {
                     obf_K_e_3075.showTipInfo(DiversityManager.getString("PetUI","petPrompt_BagIsFull"));
                     return false;
                  }
                  _loc26_ = GameContext.localPlayer.obf_0_6_a_430 as obf_T_L_801;
                  if(!_loc26_ || obf_L_l_4100.isEmpty(_loc26_.config.petCode))
                  {
                     obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_NeedMonster"));
                     return false;
                  }
                  if(_loc26_.level > GameContext.localPlayer.level)
                  {
                     obf_K_e_3075.showTipInfo(DiversityManager.getString("PetUI","petPrompt_CatchPetLevelError"));
                     return false;
                  }
                  _loc27_ = JSONUtil.getObject(_loc2_.properties.result[obf_i_Z_1618 + ""],["monsterList"],new Array()) as Array;
                  if(_loc27_.indexOf(_loc26_.monsterCode) <= -1)
                  {
                     obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_TargetNotInList"));
                     return false;
                  }
                  return GameContext.bagItemManager.sendUseItem(itemCode,PlayerBagIndex.PLAYER_MAIN_BAG,IconItemBag(this.parent).itemIndex,null,_loc26_);
               }
               if(JSONUtil.getStr(_loc2_,["properties","confirmText"]) != "")
               {
                  WindowManager.showConfirmBox(JSONUtil.getStr(_loc2_,["properties","confirmText"]),this.confirmUseItem,[itemCode,PlayerBagIndex.PLAYER_MAIN_BAG,IconItemBag(this.parent).itemIndex,null,null,param1]);
                  return false;
               }
               return GameContext.bagItemManager.sendUseItem(itemCode,PlayerBagIndex.PLAYER_MAIN_BAG,IconItemBag(this.parent).itemIndex,null,null,param1);
            }
         }
         return false;
      }
      
      private function confirmUseItem(param1:Object) : void
      {
         if(param1.confirm)
         {
            GameContext.bagItemManager.sendUseItem.apply(null,param1.par);
         }
      }
      
      override public function clone() : IconItem
      {
         var _loc1_:IconItemExpendable = getNewIconItem(itemCode,itemId);
         _loc1_.itemCount = this.itemCount;
         return _loc1_;
      }
   }
}

