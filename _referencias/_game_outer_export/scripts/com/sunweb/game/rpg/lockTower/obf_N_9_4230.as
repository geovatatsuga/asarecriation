package com.sunweb.game.rpg.lockTower
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.lockTower.CommandCodeLockTower;
   import com.sunweb.game.rpg.worldZone.command.lockTower.LockTowerAddFloorAnswer;
   import com.sunweb.game.rpg.worldZone.command.lockTower.LockTowerAddFloorRequest;
   import com.sunweb.game.rpg.worldZone.command.lockTower.LockTowerBuffRequest;
   import com.sunweb.game.rpg.worldZone.command.lockTower.LockTowerEatRequest;
   import com.sunweb.game.rpg.worldZone.command.lockTower.LockTowerFreeRequest;
   import com.sunweb.game.rpg.worldZone.command.lockTower.LockTowerInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.lockTower.LockTowerUpRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_N_9_4230
   {
      
      private static var config:Object = new Object();
      
      public function obf_N_9_4230()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         config = param1;
      }
      
      public static function obf_s_4_4089() : int
      {
         return JSONUtil.getInt(config,["allFloor"]);
      }
      
      public static function levelList() : Array
      {
         return JSONUtil.getValue(config,["levelList"]) as Array;
      }
      
      public static function itemCode() : String
      {
         return JSONUtil.getStr(config,["itemCode"]);
      }
      
      public static function addFloorItem() : String
      {
         return JSONUtil.getStr(config,["addFloorItem"]);
      }
      
      public static function addFloorNum() : int
      {
         return JSONUtil.getInt(config,["addFloorNum"]);
      }
      
      public static function obf_L_A_4035(param1:String) : String
      {
         var _loc4_:String = null;
         var _loc2_:Array = JSONUtil.getValue(config,["relationConfig"]) as Array;
         if(!_loc2_)
         {
            return null;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = JSONUtil.getStr(_loc2_[_loc3_],["itemCode"]);
            if(param1 == _loc4_)
            {
               return JSONUtil.getStr(_loc2_[_loc3_],["monsterCode"]);
            }
            _loc3_++;
         }
         return null;
      }
      
      public static function obf_R_Y_4105(param1:String) : String
      {
         var _loc4_:String = null;
         var _loc2_:Array = JSONUtil.getValue(config,["relationConfig"]) as Array;
         if(!_loc2_)
         {
            return null;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = JSONUtil.getStr(_loc2_[_loc3_],["monsterCode"]);
            if(param1 == _loc4_)
            {
               return JSONUtil.getStr(_loc2_[_loc3_],["itemCode"]);
            }
            _loc3_++;
         }
         return null;
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeLockTower.LOCK_TOWER_INFO_NOTIFY)
         {
            obf_L_4_2450(param1 as LockTowerInfoNotify);
         }
         if(param1.code == CommandCodeLockTower.LOCK_TOWER_ADD_FLOOR_ANSWER)
         {
            obf_M_s_1386(param1 as LockTowerAddFloorAnswer);
         }
      }
      
      public static function obf_L_4_2450(param1:LockTowerInfoNotify) : void
      {
         var _loc2_:* = undefined;
         if(!param1)
         {
            return;
         }
         if(param1.isAll)
         {
            obf_K_e_3075.lockTowerUI.setTowerMap(param1.lockTower);
         }
         else
         {
            for each(_loc2_ in param1.lockTower)
            {
               obf_K_e_3075.lockTowerUI.setTowerMapOne(_loc2_ as LockTowerInfo);
            }
         }
      }
      
      public static function obf_M_s_1386(param1:LockTowerAddFloorAnswer) : void
      {
         obf_K_e_3075.lockTowerUI.setOpenFloor(param1.lockTowerInfo.floor);
         obf_K_e_3075.lockTowerUI.setTowerMapOne(param1.lockTowerInfo);
      }
      
      public static function obf_7_w_1560(param1:int) : void
      {
         var _loc2_:LockTowerBuffRequest = new LockTowerBuffRequest();
         _loc2_.floor = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function obf_E_a_1328(param1:int, param2:String) : void
      {
         var _loc3_:LockTowerEatRequest = new LockTowerEatRequest();
         _loc3_.floor = param1;
         _loc3_.itemCode = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function obf_X_U_2834(param1:int, param2:String, param3:int) : void
      {
         var _loc4_:LockTowerUpRequest = new LockTowerUpRequest();
         _loc4_.floor = param1;
         _loc4_.itemCode = param2;
         _loc4_.num = param3;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public static function obf_c_a_t_c_h_529(param1:int) : void
      {
         var _loc2_:LockTowerFreeRequest = new LockTowerFreeRequest();
         _loc2_.floor = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function obf_f_6_2285() : void
      {
         var _loc1_:LockTowerAddFloorRequest = new LockTowerAddFloorRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
   }
}

