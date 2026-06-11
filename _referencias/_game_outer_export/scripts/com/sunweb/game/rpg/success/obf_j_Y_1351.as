package com.sunweb.game.rpg.success
{
   import obf_l_e_4270.obf_V_o_1214;
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.activity.obf_J_F_3431;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.script.DynamicVars;
   import com.sunweb.game.rpg.worldZone.command.success.CommandCodePlayerSuccess;
   import com.sunweb.game.rpg.worldZone.command.success.PlayerFinishSuccessNotify;
   import com.sunweb.game.rpg.worldZone.command.success.PlayerFinishSuccessRequest;
   import com.sunweb.game.rpg.worldZone.command.success.PlayerSuccessInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.success.WorldSuccessTimesAnswer;
   import com.sunweb.game.rpg.worldZone.command.success.WorldSuccessTimesRequest;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   
   public class obf_j_Y_1351
   {
      
      private static var obf_n_O_1899:int;
      
      private static var successMap:Object;
      
      private static var typeList:Array;
      
      private static var successRecorder:SuccessRecorder;
      
      private static var successVars:DynamicVars;
      
      private static var worldSuccessDoneMap:Object;
      
      public function obf_j_Y_1351()
      {
         super();
      }
      
      public static function init(param1:Array) : void
      {
         var _loc2_:Object = null;
         successMap = new Object();
         typeList = new Array();
         obf_n_O_1899 = 0;
         for each(_loc2_ in param1)
         {
            successMap[_loc2_.successId] = _loc2_;
            if(!obf_L_l_4100.isEmpty(_loc2_.kind) && typeList.indexOf(_loc2_.kind) <= -1)
            {
               typeList.push(_loc2_.kind);
            }
            ++obf_n_O_1899;
         }
         typeList.sort();
      }
      
      public static function get types() : Array
      {
         return typeList.concat();
      }
      
      public static function get successTotal() : int
      {
         return obf_n_O_1899;
      }
      
      public static function get doneSuccessTotal() : int
      {
         if(!successRecorder || !successRecorder.doneSuccesses)
         {
            return 0;
         }
         return successRecorder.doneSuccesses.length;
      }
      
      public static function get dynamicVars() : DynamicVars
      {
         return successVars;
      }
      
      public static function getSuccessConfigByType(param1:String) : Array
      {
         var _loc3_:Object = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in successMap)
         {
            if(!(!_loc3_ || Boolean(_loc3_.isDisabled)))
            {
               if(JSONUtil.getStr(_loc3_,["kind"]) == param1)
               {
                  _loc2_.push(_loc3_);
               }
            }
         }
         _loc2_.sortOn("successId");
         return _loc2_;
      }
      
      public static function getSuccessName(param1:int) : String
      {
         return JSONUtil.getStr(successMap,[param1,"name"]);
      }
      
      public static function getSuccessConfig(param1:int) : Object
      {
         return JSONUtil.getObject(successMap,[param1]);
      }
      
      public static function successIsDone(param1:int) : Boolean
      {
         if(!successRecorder || !successRecorder.doneSuccesses)
         {
            return false;
         }
         return successRecorder.doneSuccesses.indexOf(param1) > -1;
      }
      
      public static function get getWorldSuccessDoneMap() : Object
      {
         return worldSuccessDoneMap;
      }
      
      public static function getSuccessDoneTimesName(param1:int) : String
      {
         var _loc2_:int = JSONUtil.getInt(worldSuccessDoneMap,[param1]);
         var _loc3_:Array = [0,1,5,20,50,100,int.MAX_VALUE];
         var _loc4_:int = int(_loc3_.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.length)
         {
            if(_loc2_ <= _loc3_[_loc5_])
            {
               _loc4_ = _loc5_ + 1;
               break;
            }
            _loc5_++;
         }
         return DiversityManager.getString("SuccessUI","doneTimesLv" + _loc4_);
      }
      
      public static function obf_g_5_1840() : void
      {
         var _loc1_:Object = null;
         for each(_loc1_ in successMap)
         {
            if(!(!_loc1_ || Boolean(_loc1_.isDisabled)))
            {
               if(!successIsDone(_loc1_.successId))
               {
                  if(!(Boolean(_loc1_.activityForFinish) && !obf_J_F_3431.obf_U_Q_3887(_loc1_.activityForFinish)))
                  {
                     if(ConditionScript.checkCondition(JSONUtil.getObject(_loc1_,["condition"])))
                     {
                        sendFinishSuccess(_loc1_.successId);
                     }
                  }
               }
            }
         }
      }
      
      public static function sendViewWorldSuccessTimes() : void
      {
         var _loc1_:WorldSuccessTimesRequest = new WorldSuccessTimesRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendFinishSuccess(param1:int) : void
      {
         var _loc2_:PlayerFinishSuccessRequest = new PlayerFinishSuccessRequest();
         _loc2_.successId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerSuccess.PLAYER_SUCCESS_INFO_NOTIFY)
         {
            obf_d_k_1240(param1 as PlayerSuccessInfoNotify);
         }
         else if(param1.code == CommandCodePlayerSuccess.WORLD_SUCCESS_TIMES_ANSWER)
         {
            obf_j_K_2865(param1 as WorldSuccessTimesAnswer);
         }
         else if(param1.code == CommandCodePlayerSuccess.PLAYER_FINISH_SUCCESS_NOTIFY)
         {
            obf_Z_9_1873(param1 as PlayerFinishSuccessNotify);
         }
      }
      
      private static function obf_d_k_1240(param1:PlayerSuccessInfoNotify) : void
      {
         successRecorder = param1.successRecorder;
         successVars = param1.killedMonstersOfSuccess;
         obf_K_e_3075.successUI.obf_g_d_2160();
      }
      
      private static function obf_j_K_2865(param1:WorldSuccessTimesAnswer) : void
      {
         worldSuccessDoneMap = param1.successTimes;
         obf_K_e_3075.successUI.listSuccess.invalidateList();
      }
      
      private static function obf_Z_9_1873(param1:PlayerFinishSuccessNotify) : void
      {
         successRecorder.doneSuccesses.push(param1.successId);
         obf_K_e_3075.showUI(new obf_V_o_1214(obf_j_Y_1351.getSuccessName(param1.successId)));
         obf_K_e_3075.successUI.obf_g_d_2160();
         obf_6_D_3816.print(DiversityManager.getString("SuccessUI","prompt_SuccessDone",[obf_j_Y_1351.getSuccessName(param1.successId)]));
      }
   }
}

