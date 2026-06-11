package com.sunweb.game.rpg.activity
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.shop.ShopManager;
   import com.sunweb.game.rpg.world.map.MapManager;
   import com.sunweb.game.rpg.worldZone.command.activity.ActivityCheckAllNotify;
   import com.sunweb.game.rpg.worldZone.command.activity.ActivityCheckOneNotify;
   import com.sunweb.game.rpg.worldZone.command.activity.CommandCodeActivity;
   import com.sunweb.game.rpg.worldZone.command.activity.PayMarkActivityNotify;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_J_F_3431
   {
      
      public static var activityList:Array;
      
      private static var activityConfig:Object;
      
      private static var activityTypeConfig:Object;
      
      public static var activities:Object = new Object();
      
      public function obf_J_F_3431()
      {
         super();
      }
      
      public static function init(param1:Array) : void
      {
         var _loc2_:Object = null;
         activityConfig = new Object();
         activityTypeConfig = new Object();
         activityList = param1;
         activityList.sortOn("listOrder",Array.NUMERIC);
         for each(_loc2_ in param1)
         {
            activityConfig[_loc2_.activityCode] = _loc2_;
            if(!activityTypeConfig[_loc2_.activityType])
            {
               activityTypeConfig[_loc2_.activityType] = new Array();
            }
            activityTypeConfig[_loc2_.activityType].push(_loc2_);
         }
      }
      
      public static function getActConfig(param1:String) : Object
      {
         return activityConfig[param1];
      }
      
      public static function getTypeList() : Array
      {
         var _loc2_:String = null;
         var _loc1_:Array = new Array();
         for(_loc2_ in activityTypeConfig)
         {
            _loc1_.push(_loc2_);
         }
         _loc1_.sort();
         return _loc1_;
      }
      
      public static function getTypeConfig(param1:String) : Array
      {
         return JSONUtil.getObject(activityTypeConfig,[param1]) as Array;
      }
      
      public static function obf_U_Q_3887(param1:Array) : Boolean
      {
         var _loc2_:String = null;
         for each(_loc2_ in param1)
         {
            if(activities[_loc2_] == true)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function obf_4_4696(param1:String) : Boolean
      {
         if(activities[param1] == true)
         {
            return true;
         }
         return false;
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeActivity.ACTIVITY_CHECK_ALL_NOTIFY)
         {
            obf_u_N_2600(param1 as ActivityCheckAllNotify);
         }
         else if(param1.code == CommandCodeActivity.ACTIVITY_CHECK_ONE_NOTIFY)
         {
            obf_F_C_1683(param1 as ActivityCheckOneNotify);
         }
         else if(param1.code == CommandCodeActivity.PAY_MARK_ACTIVITY_NOTIFY)
         {
            obf_m_B_3162(param1 as PayMarkActivityNotify);
         }
      }
      
      private static function obf_u_N_2600(param1:ActivityCheckAllNotify) : void
      {
         var _loc2_:String = null;
         for(_loc2_ in param1.activities)
         {
            activities[_loc2_] = param1.activities[_loc2_];
         }
         obf_K_e_3075.activityUI.refreshList();
         if(obf_K_e_3075.smallMapUI)
         {
            obf_K_e_3075.smallMapUI.setSpecially();
         }
      }
      
      private static function obf_F_C_1683(param1:ActivityCheckOneNotify) : void
      {
         activities[param1.activityCode] = param1.isActive;
         MapManager.instance.obf_5_G_1974();
         obf_K_e_3075.activityUI.refreshList();
         if(obf_K_e_3075.smallMapUI)
         {
            obf_K_e_3075.smallMapUI.setSpecially();
         }
      }
      
      private static function obf_m_B_3162(param1:PayMarkActivityNotify) : void
      {
         ShopManager.obf_a_G_767 = param1.isValid;
         ShopManager.payGoodsObject = param1.items;
         ShopManager.obf_4_E_4448 = param1.dateFrom;
         ShopManager.obf_3_A_2009 = param1.dateTo;
         if(obf_K_e_3075.obf_N_i_3901.selectedType == ShopManager.obf_R_c_3073)
         {
            obf_K_e_3075.obf_N_i_3901.showShop(ShopManager.getStoreItemListByKind(ShopManager.obf_R_c_3073),1,true);
            obf_K_e_3075.obf_N_i_3901.obf_d_6_3571();
         }
         if(obf_K_e_3075.newShopBoxUI.selectedType == ShopManager.obf_R_c_3073)
         {
            obf_K_e_3075.newShopBoxUI.showShop(ShopManager.getStoreItemListByKind(ShopManager.obf_R_c_3073),1,true);
            obf_K_e_3075.newShopBoxUI.obf_d_6_3571();
         }
      }
   }
}

