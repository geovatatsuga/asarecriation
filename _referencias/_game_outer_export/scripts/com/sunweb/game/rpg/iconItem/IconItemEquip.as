package com.sunweb.game.rpg.iconItem
{
   import obf_R_R_2172.obf_1_Y_1502;
   import obf_x_O_4078.obf_1_t_884;
   import obf_x_O_4078.obf_A_V_935;
   import com.adobe.serialization.json.JSON;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.equ.EquipmentManager;
   import com.sunweb.game.rpg.gameItem.GameItemCDManager;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.gameItem.obf_Q_l_1536;
   import com.sunweb.game.rpg.gameItem.obf_t_v_4376;
   import com.sunweb.game.rpg.legend.LegendAttrKind;
   import com.sunweb.game.rpg.pet.PetFullInfo;
   import com.sunweb.game.rpg.playerBag.PlayerBagIndex;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_0_3_0_538;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.SkillConfig;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.rpg.skill.obf_M_F_3694;
   import com.sunweb.game.rpg.wingSpirit.obf_B_5_1274;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObject;
   
   public class IconItemEquip extends IconItem
   {
      
      public var kind:int;
      
      public var modelCode:String;
      
      public function IconItemEquip(param1:DisplayObject, param2:String, param3:String)
      {
         super(param1);
         itemCode = param2;
         itemId = param3;
         addType(GameItemType.EQUIPMENT);
      }
      
      public static function getNewIconItem(param1:String, param2:String) : IconItemEquip
      {
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc3_)
         {
            obf_x_0_1295.obf_r_w_3556("obf_____4735(" + param1 + ")obf___4949！");
            return null;
         }
         var _loc4_:IconItemEquip = new IconItemEquip(GameItemManager.getItemIcon(param1),param1,param2);
         _loc4_.kind = _loc3_.properties.kind;
         _loc4_.modelCode = _loc3_.properties.modelCode;
         _loc4_.itemName = _loc3_.name;
         _loc4_.iconMask = GameItemCDManager.getCDBitmap("_EquipItem");
         _loc4_.rankMask = GameItemRank.getRankIcon(_loc3_.rank);
         _loc4_.iconItemRank = _loc3_.rank;
         return _loc4_;
      }
      
      public static function showTip(param1:String, param2:String, param3:Array = null) : void
      {
         var _loc4_:Array = getEquipTips(param1,param2);
         if(!_loc4_ || _loc4_.length <= 0)
         {
            return;
         }
         var _loc5_:GameTipUI = _loc4_.shift() as GameTipUI;
         GameTipManager.showTip(_loc5_,null,_loc4_.concat(param3));
      }
      
      public static function getEquipTips(param1:String, param2:String, param3:String = "Items") : Array
      {
         var subTips:Array = null;
         var wingSpiritTips:Array = null;
         var itemInfo:GameItemFullInfo = null;
         var rankColor:String = null;
         var itemQuality:int = 0;
         var fusionAttr:Array = null;
         var extAttr:Array = null;
         var showSkillTip:Boolean = false;
         var divineAttr:Array = null;
         var _feedGodObj:Object = null;
         var petTypeStr:String = null;
         var petTypeList:Array = null;
         var thisPetType:String = null;
         var lv:String = null;
         var rs:String = null;
         var attrObj:Object = null;
         var attrValue:Number = NaN;
         var baseAttrAdd:int = 0;
         var baseAddSoul:int = 0;
         var baseAddKindGrow:int = 0;
         var baseAttrAddString:String = null;
         var fusionObj:Object = null;
         var refineFusionString:String = null;
         var extObj:Object = null;
         var extAttrAdd:int = 0;
         var extAttrAddString:String = null;
         var levelExtAttr:Array = null;
         var levelSkills:Array = null;
         var levelExtObj:Object = null;
         var equLvSkillObj:Object = null;
         var equLvSkillConfig:Object = null;
         var holeSprite:DisplayObject = null;
         var embedGroup:Array = null;
         var gemCode:String = null;
         var matchGroupId:String = null;
         var matchGroupConfig:Object = null;
         var groupAttr:Array = null;
         var groupAddSkills:Array = null;
         var groupAttrObj:Object = null;
         var gaddSkill:Object = null;
         var groupkillConfig:Object = null;
         var gemConfig:Object = null;
         var gemColor:String = null;
         var gemAttr:Object = null;
         var gemNameShowed:Boolean = false;
         var gemEnum:String = null;
         var skillCode:String = null;
         var skillConfig:Object = null;
         var i:int = 0;
         var legendGemConfig:Object = null;
         var legendAttrValue:int = 0;
         var divineObj:Object = null;
         var dSprite:DisplayObject = null;
         var key:* = undefined;
         var itemCode:String = param1;
         var itemId:String = param2;
         var tipName:String = param3;
         var tipWidth:int = 250;
         var tipUI:GameTipUI = new GameTipUI(tipName);
         var thisConfig:Object = GameItemManager.getItemConfig(itemCode);
         if(thisConfig)
         {
            itemInfo = GameItemInfoManager.getItemInfo(itemId);
            rankColor = GameItemRank.getRankColor(thisConfig.rank).toString(16);
            GameItemManager.obf_4_G_4299(EquipmentManager.getItemFullName(itemCode,itemInfo),thisConfig.rank,tipUI,tipWidth);
            if(Boolean(itemInfo) && Boolean(!itemInfo.isEmpty) && itemInfo.equipmentInfo.refineLevel > 0)
            {
               tipUI.addTipObject(obf_1_t_884.getRefineLevelDisplay(itemInfo.equipmentInfo.refineLevel),tipUI.maxRow);
            }
            if(Boolean(itemInfo) && Boolean(!itemInfo.isEmpty) && itemInfo.equipmentInfo.addSoulLevel > 0)
            {
               tipUI.addTipObject(obf_1_t_884.getSoulLevelDisplay(itemInfo.equipmentInfo.addSoulLevel),tipUI.maxRow);
            }
            GameItemManager.obf_o_l_1634(thisConfig,tipUI,tipWidth,itemInfo);
            if(JSONUtil.getInt(thisConfig,["properties","petLevel"]) > 0)
            {
               tipUI.addTipInfo(DiversityManager.getString("EquipmentAttribute","petLevel_Label"),tipWidth,tipUI.maxRow + 1);
               tipUI.addTipInfo("<P align=\'right\'>" + DiversityManager.getString("EquipmentAttribute","petLevel_Value",[thisConfig.properties.petLevel]) + "</P>",tipWidth,tipUI.maxRow);
            }
            if(JSONUtil.getValue(thisConfig,"properties","petType","length") > 0)
            {
               tipUI.addTipInfo(DiversityManager.getString("EquipmentAttribute","petType"),tipWidth,tipUI.maxRow + 1);
               petTypeStr = "";
               petTypeList = JSONUtil.getObject(thisConfig,["properties","petType"],[]) as Array;
               for each(thisPetType in petTypeList)
               {
                  if(!obf_L_l_4100.isEmpty(petTypeStr))
                  {
                     petTypeStr += ",";
                  }
                  petTypeStr += GameItemManager.getItemName(thisPetType);
               }
               tipUI.addTipInfo("<P align=\'right\'>" + petTypeStr + "</P>",tipWidth,tipUI.maxRow);
            }
            itemQuality = 0;
            if(Boolean(itemInfo) && !itemInfo.isEmpty)
            {
               tipUI.addTipInfo(DiversityManager.getString("ItemPrompt","itemQuality"),tipWidth,tipUI.maxRow + 1);
               if(itemInfo.equipmentInfo.isRandomQuality)
               {
                  itemQuality = itemInfo.equipmentInfo.quality;
                  tipUI.addTipInfo("<P align=\'right\'>" + obf_Q_l_1536.getItemQualityName(itemInfo.equipmentInfo.quality) + "</P>",tipWidth,tipUI.maxRow);
               }
               else
               {
                  itemQuality = JSONUtil.getInt(thisConfig,["properties","quality"]);
               }
               tipUI.addTipInfo("<P align=\'right\'>" + obf_Q_l_1536.getItemQualityName(itemQuality) + "</P>",tipWidth,tipUI.maxRow);
               tipUI.addTipInfo(DiversityManager.getString("ItemPrompt","itemDurability"),tipWidth,tipUI.maxRow + 1);
               if(JSONUtil.getBoolean(thisConfig,["isEternal"]))
               {
                  tipUI.addTipInfo("<P align=\'right\'>" + DiversityManager.getString("ItemPrompt","itemIsEternal") + "</P>",tipWidth,tipUI.maxRow);
               }
               else
               {
                  tipUI.addTipInfo("<P align=\'right\'><font color=\'#" + (itemInfo.equipmentInfo.durabilityCurrent <= 0 ? "FF0000" : "FFFFFF") + "\'>" + itemInfo.equipmentInfo.durabilityCurrent + " / " + itemInfo.equipmentInfo.durabilityMax + "</font></P>",tipWidth,tipUI.maxRow);
               }
               if(itemInfo.equipmentInfo.isBinded || JSONUtil.getBoolean(thisConfig,["properties","willBindAfterUse"]))
               {
                  tipUI.addTipInfo(DiversityManager.getString("ItemPrompt",itemInfo.equipmentInfo.isBinded ? "itemIsBinded" : "itemNotBinded"),tipWidth,tipUI.maxRow + 1);
               }
            }
            tipUI.addTipInfo("　",tipWidth,tipUI.maxRow + 1);
            if(Boolean(itemInfo) && Boolean(!itemInfo.isEmpty) && itemInfo.equipmentInfo.kindGrowLevel > 0)
            {
               lv = itemInfo.equipmentInfo.kindGrowLevel + "";
               rs = Math.round(itemInfo.equipmentInfo.kindGrowRate * 100) + "%";
               tipUI.addTipInfo(DiversityManager.getString("ItemPrompt","itemKindGrowLv",[lv]),tipWidth,tipUI.maxRow + 1);
               tipUI.addTipInfo(DiversityManager.getString("ItemPrompt","itemKindGrow",[rs]),tipWidth,tipUI.maxRow);
            }
            if(Boolean(thisConfig.properties.baseAttr) && thisConfig.properties.baseAttr.length > 0)
            {
               for each(attrObj in thisConfig.properties.baseAttr)
               {
                  attrValue = GameItemManager.getItemQualityValue(attrObj.value,itemQuality);
                  baseAttrAdd = EquipmentManager.getEquipmentAttrValue(attrValue,itemInfo);
                  baseAddSoul = 0;
                  if(Boolean(itemInfo) && Boolean(!itemInfo.isEmpty) && itemInfo.equipmentInfo.addSoulLevel > 0)
                  {
                     baseAddSoul = Math.round(itemInfo.equipmentInfo.addSoulLevel * obf_1_t_884.getSoulAttr() * attrValue);
                  }
                  baseAddKindGrow = 0;
                  if(Boolean(itemInfo) && Boolean(!itemInfo.isEmpty) && itemInfo.equipmentInfo.kindGrowLevel > 0)
                  {
                     baseAddKindGrow = Math.round(attrValue * itemInfo.equipmentInfo.kindGrowRate);
                  }
                  baseAttrAddString = "";
                  if(baseAttrAdd > 0)
                  {
                     baseAttrAddString = "<font color=\'#00FF00\'>(+" + baseAttrAdd + ")</font>";
                  }
                  if(baseAddSoul > 0)
                  {
                     baseAttrAddString += "<font color=\'#FF0FF3\'>(+" + baseAddSoul + ")</font>";
                  }
                  if(baseAddKindGrow > 0)
                  {
                     baseAttrAddString += "<font color=\'#FF20FF\'>(" + baseAddKindGrow + ")</font>";
                  }
                  tipUI.addTipInfo(RoleAttributesModifierEnum.getAttributesName(attrObj.attr),tipWidth,tipUI.maxRow + 1);
                  tipUI.addTipInfo("<P align=\'right\'>" + RoleAttributesModifierEnum.getAttributesValueString(attrObj.attr,attrValue) + baseAttrAddString + "</P>",tipWidth,tipUI.maxRow);
               }
            }
            if(Boolean(itemInfo) && Boolean(!itemInfo.isEmpty) && !obf_L_l_4100.isEmpty(itemInfo.equipmentInfo.fusionAttributes))
            {
               fusionAttr = com.adobe.serialization.json.JSON.decode(itemInfo.equipmentInfo.fusionAttributes) as Array;
               for each(fusionObj in fusionAttr)
               {
                  refineFusionString = "";
                  if(JSONUtil.getInt(itemInfo,["equipmentInfo","refineLevel"]) > 0)
                  {
                     refineFusionString = "<font color=\'#00FF00\'>(+" + Math.round(obf_1_t_884.getValueRefine(fusionObj.value,itemInfo.equipmentInfo.refineLevel)) + ")</font>";
                  }
                  tipUI.addTipInfo("<FONT color=\'#FFAE40\'>" + RoleAttributesModifierEnum.getAttributesName(fusionObj.attr) + "</FONT>",tipWidth,tipUI.maxRow + 1);
                  tipUI.addTipInfo("<P align=\'right\'><FONT color=\'#FFAE40\'>" + RoleAttributesModifierEnum.getAttributesValueString(fusionObj.attr,fusionObj.value) + refineFusionString + "</FONT></P>",tipWidth,tipUI.maxRow);
               }
            }
            if(Boolean(itemInfo) && Boolean(!itemInfo.isEmpty) && itemInfo.equipmentInfo.isRandomExtAttr)
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
               extAttr = JSONUtil.getObject(thisConfig,["properties","extAttr"]) as Array;
            }
            if(Boolean(extAttr) && extAttr.length > 0)
            {
               for each(extObj in extAttr)
               {
                  extAttrAdd = EquipmentManager.getEquipmentAttrValue(extObj.value,itemInfo,true);
                  extAttrAddString = "";
                  if(extAttrAdd > 0)
                  {
                     extAttrAddString = "<font color=\'#00FF00\'>(+" + extAttrAdd + ")</font>";
                  }
                  tipUI.addTipInfo("<FONT color=\'#00FF00\'>" + RoleAttributesModifierEnum.getAttributesName(extObj.attr) + "</FONT>",tipWidth,tipUI.maxRow + 1);
                  tipUI.addTipInfo("<P align=\'right\'><FONT color=\'#00FF00\'>" + RoleAttributesModifierEnum.getAttributesValueString(extObj.attr,extObj.value) + extAttrAddString + "</FONT></P>",tipWidth,tipUI.maxRow);
               }
            }
            if(Boolean(itemInfo) && Boolean(itemInfo.equipmentInfo) && !itemInfo.isEmpty)
            {
               levelExtAttr = EquipmentManager.getEquipmentLevelUpExtAttr(itemCode,itemInfo.equipmentInfo.equLevel);
               levelSkills = EquipmentManager.getEquipmentLevelUpSkills(itemCode,itemInfo.equipmentInfo.equLevel);
               if(Boolean(levelExtAttr) && Boolean(levelExtAttr.length > 0) || Boolean(levelSkills) && Boolean(levelSkills.length > 0))
               {
                  tipUI.addTipInfo("<FONT color=\'#00FF00\'>" + DiversityManager.getString("EquipmentAttribute","itemLevelAttribute",[itemInfo.equipmentInfo.equLevel]) + "</FONT>",tipWidth,tipUI.maxRow + 1);
               }
               if(Boolean(levelExtAttr) && levelExtAttr.length > 0)
               {
                  for each(levelExtObj in levelExtAttr)
                  {
                     tipUI.addTipInfo("<FONT color=\'#00FF00\'>" + RoleAttributesModifierEnum.getAttributesName(levelExtObj.attr) + "</FONT>",tipWidth,tipUI.maxRow + 1);
                     tipUI.addTipInfo("<P align=\'right\'><FONT color=\'#00FF00\'>" + RoleAttributesModifierEnum.getAttributesValueString(levelExtObj.attr,levelExtObj.value) + "</FONT></P>",tipWidth,tipUI.maxRow);
                  }
               }
               if(Boolean(levelSkills) && levelSkills.length > 0)
               {
                  tipUI.addTipInfo("<FONT color=\'#00FF00\'>" + DiversityManager.getString("EquipmentAttribute","itemGiveSkill") + "</FONT>",tipWidth,tipUI.maxRow + 1);
                  for each(equLvSkillObj in levelSkills)
                  {
                     equLvSkillConfig = SkillConfig.getSkillConfig(equLvSkillObj.skillCode);
                     if(equLvSkillConfig)
                     {
                        tipUI.addTipInfo("<FONT color=\'#00FF00\'>" + equLvSkillConfig.name + (equLvSkillConfig.type == obf_M_F_3694.obf_u_8_4559 ? "(" + DiversityManager.getString("PlayerSkillPrompt","passiveSkill") + ")" : "") + ": " + equLvSkillConfig.levelInfo[0].detail + "</FONT>",tipWidth,tipUI.maxRow + 1);
                     }
                  }
               }
            }
            if(Boolean(GameItemManager.itemCanHole(itemCode) && itemInfo) && Boolean(!itemInfo.isEmpty) && itemInfo.equipmentInfo.holeNumber > 0)
            {
               tipUI.addTipInfo("<P align=\'center\'><FONT color=\'#" + rankColor + "\'>" + DiversityManager.getString("EquipmentAttribute","itemEmbed") + "</FONT></P>",tipWidth,tipUI.maxRow + 1);
               tipUI.addTipInfo(DiversityManager.getString("EmbedPrompt","embedGemLevel"),tipWidth,tipUI.maxRow + 1);
               tipUI.addTipInfo("<P align=\'right\'>" + JSONUtil.getInt(thisConfig,["properties","embedGemLevel"]) + "</P>",tipWidth,tipUI.maxRow);
               tipUI.addTipInfo(DiversityManager.getString("EmbedPrompt","equipHoleCount"),tipWidth,tipUI.maxRow + 1);
               holeSprite = obf_A_V_935.getHolesDisplay(itemInfo.equipmentInfo.holeNumber,itemInfo.equipmentInfo.embedGemCodeList.length);
               holeSprite.x = tipWidth - holeSprite.width;
               tipUI.addTipObject(holeSprite,tipUI.maxRow - 1);
               embedGroup = JSONUtil.getObject(thisConfig,["properties","embedGroup"]) as Array;
               if(Boolean(embedGroup) && embedGroup.length > 0)
               {
                  matchGroupId = obf_A_V_935.getMatchGroupPlan(embedGroup,itemInfo.equipmentInfo.embedGemCodeList);
                  if(!obf_L_l_4100.isEmpty(matchGroupId))
                  {
                     matchGroupConfig = obf_A_V_935.getEmbedGroupPlan(matchGroupId);
                     tipUI.addTipInfo("<font color=\'#" + obf_0_3_0_538.obf_3_l_1790.toString(16) + "\'>" + DiversityManager.getString("EmbedPrompt","embedGroup",[JSONUtil.getStr(matchGroupConfig,["groupName"])]) + "</font>",tipWidth,tipUI.maxRow + 1);
                     groupAttr = JSONUtil.getObject(matchGroupConfig,["addAttr"]) as Array;
                     if(Boolean(groupAttr) && groupAttr.length > 0)
                     {
                        for each(groupAttrObj in groupAttr)
                        {
                           tipUI.addTipInfo("<FONT color=\'#" + obf_0_3_0_538.obf_3_l_1790.toString(16) + "\'>" + RoleAttributesModifierEnum.getAttributesName(groupAttrObj.attr) + "</FONT>",tipWidth,tipUI.maxRow + 1);
                           tipUI.addTipInfo("<P align=\'right\'><FONT color=\'#" + obf_0_3_0_538.obf_3_l_1790.toString(16) + "\'>" + RoleAttributesModifierEnum.getAttributesValueString(groupAttrObj.attr,groupAttrObj.value) + "</FONT></P>",tipWidth,tipUI.maxRow);
                        }
                     }
                     groupAddSkills = JSONUtil.getObject(matchGroupConfig,["addSkills"]) as Array;
                     if(groupAddSkills)
                     {
                        for each(gaddSkill in groupAddSkills)
                        {
                           groupkillConfig = SkillConfig.getSkillConfig(gaddSkill.skillCode);
                           if(groupkillConfig)
                           {
                              tipUI.addTipInfo("<FONT color=\'#" + obf_0_3_0_538.obf_3_l_1790.toString(16) + "\'>" + groupkillConfig.name + (groupkillConfig.type == obf_M_F_3694.obf_u_8_4559 ? "(" + DiversityManager.getString("PlayerSkillPrompt","passiveSkill") + ")" : "") + ": " + JSONUtil.getStr(groupkillConfig.levelInfo,[gaddSkill.skillLevel - 1,"detail"]) + "</FONT>",tipWidth,tipUI.maxRow + 1);
                           }
                        }
                     }
                  }
               }
               for each(gemCode in itemInfo.equipmentInfo.embedGemCodeList)
               {
                  gemConfig = GameItemManager.getItemConfig(gemCode);
                  if(gemConfig)
                  {
                     gemColor = GameItemRank.getRankColor(gemConfig.rank).toString(16);
                     gemAttr = JSONUtil.getObject(gemConfig,["properties","gemAttr"]);
                     gemNameShowed = false;
                     for(gemEnum in gemAttr)
                     {
                        tipUI.addTipInfo("<font color=\'#" + gemColor + "\'>" + (!gemNameShowed ? gemConfig.name : " ") + "</font>",tipWidth,tipUI.maxRow + 1);
                        tipUI.addTipInfo("<p align=\'right\'><font color=\'#" + gemColor + "\'>" + RoleAttributesModifierEnum.getAttributesName(int(gemEnum)) + " " + RoleAttributesModifierEnum.getAttributesValueString(int(gemEnum),gemAttr[gemEnum]) + "</font></p>",tipWidth,tipUI.maxRow);
                        gemNameShowed = true;
                     }
                  }
               }
            }
            showSkillTip = true;
            if(Boolean(thisConfig.properties.bindingSkills) && thisConfig.properties.bindingSkills.length > 0)
            {
               for each(skillCode in thisConfig.properties.bindingSkills)
               {
                  skillConfig = SkillConfig.getSkillConfig(skillCode);
                  if(!(!skillConfig || obf_L_l_4100.isEmpty(skillConfig.levelInfo[0].detail)))
                  {
                     if(showSkillTip)
                     {
                        tipUI.addTipInfo("<FONT color=\'#00FF00\'>" + DiversityManager.getString("EquipmentAttribute","itemGiveSkill") + "</FONT>",tipWidth,tipUI.maxRow + 2);
                        showSkillTip = false;
                     }
                     tipUI.addTipInfo("<FONT color=\'#00FF00\'>" + skillConfig.name + (skillConfig.type == obf_M_F_3694.obf_u_8_4559 ? "(" + DiversityManager.getString("PlayerSkillPrompt","passiveSkill") + ")" : "") + ": " + skillConfig.levelInfo[0].detail + "</FONT>",tipWidth,tipUI.maxRow + 1);
                  }
               }
            }
            if(Boolean(itemInfo && itemInfo.equipmentInfo) && Boolean(!itemInfo.isEmpty) && itemInfo.equipmentInfo.legendHole > 0)
            {
               tipUI.addTipInfo("<P align=\'center\'><FONT color=\'#" + rankColor + "\'>" + DiversityManager.getString("EquipmentAttribute","legendItemEmbed") + "</FONT></P>",tipWidth,tipUI.maxRow + 1);
               i = 1;
               while(i <= itemInfo.equipmentInfo.legendHole)
               {
                  if(itemInfo.equipmentInfo.legends[i])
                  {
                     legendGemConfig = GameItemManager.getItemConfig(itemInfo.equipmentInfo.legends[i]);
                     if(legendGemConfig)
                     {
                        gemColor = GameItemRank.getRankColor(legendGemConfig.rank).toString(16);
                        tipUI.addTipObject(obf_K_e_3075.legendUI.getGemLevelDisplay(JSONUtil.getInt(legendGemConfig,["properties","attrType"]),JSONUtil.getInt(legendGemConfig,["itemLevel"])),tipUI.maxRow);
                        legendAttrValue = JSONUtil.getInt(legendGemConfig,["properties","attrValue"]);
                        tipUI.addTipInfo("<p align=\'right\'><font color=\'#" + gemColor + "\'>" + LegendAttrKind.getViewKindString(JSONUtil.getInt(legendGemConfig,["properties","attrType"])) + " +" + legendAttrValue + "</font></p>",tipWidth,tipUI.maxRow);
                     }
                  }
                  else
                  {
                     tipUI.addTipObject(obf_K_e_3075.legendUI.getGemLevelDisplay(),tipUI.maxRow);
                     tipUI.addTipInfo("<p align=\'right\'><font color=\'#" + gemColor + "\'>" + DiversityManager.getString("LegendUI","noGem") + "</font></p>",tipWidth,tipUI.maxRow);
                  }
                  i++;
               }
            }
            if(Boolean(itemInfo) && Boolean(!itemInfo.isEmpty) && !obf_L_l_4100.isEmpty(itemInfo.equipmentInfo.divineAttr))
            {
               divineAttr = com.adobe.serialization.json.JSON.decode(itemInfo.equipmentInfo.divineAttr) as Array;
               for each(divineObj in divineAttr)
               {
                  dSprite = obf_1_Y_1502.getIconDisplay();
                  dSprite.x = tipWidth / 2;
                  tipUI.addTipObject(dSprite,tipUI.maxRow);
                  tipUI.addTipInfo("<FONT color=\'#FF00FF\'>" + RoleAttributesModifierEnum.getAttributesName(divineObj.attr) + "</FONT>",tipWidth + 20,tipUI.maxRow);
                  tipUI.addTipInfo("<P align=\'right\'><FONT color=\'#FF00FF\'>" + RoleAttributesModifierEnum.getAttributesValueString(divineObj.attr,divineObj.value) + "</FONT></P>",tipWidth,tipUI.maxRow);
               }
            }
            if(Boolean(itemInfo) && Boolean(!itemInfo.isEmpty) && !obf_L_l_4100.isEmpty(itemInfo.equipmentInfo.feedGodAttr))
            {
               _feedGodObj = com.adobe.serialization.json.JSON.decode(itemInfo.equipmentInfo.feedGodAttr);
               tipUI.addTipInfo("<P align=\'center\'><FONT color=\'#FF0000\'>" + DiversityManager.getString("EquipmentAttribute","feedGodAttr") + "</FONT></P>",tipWidth,tipUI.maxRow + 1);
               for(key in _feedGodObj)
               {
                  tipUI.addTipInfo("<FONT color=\'#FFFF99\'>" + RoleAttributesModifierEnum.getAttributesName(int(key)) + "</FONT>",tipWidth + 20,tipUI.maxRow + 1);
                  tipUI.addTipInfo("<P align=\'right\'><FONT color=\'#FFFF99\'>" + RoleAttributesModifierEnum.getAttributesValueString(int(key),_feedGodObj[key]) + "</FONT></P>",tipWidth,tipUI.maxRow);
               }
            }
            if(Boolean(thisConfig.remark) && thisConfig.remark != "")
            {
               tipUI.addTipInfo(thisConfig.remark,tipWidth,tipUI.maxRow + 1);
            }
            GameItemManager.obf_7_0_2420(thisConfig,tipUI,tipWidth,itemInfo);
            GameItemManager.obf_J_l_4537(thisConfig,tipUI,tipWidth);
            GameItemManager.setItemTipValidTime(itemCode,itemId,tipUI,tipWidth);
            if(!obf_L_l_4100.isEmpty(JSONUtil.getStr(thisConfig,["properties","suitCode"])))
            {
               subTips = [obf_t_v_4376.getSuitTipUI(JSONUtil.getStr(thisConfig,["properties","suitCode"]))];
            }
            if(Boolean(itemInfo) && Boolean(!itemInfo.isEmpty) && Boolean(itemInfo.equipmentInfo.wingSpiritMap))
            {
               wingSpiritTips = [obf_B_5_1274.getWingSpiritTipUI(itemInfo.equipmentInfo.wingSpiritMap,itemInfo.equipmentInfo.wingSpiritSkills)];
            }
         }
         else
         {
            tipUI.addTipInfo(GameItemManager.getItemTipText(itemCode,thisConfig.rank),240,0);
         }
         return [tipUI].concat(subTips,wingSpiritTips);
      }
      
      public static function showResultAttr(param1:Object, param2:GameTipUI, param3:int) : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc4_:Array = new Array();
         for(_loc5_ in param1)
         {
            _loc4_.push(_loc5_);
         }
         _loc4_.sort();
         for each(_loc6_ in _loc4_)
         {
            param2.addTipInfo(RoleAttributesModifierEnum.getAttributesName(int(_loc6_)),param3,param2.maxRow + 1);
            param2.addTipInfo("<P align=\'right\'><font color=\'#00FF00\'>" + RoleAttributesModifierEnum.getAttributesValueString(int(_loc6_),param1[_loc6_]) + "</font></P>",param3,param2.maxRow);
         }
      }
      
      override public function useIcon(param1:* = null) : Boolean
      {
         var _loc2_:GameItemFullInfo = null;
         var _loc3_:Object = null;
         var _loc4_:PetFullInfo = null;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         if(Boolean(this.parent) && this.parent is IconItemBag)
         {
            if(Boolean(GameContext.localPlayer) && GameContext.localPlayer.isActiveOrPassiveRiding)
            {
               GameContext.localPlayer.ride(false);
               GameContext.localPlayer.obf_2_4683("");
            }
            _loc2_ = GameItemInfoManager.getItemInfo(itemId);
            if(Boolean(_loc2_) && Boolean(GameItemManager.haveValidTime(itemCode)) && _loc2_.expiredTimeLeftInHour <= 0)
            {
               obf_K_e_3075.obf_t_q_3040.showRenewPlan(itemCode,itemId);
               WindowManager.showMessageBox(DiversityManager.getString("ItemPrompt","useItemError_ItemExpired"));
            }
            _loc3_ = GameItemManager.getItemConfig(itemCode);
            if(!_loc3_)
            {
               return false;
            }
            if(JSONUtil.getInt(_loc3_,["properties","petLevel"]) > 0 || JSONUtil.getInt(_loc3_,["properties","petType","length"]) > 0)
            {
               _loc4_ = param1 as PetFullInfo;
               if(!_loc4_)
               {
                  if(!GameContext.localPlayer.petFullInfo)
                  {
                     obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_PetEquipment"));
                     return false;
                  }
                  _loc4_ = GameContext.localPlayer.petFullInfo;
               }
               _loc5_ = JSONUtil.getInt(_loc3_,["properties","petLevel"]);
               _loc6_ = JSONUtil.getObject(_loc3_,["properties","petType"]) as Array;
               if(_loc4_.level < _loc5_)
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_PetLevel",[_loc5_]));
                  return false;
               }
               if(Boolean(_loc6_) && _loc6_.indexOf(_loc4_.petCode) <= -1)
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_PetType"));
                  return false;
               }
               param1 = {"petId":_loc4_.petId};
            }
            return GameContext.bagItemManager.sendUseItem(itemCode,PlayerBagIndex.PLAYER_MAIN_BAG,IconItemBag(this.parent).itemIndex,null,null,param1);
         }
         return false;
      }
      
      private function confirmUseBindEquip(param1:Object) : void
      {
         if(param1.confirm)
         {
            GameContext.bagItemManager.sendUseItem.apply(null,param1.par);
         }
      }
      
      override public function clone() : IconItem
      {
         return getNewIconItem(itemCode,itemId);
      }
   }
}

