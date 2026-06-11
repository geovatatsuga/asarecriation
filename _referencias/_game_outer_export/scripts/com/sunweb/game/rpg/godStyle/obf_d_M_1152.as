package com.sunweb.game.rpg.godStyle
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.godStyle.CommandCodeGodStyle;
   import com.sunweb.game.rpg.worldZone.command.godStyle.GodStyleNotify;
   import com.sunweb.game.rpg.worldZone.command.godStyle.GodStyleRankNotify;
   import com.sunweb.game.rpg.worldZone.command.godStyle.GodStyleUpRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_d_M_1152
   {
      
      public static var _config:Object;
      
      public function obf_d_M_1152()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         _config = new Object();
         _config = param1;
      }
      
      public static function get openCon() : Object
      {
         return JSONUtil.getObject(_config,["openCondition"]);
      }
      
      public static function getGodStyleConfig(param1:int) : Array
      {
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc2_:Array = JSONUtil.getValue(_config,["styleList"]) as Array;
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = JSONUtil.getInt(_loc3_,["type"]);
            if(param1 == _loc4_)
            {
               return JSONUtil.getValue(_loc3_,["styles"]) as Array;
            }
         }
         return null;
      }
      
      public static function getStyleConfig(param1:String) : Object
      {
         var _loc3_:* = undefined;
         var _loc4_:Array = null;
         var _loc5_:* = undefined;
         var _loc6_:String = null;
         var _loc2_:Array = JSONUtil.getValue(_config,["styleList"]) as Array;
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = JSONUtil.getValue(_loc3_,["styles"]) as Array;
            for each(_loc5_ in _loc4_)
            {
               _loc6_ = JSONUtil.getStr(_loc5_,["id"]);
               if(param1 == _loc6_)
               {
                  return _loc5_;
               }
            }
         }
         return null;
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeGodStyle.GOD_STYLE_NOTIFY)
         {
            obf_0_9_I_280(param1 as GodStyleNotify);
         }
         else if(param1.code == CommandCodeGodStyle.GOD_STYLE_RANK_NOTIFY)
         {
            obf_c_Q_4339(param1 as GodStyleRankNotify);
         }
      }
      
      public static function obf_0_9_I_280(param1:GodStyleNotify) : void
      {
         var _loc2_:* = undefined;
         if(!param1 || !param1.godStyleId)
         {
            return;
         }
         obf_K_e_3075.godStyleUI.setGodStyleMap(param1.godStyleId,param1.godStyleLevel);
         if(obf_K_e_3075.godStyleUI.ids)
         {
            _loc2_ = obf_K_e_3075.godStyleUI.ids[param1.godStyleId];
            if(_loc2_ != 0 && !_loc2_)
            {
               return;
            }
            obf_K_e_3075.godStyleUI.refreshItem(param1.godStyleId);
            obf_K_e_3075.godStyleUI.obf_n_n_1093(param1.godStyleId);
            obf_K_e_3075.godStyleUI.obf_e_x_t_e_n_d_s_32(obf_K_e_3075.godStyleUI.type);
         }
      }
      
      public static function obf_c_Q_4339(param1:GodStyleRankNotify) : void
      {
         if(!param1 || !param1.godStyleId || !param1.rankList)
         {
            return;
         }
         obf_K_e_3075.godStyleUI.updateRankMap(param1.godStyleId,param1.rankList);
         obf_K_e_3075.godStyleUI.obf_N_n_916(param1.godStyleId);
      }
      
      public static function obf_p_P_3626(param1:String) : void
      {
         var _loc2_:GodStyleUpRequest = new GodStyleUpRequest();
         _loc2_.godStyleId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
   }
}

