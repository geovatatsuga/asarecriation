package com.sunweb.game.rpg.onlineBonus
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.worldZone.command.onlineBonus.CommandCodeOnlineBonus;
   import com.sunweb.game.rpg.worldZone.command.onlineBonus.OfflineBonusCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.onlineBonus.OfflineBonusFetchRequest;
   import com.sunweb.game.rpg.worldZone.command.onlineBonus.OnlineBonusCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.onlineBonus.OnlineBonusFetchRequest;
   import com.sunweb.game.rpg.worldZone.command.onlineBonus.OnlineCoinCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.onlineBonus.OnlineCoinFetchRequest;
   import com.sunweb.game.rpg.worldZone.command.onlineBonus.obf_0_0_K_730;
   import com.sunweb.game.rpg.worldZone.command.onlineBonus.obf_0_4_d_641;
   import com.sunweb.game.rpg.worldZone.command.onlineBonus.obf_Z_k_3863;
   import com.sunweb.game.rpg.worldZone.command.onlineBonus.obf_o_4_1564;
   import com.sunweb.game.rpg.worldZone.command.onlineBonus.obf_f_i_n_a_l_l_y_27;
   import com.sunweb.game.util.TimeLimiter;
   
   public class obf_v_1_1352
   {
      
      private static var obf_a_B_2633:Array;
      
      private static var obf_O_1_2684:int;
      
      private static var obf_4_H_2718:TimeLimiter;
      
      private static var dayBonusAutoShowed:Boolean;
      
      public function obf_v_1_1352()
      {
         super();
      }
      
      public static function init(param1:Array) : void
      {
         obf_a_B_2633 = param1;
      }
      
      public static function get obf_z_D_1932() : TimeLimiter
      {
         return obf_4_H_2718;
      }
      
      public static function obf_0_G_4126() : Object
      {
         if(!obf_a_B_2633 || obf_O_1_2684 < 0 || obf_O_1_2684 >= obf_a_B_2633.length)
         {
            return null;
         }
         return obf_a_B_2633[obf_O_1_2684];
      }
      
      public static function obf_M_S_2137() : void
      {
         if(!obf_a_B_2633 || obf_O_1_2684 < 0 || obf_O_1_2684 >= obf_a_B_2633.length)
         {
            return;
         }
         if(!obf_4_H_2718 || obf_4_H_2718.totalTimeInMS < obf_4_H_2718.timelimit)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","cantFetchOnlineBonusNow"));
            return;
         }
         var _loc1_:Object = obf_a_B_2633[obf_O_1_2684];
         if(Boolean(_loc1_.condition) && !ConditionScript.checkCondition(_loc1_.condition,null,true))
         {
            return;
         }
         var _loc2_:OnlineBonusFetchRequest = new OnlineBonusFetchRequest();
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendGetOnlineCoin() : void
      {
         var _loc1_:OnlineCoinFetchRequest = new OnlineCoinFetchRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function obf_D_V_3352(param1:int) : void
      {
         var _loc2_:OfflineBonusFetchRequest = new OfflineBonusFetchRequest();
         _loc2_.expMul = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendDayHortation() : void
      {
         var _loc1_:obf_0_4_d_641 = new obf_0_4_d_641();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendRunHortation() : void
      {
         var _loc1_:obf_0_0_K_730 = new obf_0_0_K_730();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendBoon() : void
      {
         var _loc1_:obf_o_4_1564 = new obf_o_4_1564();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeOnlineBonus.ONLINE_BONUS_CHECK_NOTIFY)
         {
            obf_4_w_1759(param1 as OnlineBonusCheckNotify);
         }
         else if(param1.code == CommandCodeOnlineBonus.ONLINE_COIN_CHECK_NOTIFY)
         {
            obf_s_y_3169(param1 as OnlineCoinCheckNotify);
         }
         else if(param1.code == CommandCodeOnlineBonus.OFFLINE_BONUS_CHECK_NOTIFY)
         {
            obf_j_Q_1260(param1 as OfflineBonusCheckNotify);
         }
         else if(param1.code == CommandCodeOnlineBonus.obf_0_8_k_656)
         {
            obf_n_y_2194(param1 as obf_Z_k_3863);
         }
         else if(param1.code == CommandCodeOnlineBonus.obf_0_0_W_474)
         {
            obf_v_x_3271(param1 as obf_f_i_n_a_l_l_y_27);
         }
      }
      
      private static function obf_4_w_1759(param1:OnlineBonusCheckNotify) : void
      {
         obf_O_1_2684 = param1.bonusIndex;
         if(obf_K_e_3075.smallMapUI)
         {
            if(param1.afterTimeInSec >= 0 && param1.bonusIndex >= 0)
            {
               obf_K_e_3075.smallMapUI.showOnlineBonus(param1.afterTimeInSec);
               obf_4_H_2718 = new TimeLimiter(param1.afterTimeInSec * 1000);
            }
            else
            {
               obf_K_e_3075.smallMapUI.disableOnlineBonus();
               obf_4_H_2718 = null;
            }
            obf_K_e_3075.onlineBonusUI.showOnlineBonus();
         }
      }
      
      private static function obf_s_y_3169(param1:OnlineCoinCheckNotify) : void
      {
         obf_K_e_3075.dayBonusUI.coinBonus = param1.bonusCoin;
         obf_K_e_3075.obf_1_p_1763.coinBonus = param1.bonusCoin;
      }
      
      private static function obf_j_Q_1260(param1:OfflineBonusCheckNotify) : void
      {
         obf_K_e_3075.dayBonusUI.offlineExp = param1.exp;
         obf_K_e_3075.dayBonusUI.setOfflineTime(param1.offlineHours);
         obf_K_e_3075.obf_N_5_4623.offlineExp = param1.exp;
         obf_K_e_3075.obf_N_5_4623.setOfflineTime(param1.offlineHours);
         if(param1.offlineHours >= 3 && !dayBonusAutoShowed)
         {
            if(!WorldConfig.getValue("functionSwitch","onlineBonus"))
            {
               if(WorldConfig.getValue("functionSwitch","showNewLoginReward"))
               {
                  if(!obf_K_e_3075.obf_r_d_3196)
                  {
                     return;
                  }
                  if(obf_K_e_3075.obf_r_d_3196.visible)
                  {
                     obf_K_e_3075.closeUI(obf_K_e_3075.obf_r_d_3196);
                  }
                  else
                  {
                     obf_K_e_3075.showUI(obf_K_e_3075.obf_r_d_3196);
                     obf_K_e_3075.obf_r_d_3196.openTab3();
                  }
               }
               else
               {
                  if(!obf_K_e_3075.dayBonusUI)
                  {
                     return;
                  }
                  if(obf_K_e_3075.dayBonusUI.visible)
                  {
                     obf_K_e_3075.closeUI(obf_K_e_3075.dayBonusUI);
                  }
                  else
                  {
                     obf_K_e_3075.showUI(obf_K_e_3075.dayBonusUI);
                  }
               }
            }
            dayBonusAutoShowed = true;
         }
      }
      
      private static function obf_n_y_2194(param1:obf_Z_k_3863) : void
      {
         obf_K_e_3075.obf_S_w_2923.upData(param1.consecutiveLoginDays,param1.boonItemCode);
      }
      
      private static function obf_v_x_3271(param1:obf_f_i_n_a_l_l_y_27) : void
      {
         obf_K_e_3075.obf_S_w_2923.upDayData();
      }
   }
}

