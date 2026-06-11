package obf_Z_U_3013
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.map.MapInteractiveObject;
   import com.sunweb.game.rpg.role.MapTrapInfo;
   import com.sunweb.game.rpg.world.map.MapPoint;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   import com.sunweb.game.rpg.worldZone.command.player.PlayerViewMapAnswer;
   import com.sunweb.game.rpg.worldZone.command.trap.CommandCodeMapTrap;
   import com.sunweb.game.rpg.worldZone.command.trap.MapTrapAddedNotify;
   import com.sunweb.game.rpg.worldZone.command.trap.MapTrapRemovedNotify;
   import com.sunweb.game.rpg.worldZone.command.trap.MapTrapUseSkillNotify;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_C_p_3418
   {
      
      private static var trapConfig:Array;
      
      private static var obf_m_z_4307:Object;
      
      public function obf_C_p_3418()
      {
         super();
      }
      
      public static function initTrapConfig(param1:Array) : void
      {
         var _loc2_:Object = null;
         if(!param1)
         {
            return;
         }
         trapConfig = param1;
         obf_m_z_4307 = new Object();
         for each(_loc2_ in trapConfig)
         {
            obf_m_z_4307[_loc2_.code] = _loc2_;
         }
      }
      
      public static function getTrapConfig(param1:String) : Object
      {
         return JSONUtil.getObject(obf_m_z_4307,[param1]);
      }
      
      public static function obf_w_K_3432(param1:MapTrapInfo) : obf_L_4641
      {
         var _loc2_:obf_L_4641 = new obf_L_4641(param1.trapCode);
         _loc2_.id = param1.id;
         _loc2_.moveToPixel(param1.x,param1.y);
         return _loc2_;
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayer.PLAYER_VIEW_MAP_ANSWER)
         {
            onViewMap(param1 as PlayerViewMapAnswer);
         }
         else if(param1.code == CommandCodeMapTrap.MAP_TRAP_ADDED_NOTIFY)
         {
            obf_5_9_3669(param1 as MapTrapAddedNotify);
         }
         else if(param1.code == CommandCodeMapTrap.MAP_TRAP_REMOVED_NOTIFY)
         {
            obf_M_Q_1103(param1 as MapTrapRemovedNotify);
         }
         else if(param1.code == CommandCodeMapTrap.MAP_TRAP_USE_SKILL_NOTIFY)
         {
            obf_g_s_2410(param1 as MapTrapUseSkillNotify);
         }
      }
      
      private static function onViewMap(param1:PlayerViewMapAnswer) : void
      {
         var _loc2_:MapTrapInfo = null;
         var _loc3_:obf_L_4641 = null;
         if(!GameContext.currentMap || param1.mapId != GameContext.currentMap.mapId)
         {
            return;
         }
         for each(_loc2_ in param1.traps)
         {
            if(!GameContext.currentMap.obf_c_z_1779.getObject(_loc2_.id))
            {
               _loc3_ = obf_w_K_3432(_loc2_);
               if(_loc3_)
               {
                  GameContext.currentMap.obf_c_z_1779.addObject(_loc3_);
               }
            }
         }
      }
      
      private static function obf_5_9_3669(param1:MapTrapAddedNotify) : void
      {
         if(!GameContext.currentMap || param1.mapId != GameContext.currentMap.mapId)
         {
            return;
         }
         if(GameContext.currentMap.obf_c_z_1779.getObject(param1.trap.id))
         {
            return;
         }
         var _loc2_:obf_L_4641 = obf_w_K_3432(param1.trap);
         GameContext.currentMap.obf_c_z_1779.addObject(_loc2_);
      }
      
      private static function obf_M_Q_1103(param1:MapTrapRemovedNotify) : void
      {
         if(!GameContext.currentMap || param1.mapId != GameContext.currentMap.mapId)
         {
            return;
         }
         var _loc2_:obf_L_4641 = GameContext.currentMap.obf_c_z_1779.getObject(param1.trapId) as obf_L_4641;
         if(_loc2_)
         {
            GameContext.currentMap.obf_c_z_1779.removeObject(_loc2_,true);
         }
      }
      
      private static function obf_g_s_2410(param1:MapTrapUseSkillNotify) : void
      {
         var _loc3_:MapInteractiveObject = null;
         if(!GameContext.currentMap || param1.mapId != GameContext.currentMap.mapId)
         {
            return;
         }
         var _loc2_:obf_L_4641 = GameContext.currentMap.obf_c_z_1779.getObject(param1.trapId) as obf_L_4641;
         if(_loc2_)
         {
            _loc3_ = GameContext.currentMap.getObjectById(param1.targetId);
            if(_loc3_)
            {
               _loc2_.useSkillOnObject(0,param1.skillCode,_loc3_,param1.singTime,param1.castTime,param1.skillLevel);
            }
            else if(param1.targetPoint)
            {
               _loc2_.useSkillOnPoint(0,param1.skillCode,MapPoint.MapPointToPoint(param1.targetPoint),param1.singTime,param1.castTime,param1.skillLevel);
            }
            else
            {
               _loc2_.useSkillOnObject(0,param1.skillCode,_loc2_,param1.singTime,param1.castTime,param1.skillLevel);
            }
         }
      }
   }
}

