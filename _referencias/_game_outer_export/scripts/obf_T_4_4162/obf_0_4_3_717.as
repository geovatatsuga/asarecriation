package obf_T_4_4162
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.forgeGod.CommandCodeForgeGod;
   import com.sunweb.game.rpg.worldZone.command.forgeGod.ForgeGodInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.forgeGod.ForgeGodRequest;
   import com.sunweb.game.rpg.worldZone.command.forgeGod.ForgeGodToMapRequest;
   import com.sunweb.game.rpg.worldZone.command.forgeGod.ForgeGodValueNotify;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_0_4_3_717
   {
      
      private static var forgeGodConfig:Object;
      
      public function obf_0_4_3_717()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         forgeGodConfig = param1;
      }
      
      public static function get openCon() : Object
      {
         return JSONUtil.getObject(forgeGodConfig,["openCondition"]);
      }
      
      public static function get toMapCost() : Object
      {
         return JSONUtil.getObject(forgeGodConfig,["toMapCost"]);
      }
      
      public static function getNoChallgeMapIdList() : Array
      {
         var _loc1_:Array = JSONUtil.getValue(forgeGodConfig,["noEnterMap"]) as Array;
         if(_loc1_)
         {
            return _loc1_;
         }
         return new Array();
      }
      
      public static function getCanChallgeMapIdList() : Array
      {
         var _loc1_:Array = JSONUtil.getValue(forgeGodConfig,["enterMap"]) as Array;
         if(_loc1_)
         {
            return _loc1_;
         }
         return [];
      }
      
      public static function get maxLevel() : int
      {
         var _loc1_:Array = JSONUtil.getValue(forgeGodConfig,["levels"]) as Array;
         if(_loc1_)
         {
            return _loc1_.length;
         }
         return 0;
      }
      
      public static function getLevelConfig(param1:int) : Object
      {
         var _loc2_:Array = JSONUtil.getValue(forgeGodConfig,["levels"]) as Array;
         if(!_loc2_)
         {
            return null;
         }
         return _loc2_[param1];
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeForgeGod.FORGE_GOD_INFO_NOTIFY)
         {
            obf_p_l_4588(param1 as ForgeGodInfoNotify);
         }
         else if(param1.code == CommandCodeForgeGod.FORGE_GOD_VALUE_NOTIFY)
         {
            obf_y_B_3947(param1 as ForgeGodValueNotify);
         }
      }
      
      private static function obf_p_l_4588(param1:ForgeGodInfoNotify) : void
      {
         obf_K_e_3075.forgeGodUI.value = param1.value;
         obf_K_e_3075.forgeGodUI.level = param1.level;
         obf_K_e_3075.forgeGodUI.refresh();
      }
      
      private static function obf_y_B_3947(param1:ForgeGodValueNotify) : void
      {
         obf_K_e_3075.forgeGodUI.value = param1.value;
         obf_K_e_3075.forgeGodUI.obf_9_5_4194();
      }
      
      public static function obf_X_O_3513() : void
      {
         var _loc1_:ForgeGodToMapRequest = new ForgeGodToMapRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function obf_0_0_d_337() : void
      {
         var _loc1_:ForgeGodRequest = new ForgeGodRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
   }
}

