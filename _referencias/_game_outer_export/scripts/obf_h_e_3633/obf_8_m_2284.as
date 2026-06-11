package obf_h_e_3633
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.incubator.CommandCodeIncubator;
   import com.sunweb.game.rpg.worldZone.command.incubator.IncubatorChangePressureTempNotify;
   import com.sunweb.game.rpg.worldZone.command.incubator.IncubatorDoAnswer;
   import com.sunweb.game.rpg.worldZone.command.incubator.IncubatorDoRequest;
   import com.sunweb.game.rpg.worldZone.command.incubator.IncubatorInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.incubator.IncubatorNoRequest;
   import com.sunweb.game.rpg.worldZone.command.incubator.IncubatorOverAnswer;
   import com.sunweb.game.rpg.worldZone.command.incubator.IncubatorOverRequest;
   import com.sunweb.game.rpg.worldZone.command.incubator.IncubatorPowerAnswer;
   import com.sunweb.game.rpg.worldZone.command.incubator.IncubatorPowerRequest;
   import com.sunweb.game.rpg.worldZone.command.incubator.IncubatorPressureRequest;
   import com.sunweb.game.rpg.worldZone.command.incubator.IncubatorSaveAnswer;
   import com.sunweb.game.rpg.worldZone.command.incubator.IncubatorSaveRequest;
   import com.sunweb.game.rpg.worldZone.command.incubator.IncubatorStateNotify;
   import com.sunweb.game.rpg.worldZone.command.incubator.IncubatorTakeAnswer;
   import com.sunweb.game.rpg.worldZone.command.incubator.IncubatorTakeRequest;
   import com.sunweb.game.rpg.worldZone.command.incubator.IncubatorTempRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_8_m_2284
   {
      
      private static var incubatorConfig:Object;
      
      public static var itemsConfig:Array;
      
      public function obf_8_m_2284()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         incubatorConfig = param1;
         itemsConfig = obf_8_m_2284.initItemsConfig;
      }
      
      public static function get openCon() : Object
      {
         return JSONUtil.getObject(incubatorConfig,["openCondition"]);
      }
      
      public static function get initItemsConfig() : Array
      {
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:IncubatorItemConfig = null;
         var _loc1_:Array = JSONUtil.getValue(incubatorConfig,["eggRanks"]) as Array;
         if(!_loc1_)
         {
            return null;
         }
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = JSONUtil.getInt(_loc1_[_loc3_],["rankColor"]);
            _loc5_ = JSONUtil.getValue(_loc1_[_loc3_],["eggTypes"]) as Array;
            if(_loc5_)
            {
               _loc6_ = 0;
               while(_loc6_ < _loc5_.length)
               {
                  _loc7_ = new IncubatorItemConfig();
                  _loc7_.itemCode = JSONUtil.getStr(_loc5_[_loc6_],["itemCode"]);
                  _loc7_.maxTimes = JSONUtil.getInt(_loc5_[_loc3_],["maxTimes"]);
                  _loc7_.attr = JSONUtil.getObject(_loc5_[_loc6_],["attr"]);
                  _loc7_.rank = _loc4_;
                  _loc2_.push(_loc7_);
                  _loc6_++;
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function getIncubatorInfoByItemCode(param1:String) : obf_3_T_877
      {
         var _loc5_:Object = null;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:Object = null;
         var _loc9_:obf_3_T_877 = null;
         var _loc2_:Array = JSONUtil.getValue(incubatorConfig,["eggRanks"]) as Array;
         if(!_loc2_)
         {
            return null;
         }
         var _loc3_:Array = new Array();
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = _loc2_[_loc4_];
            _loc6_ = JSONUtil.getValue(_loc5_,["eggTypes"]) as Array;
            if(_loc6_)
            {
               _loc7_ = 0;
               while(_loc7_ < _loc6_.length)
               {
                  _loc8_ = _loc6_[_loc7_];
                  if(param1 == JSONUtil.getStr(_loc8_,["itemCode"]))
                  {
                     _loc9_ = new obf_3_T_877();
                     _loc9_.rankName = JSONUtil.getStr(_loc5_,["rankName"]);
                     _loc9_.rankColor = JSONUtil.getInt(_loc5_,["rankColor"]);
                     _loc9_.typeName = JSONUtil.getStr(_loc8_,["typeName"]);
                     _loc9_.typeAttr = JSONUtil.getStr(_loc8_,["typeAttr"]);
                     _loc9_.typeAttrValue = JSONUtil.getInt(_loc8_,["typeAttrValue"]);
                     _loc9_.itemCode = JSONUtil.getStr(_loc8_,["itemCode"]);
                     _loc9_.needTime = JSONUtil.getInt(_loc8_,["needTime"]);
                     _loc9_.pressure = JSONUtil.getInt(_loc8_,["pressure"]);
                     _loc9_.temp = JSONUtil.getInt(_loc8_,["temp"]);
                     _loc9_.dif = JSONUtil.getNumber(_loc8_,["dif"]);
                     _loc9_.power = JSONUtil.getInt(_loc8_,["power"]);
                     _loc9_.maxTimes = JSONUtil.getInt(_loc8_,["maxTimes"]);
                     return _loc9_;
                  }
                  _loc7_++;
               }
            }
            _loc4_++;
         }
         return null;
      }
      
      public static function get takeGold() : int
      {
         return JSONUtil.getInt(incubatorConfig,["takeGold"]);
      }
      
      public static function get incubateNeeds() : Array
      {
         return JSONUtil.getValue(incubatorConfig,["incubateNeeds"]) as Array;
      }
      
      public static function get maxPressure() : int
      {
         return JSONUtil.getInt(incubatorConfig,["maxPressure"]);
      }
      
      public static function get pressureItems() : Object
      {
         return JSONUtil.getObject(incubatorConfig,["pressureItems"]);
      }
      
      public static function get pressureValue() : int
      {
         return JSONUtil.getInt(incubatorConfig,["pressureValue"]);
      }
      
      public static function get losePressure() : int
      {
         return JSONUtil.getInt(incubatorConfig,["losePressure"]);
      }
      
      public static function get maxTemp() : int
      {
         return JSONUtil.getInt(incubatorConfig,["maxTemp"]);
      }
      
      public static function get tempItems() : Object
      {
         return JSONUtil.getObject(incubatorConfig,["tempItems"]);
      }
      
      public static function get tempValue() : int
      {
         return JSONUtil.getInt(incubatorConfig,["tempValue"]);
      }
      
      public static function get loseTemp() : int
      {
         return JSONUtil.getInt(incubatorConfig,["loseTemp"]);
      }
      
      public static function get maxPower() : int
      {
         return JSONUtil.getInt(incubatorConfig,["maxPower"]);
      }
      
      public static function get powerItems() : Object
      {
         return JSONUtil.getObject(incubatorConfig,["powerItems"]);
      }
      
      public static function get powerValue() : int
      {
         return JSONUtil.getInt(incubatorConfig,["powerValue"]);
      }
      
      public static function get overNeed() : int
      {
         return JSONUtil.getInt(incubatorConfig,["overNeed"]);
      }
      
      public static function get successMul() : Number
      {
         return JSONUtil.getNumber(incubatorConfig,["successMul"]);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeIncubator.INCUBATOR_TAKE_ANSWER)
         {
            obf_w_r_1432(param1 as IncubatorTakeAnswer);
         }
         else if(param1.code == CommandCodeIncubator.INCUBATOR_DO_ANSWER)
         {
            obf_G_5_3695(param1 as IncubatorDoAnswer);
         }
         else if(param1.code == CommandCodeIncubator.INCUBATOR_OVER_ANSWER)
         {
            obf_0_1_W_660(param1 as IncubatorOverAnswer);
         }
         else if(param1.code == CommandCodeIncubator.INCUBATOR_POWER_ANSWER)
         {
            obf_0_m_4545(param1 as IncubatorPowerAnswer);
         }
         else if(param1.code == CommandCodeIncubator.INCUBATOR_SAVE_ANSWER)
         {
            obf_a_d_1133(param1 as IncubatorSaveAnswer);
         }
         else if(param1.code == CommandCodeIncubator.INCUBATOR_CHANGE_PRESSURE_TEMP_NOTIFY)
         {
            obf_f_h_4330(param1 as IncubatorChangePressureTempNotify);
         }
         else if(param1.code == CommandCodeIncubator.INCUBATOR_INFO_NOTIFY)
         {
            obf_B_a_3206(param1 as IncubatorInfoNotify);
         }
         else if(param1.code == CommandCodeIncubator.INCUBATOR_STATE_NOTIFY)
         {
            obf_0_6_P_647(param1 as IncubatorStateNotify);
         }
      }
      
      private static function obf_w_r_1432(param1:IncubatorTakeAnswer) : void
      {
         obf_K_e_3075.obf_P_I_3025.setState(2);
         obf_K_e_3075.obf_P_I_3025.setItemCode(param1.itemCode);
      }
      
      private static function obf_G_5_3695(param1:IncubatorDoAnswer) : void
      {
         obf_K_e_3075.obf_P_I_3025.setState(3);
         obf_K_e_3075.obf_P_I_3025.setEndTime(param1.endTime);
         obf_K_e_3075.obf_P_I_3025.changeValue(param1.pressure,1);
         obf_K_e_3075.obf_P_I_3025.changeValue(param1.temp,2);
         obf_K_e_3075.obf_P_I_3025.changeValue(param1.power,3);
      }
      
      private static function obf_0_1_W_660(param1:IncubatorOverAnswer) : void
      {
         obf_K_e_3075.obf_P_I_3025.incubatorResult(param1.isSuccess);
      }
      
      private static function obf_0_m_4545(param1:IncubatorPowerAnswer) : void
      {
         obf_K_e_3075.obf_P_I_3025.changeValue(param1.power,3);
      }
      
      private static function obf_a_d_1133(param1:IncubatorSaveAnswer) : void
      {
         obf_K_e_3075.obf_P_I_3025.setState(1);
         obf_K_e_3075.obf_P_I_3025.setHaveItems(param1.haveItems);
         obf_K_e_3075.obf_P_I_3025.obf_y_U_4137();
         obf_K_e_3075.obf_P_I_3025.changeValue(param1.pressure,1);
         obf_K_e_3075.obf_P_I_3025.changeValue(param1.temp,2);
         obf_K_e_3075.obf_P_I_3025.changeValue(param1.power,3);
      }
      
      private static function obf_f_h_4330(param1:IncubatorChangePressureTempNotify) : void
      {
         obf_K_e_3075.obf_P_I_3025.changeValue(param1.pressure,1);
         obf_K_e_3075.obf_P_I_3025.changeValue(param1.temp,2);
      }
      
      private static function obf_B_a_3206(param1:IncubatorInfoNotify) : void
      {
         obf_K_e_3075.obf_P_I_3025.setState(param1.state);
         if(param1.state == 1)
         {
            obf_K_e_3075.obf_P_I_3025.initView();
         }
         else if(param1.state == 2)
         {
            obf_K_e_3075.obf_P_I_3025.setItemCode(param1.itemCode);
         }
         else if(param1.state == 3)
         {
            obf_K_e_3075.obf_P_I_3025.setItemCode(param1.itemCode);
            obf_K_e_3075.obf_P_I_3025.setEndTime(param1.endTime);
         }
         else if(param1.state == 4)
         {
            obf_K_e_3075.obf_P_I_3025.setItemCode(param1.itemCode);
            obf_K_e_3075.obf_P_I_3025.setEndTime(param1.endTime);
            obf_K_e_3075.obf_P_I_3025.incubatorResult(true);
         }
         else if(param1.state == 5)
         {
            obf_K_e_3075.obf_P_I_3025.setItemCode(param1.itemCode);
            obf_K_e_3075.obf_P_I_3025.incubatorResult(false);
         }
         obf_K_e_3075.obf_P_I_3025.changeValue(param1.pressure,1);
         obf_K_e_3075.obf_P_I_3025.changeValue(param1.temp,2);
         obf_K_e_3075.obf_P_I_3025.changeValue(param1.power,3);
         obf_K_e_3075.obf_P_I_3025.setHaveItems(param1.haveItems);
      }
      
      private static function obf_0_6_P_647(param1:IncubatorStateNotify) : void
      {
         obf_K_e_3075.obf_P_I_3025.setState(param1.state);
      }
      
      public static function sendTakeRequest() : void
      {
         var _loc1_:IncubatorTakeRequest = new IncubatorTakeRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendNoRequest() : void
      {
         var _loc1_:IncubatorNoRequest = new IncubatorNoRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendDoRequest() : void
      {
         var _loc1_:IncubatorDoRequest = new IncubatorDoRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendOverRequest() : void
      {
         var _loc1_:IncubatorOverRequest = new IncubatorOverRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendSaveRequest() : void
      {
         var _loc1_:IncubatorSaveRequest = new IncubatorSaveRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendPressureRequest() : void
      {
         var _loc1_:IncubatorPressureRequest = new IncubatorPressureRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendTempRequest() : void
      {
         var _loc1_:IncubatorTempRequest = new IncubatorTempRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendPowerRequest() : void
      {
         var _loc1_:IncubatorPowerRequest = new IncubatorPowerRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
   }
}

