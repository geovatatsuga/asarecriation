package com.sunweb.game.rpg.mate
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.DynamicVars;
   import com.sunweb.game.rpg.world.map.MapManager;
   import com.sunweb.game.rpg.worldZone.command.mate.CommandCodePlayerMate;
   import com.sunweb.game.rpg.worldZone.command.mate.PlayerMateRelationCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.mate.PlayerMateVarChangeNotify;
   import com.sunweb.game.rpg.worldZone.command.mate.PlayerMateVarClearNotify;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   import com.sunweb.game.rpg.worldZone.command.player.PlayerEnterWorldAnswer;
   
   public class MateManager
   {
      
      public function MateManager()
      {
         super();
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayer.PLAYER_ENTER_WORLD_ANSWER)
         {
            onEnterWorld(param1 as PlayerEnterWorldAnswer);
         }
         else if(param1.code == CommandCodePlayerMate.PLAYER_MATE_RELATION_CHECK_NOTIFY)
         {
            onMateRelationCheck(param1 as PlayerMateRelationCheckNotify);
         }
         else if(param1.code == CommandCodePlayerMate.PLAYER_MATE_VAR_CHANGE_NOTIFY)
         {
            onMateVarsChange(param1 as PlayerMateVarChangeNotify);
         }
         else if(param1.code == CommandCodePlayerMate.PLAYER_MATE_VAR_CLEAR_NOTIFY)
         {
            onClearMateVars(param1 as PlayerMateVarClearNotify);
         }
      }
      
      private static function onEnterWorld(param1:PlayerEnterWorldAnswer) : void
      {
         if(obf_K_e_3075.obf_w_f_4556)
         {
            obf_K_e_3075.obf_w_f_4556.setMate(param1.role.mateRelationInfo);
         }
      }
      
      private static function onMateRelationCheck(param1:PlayerMateRelationCheckNotify) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1.mateRelationInfo)
         {
            _loc2_ = GameContext.localPlayer.fullInfo.mateRelationInfo ? GameContext.localPlayer.fullInfo.mateRelationInfo.mateValue : 0;
            _loc3_ = GameContext.localPlayer.fullInfo.mateRelationInfo ? GameContext.localPlayer.fullInfo.mateRelationInfo.mateGold : 0;
            if(param1.mateRelationInfo.mateValue - _loc2_ != 0)
            {
               obf_6_D_3816.print(DiversityManager.getString("MatePrompt","mateValueChange",[param1.mateRelationInfo.mateValue - _loc2_]));
            }
            if(param1.mateRelationInfo.mateGold - _loc3_ != 0)
            {
               obf_6_D_3816.print(DiversityManager.getString("MatePrompt","mateGoldChange",[param1.mateRelationInfo.mateGold - _loc3_]));
            }
         }
         GameContext.localPlayer.fullInfo.mateRelationInfo = param1.mateRelationInfo;
         if(!param1.mateRelationInfo && Boolean(GameContext.localPlayer.fullInfo.mateVars))
         {
            GameContext.localPlayer.fullInfo.mateVars.obf_8_W_2534();
            GameContext.localPlayer.fullInfo.mateVars.obf_f_1820();
            GameContext.localPlayer.fullInfo.mateVars.obf_E_t_1531();
         }
         if(obf_K_e_3075.obf_w_f_4556)
         {
            obf_K_e_3075.obf_w_f_4556.setMate(param1.mateRelationInfo);
         }
         GameContext.localPlayer.obf_G_p_757();
         MapManager.instance.doRefreshNPCTask();
      }
      
      private static function onMateVarsChange(param1:PlayerMateVarChangeNotify) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(!GameContext.localPlayer.fullInfo.mateVars)
         {
            GameContext.localPlayer.fullInfo.mateVars = new DynamicVars();
         }
         for(_loc2_ in param1.boolVars)
         {
            GameContext.localPlayer.fullInfo.mateVars.boolVars[_loc2_] = param1.boolVars[_loc2_];
         }
         for(_loc3_ in param1.intVars)
         {
            GameContext.localPlayer.fullInfo.mateVars.intVars[_loc3_] = param1.intVars[_loc3_];
         }
         MapManager.instance.doRefreshNPCTask();
      }
      
      private static function onClearMateVars(param1:PlayerMateVarClearNotify) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(!GameContext.localPlayer.fullInfo.mateVars)
         {
            GameContext.localPlayer.fullInfo.mateVars = new DynamicVars();
         }
         for each(_loc2_ in param1.boolVars)
         {
            GameContext.localPlayer.fullInfo.mateVars.delBoolVar(_loc2_);
         }
         for each(_loc3_ in param1.intVars)
         {
            GameContext.localPlayer.fullInfo.mateVars.delIntVar(_loc3_);
         }
         MapManager.instance.doRefreshNPCTask();
      }
   }
}

