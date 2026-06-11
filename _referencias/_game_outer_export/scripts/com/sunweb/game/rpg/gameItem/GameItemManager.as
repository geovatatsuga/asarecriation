package com.sunweb.game.rpg.gameItem
{
   import obf_x_O_4078.obf_A_V_935;
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemCollection;
   import com.sunweb.game.rpg.iconItem.IconItemEquip;
   import com.sunweb.game.rpg.iconItem.IconItemExpendable;
   import com.sunweb.game.rpg.iconItem.IconItemFarm;
   import com.sunweb.game.rpg.iconItem.IconItemRide;
   import com.sunweb.game.rpg.iconItem.obf_U_N_1827;
   import com.sunweb.game.rpg.iconItem.obf_l_3_3784;
   import com.sunweb.game.rpg.iconItem.obf_n_m_2273;
   import com.sunweb.game.rpg.lifeJob.LifeJobCode;
   import com.sunweb.game.rpg.pet.obf_c_4686;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.obf_I_5_1944;
   import com.sunweb.game.rpg.settingConfig.NumberConfig;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import com.sunweb.game.utils.obf_l_y_733;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   
   public class GameItemManager
   {
      
      private static var tipInfoItemCode:String;
      
      private static var tipInfoItemId:String;
      
      private static var itemConfigObject:Object = new Object();
      
      private static var itemConfigMap:Object = new Object();
      
      public function GameItemManager()
      {
         super();
      }
      
      public static function addItemConfig(param1:Array) : void
      {
         var _loc2_:Object = null;
         if(!param1)
         {
            return;
         }
         for each(_loc2_ in param1)
         {
            itemConfigObject[_loc2_.code] = _loc2_;
            itemConfigMap[_loc2_.name] = _loc2_.code;
         }
      }
      
      public static function getItemConfig(param1:String) : Object
      {
         return itemConfigObject[param1];
      }
      
      public static function getEquipItemModelCode(param1:String) : String
      {
         return JSONUtil.getStr(itemConfigObject,[param1,"properties","modelCode"]);
      }
      
      public static function getItemName(param1:String) : String
      {
         var _loc2_:Object = getItemConfig(param1);
         if(_loc2_)
         {
            return _loc2_.name;
         }
         return "";
      }
      
      public static function getItemCode(param1:String) : String
      {
         return itemConfigMap[param1];
      }
      
      public static function isBooth(param1:String) : Boolean
      {
         var _loc2_:Object = getItemConfig(param1);
         return JSONUtil.getBoolean(_loc2_,["canTrade"]);
      }
      
      public static function isEquip(param1:String) : Boolean
      {
         var _loc2_:Object = getItemConfig(param1);
         return JSONUtil.getInt(_loc2_,["type"]) == GameItemType.EQUIPMENT;
      }
      
      public static function getStackSize(param1:String) : int
      {
         var _loc2_:Object = getItemConfig(param1);
         return JSONUtil.getInt(_loc2_,["stackSize"],1);
      }
      
      public static function getItemIconRes(param1:String) : String
      {
         var _loc2_:Object = getItemConfig(param1);
         return JSONUtil.getStr(_loc2_,["icon"]);
      }
      
      public static function getItemIcon(param1:String) : DisplayObject
      {
         var _loc2_:Object = getItemConfig(param1);
         if(!_loc2_)
         {
            return null;
         }
         var _loc3_:DisplayObject = ResourceManager.instance.getDisplayObject(_loc2_.icon);
         if(!_loc3_)
         {
            _loc3_ = new Bitmap(new nullItemIcon(1,1));
         }
         if(_loc3_ is InteractiveObject)
         {
            InteractiveObject(_loc3_).mouseEnabled = false;
         }
         if(_loc3_ is DisplayObjectContainer)
         {
            DisplayObjectContainer(_loc3_).mouseChildren = false;
         }
         return _loc3_;
      }
      
      public static function getItemCDFlag(param1:String) : String
      {
         var _loc2_:Object = getItemConfig(param1);
         if(_loc2_)
         {
            if(JSONUtil.getInt(_loc2_,["type"]) == GameItemType.PET)
            {
               return JSONUtil.getStr(obf_c_4686.config,["petCDFlag"]);
            }
            return _loc2_.cdFlag;
         }
         return "Unkown";
      }
      
      public static function getItemCDTimeInMS(param1:String) : int
      {
         var _loc2_:Object = getItemConfig(param1);
         if(JSONUtil.getInt(_loc2_,["type"]) == GameItemType.PET)
         {
            return JSONUtil.getInt(obf_c_4686.config,["petCDTimeInMS"]);
         }
         return JSONUtil.getInt(_loc2_,["cdTime"]);
      }
      
      public static function getItemEqual(param1:String) : String
      {
         var _loc2_:Object = getItemConfig(param1);
         if(Boolean(_loc2_) && Boolean(_loc2_.equalItem))
         {
            return _loc2_.equalItem;
         }
         return "";
      }
      
      public static function getItemGoldBuy(param1:String) : int
      {
         var _loc2_:Object = getItemConfig(param1);
         if(Boolean(_loc2_) && Boolean(_loc2_.goldPrice))
         {
            return _loc2_.goldPrice;
         }
         return 0;
      }
      
      public static function getItemMoneyBuy(param1:String) : int
      {
         var _loc2_:Object = getItemConfig(param1);
         if(Boolean(_loc2_) && Boolean(_loc2_.moneyPrice))
         {
            return _loc2_.moneyPrice;
         }
         return 0;
      }
      
      public static function getItemCoinBuy(param1:String) : int
      {
         var _loc2_:Object = getItemConfig(param1);
         return JSONUtil.getInt(_loc2_,["coinPrice"]);
      }
      
      public static function haveValidTime(param1:String) : Boolean
      {
         var _loc2_:Object = getItemConfig(param1);
         if(!_loc2_)
         {
            return false;
         }
         if(Boolean(_loc2_.validDays) && Boolean(_loc2_.validDays > 0) || Boolean(_loc2_.validMinutes) && Boolean(_loc2_.validMinutes > 0) || Boolean(_loc2_.expiredDate) && Boolean(_loc2_.expiredDate != ""))
         {
            return true;
         }
         return false;
      }
      
      public static function setItemTipValidTime(param1:String, param2:String, param3:GameTipUI, param4:int) : void
      {
         var _loc6_:GameItemFullInfo = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc5_:Object = getItemConfig(param1);
         if(!_loc5_)
         {
            return;
         }
         if(Boolean(param2) && param2 != "")
         {
            _loc6_ = GameItemInfoManager.getItemInfo(param2);
            _loc7_ = "";
            if(_loc6_)
            {
               if(!_loc6_.isEmpty)
               {
                  if(_loc6_.expiredTimeLeftInHour > 0 && _loc6_.expiredTimeLeftInHour < int.MAX_VALUE)
                  {
                     _loc7_ = obf_l_y_733.getTimeStringMin(_loc6_.timeLeftInMs);
                  }
                  else if(_loc6_.expiredTimeLeftInHour <= 0)
                  {
                     _loc7_ = DiversityManager.getString("ItemPrompt","itemExpired");
                  }
               }
               else
               {
                  _loc7_ = "";
               }
            }
            else
            {
               _loc7_ = DiversityManager.getString("ItemPrompt","getItemInfo");
            }
            if(_loc7_ != "")
            {
               if(Boolean(_loc6_) && _loc6_.isEmpty)
               {
                  param3.addTipInfo("<p align=\'center\'>" + _loc7_ + "</P>",param4,param3.maxRow + 2);
               }
               else
               {
                  param3.addTipInfo("<font color=\'#00ff00\'>" + DiversityManager.getString("ItemPrompt","itemValidity") + "</font>",param4,param3.maxRow + 2);
                  param3.addTipInfo("<font color=\'#00ff00\'><p align=\'right\'>" + _loc7_ + "</p></font>",param4,param3.maxRow);
               }
            }
         }
         else
         {
            _loc8_ = "";
            if(Boolean(_loc5_.validDays) && _loc5_.validDays > 0)
            {
               _loc8_ = DiversityManager.getString("TimePrompt","D",[_loc5_.validDays]);
            }
            if(Boolean(_loc5_.validMinutes) && _loc5_.validMinutes > 0)
            {
               _loc8_ += DiversityManager.getString("TimePrompt","H",[_loc5_.validDays]);
            }
            if(Boolean(_loc5_.validDays) || Boolean(_loc5_.validMinutes))
            {
               param3.addTipInfo("<font color=\'#00ff00\'>" + DiversityManager.getString("ItemPrompt","itemValidity") + "</font>",param4,param3.maxRow + 2);
               param3.addTipInfo("<font color=\'#00ff00\'><P align=\'right\'>" + _loc8_ + "</P></font>",param4,param3.maxRow);
            }
         }
         if(Boolean(_loc5_.expiredDate) && _loc5_.expiredDate != "")
         {
            param3.addTipInfo("<font color=\'#00ff00\'>" + DiversityManager.getString("ItemPrompt","itemValidityTo") + "</font>",param4,param3.maxRow + 1);
            param3.addTipInfo("<font color=\'#00ff00\'><p align=\'right\'>" + _loc5_.expiredDate + "</p></font>",param4,param3.maxRow);
         }
      }
      
      public static function getItemTipText(param1:String, param2:int) : String
      {
         var _loc3_:Object = getItemConfig(param1);
         if(!_loc3_)
         {
            return "";
         }
         var _loc4_:String = "<P align=\'center\'><FONT COLOR=\'#" + GameItemRank.getRankColor(param2).toString(16) + "\'>" + _loc3_.name + "</FONT></P>\n\n";
         _loc4_ = _loc4_ + (_loc3_.remark + "\n\n");
         return _loc4_ + ("<FONT COLOR=\'#FFFF00\'>" + DiversityManager.getString("ItemPrompt","itemValidityTo",[_loc3_.recycleGoldPrice]) + "</FONT>");
      }
      
      public static function obf_D_n_3089(param1:String, param2:Boolean = false) : Boolean
      {
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc3_ || !GameContext.localPlayer)
         {
            return false;
         }
         if(GameContext.localPlayer.isDead)
         {
            if(param2)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_Died"));
            }
            return false;
         }
         if(GameItemCDManager.checkItemCD(GameItemManager.getItemCDFlag(param1)))
         {
            if(param2)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_CD"));
            }
            return false;
         }
         if(_loc3_.playerLevel != null && GameContext.localPlayer.level < _loc3_.playerLevel)
         {
            if(param2)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_PlayerLevel",[_loc3_.playerLevel]));
            }
            return false;
         }
         if(_loc3_.honorLevel != null && GameContext.localPlayer.fullInfo.honorLevel < _loc3_.honorLevel)
         {
            if(param2)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_HonorLevel",[NumberConfig.getHonorLevelName(_loc3_.honorLevel)]));
            }
            return false;
         }
         if(_loc3_.playerSex != null && _loc3_.playerSex > -1 && _loc3_.playerSex != GameContext.localPlayer.fullInfo.sex)
         {
            if(param2)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_Sex",[_loc3_.playerSex == 0 ? DiversityManager.getString("EquipmentAttribute","woman") : DiversityManager.getString("EquipmentAttribute","man")]));
            }
            return false;
         }
         if(_loc3_.playerJob != null && _loc3_.playerJob.length > 0 && _loc3_.playerJob.indexOf(GameContext.localPlayer.fullInfo.jobCode) == -1)
         {
            if(param2)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_Job"));
            }
            return false;
         }
         if(_loc3_.playerLifeJob != null && _loc3_.playerLifeJob.length > 0 && GameContext.localPlayer.fullInfo.lifeJob != _loc3_.playerLifeJob)
         {
            if(param2)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_LifeJob",[LifeJobCode.getLifeJobName(_loc3_.playerLifeJob)]));
            }
            return false;
         }
         if(_loc3_.playerLifeLevel != null)
         {
            if(GameContext.localPlayer.fullInfo.lifeJob == 0 || GameContext.localPlayer.fullInfo.lifeLevel < _loc3_.playerLifeLevel)
            {
               if(param2)
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_LifeLevel",[LifeJobCode.getLifeJobRankName(_loc3_.playerLifeLevel)]));
               }
               return false;
            }
         }
         return true;
      }
      
      public static function itemCanTrade(param1:String) : Boolean
      {
         var _loc2_:Object = getItemConfig(param1);
         if(!_loc2_)
         {
            return false;
         }
         return JSONUtil.getBoolean(_loc2_,["canTrade"],true);
      }
      
      public static function itemCanHole(param1:String) : Boolean
      {
         var _loc2_:Object = getItemConfig(param1);
         if(_loc2_.type != GameItemType.EQUIPMENT)
         {
            return false;
         }
         var _loc3_:Object = obf_A_V_935.getHolePlan(JSONUtil.getStr(_loc2_,["properties","holePlanId"]));
         if(!_loc3_ || JSONUtil.getInt(_loc3_,["maxHoleNumber"]) <= 0)
         {
            return false;
         }
         return true;
      }
      
      public static function itemCanRefine(param1:String) : Boolean
      {
         var _loc2_:Object = getItemConfig(param1);
         if(_loc2_.type != GameItemType.EQUIPMENT)
         {
            return false;
         }
         if(JSONUtil.getNumber(_loc2_,["properties","extAttrPoint"]) <= 0)
         {
            return false;
         }
         return JSONUtil.getBoolean(_loc2_,["properties","canRefine"]);
      }
      
      public static function getItemQualityValue(param1:Number, param2:int) : Number
      {
         return param1 * obf_Q_l_1536.getQualityMul(param2);
      }
      
      public static function refreshItemTipInfo() : void
      {
         showItemTipInfo(tipInfoItemCode,tipInfoItemId);
      }
      
      public static function showItemTipInfo(param1:String, param2:String) : void
      {
         var _loc4_:int = 0;
         var _loc5_:IconItemBag = null;
         var _loc6_:IconItemEquip = null;
         var _loc7_:GameTipUI = null;
         var _loc8_:Array = null;
         tipInfoItemCode = param1;
         tipInfoItemId = param2;
         GameTipManager.closeTip("Items");
         GameTipManager.closeTip("equipSuit");
         GameTipManager.closeTip("equipContrast");
         GameTipManager.closeTip("wingSpirit");
         if(!obf_L_l_4100.isEmpty(param2) && GameItemInfoManager.getItemInfo(param2) == null)
         {
            GameContext.bagItemManager.sendViewItem(param2);
         }
         var _loc3_:Object = getItemConfig(param1);
         if(_loc3_)
         {
            if(_loc3_.type == GameItemType.RIDE)
            {
               IconItemRide.showTip(param1,param2);
            }
            else if(_loc3_.type == GameItemType.PET)
            {
               obf_U_N_1827.showTip(param1,param2);
            }
            else if(_loc3_.type == GameItemType.obf_N_v_4048)
            {
               obf_l_3_3784.showTip(param1,param2);
            }
            else if(_loc3_.type == GameItemType.obf_y_n_2092)
            {
               obf_n_m_2273.showTip(param1,param2);
            }
            else if(_loc3_.type == GameItemType.EQUIPMENT)
            {
               _loc4_ = JSONUtil.getInt(_loc3_,["properties","kind"]);
               _loc5_ = obf_K_e_3075.playerFullInfoUI.getEquipBagByKind(_loc4_);
               if(_loc5_)
               {
                  _loc6_ = _loc5_.haveIconItem as IconItemEquip;
               }
               if(Boolean(_loc6_) && (_loc6_.itemCode != param1 || _loc6_.itemId != param2))
               {
                  if(GameItemInfoManager.getItemInfo(_loc6_.itemId) == null)
                  {
                     GameContext.bagItemManager.sendViewItem(_loc6_.itemId);
                  }
                  _loc8_ = IconItemEquip.getEquipTips(_loc6_.itemCode,_loc6_.itemId,"equipContrast");
                  if((Boolean(_loc8_)) && _loc8_.length > 0)
                  {
                     _loc7_ = _loc8_[0];
                     _loc7_.addTipInfo("<p align=\'left\'><font color=\'#FFFF00\'>" + DiversityManager.getString("ItemPrompt","currentUseItem") + "</font></p>",_loc7_.maxTipTextWidth,2);
                  }
               }
               IconItemEquip.showTip(param1,param2,[_loc7_]);
            }
            else if(_loc3_.type == GameItemType.EXPENDABLE)
            {
               if(_loc3_.subtype == GameItemSubtype.EXPENDABLE_FARM_SEED || _loc3_.subtype == GameItemSubtype.EXPENDABLE_FARM_BUILDING)
               {
                  IconItemFarm.showTip(param1,param2);
               }
               else
               {
                  IconItemExpendable.showTip(param1,param2);
               }
            }
            else if(_loc3_.type == GameItemType.COLLECTION)
            {
               IconItemCollection.showTip(param1,param2);
            }
            else
            {
               IconItem.showTip(param1,param2);
            }
         }
      }
      
      public static function obf_4_G_4299(param1:String, param2:int, param3:GameTipUI, param4:int) : void
      {
         param3.addTipInfo("<P align=\'center\'><FONT size=\'14\' COLOR=\'#" + GameItemRank.getRankColor(param2).toString(16) + "\'><B>" + param1 + "</B></FONT></P>",param4,1);
      }
      
      public static function obf_o_l_1634(param1:Object, param2:GameTipUI, param3:int, param4:GameItemFullInfo = null) : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:int = 0;
         var _loc13_:String = null;
         if(Boolean(param4) && Boolean(param4.equipmentInfo) && !obf_L_l_4100.isEmpty(param4.equipmentInfo.letteringWord))
         {
            param2.addTipInfo(DiversityManager.getString("EquipmentAttribute","lettering",[param4.equipmentInfo.letteringRole,param4.equipmentInfo.letteringWord]),param3,param2.maxRow + 1);
         }
         if(param1.playerLevel > 0)
         {
            _loc5_ = GameContext.localPlayer.fullInfo.level >= param1.playerLevel ? "00FF00" : "FF0000";
            param2.addTipInfo("<FONT color=\'#" + _loc5_ + "\'>" + DiversityManager.getString("EquipmentAttribute","playerLevel_Label") + "</FONT>",param3,param2.maxRow + 1);
            param2.addTipInfo("<P align=\'right\'><FONT color=\'#" + _loc5_ + "\'>" + DiversityManager.getString("EquipmentAttribute","playerLevel_Value",[param1.playerLevel]) + "</FONT></P>",param3,param2.maxRow);
         }
         if(param1.honorLevel > 0)
         {
            _loc6_ = GameContext.localPlayer.fullInfo.honorLevel >= param1.honorLevel ? "00FF00" : "FF0000";
            param2.addTipInfo("<FONT color=\'#" + _loc6_ + "\'>" + DiversityManager.getString("EquipmentAttribute","playerHonor_Label") + "</FONT>",param3,param2.maxRow + 1);
            param2.addTipInfo("<P align=\'right\'><FONT color=\'#" + _loc6_ + "\'>" + NumberConfig.getHonorLevelName(param1.honorLevel) + "</FONT></P>",param3,param2.maxRow);
         }
         param2.addTipInfo(DiversityManager.getString("ItemPrompt","itemType"),param3,param2.maxRow + 1);
         param2.addTipInfo("<P align=\'right\'>" + GameItemType.getTypeName(param1.type) + (param1.subtype ? "--" + GameItemSubtype.getSubTypeName(param1.subtype) : "") + "</P>",param3,param2.maxRow);
         if(JSONUtil.getInt(param1,["itemLevel"]) > 0)
         {
            param2.addTipInfo(DiversityManager.getString("ItemPrompt","itemLevel"),param3,param2.maxRow + 1);
            param2.addTipInfo("<P align=\'right\'>" + DiversityManager.getString("ItemPrompt","itemLevelValue",[JSONUtil.getInt(param1,["itemLevel"])]) + "</P>",param3,param2.maxRow);
         }
         if(!JSONUtil.getBoolean(param1,["canTrade"]) || !JSONUtil.getBoolean(param4,["canTrade"],true))
         {
            param2.addTipInfo("<font color=\'#FFFF00\'>" + DiversityManager.getString("EquipmentAttribute","cantTrade") + "</font>",param3,param2.maxRow + 1);
         }
         if(!JSONUtil.getBoolean(param1,["canDepot"]))
         {
            param2.addTipInfo("<font color=\'#FFFF00\'>" + DiversityManager.getString("EquipmentAttribute","cantDepot") + "</font>",param3,param2.maxRow + 1);
         }
         if(JSONUtil.getStr(param1,["decDropRule"]) != "")
         {
            param2.addTipInfo("<font color=\'#FFFF00\'>" + DiversityManager.getString("EquipmentAttribute","canDecompose") + "</font>",param3,param2.maxRow + 1);
         }
         if(param1.playerSex > -1)
         {
            param2.addTipInfo(DiversityManager.getString("EquipmentAttribute","playerSex_Label"),param3,param2.maxRow + 1);
            param2.addTipInfo("<P align=\'right\'><FONT color=\'#" + (param1.playerSex == 0 ? "FF8484" : "59B0FF") + "\'>" + (param1.playerSex == 0 ? DiversityManager.getString("EquipmentAttribute","woman") : DiversityManager.getString("EquipmentAttribute","man")) + "</FONT></P>",param3,param2.maxRow);
         }
         if(Boolean(param1.playerJob) && param1.playerJob.length > 0)
         {
            param2.addTipInfo(DiversityManager.getString("EquipmentAttribute","playerJob"),param3,param2.maxRow + 1);
            _loc7_ = "";
            _loc8_ = param1.playerJob.indexOf(GameContext.localPlayer.fullInfo.jobCode) > -1 ? "00FF00" : "FF0000";
            for each(_loc9_ in param1.playerJob)
            {
               if(_loc7_ != "")
               {
                  _loc7_ += ",";
               }
               _loc7_ += obf_I_5_1944.getJobShowName(_loc9_);
            }
            param2.addTipInfo("<P align=\'right\'><font color=\'#" + _loc8_ + "\'>" + _loc7_ + "</font></P>",param3,param2.maxRow);
         }
         if(Boolean(param1.playerLifeJob) && param1.playerLifeJob.length > 0)
         {
            param2.addTipInfo(DiversityManager.getString("EquipmentAttribute","lifeJob_Label"),param3,param2.maxRow + 1);
            _loc10_ = "";
            _loc11_ = param1.playerLifeJob.indexOf(GameContext.localPlayer.fullInfo.lifeJob) > -1 ? "00FF00" : "FF0000";
            for each(_loc12_ in param1.playerLifeJob)
            {
               if(_loc10_ != "")
               {
                  _loc10_ += "、";
               }
               _loc10_ += LifeJobCode.getLifeJobName(_loc12_);
            }
            param2.addTipInfo("<p align=\'right\'><font color=\'#" + _loc11_ + "\'>" + _loc10_ + "</font></p>",param3,param2.maxRow);
         }
         if(Boolean(param1.playerLifeLevel) && param1.playerLifeLevel > 0)
         {
            param2.addTipInfo(DiversityManager.getString("EquipmentAttribute","lifeJobLevel_Label"),param3,param2.maxRow + 1);
            _loc13_ = GameContext.localPlayer.fullInfo.lifeLevel >= param1.playerLifeLevel ? "00FF00" : "FF0000";
            param2.addTipInfo("<p align=\'right\'><font color=\'#" + _loc13_ + "\'>" + LifeJobCode.getLifeJobRankName(param1.playerLifeLevel) + "</font></p>",param3,param2.maxRow);
         }
      }
      
      public static function obf_7_0_2420(param1:Object, param2:GameTipUI, param3:int, param4:GameItemFullInfo = null) : void
      {
         if(!obf_L_l_4100.isEmpty(param1.remarkUsage))
         {
            param2.addTipInfo(DiversityManager.getString("EquipmentAttribute","itemUsage",[param1.remarkUsage]),param3,param2.maxRow + 1);
         }
         if(!obf_L_l_4100.isEmpty(param1.remarkGain))
         {
            param2.addTipInfo(DiversityManager.getString("EquipmentAttribute","itemGain",[param1.remarkGain]),param3,param2.maxRow + 1);
         }
      }
      
      public static function obf_J_l_4537(param1:Object, param2:GameTipUI, param3:int) : void
      {
         var _loc4_:DisplayObject = null;
         if(param1.canRecycle)
         {
            param2.addTipInfo(DiversityManager.getString("EquipmentAttribute","itemPrice"),param3,param2.maxRow + 1);
            _loc4_ = obf_a_f_2935.getGoldDisplay(JSONUtil.getNumber(param1,["recycleGoldPrice"]));
            _loc4_.x = 80;
            param2.addTipObject(_loc4_,param2.maxRow - 1);
         }
      }
   }
}

