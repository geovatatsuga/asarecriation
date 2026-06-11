package obf_R_R_2172
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.rpg.worldZone.command.divine.CommandCodePlayerDivine;
   import com.sunweb.game.rpg.worldZone.command.divine.PlayerDivineLevelNotify;
   import com.sunweb.game.rpg.worldZone.command.divine.PlayerDivineUpLevelRequest;
   import com.sunweb.game.rpg.worldZone.command.divine.PlayerDivineValueNotify;
   import com.sunweb.game.rpg.worldZone.command.divine.PlayerEquipmentDivineAnswer;
   import com.sunweb.game.rpg.worldZone.command.divine.PlayerEquipmentDivineRequest;
   import com.sunweb.game.rpg.worldZone.command.divine.PlayerGetFreeItemRequest;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import playerUI.DivineIcon;
   
   public class obf_1_Y_1502
   {
      
      private static var divineConfig:Object;
      
      public static var obf_e_j_1724:String;
      
      public static var divineLevel:int;
      
      public static var divineValue:int;
      
      private static var $divineFreeTime:String = "$divineFree";
      
      public function obf_1_Y_1502()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         divineConfig = param1;
      }
      
      public static function getConfigValue(... rest) : *
      {
         return JSONUtil.getObject(divineConfig,rest);
      }
      
      public static function obf_X_W_3534() : String
      {
         return getConfigValue("itemCode");
      }
      
      public static function obf_S_O_3216() : int
      {
         return getConfigValue("freeTimes");
      }
      
      public static function divineLeveConfig() : Array
      {
         return getConfigValue("levelConfig");
      }
      
      public static function divineLeveAttrsConfig(param1:int) : Object
      {
         return getConfigValue("levelConfig")[param1 - 1];
      }
      
      public static function get dayTimes() : int
      {
         var _loc1_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter($divineFreeTime);
         return JSONUtil.getInt(_loc1_,["numOfDay"]);
      }
      
      public static function getIconDisplay() : DisplayObject
      {
         var _loc2_:DisplayObject = null;
         var _loc1_:Sprite = new Sprite();
         _loc2_ = new DivineIcon();
         _loc2_.x = _loc1_.width;
         _loc2_.scaleX = 0.4;
         _loc2_.scaleY = 0.4;
         _loc1_.addChild(_loc2_);
         return _loc1_;
      }
      
      public static function sendGetFreeItem() : void
      {
         var _loc1_:PlayerGetFreeItemRequest = new PlayerGetFreeItemRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendDivineUpLevel() : void
      {
         var _loc1_:PlayerDivineUpLevelRequest = new PlayerDivineUpLevelRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendEquipmentDivine(param1:String) : void
      {
         var _loc2_:PlayerEquipmentDivineRequest = new PlayerEquipmentDivineRequest();
         _loc2_.equipId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerDivine.PLAYER_EQUIPMENT_DIVINE_ANSWER)
         {
            obf_B_n_2501(param1 as PlayerEquipmentDivineAnswer);
         }
         else if(param1.code == CommandCodePlayerDivine.PLAYER_DIVINE_LEVEL_NOTIFY)
         {
            obf_g_r_3751(param1 as PlayerDivineLevelNotify);
         }
         else if(param1.code == CommandCodePlayerDivine.PLAYER_DIVINE_VALUE_NOTIFY)
         {
            obf_y_C_858(param1 as PlayerDivineValueNotify);
         }
      }
      
      private static function obf_B_n_2501(param1:PlayerEquipmentDivineAnswer) : void
      {
         obf_e_j_1724 = param1.equipId;
         obf_K_e_3075.obf_O_S_1448.clear();
         WindowManager.showMessageBox(DiversityManager.getString("DivineUI","divineSucceed"));
         GameItemInfoManager.removeItemInfo(param1.equipId);
      }
      
      private static function obf_g_r_3751(param1:PlayerDivineLevelNotify) : void
      {
         divineLevel = param1.divineLevel;
         obf_K_e_3075.obf_O_S_1448.obf_p_R_2702(param1.divineLevel);
      }
      
      private static function obf_y_C_858(param1:PlayerDivineValueNotify) : void
      {
         var _loc2_:int = 0;
         divineValue = param1.divineValue;
         if(obf_K_e_3075.obf_O_S_1448.divineValue != -1)
         {
            _loc2_ = obf_K_e_3075.obf_O_S_1448.divineValue - param1.divineValue;
            if(_loc2_ > 0)
            {
               obf_6_D_3816.print(DiversityManager.getString("DivineUI","allayDivineValue",[_loc2_]));
            }
            else if(_loc2_ < 0)
            {
               obf_6_D_3816.print(DiversityManager.getString("DivineUI","addDivineValue",[Math.abs(_loc2_)]));
            }
         }
         obf_K_e_3075.obf_O_S_1448.obf_D_s_3771(param1.divineValue);
      }
   }
}

