package obf_5_S_2387
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.rpg.worldZone.command.map.tower.CommandCodeMapTower;
   import com.sunweb.game.rpg.worldZone.command.map.tower.MapTowerNotify;
   import com.sunweb.game.rpg.worldZone.command.tower.ClickLvUpTowerAnswer;
   import com.sunweb.game.rpg.worldZone.command.tower.ClickLvUpTowerRequest;
   import com.sunweb.game.rpg.worldZone.command.tower.CommandCodePlayerTower;
   import com.sunweb.game.rpg.worldZone.command.tower.EnterTowerRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_H_c_1383
   {
      
      private static var towerConfig:Object;
      
      private static var $freeDayTimes:String = "$freeDayTimes";
      
      private static var $chargeDayTimes:String = "$chargeDayTimes";
      
      public function obf_H_c_1383()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         towerConfig = param1;
      }
      
      public static function get towerList() : Array
      {
         return JSONUtil.getObject(towerConfig,["towerList"]) as Array;
      }
      
      public static function get pearlList() : Array
      {
         return JSONUtil.getObject(towerConfig,["pearlList"]) as Array;
      }
      
      public static function get allExp() : int
      {
         return JSONUtil.getInt(towerConfig,["allExp"]);
      }
      
      public static function get chargeItems() : Object
      {
         return JSONUtil.getObject(towerConfig,["chargeItems"]);
      }
      
      public static function get freeDayTimes() : int
      {
         var _loc1_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter($freeDayTimes);
         return JSONUtil.getInt(towerConfig,["freeDayTimes"]) - JSONUtil.getInt(_loc1_,["numOfDay"]);
      }
      
      public static function get chargeDayTimes() : int
      {
         var _loc1_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter($chargeDayTimes);
         return JSONUtil.getInt(towerConfig,["chargeDayTimes"]) - JSONUtil.getInt(_loc1_,["numOfDay"]);
      }
      
      public static function get obf_0___o_297() : Object
      {
         return JSONUtil.getObject(towerConfig,["enterCopyWorldCon"],new Object());
      }
      
      public static function getTowerObject(param1:int) : Object
      {
         var _loc3_:int = 0;
         if(!towerList)
         {
            return null;
         }
         var _loc2_:int = 0;
         while(_loc2_ < towerList.length)
         {
            if(JSONUtil.getInt(towerList[_loc2_],["exp"]) > param1)
            {
               _loc3_ = _loc2_ - 1;
               if(_loc3_ < 0)
               {
                  return null;
               }
               return towerList[_loc3_];
            }
            _loc2_++;
         }
         return towerList[towerList.length - 1];
      }
      
      public static function getPearlObject(param1:int) : Object
      {
         var _loc2_:Object = null;
         for each(_loc2_ in pearlList)
         {
            if(_loc2_.pearlType == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function sendEnterTower() : void
      {
         var _loc1_:EnterTowerRequest = new EnterTowerRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendTowerLvUp(param1:int) : void
      {
         var _loc2_:ClickLvUpTowerRequest = new ClickLvUpTowerRequest();
         _loc2_.characterIndex = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerTower.CLICK_LVUP_TOWER_ANSWER)
         {
            obf_k_S_1902(param1 as ClickLvUpTowerAnswer);
         }
         else if(param1.code == CommandCodeMapTower.MAP_TOWER_NOTIFY)
         {
            obf_f_0_1015(param1 as MapTowerNotify);
         }
      }
      
      private static function obf_k_S_1902(param1:ClickLvUpTowerAnswer) : void
      {
         GameContext.localPlayer.fullInfo.towerValue = param1.currValue;
         GameContext.localPlayer.fullInfo.pearlNumMap[param1.characterIndex] = param1.num;
         obf_K_e_3075.towerBoxUI.showData(param1.currValue);
         obf_K_e_3075.towerBoxUI.showEffect(param1.changeValue,param1.characterIndex);
      }
      
      private static function obf_f_0_1015(param1:MapTowerNotify) : void
      {
         obf_K_e_3075.closeUI(obf_K_e_3075.passBoxUI);
      }
   }
}

