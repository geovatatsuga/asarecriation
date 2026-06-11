package com.sunweb.game.rpg.constellation
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.worldZone.command.constellation.CommandCodePlayerConstellation;
   import com.sunweb.game.rpg.worldZone.command.constellation.ConstellationLuckNotify;
   import com.sunweb.game.rpg.worldZone.command.constellation.ConstellationTaskNotify;
   import com.sunweb.game.rpg.worldZone.command.constellation.FinishTaskConstellationRequest;
   import com.sunweb.game.rpg.worldZone.command.constellation.LuckChangeConstellationAnswer;
   import com.sunweb.game.rpg.worldZone.command.constellation.LuckChangeConstellationRequest;
   import com.sunweb.game.rpg.worldZone.command.constellation.LuckGetConstellationAnswer;
   import com.sunweb.game.rpg.worldZone.command.constellation.LuckGetConstellationRequest;
   import com.sunweb.game.rpg.worldZone.command.constellation.PrayPlayerConstellationRequest;
   import com.sunweb.game.rpg.worldZone.command.constellation.ReceiveTaskConstellationRequest;
   import com.sunweb.game.rpg.worldZone.command.constellation.ResetPlayerConstellationNotify;
   import com.sunweb.game.rpg.worldZone.command.constellation.SetPlayerConstellationAnswer;
   import com.sunweb.game.rpg.worldZone.command.constellation.SetPlayerConstellationRequest;
   import com.sunweb.game.rpg.worldZone.command.constellation.UpPlayerConstellationAnswer;
   import com.sunweb.game.rpg.worldZone.command.constellation.UpPlayerConstellationRequest;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import img.HeartOff;
   import img.HeartOn;
   import img.LuckOff;
   import img.LuckOn;
   
   public class obf_H_B_2569
   {
      
      private static var constellationConfig:Object;
      
      public function obf_H_B_2569()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         constellationConfig = param1;
      }
      
      public static function getConfigValue(... rest) : *
      {
         return JSONUtil.getObject(constellationConfig,rest);
      }
      
      public static function getConstellationInfo() : Array
      {
         return getConfigValue("constellation") as Array;
      }
      
      public static function obf_M_4_3195() : Boolean
      {
         var _loc1_:Object = getConfigValue("openConstellationCond");
         if(!ConditionScript.checkCondition(_loc1_,null,true))
         {
            return false;
         }
         return true;
      }
      
      public static function getConstellationComposeList() : Array
      {
         return getConfigValue("constellationTypeList") as Array;
      }
      
      public static function getConstellationRouseList() : Array
      {
         return getConfigValue("constellationRouseList") as Array;
      }
      
      public static function getConstellationObject(param1:int) : Object
      {
         var _loc2_:Array = getConstellationInfo() as Array;
         if(!_loc2_)
         {
            return null;
         }
         if(param1 < 0)
         {
            return null;
         }
         if(param1 > _loc2_.length)
         {
            return null;
         }
         var _loc3_:Object = _loc2_[param1];
         if(!_loc3_)
         {
            return null;
         }
         return _loc3_;
      }
      
      public static function getConstellationLevel(param1:int) : int
      {
         var _loc2_:Object = getConstellationObject(param1);
         if(!_loc2_)
         {
            return 0;
         }
         var _loc3_:Array = JSONUtil.getObject(_loc2_,["addAttrList"]) as Array;
         return _loc3_.length;
      }
      
      public static function getChangeLuckByMoney() : int
      {
         return getConfigValue("changeLuckByMoney");
      }
      
      public static function get getLuckLevelArr() : Array
      {
         return getConfigValue("luckList") as Array;
      }
      
      public static function get getMaxHartLevel() : int
      {
         return JSONUtil.getInt(constellationConfig,["maxHartLevel"]);
      }
      
      public static function getGodTypeName(param1:int) : String
      {
         return DiversityManager.getString("ConstellationUI","txtConstellationTypeName_" + param1);
      }
      
      public static function initializeConstellationDay(param1:int) : String
      {
         var _loc2_:String = "";
         switch(param1)
         {
            case ConstellationKind.BAIYANG:
               _loc2_ = "03.21-04.19";
               break;
            case ConstellationKind.JINNIU:
               _loc2_ = "04.20-05.20";
               break;
            case ConstellationKind.SHUANGZI:
               _loc2_ = "05.21-06.21";
               break;
            case ConstellationKind.JUXIE:
               _loc2_ = "06.22-07.22";
               break;
            case ConstellationKind.SHIZI:
               _loc2_ = "07.23-08.22";
               break;
            case ConstellationKind.CHUNV:
               _loc2_ = "08.23-09.22";
               break;
            case ConstellationKind.TIANCHENG:
               _loc2_ = "09.23-10.23";
               break;
            case ConstellationKind.TIANXIE:
               _loc2_ = "10.24-11.22";
               break;
            case ConstellationKind.SHESHOU:
               _loc2_ = "11.23-12.21";
               break;
            case ConstellationKind.MOJIE:
               _loc2_ = "12.22-01.19";
               break;
            case ConstellationKind.SHUIPING:
               _loc2_ = "01.20-02.18";
               break;
            case ConstellationKind.SHUANGYU:
               _loc2_ = "02.19-03.20";
               break;
            default:
               _loc2_ = "";
         }
         return _loc2_;
      }
      
      public static function sendGetBless() : void
      {
         var _loc1_:PrayPlayerConstellationRequest = new PrayPlayerConstellationRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendBirthday(param1:String) : void
      {
         var _loc2_:SetPlayerConstellationRequest = new SetPlayerConstellationRequest();
         _loc2_.dateTime = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendChangLuck() : void
      {
         var _loc1_:LuckChangeConstellationRequest = new LuckChangeConstellationRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendGetLuck(param1:int) : void
      {
         var _loc2_:LuckGetConstellationRequest = new LuckGetConstellationRequest();
         _loc2_.luckLevel = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendUp() : void
      {
         var _loc1_:UpPlayerConstellationRequest = new UpPlayerConstellationRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendReceiveTask(param1:int) : void
      {
         var _loc2_:ReceiveTaskConstellationRequest = new ReceiveTaskConstellationRequest();
         _loc2_.taskId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendFinishTask(param1:int) : void
      {
         var _loc2_:FinishTaskConstellationRequest = new FinishTaskConstellationRequest();
         _loc2_.taskId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerConstellation.SET_PLAYER_CONSTELLATION_ANSWER)
         {
            obf_0___n_693(param1 as SetPlayerConstellationAnswer);
         }
         else if(param1.code == CommandCodePlayerConstellation.RESET_PLAYER_CONSTELLATION_NOTIFY)
         {
            obf_x_H_3379(param1 as ResetPlayerConstellationNotify);
         }
         else if(param1.code == CommandCodePlayerConstellation.LUCK_CHANGE_CONSTELLATION_ANSWER)
         {
            obf_n_b_1404(param1 as LuckChangeConstellationAnswer);
         }
         else if(param1.code == CommandCodePlayerConstellation.LUCK_GET_CONSTELLATION_ANSWER)
         {
            obf_l_w_3226(param1 as LuckGetConstellationAnswer);
         }
         else if(param1.code == CommandCodePlayerConstellation.UP_PLAYER_CONSTELLATION_ANSWER)
         {
            obf_7_C_921(param1 as UpPlayerConstellationAnswer);
         }
         else if(param1.code == CommandCodePlayerConstellation.CONSTELLATION_LUCK_NOTIFY)
         {
            obf_S_o_2981(param1 as ConstellationLuckNotify);
         }
         else if(param1.code == CommandCodePlayerConstellation.CONSTELLATION_TASK_NOTIFY)
         {
            obf_c_d_1056(param1 as ConstellationTaskNotify);
         }
      }
      
      private static function obf_0___n_693(param1:SetPlayerConstellationAnswer) : void
      {
         GameContext.localPlayer.fullInfo.constellation = param1.constellation;
         GameContext.localPlayer.fullInfo.constellationLevel = param1.constellationLevel;
         GameContext.localPlayer.fullInfo.constellationTaskId = param1.taskId;
         GameContext.localPlayer.fullInfo.luckLevel = param1.luckLevel;
         obf_K_e_3075.constellationUI.refreshTask(param1.taskId);
         obf_K_e_3075.constellationUI.obf_b_z_1599();
         obf_K_e_3075.constellationUI.resetBirthday();
         obf_K_e_3075.constellationUI.obf_k_I_2192(param1.luckLevel);
         obf_K_e_3075.constellationUI.updateAllButton();
      }
      
      private static function obf_x_H_3379(param1:ResetPlayerConstellationNotify) : void
      {
         GameContext.localPlayer.fullInfo.constellationLevel = param1.constellationLevel;
         GameContext.localPlayer.fullInfo.luckLevel = param1.luckLevel;
         GameContext.localPlayer.fullInfo.hartLevel = param1.hartLevel;
         obf_K_e_3075.constellationUI.obf_b_z_1599();
         obf_K_e_3075.constellationUI.resetBirthday();
         obf_K_e_3075.constellationUI.obf_k_I_2192(param1.luckLevel);
         obf_K_e_3075.constellationUI.obf_U_v_2683(param1.hartLevel);
         obf_K_e_3075.constellationUI.refreshTask(param1.taskId);
         obf_K_e_3075.constellationUI.updateAllButton();
      }
      
      private static function obf_n_b_1404(param1:LuckChangeConstellationAnswer) : void
      {
         GameContext.localPlayer.fullInfo.luckLevel = param1.luckLevel;
         obf_K_e_3075.constellationUI.obf_k_I_2192(param1.luckLevel);
         obf_K_e_3075.constellationUI.updateReceiveLuckButton();
      }
      
      private static function obf_l_w_3226(param1:LuckGetConstellationAnswer) : void
      {
         GameContext.localPlayer.fullInfo.hartLevel = param1.hartLevel;
         obf_K_e_3075.constellationUI.obf_U_v_2683(param1.hartLevel);
      }
      
      private static function obf_7_C_921(param1:UpPlayerConstellationAnswer) : void
      {
         GameContext.localPlayer.fullInfo.constellationLevel = param1.constellationLevel;
         GameContext.localPlayer.fullInfo.hartLevel = param1.hartLevel;
         obf_K_e_3075.constellationUI.obf_U_v_2683(param1.hartLevel);
         obf_K_e_3075.constellationUI.obf_b_z_1599();
      }
      
      private static function obf_S_o_2981(param1:ConstellationLuckNotify) : void
      {
         GameContext.localPlayer.fullInfo.luckLevel = param1.luckLevel;
         obf_K_e_3075.constellationUI.obf_k_I_2192(param1.luckLevel);
      }
      
      private static function obf_c_d_1056(param1:ConstellationTaskNotify) : void
      {
         obf_K_e_3075.constellationUI.refreshTask(param1.taskId);
      }
      
      public static function getConstellationLuckDisplay(param1:int = 0, param2:Boolean = false) : DisplayObject
      {
         var _loc6_:LuckOn = null;
         var _loc7_:LuckOff = null;
         var _loc3_:int = 35;
         var _loc4_:Sprite = new Sprite();
         if(!getLuckLevelArr)
         {
            return _loc4_;
         }
         var _loc5_:int = 1;
         while(_loc5_ <= getLuckLevelArr.length)
         {
            if(_loc5_ <= param1)
            {
               _loc6_ = new LuckOn();
               _loc6_.x = (_loc5_ - 1) * _loc3_;
               _loc4_.addChild(_loc6_);
            }
            else
            {
               if(!param2)
               {
                  break;
               }
               _loc7_ = new LuckOff();
               _loc7_.x = (_loc5_ - 1) * _loc3_;
               _loc4_.addChild(_loc7_);
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public static function getConstellationHartDisplay(param1:int = 0, param2:Boolean = false) : DisplayObject
      {
         var _loc6_:HeartOn = null;
         var _loc7_:HeartOff = null;
         var _loc3_:int = 35;
         var _loc4_:Sprite = new Sprite();
         var _loc5_:int = 1;
         while(_loc5_ <= getMaxHartLevel)
         {
            if(_loc5_ <= param1)
            {
               _loc6_ = new HeartOn();
               _loc6_.x = (_loc5_ - 1) * _loc3_;
               _loc4_.addChild(_loc6_);
            }
            else
            {
               if(!param2)
               {
                  break;
               }
               _loc7_ = new HeartOff();
               _loc7_.x = (_loc5_ - 1) * _loc3_;
               _loc4_.addChild(_loc7_);
            }
            _loc5_++;
         }
         return _loc4_;
      }
   }
}

