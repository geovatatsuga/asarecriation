package com.sunweb.game.rpg.netRole
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.buff.BuffInfo;
   import com.sunweb.game.rpg.buff.BuffManager;
   import com.sunweb.game.rpg.map.Map;
   import com.sunweb.game.rpg.role.obf_0_9_V_473;
   import com.sunweb.game.rpg.world.MonsterInfoUtil;
   import com.sunweb.game.rpg.world.info.MonsterInfo;
   import com.sunweb.game.rpg.worldZone.command.monster.CommandCodeMonster;
   import com.sunweb.game.rpg.worldZone.command.monster.MonsterBornNotify;
   import com.sunweb.game.rpg.worldZone.command.monster.MonsterMoveNotify;
   import com.sunweb.game.rpg.worldZone.command.monster.MonsterRemovedNotify;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   import com.sunweb.game.rpg.worldZone.command.player.PlayerViewMapAnswer;
   import com.sunweb.game.utils.JSONUtil;
   
   public class AIMonsterManager
   {
      
      public function AIMonsterManager()
      {
         super();
      }
      
      public static function createMonster(param1:MonsterInfo) : obf_T_L_801
      {
         var _loc3_:obf_T_L_801 = null;
         var _loc4_:BuffInfo = null;
         var _loc5_:Object = null;
         var _loc2_:Object = MonsterInfoUtil.getMonsterInfo(param1.monsterCode);
         if(!_loc2_)
         {
            trace("obf__________26：" + param1.monsterCode + " obf_________53！");
            return null;
         }
         _loc3_ = new obf_T_L_801(param1.monsterCode);
         _loc3_.ownerPlayerId = param1.ownerPlayerId;
         _loc3_.id = param1.id;
         _loc3_.obf_w_I_2773 = _loc2_.name;
         _loc3_.monsterCode = param1.monsterCode;
         _loc3_.walkSpeed = param1.walkSpeed;
         _loc3_.hpPercent = param1.hpPercent;
         _loc3_.side = JSONUtil.getInt(_loc2_,["side"]);
         if(param1.level > 0)
         {
            _loc3_.level = param1.level;
         }
         else
         {
            _loc3_.level = _loc2_.level;
         }
         for each(_loc4_ in param1.buffArray)
         {
            _loc5_ = BuffManager.getBuffConfigById(_loc4_.buffId);
            if(_loc5_)
            {
               if(!_loc5_.isDebuff)
               {
                  _loc3_.obf_a_8_4261(_loc4_);
               }
               else
               {
                  _loc3_.obf_i_b_872(_loc4_);
               }
            }
         }
         _loc3_.setAndShowLabel(_loc3_.obf_w_I_2773);
         _loc3_.moveToPixel(param1.x,param1.y);
         return _loc3_;
      }
      
      public static function obf_4_M_4030() : void
      {
         var _loc1_:String = null;
         var _loc2_:obf_T_L_801 = null;
         if(!GameContext.currentMap)
         {
            return;
         }
         for(_loc1_ in GameContext.currentMap.monsterSet.obf_0_678)
         {
            _loc2_ = GameContext.currentMap.monsterSet.getObject(_loc1_) as obf_T_L_801;
            if(_loc2_)
            {
               _loc2_.setAndShowLabel(_loc2_.obf_w_I_2773);
            }
         }
      }
      
      public static function dispatchCommand(param1:obf_C_m_1350, param2:Map) : void
      {
         var _loc3_:Object = null;
         var _loc4_:obf_T_L_801 = null;
         if(param1.code == CommandCodeMonster.MONSTER_BORN_NOTIFY)
         {
            onMonsterBorn(param1 as MonsterBornNotify,param2);
         }
         else if(param1.code == CommandCodeMonster.MONSTER_REMOVED_NOTIFY)
         {
            onMonsterRemove(param1 as MonsterRemovedNotify);
         }
         else if(param1.code == CommandCodeMonster.MONSTER_MOVE_NOTIFY)
         {
            onMonsterMove(param1 as MonsterMoveNotify,param2);
         }
         else if(param1.code == CommandCodePlayer.PLAYER_VIEW_MAP_ANSWER)
         {
            onViewMap(param1 as PlayerViewMapAnswer,param2);
         }
         else
         {
            _loc3_ = param1 as Object;
            if(_loc3_.monsterId)
            {
               _loc4_ = param2.monsterSet.getObject(_loc3_.monsterId) as obf_T_L_801;
               if(_loc4_)
               {
                  _loc4_.doCommand(param1);
               }
            }
         }
      }
      
      private static function onViewMap(param1:PlayerViewMapAnswer, param2:Map) : void
      {
         var _loc3_:MonsterInfo = null;
         if(param1.mapId != param2.mapId)
         {
            return;
         }
         for each(_loc3_ in param1.monsters)
         {
            param2.monsterSet.addObject(createMonster(_loc3_));
         }
      }
      
      private static function onMonsterBorn(param1:MonsterBornNotify, param2:Map) : void
      {
         if(param1.mapId != param2.mapId)
         {
            return;
         }
         var _loc3_:obf_T_L_801 = createMonster(param1.monster);
         param2.monsterSet.addObject(_loc3_);
         obf_0_9_V_473.showEffectOnObject(param2,_loc3_,"C_RoleTeleport");
      }
      
      private static function onMonsterRemove(param1:MonsterRemovedNotify) : void
      {
         var _loc2_:obf_T_L_801 = GameContext.currentMap.monsterSet.getObject(param1.monsterId) as obf_T_L_801;
         if(_loc2_)
         {
            if(GameContext.localPlayer.obf_0_6_a_430 == _loc2_)
            {
               GameContext.localPlayer.obf_3_v_4336();
            }
            GameContext.currentMap.monsterSet.removeObject(_loc2_,true);
         }
      }
      
      private static function onMonsterMove(param1:MonsterMoveNotify, param2:Map) : void
      {
         if(param1.mapId != param2.mapId)
         {
            return;
         }
         var _loc3_:obf_T_L_801 = param2.monsterSet.getObject(param1.monsterId) as obf_T_L_801;
         if(_loc3_)
         {
            _loc3_.doCommand(param1);
         }
      }
   }
}

