package obf_q_S_2073
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.map.clear.CommandCodeMapClear;
   import com.sunweb.game.rpg.worldZone.command.map.clear.MapClearBonusAnswer;
   import com.sunweb.game.rpg.worldZone.command.map.clear.MapClearBonusRequest;
   import com.sunweb.game.rpg.worldZone.command.map.clear.MapClearInfoCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.map.clear.MapClearedDoMacroRequest;
   import com.sunweb.game.rpg.worldZone.command.map.clear.MapClearedNotify;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_O_a_3022
   {
      
      private static var configObj:Object = new Object();
      
      public function obf_O_a_3022()
      {
         super();
      }
      
      public static function setMapConfig(param1:String, param2:Object) : void
      {
         configObj[param1] = param2;
      }
      
      public static function getMapConfig(param1:String) : Object
      {
         return configObj[param1];
      }
      
      public static function obf_g_Q_1361(param1:Object) : void
      {
         obf_K_e_3075.closeUI(obf_K_e_3075.passBoxUI);
         var _loc2_:Object = JSONUtil.getObject(param1,["rules","clearRule"]);
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_.isEnabled)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.passBoxUI);
            obf_K_e_3075.passBoxUI.setClearRule(_loc2_,param1.id);
            setMapConfig(param1.id,_loc2_);
         }
      }
      
      public static function sendClearBonus(param1:String, param2:int) : void
      {
         var _loc3_:MapClearBonusRequest = new MapClearBonusRequest();
         _loc3_.mapId = param1;
         _loc3_.bonusIndex = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendLeave(param1:String) : void
      {
         var _loc2_:MapClearedDoMacroRequest = new MapClearedDoMacroRequest();
         _loc2_.mapId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeMapClear.MAP_CLEAR_INFO_CHECK_NOTIFY)
         {
            obf_K_e_3075.passBoxUI.obf_s_D_1287(param1 as MapClearInfoCheckNotify);
            obf_K_e_3075.obf_R_k_2832.obf_s_D_1287(param1 as MapClearInfoCheckNotify);
         }
         else if(param1.code == CommandCodeMapClear.MAP_CLEARED_NOTIFY)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.passBoxUI);
            obf_K_e_3075.obf_R_k_2832.checkCleared(param1 as MapClearedNotify);
         }
         else if(param1.code == CommandCodeMapClear.MAP_CLEAR_BONUS_ANSWER)
         {
            obf_K_e_3075.obf_R_k_2832.onBonusItems(param1 as MapClearBonusAnswer);
         }
      }
   }
}

