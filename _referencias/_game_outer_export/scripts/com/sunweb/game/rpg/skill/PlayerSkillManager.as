package com.sunweb.game.rpg.skill
{
   import obf_E_p_2386.obf_S_Q_3707;
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemSkill;
   import com.sunweb.game.rpg.map.MapInteractiveObject;
   import com.sunweb.game.rpg.netRole.obf_T_L_801;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.SkillConfig;
   import com.sunweb.game.rpg.role.obf_0_9_V_473;
   import com.sunweb.game.rpg.role.obf_d_j_2550;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   import com.sunweb.game.rpg.worldZone.command.player.PlayerLearnSkillRequest;
   import com.sunweb.game.rpg.worldZone.command.player.PlayerLearnedSkillNotify;
   import com.sunweb.game.rpg.worldZone.command.player.PlayerLearnedSkillsCheckNotify;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import fl.data.DataProvider;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import img.autoSkillBD;
   
   public class PlayerSkillManager
   {
      
      private static var _skillBook:Object;
      
      private static var jobSkill:Object;
      
      private static var fateSkill:Object;
      
      private static var familySkill:Object;
      
      private static var blessSkill:Object;
      
      private static var bookSkill:Object;
      
      private static var devilGodeSkill:Object;
      
      public static var obf_y_V_1989:Object;
      
      private static var obf_w_3_4437:Boolean;
      
      private static var autoUseSkills:Array;
      
      private static var _defaultAttackSkillObj:Object;
      
      private static var skillEffectLoaded:Boolean;
      
      public static const obf_c_c_4538:int = 0;
      
      public static const obf_6_5_3904:int = 1;
      
      public static const obf_9_e_2183:int = 2;
      
      public static const obf_0_6_5_187:int = 3;
      
      public static const obf_0_6_Q_702:int = 4;
      
      public static const obf_n_4681:int = 5;
      
      public static const obf_0_9_S_645:int = 10;
      
      private static var equipKindSkills:Object = new Object();
      
      private static var disableAutoUseSkills:Array = new Array();
      
      private static var autoSkillBitmapDataMap:Object = new Object();
      
      private static var _defaultAttackSkillCode:String = "";
      
      private static var haveSkills:Object = new Object();
      
      private static var commonSkill:Array = new Array();
      
      public function PlayerSkillManager()
      {
         super();
      }
      
      public static function initSkillBook(param1:Object) : void
      {
         _skillBook = param1;
      }
      
      public static function getSkillBookPage(param1:*) : Object
      {
         return JSONUtil.getObject(_skillBook,[param1]);
      }
      
      public static function getJobSkillTree(param1:int) : Array
      {
         return JSONUtil.getObject(_skillBook,["treePage",param1]) as Array;
      }
      
      public static function setFamilySkill(param1:Object) : void
      {
         familySkill = param1;
         obf_y_m_873();
      }
      
      public static function setEquipmentSkill(param1:int, param2:Array) : void
      {
         equipKindSkills[param1] = param2;
         obf_y_m_873();
      }
      
      public static function setDevilGodSkill(param1:Object) : void
      {
         devilGodeSkill = param1;
         obf_y_m_873();
      }
      
      public static function getTotalSkillPoint() : int
      {
         if(!GameContext.localPlayer || !GameContext.localPlayer.fullInfo)
         {
            return 0;
         }
         var _loc1_:int = obf_S_Q_3707.getRebornSkillPoint(GameContext.localPlayer.fullInfo.rebornTimes);
         return Math.max(0,GameContext.localPlayer.level / 2 + _loc1_);
      }
      
      public static function getUsedSkillPoint() : int
      {
         var _loc2_:String = null;
         var _loc1_:int = 0;
         for(_loc2_ in jobSkill)
         {
            _loc1_ += getSkillCostPoint(_loc2_,jobSkill[_loc2_]);
         }
         return _loc1_;
      }
      
      public static function getOverSkillPoint() : int
      {
         return getTotalSkillPoint() - getUsedSkillPoint();
      }
      
      public static function getSkillCostPoint(param1:String, param2:int) : int
      {
         var _loc3_:Object = SkillConfig.getSkillConfig(param1);
         var _loc4_:Array = JSONUtil.getObject(_loc3_,["levelInfo"]) as Array;
         if(!_loc4_)
         {
            return 0;
         }
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         while(_loc6_ < param2)
         {
            if(_loc6_ >= _loc4_.length)
            {
               break;
            }
            _loc5_++;
            _loc6_++;
         }
         return _loc5_;
      }
      
      public static function getPetUpSkillCondition(param1:String, param2:int) : Object
      {
         var _loc3_:Object = SkillConfig.getSkillConfig(param1);
         var _loc4_:Array = JSONUtil.getObject(_loc3_,["levelInfo"]) as Array;
         if(!_loc4_)
         {
            return null;
         }
         param2--;
         param2 = int(Math.min(Math.max(param2,0),_loc4_.length - 1));
         return JSONUtil.getObject(_loc4_[param2],["learnRule","petCondition"]);
      }
      
      public static function getUpSkillCondition(param1:String, param2:int) : Object
      {
         var _loc3_:Object = SkillConfig.getSkillConfig(param1);
         var _loc4_:Array = JSONUtil.getObject(_loc3_,["levelInfo"]) as Array;
         if(!_loc4_)
         {
            return null;
         }
         param2--;
         param2 = int(Math.min(Math.max(param2,0),_loc4_.length - 1));
         return JSONUtil.getObject(_loc4_[param2],["learnRule","condition"]);
      }
      
      public static function getLearnSkillConditionString(param1:Object) : String
      {
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:Object = null;
         var _loc2_:String = "";
         for(_loc3_ in param1)
         {
            if(!obf_L_l_4100.isEmpty(_loc2_))
            {
               _loc2_ += "\n";
            }
            _loc4_ = param1[_loc3_];
            _loc5_ = "FFFFFF";
            if(_loc3_ == "roleLevel>=")
            {
               if(GameContext.localPlayer.fullInfo.level >= _loc4_)
               {
                  _loc5_ = "00FF00";
               }
               else
               {
                  _loc5_ = "FF0000";
               }
               _loc2_ += "<font color=\'#" + _loc5_ + "\'>" + DiversityManager.getString("PlayerSkillPrompt","learnCondition_RoleLevel",[_loc4_]) + "</font>";
            }
            else if(_loc3_ == "hasAnySkillLevel" || _loc3_ == "hasAllSkillLevel")
            {
               _loc6_ = DiversityManager.getString("PlayerSkillPrompt","learnCondition_SkillLevel");
               for(_loc7_ in _loc4_)
               {
                  _loc8_ = SkillConfig.getSkillConfig(_loc7_);
                  if(_loc8_)
                  {
                     if(getSkillLevel(_loc7_) >= _loc4_[_loc7_])
                     {
                        _loc5_ = "00FF00";
                     }
                     else
                     {
                        _loc5_ = "FF0000";
                     }
                     _loc6_ += "\n<font color=\'#" + _loc5_ + "\'>" + JSONUtil.getStr(_loc8_,["name"]) + " Lv." + _loc4_[_loc7_] + "</font>";
                  }
               }
               _loc2_ += _loc6_;
            }
         }
         return _loc2_;
      }
      
      public static function sendLearnSkill(param1:String, param2:int) : void
      {
         var _loc3_:PlayerLearnSkillRequest = new PlayerLearnSkillRequest();
         _loc3_.skillCode = param1;
         _loc3_.skillKind = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayer.PLAYER_LEARNED_SKILLS_CHECK_NOTIFY)
         {
            obf_0_2_O_621(param1 as PlayerLearnedSkillsCheckNotify);
         }
         else if(param1.code == CommandCodePlayer.PLAYER_LEARNED_SKILL_NOTIFY)
         {
            obf_C_l_2360(param1 as PlayerLearnedSkillNotify);
         }
      }
      
      private static function obf_0_2_O_621(param1:PlayerLearnedSkillsCheckNotify) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         if(param1.skillKind == obf_c_c_4538)
         {
            jobSkill = param1.learnedSkills;
         }
         else if(param1.skillKind == obf_6_5_3904)
         {
            familySkill = param1.learnedSkills;
         }
         else if(param1.skillKind == obf_0_6_5_187)
         {
            fateSkill = param1.learnedSkills;
         }
         else if(param1.skillKind == obf_0_6_Q_702)
         {
            blessSkill = param1.learnedSkills;
         }
         else if(param1.skillKind == obf_n_4681)
         {
            bookSkill = param1.learnedSkills;
         }
         skillEffectLoaded = false;
         obf_y_m_873();
         if(obf_K_e_3075.obf_f_a_l_s_e_334)
         {
            obf_K_e_3075.obf_f_a_l_s_e_334.obf_n_E_2173();
         }
         obf_K_e_3075.fateSkillUI.obf_3_4_1172();
         obf_K_e_3075.familyBoxUI.obf_u_H_2162();
         obf_G_D_4059();
         if(param1.skillKind == obf_0_6_Q_702)
         {
            obf_K_e_3075.playerBlessUI.obf_H_P_2879();
         }
         obf_8_x_2510();
      }
      
      private static function obf_8_x_2510() : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc1_:Array = new Array({
            "label":DiversityManager.getString("BotUI","null"),
            "code":""
         });
         var _loc2_:Array = new Array();
         var _loc3_:Boolean = true;
         for(_loc4_ in jobSkill)
         {
            _loc3_ = false;
            if(SkillManager.getIsCallSkill(_loc4_))
            {
               _loc2_.push(_loc4_);
            }
         }
         _loc2_.sort();
         for each(_loc5_ in _loc2_)
         {
            _loc1_.push({
               "label":SkillManager.getSkillName(_loc5_),
               "code":_loc5_
            });
         }
         if(_loc3_)
         {
            obf_K_e_3075.obf_f_a_l_s_e_334.sIndex = 0;
         }
         obf_K_e_3075.obf_f_a_l_s_e_334.listCallAnimalSkill.dataProvider = new DataProvider(_loc1_);
         obf_K_e_3075.obf_f_a_l_s_e_334.listCallAnimalSkill.selectedIndex = obf_K_e_3075.obf_f_a_l_s_e_334.sIndex;
         obf_K_e_3075.obf_f_a_l_s_e_334.saveConfig();
      }
      
      private static function obf_C_l_2360(param1:PlayerLearnedSkillNotify) : void
      {
         var _loc3_:IconItemSkill = null;
         var _loc4_:Array = null;
         var _loc5_:IconItemBag = null;
         var _loc6_:DisplayObject = null;
         var _loc7_:Point = null;
         var _loc8_:DisplayObject = null;
         var _loc9_:Point = null;
         var _loc2_:Object = SkillConfig.getSkillConfig(param1.skillCode);
         if(!_loc2_)
         {
            return;
         }
         obf_6_D_3816.print(DiversityManager.getString("SkillBookUI","promptLearnedSkill",[JSONUtil.getStr(_loc2_,["name"]) + ".Lv" + param1.skillLevel]));
         obf_j_M_1052();
         if(JSONUtil.getInt(_loc2_,["type"]) != obf_M_F_3694.obf_u_8_4559 && JSONUtil.getInt(_loc2_,["type"]) != obf_M_F_3694.obf_0_7_O_353)
         {
            if(param1.skillLevel == 1 && PlayerSkillManager.obf_0_6_G_255(param1.skillCode) && !obf_K_e_3075.shortcutUI.haveItemIcon(GameItemType.SKILL,param1.skillCode))
            {
               _loc3_ = IconItemSkill.getNewIconItem(param1.skillCode,param1.skillLevel);
               _loc4_ = obf_K_e_3075.shortcutUI.getIconItemBags();
               for each(_loc5_ in _loc4_)
               {
                  if(!_loc5_.haveIconItem)
                  {
                     _loc5_.pushIconItem(_loc3_);
                     _loc6_ = SkillManager.getSkillIcon(param1.skillCode);
                     if(_loc6_)
                     {
                        _loc7_ = new Point();
                        _loc8_ = obf_K_e_3075.skillBookUI.getSkillIconBag(param1.skillCode);
                        if(_loc8_)
                        {
                           _loc7_ = _loc8_.localToGlobal(new Point());
                        }
                        _loc6_.x = _loc7_.x;
                        _loc6_.y = _loc7_.y;
                        _loc9_ = _loc5_.localToGlobal(new Point());
                        obf_K_e_3075.showUITween(_loc6_,1,_loc9_.x,_loc9_.y);
                     }
                     break;
                  }
               }
               obf_K_e_3075.shortcutUI.saveConfig();
            }
         }
         if(obf_K_e_3075.obf_f_a_l_s_e_334)
         {
            obf_K_e_3075.obf_f_a_l_s_e_334.obf_n_E_2173();
         }
         obf_K_e_3075.fateSkillUI.obf_3_4_1172();
         obf_K_e_3075.playerBookUI.obf_0___f_619();
         obf_G_D_4059();
      }
      
      public static function set enableAutoSkill(param1:Boolean) : void
      {
         obf_w_3_4437 = param1;
         if(GameContext.userConfig)
         {
            GameContext.userConfig.dast = obf_w_3_4437;
            GameContext.saveConfig();
         }
      }
      
      public static function get enableAutoSkill() : Boolean
      {
         return obf_w_3_4437;
      }
      
      public static function applyAutoSkillUserConfig() : void
      {
         if(!GameContext.userConfig)
         {
            return;
         }
         setAutoSkills(GameContext.userConfig.dasl,false);
         if(obf_K_e_3075.skillBookUI)
         {
            obf_w_3_4437 = JSONUtil.getBoolean(GameContext.userConfig,["dast"],true);
            obf_K_e_3075.skillBookUI.chkAutoCastSkill.selected = obf_w_3_4437;
         }
      }
      
      public static function obf_G_D_4059() : void
      {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc1_:Array = new Array();
         for(_loc2_ in haveSkills)
         {
            _loc4_ = SkillConfig.getSkillConfig(_loc2_);
            if(_loc4_)
            {
               if(!(Boolean(disableAutoUseSkills) && disableAutoUseSkills.indexOf(_loc2_) > -1))
               {
                  if(skillCanAutoCast(_loc2_))
                  {
                     _loc1_.push({
                        "skillCode":_loc2_,
                        "skillCD":JSONUtil.getInt(_loc4_,["levelInfo",haveSkills[_loc2_] - 1,"castRule","coldTime"])
                     });
                  }
               }
            }
         }
         _loc1_.sortOn("skillCD",Array.NUMERIC | Array.DESCENDING);
         autoUseSkills = new Array();
         for each(_loc3_ in _loc1_)
         {
            autoUseSkills.push(_loc3_.skillCode);
         }
      }
      
      public static function setAutoSkills(param1:Array, param2:Boolean) : void
      {
         var _loc3_:String = null;
         for each(_loc3_ in param1)
         {
            if(skillCanAutoCast(_loc3_))
            {
               if(disableAutoUseSkills.indexOf(_loc3_) > -1)
               {
                  disableAutoUseSkills.splice(disableAutoUseSkills.indexOf(_loc3_),1);
               }
               if(!param2)
               {
                  disableAutoUseSkills.push(_loc3_);
               }
               setAutoSkillMaskDisplay(_loc3_,param2);
            }
         }
         GameContext.userConfig["dasl"] = disableAutoUseSkills;
         GameContext.saveConfig();
      }
      
      public static function skillCanAutoCast(param1:String) : Boolean
      {
         var _loc2_:Object = SkillConfig.getSkillConfig(param1);
         if(!_loc2_)
         {
            return false;
         }
         if(_loc2_.type == obf_M_F_3694.obf_u_8_4559)
         {
            return false;
         }
         return JSONUtil.getBoolean(_loc2_,["mayAutoCast"]);
      }
      
      public static function skillIsAuto(param1:String) : Boolean
      {
         if(!disableAutoUseSkills)
         {
            return true;
         }
         return disableAutoUseSkills.indexOf(param1) == -1;
      }
      
      public static function getAutoSkillMask(param1:String) : Bitmap
      {
         var _loc2_:Object = SkillConfig.getSkillConfig(param1);
         if(!skillCanAutoCast(param1))
         {
            return null;
         }
         if(!autoSkillBitmapDataMap[param1])
         {
            autoSkillBitmapDataMap[param1] = new autoSkillBD(1,1);
         }
         return new Bitmap(autoSkillBitmapDataMap[param1],"auto",true);
      }
      
      public static function setAutoSkillMaskDisplay(param1:String, param2:Boolean) : void
      {
         if(WorldConfig.getValue("functionSwitch","autoCastSkill"))
         {
            param2 = false;
         }
         if(!skillCanAutoCast(param1))
         {
            return;
         }
         if(!autoSkillBitmapDataMap[param1])
         {
            autoSkillBitmapDataMap[param1] = new autoSkillBD(1,1);
         }
         var _loc3_:BitmapData = autoSkillBitmapDataMap[param1];
         if(param2)
         {
            _loc3_.copyPixels(new autoSkillBD(1,1),_loc3_.rect,new Point());
         }
         else
         {
            _loc3_.fillRect(_loc3_.rect,0);
         }
      }
      
      public static function get defaultAttackSkillCode() : String
      {
         if(_defaultAttackSkillCode == "")
         {
            setDefaultAttackSkill(WorldConfig.getDefaultAttackSkillCode(GameContext.localPlayer.fullInfo.jobCode));
         }
         return _defaultAttackSkillCode;
      }
      
      public static function get defaultAttackSkillObj() : Object
      {
         if(!_defaultAttackSkillObj)
         {
            setDefaultAttackSkill(WorldConfig.getDefaultAttackSkillCode(GameContext.localPlayer.fullInfo.jobCode));
         }
         return _defaultAttackSkillObj;
      }
      
      public static function setDefaultAttackSkill(param1:String, param2:Boolean = true) : void
      {
         _defaultAttackSkillCode = param1;
         _defaultAttackSkillObj = SkillConfig.getSkillConfig(_defaultAttackSkillCode);
         if(!_defaultAttackSkillObj)
         {
            _defaultAttackSkillCode = WorldConfig.getDefaultAttackSkillCode(GameContext.localPlayer.fullInfo.jobCode);
            _defaultAttackSkillObj = SkillConfig.getSkillConfig(_defaultAttackSkillCode);
         }
         if(obf_K_e_3075.skillBookUI)
         {
            obf_K_e_3075.skillBookUI.setDefaultSkill(_defaultAttackSkillCode);
         }
         if(param2)
         {
            GameContext.userConfig.das = _defaultAttackSkillCode;
            GameContext.saveConfig();
         }
      }
      
      public static function useDefaultAttackSkill(param1:MapInteractiveObject = null) : void
      {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         if(_defaultAttackSkillCode == "")
         {
            setDefaultAttackSkill(WorldConfig.getDefaultAttackSkillCode(GameContext.localPlayer.fullInfo.jobCode));
         }
         var _loc2_:String = _defaultAttackSkillCode;
         if(!param1)
         {
            param1 = GameContext.localPlayer.obf_0_6_a_430;
         }
         if(!WorldConfig.getValue("functionSwitch","autoCastSkill") && obf_w_3_4437)
         {
            for each(_loc3_ in autoUseSkills)
            {
               if(!SkillCDManager.checkSkillCD(SkillCDManager.getSkillCDFlag(_loc3_)))
               {
                  _loc4_ = SkillConfig.getSkillConfig(_loc3_);
                  if(SkillManager.instance.checkSkill(_loc4_,getSkillLevel(_loc3_) - 1,param1,new Point(param1.rootPX,param1.rootPY)) == 0)
                  {
                     _loc2_ = _loc3_;
                     break;
                  }
               }
            }
         }
         GameContext.localPlayer.startAutoAttack(param1);
         GameContext.localPlayer.sendSkill(_loc2_,param1,new Point(param1.rootPX,param1.rootPY));
      }
      
      public static function useCatchPetSkill(param1:obf_T_L_801) : void
      {
         if(!GameContext.localPlayer || !param1)
         {
            return;
         }
         var _loc2_:String = WorldConfig.getCatchPetSkillCode();
         var _loc3_:Object = SkillConfig.getSkillConfig(_loc2_);
         if(obf_K_e_3075.petBoxUI.getEnptyBag() <= 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("PetUI","petPrompt_BagIsFull"));
            return;
         }
         if(param1.level > GameContext.localPlayer.level)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("PetUI","petPrompt_CatchPetLevelError"));
            return;
         }
         var _loc4_:Array = JSONUtil.getObject(_loc3_,["levelInfo",PlayerSkillManager.getSkillLevel(_loc2_) - 1,"resultRule","toTarget","default","8","monsterList"]) as Array;
         if((Boolean(_loc4_)) && Boolean(_loc4_.length > 0) && _loc4_.indexOf(param1.monsterCode) <= -1)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_TargetNotInList"));
            return;
         }
         GameContext.localPlayer.sendSkill(WorldConfig.getCatchPetSkillCode(),param1,new Point(param1.rootPX,param1.rootPY));
      }
      
      public static function initCommonSkill(param1:Object) : void
      {
         var _loc2_:Object = null;
         commonSkill = new Array();
         for each(_loc2_ in param1.commonSkill)
         {
            commonSkill.push(_loc2_.code);
         }
      }
      
      public static function setHaveSkill(param1:String, param2:int) : void
      {
         haveSkills[param1] = param2;
      }
      
      public static function obf_y_m_873() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Object = null;
         var _loc8_:String = null;
         var _loc9_:Array = null;
         var _loc10_:Array = null;
         var _loc11_:Array = null;
         var _loc12_:Array = null;
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc15_:Object = null;
         var _loc16_:Array = null;
         var _loc17_:Object = null;
         var _loc18_:String = null;
         if(!GameContext.localPlayer)
         {
            return;
         }
         haveSkills = new Object();
         haveSkills[WorldConfig.getDefaultAttackSkillCode(GameContext.localPlayer.fullInfo.jobCode)] = 1;
         for(_loc1_ in jobSkill)
         {
            haveSkills[_loc1_] = jobSkill[_loc1_];
         }
         for(_loc2_ in fateSkill)
         {
            haveSkills[_loc2_] = fateSkill[_loc2_];
         }
         for(_loc3_ in familySkill)
         {
            haveSkills[_loc3_] = familySkill[_loc3_];
         }
         for(_loc4_ in blessSkill)
         {
            haveSkills[_loc4_] = blessSkill[_loc4_];
         }
         for(_loc5_ in bookSkill)
         {
            haveSkills[_loc5_] = bookSkill[_loc5_];
         }
         for(_loc6_ in devilGodeSkill)
         {
            haveSkills[_loc6_] = devilGodeSkill[_loc6_];
         }
         _loc7_ = SkillConfig.getChangePlayerSkill(GameContext.localPlayer.fullInfo.modelCode);
         for(_loc8_ in _loc7_)
         {
            _loc15_ = SkillConfig.getSkillConfig(_loc8_);
            if(_loc15_)
            {
               if(_loc15_.type != obf_M_F_3694.obf_u_8_4559)
               {
                  haveSkills[_loc8_] = _loc7_[_loc8_];
               }
            }
         }
         if(obf_K_e_3075.playerFullInfoUI)
         {
            _loc10_ = obf_K_e_3075.playerFullInfoUI.getEquipBindSkills();
         }
         if(obf_K_e_3075.armoryUpgradeUI)
         {
            _loc11_ = obf_K_e_3075.armoryUpgradeUI.getEquipBindSkills();
         }
         if(obf_K_e_3075.constellationUI)
         {
            _loc12_ = obf_K_e_3075.constellationUI.getEquipBindSkills();
         }
         _loc9_ = _loc10_.concat(_loc11_,_loc12_);
         for each(_loc13_ in _loc9_)
         {
            haveSkills[_loc13_] = 1;
         }
         for(_loc14_ in equipKindSkills)
         {
            _loc16_ = equipKindSkills[_loc14_];
            for each(_loc17_ in _loc16_)
            {
               haveSkills[_loc17_.skillCode] = _loc17_.skillLevel;
            }
         }
         if(obf_y_V_1989)
         {
            for(_loc18_ in obf_y_V_1989)
            {
               haveSkills[_loc18_] = obf_y_V_1989[_loc18_];
            }
         }
         setDefaultAttackSkill(GameContext.userConfig.das,false);
         if(obf_K_e_3075.skillBookUI)
         {
            obf_K_e_3075.skillBookUI.obf_0_5_m_711();
         }
         if(obf_K_e_3075.shortcutUI)
         {
            obf_K_e_3075.shortcutUI.recheckIconItem();
         }
      }
      
      public static function getAllSkills() : Object
      {
         return haveSkills;
      }
      
      public static function getCommonSkills() : Array
      {
         return commonSkill.concat();
      }
      
      public static function getSkillLevel(param1:String) : int
      {
         if(!JSONUtil.getObject(GameContext.localPlayer,["fullInfo"]))
         {
            return 0;
         }
         if(commonSkill.indexOf(param1) > -1)
         {
            return 1;
         }
         if(param1 == WorldConfig.getDefaultAttackSkillCode(GameContext.localPlayer.fullInfo.jobCode))
         {
            return 1;
         }
         return int(haveSkills[param1]) || 0;
      }
      
      public static function obf_0_6_G_255(param1:String) : Boolean
      {
         if(!GameContext.localPlayer || !GameContext.localPlayer.fullInfo)
         {
            return false;
         }
         if(commonSkill.indexOf(param1) > -1)
         {
            return true;
         }
         if(param1 == WorldConfig.getDefaultAttackSkillCode(GameContext.localPlayer.fullInfo.jobCode))
         {
            return true;
         }
         return haveSkills.hasOwnProperty(param1);
      }
      
      public static function obf_j_M_1052() : void
      {
         var _loc1_:String = null;
         var _loc2_:Object = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:obf_d_j_2550 = null;
         if(skillEffectLoaded || !haveSkills)
         {
            return;
         }
         for(_loc1_ in haveSkills)
         {
            _loc2_ = SkillConfig.getSkillConfig(_loc1_);
            if(_loc2_)
            {
               for(_loc3_ in _loc2_.visual)
               {
                  if(_loc3_ == "fly")
                  {
                     obf_0_9_V_473.obf_T_k_1059(JSONUtil.getStr(_loc2_.visual,[_loc3_,"flyItem"]));
                  }
                  else
                  {
                     for each(_loc4_ in ["effects","effectsAuto"])
                     {
                        _loc5_ = JSONUtil.getObject(_loc2_,["visual",_loc3_,_loc4_]) as Array;
                        if((Boolean(_loc5_)) && _loc5_.length > 0)
                        {
                           for each(_loc6_ in _loc5_)
                           {
                              _loc7_ = obf_0_9_V_473.getEffect(_loc6_);
                              if(_loc7_)
                              {
                                 obf_0_9_V_473.obf_T_k_1059(_loc7_.res);
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         skillEffectLoaded = true;
      }
      
      public static function removeHaveSkill(param1:String) : void
      {
         delete haveSkills[param1];
      }
      
      public static function obf_l_q_2119() : void
      {
         haveSkills = new Object();
      }
   }
}

