package com.sunweb.game.rpg.equ
{
   import obf_x_O_4078.obf_1_t_884;
   import com.adobe.serialization.json.JSON;
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.equipKindGrow.EquipKindGrowManager;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.SkillConfig;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.rpg.skill.obf_M_F_3694;
   import com.sunweb.game.rpg.worldZone.command.equ.CommandCodePlayerEquip;
   import com.sunweb.game.rpg.worldZone.command.equ.PlayerEquipDurCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.equ.PlayerEquipmentCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.equ.PlayerRemoveEquipmentRequest;
   import com.sunweb.game.rpg.worldZone.command.equ.PlayerRepairEquipmentAnswer;
   import com.sunweb.game.rpg.worldZone.command.equ.PlayerRepairEquipmentRequest;
   import com.sunweb.game.rpg.worldZone.command.equ.PlayerSwitchFashionNotify;
   import com.sunweb.game.rpg.worldZone.command.equ.PlayerSwitchFashionRequest;
   import com.sunweb.game.rpg.worldZone.command.equ.PlayerViewRepairInfoAnswer;
   import com.sunweb.game.rpg.worldZone.command.equ.PlayerViewRepairInfoRequest;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   
   public class EquipmentManager
   {
      
      private static var equipmentConfig:Object;
      
      public static var obf_g_N_2380:Object;
      
      public static var equipHash:Object = new Object();
      
      public function EquipmentManager()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         equipmentConfig = param1;
         var _loc2_:Object = JSONUtil.getObject(param1,["kindGrow"]);
         if(_loc2_)
         {
            EquipKindGrowManager.init(_loc2_);
         }
      }
      
      public static function getConfigValue(... rest) : *
      {
         return JSONUtil.getObject(equipmentConfig,rest);
      }
      
      public static function obf_3_Z_1689(param1:String) : Boolean
      {
         if(!GameContext.localPlayer || !obf_K_e_3075.playerFullInfoUI)
         {
            return false;
         }
         var _loc2_:Object = GameItemManager.getItemConfig(param1);
         if(JSONUtil.getInt(_loc2_,["type"]) != GameItemType.EQUIPMENT)
         {
            return false;
         }
         if(!GameItemManager.obf_D_n_3089(param1))
         {
            return false;
         }
         var _loc3_:IconItemBag = obf_K_e_3075.playerFullInfoUI.getEquipBagByKind(JSONUtil.getInt(_loc2_,["properties","kind"]));
         if(!_loc3_)
         {
            return false;
         }
         var _loc4_:Object = GameItemManager.getItemConfig(JSONUtil.getStr(_loc3_,["haveIconItem","itemCode"]));
         if(!_loc3_.haveIconItem || !_loc4_)
         {
            return true;
         }
         if(JSONUtil.getNumber(_loc4_,["properties","extAttrPoint"]) < JSONUtil.getNumber(_loc2_,["properties","extAttrPoint"]))
         {
            return true;
         }
         if(JSONUtil.getNumber(_loc4_,["properties","extAttrPoint"]) == JSONUtil.getNumber(_loc2_,["properties","extAttrPoint"]) && _loc4_.itemLevel < _loc2_.itemLevel)
         {
            return true;
         }
         if(JSONUtil.getNumber(_loc4_,["properties","extAttrPoint"]) == JSONUtil.getNumber(_loc2_,["properties","extAttrPoint"]) && _loc4_.itemLevel == _loc2_.itemLevel && _loc4_.rank < _loc2_.rank)
         {
            return true;
         }
         return false;
      }
      
      public static function getItemFullName(param1:String, param2:GameItemFullInfo = null) : String
      {
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc3_)
         {
            return "";
         }
         var _loc4_:String = _loc3_.name;
         if(JSONUtil.getInt(param2,["equipmentInfo","equLevel"]) > 0)
         {
            _loc4_ = "Lv" + param2.equipmentInfo.equLevel + " " + _loc4_;
         }
         if(Boolean(param2) && JSONUtil.getInt(param2,["equipmentInfo","refineLevel"]) > 0)
         {
            _loc4_ += " +" + JSONUtil.getInt(param2,["equipmentInfo","refineLevel"]);
         }
         return _loc4_;
      }
      
      public static function getEquipmentAttrHTML(param1:String, param2:GameItemFullInfo = null) : String
      {
         var attrHTML:String;
         var baseAttr:Array;
         var extAttr:Array = null;
         var attrObj:Object = null;
         var attrValue:Number = NaN;
         var baseAttrAdd:int = 0;
         var baseAttrAddString:String = null;
         var extObj:Object = null;
         var baseExtAdd:int = 0;
         var baseExtAddString:String = null;
         var levelExtAttr:Array = null;
         var levelSkills:Array = null;
         var levelExtObj:Object = null;
         var equLvSkillObj:Object = null;
         var equLvSkillConfig:Object = null;
         var equipCode:String = param1;
         var itemInfo:GameItemFullInfo = param2;
         var itemConfig:Object = GameItemManager.getItemConfig(equipCode);
         if(!itemConfig)
         {
            return "";
         }
         attrHTML = "";
         baseAttr = JSONUtil.getObject(itemConfig,["properties","baseAttr"]) as Array;
         if(Boolean(baseAttr) && baseAttr.length > 0)
         {
            for each(attrObj in baseAttr)
            {
               attrValue = Number(attrObj.value);
               if(Boolean(itemInfo) && Boolean(!itemInfo.isEmpty) && Boolean(itemInfo.equipmentInfo))
               {
                  attrValue = GameItemManager.getItemQualityValue(attrObj.value,itemInfo.equipmentInfo.quality);
               }
               baseAttrAdd = EquipmentManager.getEquipmentAttrValue(attrValue,itemInfo);
               baseAttrAddString = "";
               if(baseAttrAdd > 0)
               {
                  baseAttrAddString = "<font color=\'#00FF00\'>(+" + baseAttrAdd + ")</font>";
               }
               attrHTML += RoleAttributesModifierEnum.getAttributesName(attrObj.attr) + "\t" + RoleAttributesModifierEnum.getAttributesValueString(attrObj.attr,attrValue) + baseAttrAddString + "\n";
            }
         }
         attrHTML += "\n";
         if(Boolean(itemInfo && !itemInfo.isEmpty) && Boolean(itemInfo.equipmentInfo) && itemInfo.equipmentInfo.isRandomExtAttr)
         {
            if(!obf_L_l_4100.isEmpty(itemInfo.equipmentInfo.extAttributes))
            {
               try
               {
                  extAttr = com.adobe.serialization.json.JSON.decode(itemInfo.equipmentInfo.extAttributes) as Array;
               }
               catch(e:Error)
               {
               }
            }
         }
         else
         {
            extAttr = JSONUtil.getObject(itemConfig,["properties","extAttr"]) as Array;
         }
         if(Boolean(extAttr) && extAttr.length > 0)
         {
            attrHTML += "<FONT color=\'#00FF00\'>";
            for each(extObj in extAttr)
            {
               baseExtAdd = EquipmentManager.getEquipmentAttrValue(extObj.value,itemInfo,true);
               baseExtAddString = "";
               if(baseExtAdd > 0)
               {
                  baseExtAddString = "(+" + baseExtAdd + ")";
               }
               attrHTML += RoleAttributesModifierEnum.getAttributesName(extObj.attr) + "\t" + RoleAttributesModifierEnum.getAttributesValueString(extObj.attr,extObj.value) + baseExtAddString + "\n";
            }
            attrHTML += "</FONT>";
         }
         if(Boolean(itemInfo) && Boolean(!itemInfo.isEmpty) && Boolean(itemInfo.equipmentInfo))
         {
            levelExtAttr = EquipmentManager.getEquipmentLevelUpExtAttr(equipCode,itemInfo.equipmentInfo.equLevel);
            levelSkills = EquipmentManager.getEquipmentLevelUpSkills(equipCode,itemInfo.equipmentInfo.equLevel);
            attrHTML += "<FONT color=\'#00FF00\'>";
            if(Boolean(levelExtAttr) && Boolean(levelExtAttr.length > 0) || Boolean(levelSkills) && Boolean(levelSkills.length > 0))
            {
               attrHTML += "<FONT color=\'#00FF00\'>" + DiversityManager.getString("EquipmentAttribute","itemLevelAttribute",[itemInfo.equipmentInfo.equLevel]) + "</FONT>\n";
            }
            if(Boolean(levelExtAttr) && levelExtAttr.length > 0)
            {
               for each(levelExtObj in levelExtAttr)
               {
                  attrHTML += RoleAttributesModifierEnum.getAttributesName(levelExtObj.attr) + "\t" + RoleAttributesModifierEnum.getAttributesValueString(levelExtObj.attr,levelExtObj.value) + "\n";
               }
            }
            if(Boolean(levelSkills) && levelSkills.length > 0)
            {
               attrHTML += DiversityManager.getString("EquipmentAttribute","itemGiveSkill") + "\n";
               for each(equLvSkillObj in levelSkills)
               {
                  equLvSkillConfig = SkillConfig.getSkillConfig(equLvSkillObj.skillCode);
                  if(equLvSkillConfig)
                  {
                     attrHTML += equLvSkillConfig.name + (equLvSkillConfig.type == obf_M_F_3694.obf_u_8_4559 ? "(" + DiversityManager.getString("PlayerSkillPrompt","passiveSkill") + ")" : "") + ": " + equLvSkillConfig.levelInfo[0].detail + "</FONT>\n";
                  }
               }
            }
            attrHTML += "</FONT>";
         }
         return attrHTML;
      }
      
      public static function getEquipmentAttrValue(param1:int, param2:GameItemFullInfo, param3:Boolean = false, param4:int = 0, param5:int = 0) : int
      {
         if(!param2 || !param2.equipmentInfo || param2.isEmpty)
         {
            return 0;
         }
         var _loc6_:Number = 0;
         var _loc7_:int = 0;
         var _loc8_:Object = obf_1_t_884.getRefineLevelConfig((param4 > 0 ? param4 : param2.equipmentInfo.refineLevel) - 1);
         if((Boolean(_loc8_)) && !param3)
         {
            _loc6_ += JSONUtil.getNumber(_loc8_,["attrAddRate"]);
            _loc7_ += JSONUtil.getInt(_loc8_,["attrAddValue"]);
         }
         var _loc9_:Object = GameItemManager.getItemConfig(param2.itemCode);
         var _loc10_:Object = JSONUtil.getValue(_loc9_,"properties","equLevel",(param5 > 0 ? param5 : param2.equipmentInfo.equLevel) - 1);
         if(_loc10_)
         {
            if(param3)
            {
               _loc6_ += JSONUtil.getNumber(_loc10_,["extAttrAddRate"]);
               _loc7_ += JSONUtil.getNumber(_loc10_,["extAttrAddValue"]);
            }
            else
            {
               _loc6_ += JSONUtil.getNumber(_loc10_,["attrAddRate"]);
               _loc7_ += JSONUtil.getNumber(_loc10_,["attrAddValue"]);
            }
         }
         return Math.round(param1 * _loc6_) + _loc7_;
      }
      
      public static function equipmentHasLevel(param1:String) : Boolean
      {
         var _loc2_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc2_)
         {
            return false;
         }
         return JSONUtil.getInt(_loc2_,["properties","equLevel","length"]) >= 1;
      }
      
      public static function getEquipmentMaxLevel(param1:String) : int
      {
         var _loc2_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc2_)
         {
            return 0;
         }
         return JSONUtil.getInt(_loc2_,["properties","equLevel","length"]);
      }
      
      public static function getEquipmentLevelUpExpAbs(param1:String, param2:int) : int
      {
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc3_)
         {
            return 0;
         }
         var _loc4_:Array = JSONUtil.getValue(_loc3_,"properties","equLevel") as Array;
         if(!_loc4_)
         {
            return 0;
         }
         if(param2 < 1 || param2 > _loc4_.length)
         {
            return 0;
         }
         return JSONUtil.getInt(_loc4_,[param2 - 1,"reqEquExp"]) - JSONUtil.getInt(_loc4_,[param2 - 2,"reqEquExp"]);
      }
      
      public static function getEquipmentLevelUpExtAttr(param1:String, param2:int) : Array
      {
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc3_)
         {
            return null;
         }
         return JSONUtil.getValue(_loc3_,"properties","equLevel",param2 - 1,"addAttr") as Array;
      }
      
      public static function getEquipmentLevelUpSkills(param1:String, param2:int) : Array
      {
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc3_)
         {
            return null;
         }
         return JSONUtil.getValue(_loc3_,"properties","equLevel",param2 - 1,"addSkills") as Array;
      }
      
      public static function sendRemoveEquip(param1:int, param2:int) : void
      {
         if(GameContext.localPlayer.isActiveOrPassiveRiding)
         {
            GameContext.localPlayer.ride(false);
            GameContext.localPlayer.obf_2_4683("");
         }
         var _loc3_:PlayerRemoveEquipmentRequest = new PlayerRemoveEquipmentRequest();
         _loc3_.equipmentKind = param1;
         _loc3_.toBagItemIndex = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendSwitchFashion(param1:Boolean) : void
      {
         var _loc2_:PlayerSwitchFashionRequest = new PlayerSwitchFashionRequest();
         _loc2_.isUseFashion = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendRepairEquip(param1:String, param2:Boolean) : void
      {
         var _loc3_:PlayerRepairEquipmentRequest = new PlayerRepairEquipmentRequest();
         _loc3_.equipmentId = param1;
         _loc3_.isPerfectRepair = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendViewRepair(param1:String) : void
      {
         var _loc2_:PlayerViewRepairInfoRequest = new PlayerViewRepairInfoRequest();
         _loc2_.equipmentId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerEquip.PLAYER_EQUIPMENT_CHECK_NOTIFY)
         {
            onPlayerEquipCheck(param1 as PlayerEquipmentCheckNotify);
         }
         else if(param1.code == CommandCodePlayerEquip.PLAYER_SWITCH_FASHION_NOTIFY)
         {
            onPlayerSwitchFashion(param1 as PlayerSwitchFashionNotify);
         }
         else if(param1.code == CommandCodePlayerEquip.PLAYER_VIEW_REPAIR_INFO_ANSWER)
         {
            obf_0_1_J_339(param1 as PlayerViewRepairInfoAnswer);
         }
         else if(param1.code == CommandCodePlayerEquip.PLAYER_REPAIR_EQUIPMENT_ANSWER)
         {
            obf_k_g_914(param1 as PlayerRepairEquipmentAnswer);
         }
         else if(param1.code == CommandCodePlayerEquip.PLAYER_EQUIP_DUR_CHECK_NOTIFY)
         {
            obf_j_S_1045(param1 as PlayerEquipDurCheckNotify);
         }
      }
      
      private static function onPlayerEquipCheck(param1:PlayerEquipmentCheckNotify) : void
      {
         var _loc2_:EquippedItemInfo = null;
         for each(_loc2_ in param1.changedEquipments)
         {
            equipHash[_loc2_.equipmentKind + ""] = _loc2_;
            if(obf_K_e_3075.playerFullInfoUI)
            {
               obf_K_e_3075.playerFullInfoUI.setEquip(_loc2_);
            }
            if(obf_K_e_3075.constellationUI)
            {
               obf_K_e_3075.constellationUI.setEquip(_loc2_);
            }
         }
         if(obf_K_e_3075.playerFullInfoUI)
         {
            obf_K_e_3075.playerFullInfoUI.obf_K_1_4353();
         }
         PlayerSkillManager.obf_y_m_873();
      }
      
      private static function onPlayerSwitchFashion(param1:PlayerSwitchFashionNotify) : void
      {
         if(obf_K_e_3075.playerFullInfoUI)
         {
            obf_K_e_3075.playerFullInfoUI.showFashion = param1.isUseFashion;
         }
      }
      
      private static function obf_0_1_J_339(param1:PlayerViewRepairInfoAnswer) : void
      {
         obf_K_e_3075.equipRepairUI.showRepairInfo(param1);
      }
      
      private static function obf_k_g_914(param1:PlayerRepairEquipmentAnswer) : void
      {
         obf_K_e_3075.closeUI(obf_K_e_3075.equipRepairUI);
         GameItemInfoManager.removeItemInfo(param1.equipmentId);
         obf_6_D_3816.print(DiversityManager.getString("EquipRepairUI",param1.isDone ? "prompt_EquipRepairCompleted" : "prompt_EquipRepairFailed"));
      }
      
      private static function obf_j_S_1045(param1:PlayerEquipDurCheckNotify) : void
      {
         obf_K_e_3075.equipLowDurUI.checkEquDur(param1);
         obf_g_N_2380 = param1.equipmentDurMap;
      }
   }
}

