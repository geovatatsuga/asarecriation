package obf_r_4635
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.equ.EquipmentManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.map.obf_z_T_3316;
   import com.sunweb.game.rpg.netRole.obf_T_L_801;
   import com.sunweb.game.rpg.playerUI.managers.ButtonToItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.obf_I_5_1944;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.rpg.skill.SkillCDManager;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.map.MapManager;
   import com.sunweb.game.rpg.worldZone.command.bot.CommandCodeRobot;
   import com.sunweb.game.rpg.worldZone.command.bot.RobotActionRequest;
   import com.sunweb.game.rpg.worldZone.command.bot.RobotStatusCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   import com.sunweb.game.rpg.worldZone.command.player.PlayerSkillInterruptedNotify;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import com.sunweb.game.utils.obf_l_y_733;
   import flash.geom.Point;
   
   public class obf_R_6_1363
   {
      
      private static var botPoint:Point;
      
      private static var obf_s_5_1473:Boolean;
      
      private static var isBacking:Boolean;
      
      private static var targetId:String;
      
      public static var obf_L_A_4035:String;
      
      public static var excludedList:Array;
      
      public static var autoRepairEqu:Boolean;
      
      public static var autoPerfectRepairEqu:Boolean;
      
      public static var autoAddBotTime:Boolean;
      
      public static var autoAddPlayerExpTime:Boolean;
      
      public static var autoAddPetExpTime:Boolean;
      
      public static var autoHpPercentItems:Array;
      
      public static var autoMpPercentItems:Array;
      
      public static var autoPetHpPercentItems:Array;
      
      public static var autoPetMpPercentItems:Array;
      
      public static var enabledHpPercentItem:Boolean;
      
      public static var enabledMpPercentItem:Boolean;
      
      public static var enabledPetHpPercentItem:Boolean;
      
      public static var enabledPetMpPercentItem:Boolean;
      
      public static var hpPercentItemsCode:Array;
      
      public static var mpPercentItemsCode:Array;
      
      public static var petHpPercentItemsCode:Array;
      
      public static var petMpPercentItemsCode:Array;
      
      public static var useSkills:Array;
      
      private static var currentSkillIndex:int;
      
      public static var pickUpEquipRank:Array;
      
      public static var pickUpOtherRank:Array;
      
      private static var obf_x_w_876:int;
      
      private static var obf_O_q_4576:int;
      
      private static var startTime:TimeLimiter;
      
      private static var timeToUseTime:Array;
      
      public static var timeToUse:Array;
      
      private static var obf_q_e_1829:TimeLimiter;
      
      private static var skillInterrupTimeInv:TimeLimiter;
      
      private static var skillInterrupTims:int;
      
      public static var botRadius:int = 500;
      
      public static var excludedidList:Array = new Array();
      
      public static var hpPercentToUseItem:int = 60;
      
      public static var mpPercentToUseItem:int = 60;
      
      public static var petHpPercentToUseItem:int = 60;
      
      public static var petMpPercentToUseItem:int = 60;
      
      private static var useItemTimeInv:TimeLimiter = new TimeLimiter(1000);
      
      private static var pickUpTimeInv:TimeLimiter = new TimeLimiter(500);
      
      public static var pickUpItemType:int = GameItemType.ALL;
      
      private static var obf_w_S_1776:TimeLimiter = new TimeLimiter(300);
      
      private static var obf_i_I_4020:TimeLimiter = new TimeLimiter(60000);
      
      private static var callTimeInv:TimeLimiter = new TimeLimiter(2000);
      
      public function obf_R_6_1363()
      {
         super();
      }
      
      public static function get isRuning() : Boolean
      {
         return obf_s_5_1473;
      }
      
      public static function obf_Q_i_1756() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Object = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         var _loc7_:Array = null;
         var _loc8_:Object = null;
         var _loc9_:Boolean = false;
         var _loc10_:String = null;
         var _loc11_:int = 0;
         var _loc12_:TimeLimiter = null;
         var _loc13_:Object = null;
         var _loc14_:obf_z_T_3316 = null;
         if(!obf_w_S_1776.checkTimeout() || !GameContext.localPlayer || GameContext.localPlayer.isDead)
         {
            return;
         }
         if(!obf_s_5_1473)
         {
            return;
         }
         if(obf_i_I_4020.checkTimeout())
         {
            obf_P_m_3292();
         }
         if(useItemTimeInv.checkTimeout())
         {
            if(enabledHpPercentItem && GameContext.localPlayer.fullInfo.attributes.hpPercent <= hpPercentToUseItem)
            {
               _loc1_ = hpPercentItemsCode;
               if(_loc1_ == null || _loc1_.length == 0)
               {
                  _loc1_ = autoHpPercentItems;
               }
               for each(_loc2_ in _loc1_)
               {
                  if(!(!_loc2_ || obf_L_l_4100.isEmpty(_loc2_.code)))
                  {
                     if(useItemOrSkill(_loc2_))
                     {
                        break;
                     }
                  }
               }
            }
            if(enabledMpPercentItem && GameContext.localPlayer.fullInfo.attributes.mpPercent <= mpPercentToUseItem)
            {
               _loc3_ = mpPercentItemsCode;
               if(_loc3_ == null || _loc3_.length == 0)
               {
                  _loc3_ = autoMpPercentItems;
               }
               for each(_loc4_ in _loc3_)
               {
                  if(!(!_loc4_ || obf_L_l_4100.isEmpty(_loc4_.code)))
                  {
                     if(useItemOrSkill(_loc4_))
                     {
                        break;
                     }
                  }
               }
            }
            if(GameContext.localPlayer.petFullInfo)
            {
               if(enabledPetHpPercentItem && GameContext.localPlayer.petFullInfo.hpPercent <= petHpPercentToUseItem)
               {
                  _loc5_ = petHpPercentItemsCode;
                  if(_loc5_ == null || _loc5_.length == 0)
                  {
                     _loc5_ = autoPetHpPercentItems;
                  }
                  for each(_loc6_ in _loc5_)
                  {
                     if(!(!_loc6_ || obf_L_l_4100.isEmpty(_loc6_.code)))
                     {
                        if(useItemOrSkill(_loc6_))
                        {
                           break;
                        }
                     }
                  }
               }
               if(enabledPetMpPercentItem && GameContext.localPlayer.petFullInfo.mpPercent <= petMpPercentToUseItem)
               {
                  _loc7_ = petMpPercentItemsCode;
                  if(_loc7_ == null || _loc7_.length == 0)
                  {
                     _loc7_ = autoPetMpPercentItems;
                  }
                  for each(_loc8_ in _loc7_)
                  {
                     if(!(!_loc8_ || obf_L_l_4100.isEmpty(_loc8_.code)))
                     {
                        if(useItemOrSkill(_loc8_))
                        {
                           break;
                        }
                     }
                  }
               }
            }
         }
         if(!GameContext.localPlayer.obf_0_6_a_430 || GameContext.localPlayer.obf_0_6_a_430.id != targetId)
         {
            if(!GameContext.localPlayer.isWalking() && !botPoint.equals(new Point(GameContext.localPlayer.rootPX,GameContext.localPlayer.rootPY)))
            {
               isBacking = false;
            }
            _loc9_ = selectTarget();
            if(!_loc9_ && !isBacking)
            {
               if(excludedidList.length > 0)
               {
                  excludedidList = [];
               }
               else
               {
                  GameContext.localPlayer.obf_I_V_3724(botPoint.x,botPoint.y);
                  isBacking = true;
               }
            }
         }
         if(Boolean(GameContext.localPlayer.obf_0_6_a_430) && Boolean(useSkills))
         {
            if(currentSkillIndex >= useSkills.length)
            {
               currentSkillIndex = 0;
            }
            while(currentSkillIndex < useSkills.length)
            {
               _loc10_ = useSkills[currentSkillIndex];
               if(!obf_L_l_4100.isEmpty(_loc10_))
               {
                  if(PlayerSkillManager.obf_0_6_G_255(_loc10_) && !SkillCDManager.checkSkillCD(SkillCDManager.getSkillCDFlag(_loc10_)))
                  {
                     GameContext.localPlayer.sendSkill(_loc10_,GameContext.localPlayer.obf_0_6_a_430,new Point(GameContext.localPlayer.obf_0_6_a_430.rootPX,GameContext.localPlayer.obf_0_6_a_430.rootPY));
                     ++currentSkillIndex;
                     break;
                  }
               }
               ++currentSkillIndex;
            }
         }
         if(Boolean(timeToUse) && Boolean(timeToUseTime))
         {
            _loc11_ = 0;
            while(_loc11_ < timeToUse.length && _loc11_ < timeToUseTime.length)
            {
               _loc12_ = timeToUseTime[_loc11_];
               if(!(!_loc12_ || _loc12_.timelimit == 0))
               {
                  if(_loc12_.checkTimeout(true))
                  {
                     if(useItemOrSkill(timeToUse[_loc11_]))
                     {
                        _loc12_.checkTimeout();
                     }
                  }
               }
               _loc11_++;
            }
         }
         if(!GameContext.localPlayer.isUsingSkill && !GameContext.localPlayer.isWalking())
         {
            GameContext.localPlayer.startAutoAttack(GameContext.localPlayer.obf_0_6_a_430);
         }
         if(pickUpTimeInv.checkTimeout() && pickUpItemType > 0)
         {
            _loc13_ = new Object();
            _loc13_[GameItemType.EQUIPMENT] = pickUpEquipRank;
            _loc13_[GameItemType.EXPENDABLE] = pickUpOtherRank;
            _loc13_[GameItemType.COLLECTION] = pickUpOtherRank;
            _loc14_ = MapManager.instance.getMapItemInSight(pickUpItemType,_loc13_);
            if(_loc14_)
            {
               GameContext.bagItemManager.sendPickUpItem(_loc14_.id);
            }
         }
         if(GameContext.localPlayer.obf_0_6_a_430)
         {
            obf_j_4640();
         }
         if(GameContext.localPlayer.playerJobCode == obf_I_5_1944.obf_0_1_133 && callTimeInv.checkTimeout())
         {
            if(!obf_L_l_4100.isEmpty(JSONUtil.getStr(obf_K_e_3075.obf_f_a_l_s_e_334.listCallAnimalSkill.selectedItem,["code"])))
            {
               if(!GameContext.localPlayer.isCastingSkill)
               {
                  return;
               }
               if(!GameContext.localPlayer.trainerFullInfo)
               {
                  GameContext.localPlayer.sendSkill(JSONUtil.getStr(obf_K_e_3075.obf_f_a_l_s_e_334.listCallAnimalSkill.selectedItem,["code"]),null,null);
               }
               else if(GameContext.localPlayer.trainerFullInfo.callSkillCode != JSONUtil.getStr(obf_K_e_3075.obf_f_a_l_s_e_334.listCallAnimalSkill.selectedItem,["code"]))
               {
                  GameContext.localPlayer.sendSkill(JSONUtil.getStr(obf_K_e_3075.obf_f_a_l_s_e_334.listCallAnimalSkill.selectedItem,["code"]),null,null);
               }
            }
         }
      }
      
      private static function walktoMom() : void
      {
         if(GameContext.localPlayer.obf_0_6_a_430)
         {
            if(GameContext.localPlayer.isWalking() || GameContext.localPlayer.rootPX == GameContext.localPlayer.obf_0_6_a_430.rootPX && GameContext.localPlayer.rootPY == GameContext.localPlayer.obf_0_6_a_430.rootPY)
            {
               return;
            }
            GameContext.localPlayer.obf_I_V_3724(GameContext.localPlayer.obf_0_6_a_430.rootPX,GameContext.localPlayer.obf_0_6_a_430.rootPY);
            GameContext.localPlayer.stopAutoAttack();
         }
      }
      
      private static function useItemOrSkill(param1:Object) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:Point = null;
         if(!param1 || obf_L_l_4100.isEmpty(param1.code) || !GameContext.currentMap)
         {
            return false;
         }
         if(param1.type == GameItemType.SKILL)
         {
            if(GameContext.localPlayer.obf_0_6_a_430)
            {
               _loc3_ = new Point(GameContext.localPlayer.obf_0_6_a_430.rootPX,GameContext.localPlayer.obf_0_6_a_430.rootPY);
            }
            _loc2_ = GameContext.localPlayer.sendSkill(param1.code,GameContext.localPlayer.obf_0_6_a_430,_loc3_);
         }
         else
         {
            _loc2_ = obf_K_e_3075.playerBagUI.useItemByCode(param1.code);
         }
         if(!_loc2_)
         {
            obf_K_e_3075.obf_n_h_4389();
         }
         return _loc2_;
      }
      
      public static function obf_P_m_3292() : void
      {
         var _loc1_:String = null;
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         if(autoRepairEqu || autoPerfectRepairEqu)
         {
            for(_loc1_ in EquipmentManager.obf_g_N_2380)
            {
               if(EquipmentManager.obf_g_N_2380[_loc1_] > 0 && EquipmentManager.obf_g_N_2380[_loc1_] == 1)
               {
                  ButtonToItemManager.useBTIById(autoPerfectRepairEqu ? "repairEquipPerfect" : "repairEquip",null,true);
                  break;
               }
            }
         }
         if(autoAddBotTime)
         {
            _loc2_ = getTimeLeftInSec();
            _loc3_ = _loc2_[0] + _loc2_[1];
            if(_loc3_ < 10 * 60)
            {
               ButtonToItemManager.useBTIById("addRobotTime",null,true);
            }
         }
         if(autoAddPlayerExpTime && ConditionScript.hasNoBuffs(WorldConfig.getValue("botConfig","buffIdList")) && ConditionScript.hasNoBuffs(WorldConfig.getValue("botConfig","dbPlayerExpBuffId")))
         {
            ButtonToItemManager.useBTIById("addPlayerDbExp",null,true);
         }
         if(autoAddPetExpTime && ConditionScript.hasNoBuffs(WorldConfig.getValue("botConfig","dbPetExpBuffId")))
         {
            ButtonToItemManager.useBTIById("addPetDbExp",null,true);
         }
      }
      
      public static function setTimeToUseList(param1:Array) : void
      {
         var _loc2_:Object = null;
         timeToUse = new Array();
         timeToUseTime = new Array();
         if(!param1)
         {
            return;
         }
         for each(_loc2_ in param1)
         {
            timeToUse.push({
               "type":_loc2_.type,
               "code":_loc2_.code,
               "time":_loc2_.time
            });
            timeToUseTime.push(_loc2_.time > 0 ? new TimeLimiter(obf_l_y_733.obf_0___a_609 * _loc2_.time) : null);
         }
      }
      
      public static function setTimeToUse(param1:Object, param2:uint, param3:Boolean = false) : void
      {
         if(!param1 || !timeToUse || param2 > timeToUse.length - 1)
         {
            return;
         }
         var _loc4_:Object = timeToUse[param2];
         var _loc5_:TimeLimiter = timeToUseTime[param2];
         if(_loc4_)
         {
            _loc4_.type = param1.type;
            _loc4_.code = param1.code;
            _loc4_.time = param1.time;
         }
         if(param1.time <= 0)
         {
            timeToUseTime[param2] = null;
            return;
         }
         if(timeToUseTime[param2] == null)
         {
            timeToUseTime[param2] = new TimeLimiter(obf_l_y_733.obf_0___a_609 * param1.time);
         }
         if(_loc5_)
         {
            _loc5_.timelimit = obf_l_y_733.obf_0___a_609 * param1.time;
         }
         if(param3)
         {
            timeToUseTime[param2] = new TimeLimiter(obf_l_y_733.obf_0___a_609 * param1.time);
         }
      }
      
      public static function selectTarget() : Boolean
      {
         obf_q_e_1829 = null;
         targetId = "";
         var _loc1_:obf_T_L_801 = MapManager.instance.getRecentMonster(obf_L_A_4035,botRadius,excludedidList,excludedList,WorldConfig.getValue("botConfig","excludedBossLevel"));
         if(!_loc1_)
         {
            return false;
         }
         if(!_loc1_ || _loc1_.getLineDistancePt(botPoint.x,botPoint.y) > botRadius)
         {
            return false;
         }
         targetId = _loc1_.id;
         GameContext.localPlayer.selectTarget(_loc1_);
         obf_q_e_1829 = new TimeLimiter(30000);
         excludedidList = [];
         return true;
      }
      
      public static function setExcludedCodeList(param1:Array) : void
      {
         excludedList = param1;
      }
      
      public static function setUseSkills(param1:Array) : void
      {
         useSkills = param1;
      }
      
      public static function startBot(param1:String = "") : void
      {
         if(JSONUtil.getBoolean(MapManager.instance.mapInfo,["rules","commonRule","disableRobot"]))
         {
            obf_K_e_3075.showCenterInfo(DiversityManager.getString("BotUI","prompt_CantBotInMap"));
            return;
         }
         obf_i_I_4020.restartTime();
         obf_P_m_3292();
         botPoint = new Point(GameContext.localPlayer.rootPX,GameContext.localPlayer.rootPY);
         obf_L_A_4035 = param1;
         sendStartBot();
         obf_q_e_1829 = new TimeLimiter(30000);
      }
      
      public static function stopBot() : void
      {
         sendStopBot();
         obf_s_5_1473 = false;
         isBacking = false;
         obf_q_e_1829 = null;
      }
      
      public static function getTimeLeftInSec() : Array
      {
         var _loc1_:int = 0;
         if(obf_s_5_1473 && Boolean(startTime))
         {
            _loc1_ = startTime.totalTimeInMS / 1000;
         }
         var _loc2_:int = obf_x_w_876 - _loc1_;
         var _loc3_:int = obf_O_q_4576 - Math.max(_loc1_ - obf_x_w_876,0);
         return [_loc2_,_loc3_];
      }
      
      public static function sendStartBot() : void
      {
         var _loc1_:RobotActionRequest = new RobotActionRequest();
         _loc1_.action = 1;
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendStopBot() : void
      {
         var _loc1_:RobotActionRequest = new RobotActionRequest();
         _loc1_.action = 2;
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeRobot.ROBOT_STATUS_CHECK_NOTIFY)
         {
            obf_Z_D_2634(param1 as RobotStatusCheckNotify);
         }
         else if(param1.code == CommandCodePlayer.PLAYER_SKILL_INTERRUPTED_NOTIFY)
         {
            onPlayerSkillInterrup(param1 as PlayerSkillInterruptedNotify);
         }
      }
      
      private static function obf_Z_D_2634(param1:RobotStatusCheckNotify) : void
      {
         obf_x_w_876 = param1.robotTime1LeftInSec;
         obf_O_q_4576 = param1.robotTime2LeftInSec;
         if(param1.isRobot != obf_s_5_1473)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.obf_f_a_l_s_e_334);
         }
         if(param1.isRobot)
         {
            obf_s_5_1473 = true;
            startTime = new TimeLimiter(1000);
            obf_K_e_3075.obf_f_a_l_s_e_334.cmdBotAction.label = DiversityManager.getString("BotUI","cmdStopBot");
            obf_K_e_3075.showUI(obf_K_e_3075.systemAlwaysInfoUI);
            obf_K_e_3075.systemAlwaysInfoUI.txtInfo.text = DiversityManager.getString("BotUI","prompt_isBot");
         }
         else
         {
            obf_s_5_1473 = false;
            isBacking = false;
            obf_K_e_3075.obf_f_a_l_s_e_334.cmdBotAction.label = DiversityManager.getString("BotUI","cmdStartBot");
            obf_K_e_3075.closeUI(obf_K_e_3075.systemAlwaysInfoUI);
         }
      }
      
      private static function onPlayerSkillInterrup(param1:PlayerSkillInterruptedNotify) : void
      {
         if(!obf_s_5_1473)
         {
            return;
         }
         ++skillInterrupTims;
         if(skillInterrupTims >= 5)
         {
            walktoMom();
            skillInterrupTims = 0;
            skillInterrupTimeInv = null;
         }
         if(!skillInterrupTimeInv)
         {
            skillInterrupTimeInv = new TimeLimiter(5000);
         }
         else if(skillInterrupTimeInv.checkTimeout())
         {
            skillInterrupTimeInv = null;
            skillInterrupTims = 0;
         }
      }
      
      private static function obf_j_4640() : void
      {
         if(!obf_s_5_1473)
         {
            return;
         }
         if(Boolean(obf_q_e_1829) && obf_q_e_1829.checkTimeout())
         {
            excludedidList.push(GameContext.localPlayer.obf_0_6_a_430.id);
            selectTarget();
         }
      }
   }
}

