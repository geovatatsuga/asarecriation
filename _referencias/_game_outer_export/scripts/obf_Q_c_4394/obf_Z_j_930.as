package obf_Q_c_4394
{
   import obf_g_A_3629.ChatDecoder;
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.player.reward.*;
   import com.sunweb.game.rpg.worldZone.command.task.PlayerAbortTaskRequest;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_Z_j_930
   {
      
      public static var _rewardConfig:Object;
      
      public function obf_Z_j_930()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         _rewardConfig = new Object();
         _rewardConfig = param1;
      }
      
      public static function get obf_0_9_J_142() : Object
      {
         return JSONUtil.getObject(_rewardConfig,["openCondition"]);
      }
      
      public static function get obf_0_y_1225() : Array
      {
         return JSONUtil.getValue(_rewardConfig,["playerInfo"]) as Array;
      }
      
      public static function get obf_K_M_4503() : Array
      {
         return JSONUtil.getValue(_rewardConfig,["allExps"]) as Array;
      }
      
      public static function get obf_R_O_1021() : Object
      {
         return JSONUtil.getObject(_rewardConfig,["cityDayNum"]);
      }
      
      public static function get obf_q_9_2529() : Object
      {
         return JSONUtil.getObject(_rewardConfig,["dayInNum"]);
      }
      
      public static function get obf_0_4_2_272() : Object
      {
         return JSONUtil.getObject(_rewardConfig,["dayOutNum"]);
      }
      
      public static function get rewardAddAllExpItems() : Object
      {
         return JSONUtil.getObject(_rewardConfig,["addAllExpItems"]);
      }
      
      public static function get obf_b_V_2840() : Object
      {
         return JSONUtil.getObject(_rewardConfig,["addAllAward"]);
      }
      
      public static function getNum(param1:int, param2:Object) : int
      {
         var _loc5_:* = undefined;
         if(!param2)
         {
            return 0;
         }
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         for(_loc5_ in param2)
         {
            if(_loc4_ <= _loc5_ && param1 >= _loc5_)
            {
               _loc4_ = _loc5_;
               _loc3_ = int(param2[_loc5_]);
            }
         }
         return _loc3_;
      }
      
      public static function get obf_Q_X_1278() : String
      {
         return JSONUtil.getStr(_rewardConfig,["dayNumSign"]);
      }
      
      public static function get rewardOverItems() : Object
      {
         return JSONUtil.getObject(_rewardConfig,["overItems"]);
      }
      
      public static function get obf_u_R_4060() : Array
      {
         return JSONUtil.getValue(_rewardConfig,["allTasks"]) as Array;
      }
      
      public static function rewardAllTaskConfig(param1:int) : Object
      {
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc2_:Array = obf_u_R_4060;
         if(!_loc2_)
         {
            return null;
         }
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_)
            {
               _loc4_ = JSONUtil.getValue(_loc3_,["taskConfig"]) as Array;
               if(_loc4_)
               {
                  for each(_loc5_ in _loc4_)
                  {
                     if(_loc5_)
                     {
                        _loc6_ = JSONUtil.getInt(_loc5_,["id"]);
                        if(_loc6_ == param1)
                        {
                           return _loc5_;
                        }
                     }
                  }
               }
            }
         }
         return null;
      }
      
      public static function get obf_8_a_1746() : Array
      {
         return JSONUtil.getValue(_rewardConfig,["playerTasks"]) as Array;
      }
      
      public static function rewardPlayerTaskByStar(param1:int) : Object
      {
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         var _loc2_:Array = obf_8_a_1746;
         if(!_loc2_)
         {
            return null;
         }
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = JSONUtil.getInt(_loc3_,["star"]);
            if(_loc4_ == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public static function get rewardShopConfig() : Array
      {
         return JSONUtil.getValue(_rewardConfig,["shopConfig"]) as Array;
      }
      
      public static function get rewardSuccessConfig() : Object
      {
         return JSONUtil.getObject(_rewardConfig,["successConfig"]);
      }
      
      public static function get obf_5_J_1995() : Array
      {
         var _loc1_:Object = rewardSuccessConfig;
         if(!_loc1_)
         {
            return null;
         }
         return JSONUtil.getValue(_loc1_,["successMap"]) as Array;
      }
      
      public static function insertLink(param1:String, param2:String) : String
      {
         var _loc3_:String = param1;
         param1 = param1.substring(1,param1.length - 1);
         var _loc4_:Array = param1.split("^");
         if(_loc4_.length < 2)
         {
            return "";
         }
         var _loc5_:String = getFinallyLinkCode(_loc3_);
         _loc5_ = _loc5_.substring(1,_loc5_.length - 1);
         return "[<FONT COLOR=\'#" + param2 + "\'><A HREF=\"event:" + _loc5_ + "\"><U>" + _loc4_[1] + "</U></A></FONT>]";
      }
      
      public static function getFinallyLinkCode(param1:String) : String
      {
         var _loc6_:int = 0;
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:String = param1.substring(1,param1.length - 1);
         var _loc3_:Array = _loc2_.split("^");
         if(_loc3_.length < 2)
         {
            return _loc2_;
         }
         var _loc4_:String = "";
         var _loc5_:String = "";
         if(_loc3_.length == 2 && _loc3_[0] == ChatDecoder.obf_W_v_983)
         {
            _loc5_ = "^" + _loc3_[1];
         }
         if(_loc3_.length > 2)
         {
            _loc6_ = 2;
            while(_loc6_ < _loc3_.length)
            {
               _loc5_ = _loc5_ + "^" + _loc3_[_loc6_];
               _loc6_++;
            }
         }
         if(_loc3_[0] == ChatDecoder.obf_d_Y_2785)
         {
            _loc4_ = _loc3_[0] + _loc5_;
         }
         else
         {
            _loc4_ = _loc3_[0] + "^" + _loc3_[1] + _loc5_;
         }
         return "[" + _loc4_ + "]";
      }
      
      public static function getItemLinkCode(param1:String, param2:String, param3:String = null) : String
      {
         if(param3 == null)
         {
            param3 = "";
         }
         param3 = param3 == "" ? param3 : "^" + param3;
         param1 = param1.replace(new RegExp(/'/g),"");
         param1 = param1.replace(new RegExp(/\"/g),"");
         var _loc4_:String = "[" + ChatDecoder.obf_d_Y_2785 + "^" + param1 + "^" + param2 + param3 + "]";
         var _loc5_:Object = GameItemManager.getItemConfig(param2);
         if(!_loc5_)
         {
            return "";
         }
         var _loc6_:int = GameItemRank.getRankColor(_loc5_.rank);
         return insertLink(_loc4_,_loc6_.toString(16));
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeReward.REWARD_PLAYER_INFO_NOTIFY)
         {
            obf_O_9_1441(param1 as RewardPlayerInfoNotify);
         }
         else if(param1.code == CommandCodeReward.REWARD_ALL_INFO_NOTIFY)
         {
            obf_E_Y_2021(param1 as RewardAllInfoNotify);
         }
         else if(param1.code == CommandCodeReward.REWARD_OVER_AWARD_ANSWER)
         {
            obf_u_q_2432(param1 as RewardOverAwardAnswer);
         }
         else if(param1.code == CommandCodeReward.REWARD_ALL_TASK_NOTIFY)
         {
            obf_B_E_4575(param1 as RewardAllTaskNotify);
         }
         else if(param1.code == CommandCodeReward.REWARD_PLAYER_TASK_NOTIFY)
         {
            obf_k_R_1146(param1 as RewardPlayerTaskNotify);
         }
         else if(param1.code == CommandCodeReward.REWARD_SUCCESS_NOTIFY)
         {
            obf_T_i_3786(param1 as RewardSuccessNotify);
         }
         else if(param1.code == CommandCodeReward.REWARD_PLAYER_AWARD_ANSWER)
         {
            obf_l_c_1654(param1 as RewardPlayerAwardAnswer);
         }
      }
      
      public static function obf_O_9_1441(param1:RewardPlayerInfoNotify) : void
      {
         if(param1.rank < 1)
         {
            return;
         }
         obf_K_e_3075.obf_w_0_3587.setRank(param1.rank);
         obf_K_e_3075.obf_w_0_3587.setLevel(param1.level);
         obf_K_e_3075.obf_w_0_3587.setExp(param1.exp);
         obf_K_e_3075.obf_w_0_3587.obf_4_j_1878();
         obf_K_e_3075.obf_w_0_3587.obf_c_l_a_s_s_99();
         obf_K_e_3075.obf_w_0_3587.refreshDoingTask();
      }
      
      public static function obf_E_Y_2021(param1:RewardAllInfoNotify) : void
      {
         var _loc2_:Boolean = false;
         if(obf_K_e_3075.obf_w_0_3587.getAllLevel != param1.level)
         {
            obf_K_e_3075.obf_w_0_3587.setAllLevel(param1.level);
            _loc2_ = true;
         }
         obf_K_e_3075.obf_w_0_3587.setAllExp(param1.exp);
         obf_K_e_3075.obf_w_0_3587.obf_v_z_4602();
         if(_loc2_)
         {
            obf_K_e_3075.obf_0_8_g_462.obf_p_d_982();
            obf_K_e_3075.obf_F_e_3603.obf_p_9_2847();
            obf_K_e_3075.obf_F_e_3603.obf_Y_G_1757();
         }
      }
      
      public static function obf_u_q_2432(param1:RewardOverAwardAnswer) : void
      {
         obf_K_e_3075.obf_w_0_3587.obf_c_l_a_s_s_99();
      }
      
      public static function obf_B_E_4575(param1:RewardAllTaskNotify) : void
      {
         obf_K_e_3075.obf_0_8_g_462.setTasks(param1.tasks);
         if(param1.isUpdate)
         {
            obf_K_e_3075.obf_0_8_g_462.obf_p_d_982();
         }
         else
         {
            obf_K_e_3075.obf_0_8_g_462.obf_L_T_4072();
         }
      }
      
      public static function obf_k_R_1146(param1:RewardPlayerTaskNotify) : void
      {
         if(param1.refreshIn)
         {
            obf_K_e_3075.obf_F_e_3603.obf_p_9_2847();
         }
         if(param1.refreshOut)
         {
            obf_K_e_3075.obf_F_e_3603.obf_Y_G_1757();
         }
         if(param1.isOut)
         {
            obf_K_e_3075.obf_w_0_3587.setExp(param1.awardExp);
            obf_K_e_3075.obf_w_0_3587.obf_4_j_1878();
            WindowManager.showMessageBox(DiversityManager.getString("rewardPlayerTaskBoxUI","successOut"));
         }
         obf_K_e_3075.obf_F_e_3603.refreshPlayerTask();
      }
      
      public static function obf_T_i_3786(param1:RewardSuccessNotify) : void
      {
         obf_K_e_3075.obf_0___i_152.setPlayerSpArray(param1.playerSp);
         obf_K_e_3075.obf_0___i_152.setAllSpArray(param1.allSp);
         obf_K_e_3075.obf_0___i_152.obf_V_T_3922();
      }
      
      public static function obf_l_c_1654(param1:RewardPlayerAwardAnswer) : void
      {
         obf_K_e_3075.obf_w_0_3587.refreshPlayerAwardButton();
      }
      
      public static function obf_b_o_3822() : void
      {
         var _loc1_:RewardPlayerAwardRequest = new RewardPlayerAwardRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function obf_0_2_T_701() : void
      {
         var _loc1_:RewardAddAllExpRequest = new RewardAddAllExpRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function obf_7_3_2334(param1:int) : void
      {
         var _loc2_:RewardOverAwardRequest = new RewardOverAwardRequest();
         _loc2_.type = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function onPlayerFinishTaskRequest(param1:int) : void
      {
         var _loc2_:RewardFinishTaskRequest = new RewardFinishTaskRequest();
         _loc2_.taskId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function obf_7_Z_4139(param1:int) : void
      {
         var _loc2_:PlayerAbortTaskRequest = new PlayerAbortTaskRequest();
         _loc2_.taskId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function obf_Z_3_3453(param1:int) : void
      {
         var _loc2_:RewardAllTaskRequest = new RewardAllTaskRequest();
         _loc2_.taskId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function obf_U_c_3615(param1:int) : void
      {
         var _loc2_:RewardPlayerInTaskRequest = new RewardPlayerInTaskRequest();
         _loc2_.star = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function obf_0_2_h_82(param1:int) : void
      {
         var _loc2_:RewardPlayerOutTaskRequest = new RewardPlayerOutTaskRequest();
         _loc2_.star = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function obf_N_4662(param1:String) : void
      {
         var _loc2_:RewardShopBuyRequest = new RewardShopBuyRequest();
         _loc2_.itemCode = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function obf_U_S_3574(param1:int) : void
      {
         var _loc2_:RewardPlayerSpRequest = new RewardPlayerSpRequest();
         _loc2_.spType = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function obf_B_h_4055(param1:int) : void
      {
         var _loc2_:RewardAllSpRequest = new RewardAllSpRequest();
         _loc2_.spType = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function onRefreshRewardTaskList(param1:int) : void
      {
         if(obf_K_e_3075.obf_w_0_3587.isRewardTask(param1))
         {
            obf_K_e_3075.obf_w_0_3587.refreshDoingTask();
         }
      }
      
      public static function obf_U_F_2878(param1:Array) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in param1)
         {
            if(_loc2_.itemFlag == obf_Z_j_930.obf_Q_X_1278)
            {
               obf_K_e_3075.obf_w_0_3587.obf_c_l_a_s_s_99();
               return;
            }
         }
      }
      
      public static function obf_0___O_56(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         for(_loc2_ in param1)
         {
            if(obf_K_e_3075.obf_F_e_3603.isValid(_loc2_))
            {
               obf_K_e_3075.obf_F_e_3603.refreshPlayerTask();
            }
            _loc3_ = JSONUtil.getStr(obf_Z_j_930.rewardSuccessConfig,["allSpSign"]);
            if(_loc3_ == _loc2_)
            {
               obf_K_e_3075.obf_0___i_152.obf_h_X_832();
            }
         }
      }
      
      public static function obf_P_X_2520(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         for(_loc2_ in param1)
         {
            _loc3_ = JSONUtil.getStr(obf_Z_j_930.rewardSuccessConfig,["playerSpSign"]);
            if(_loc3_ == _loc2_)
            {
               obf_K_e_3075.obf_0___i_152.obf_H_j_1911();
            }
         }
      }
   }
}

