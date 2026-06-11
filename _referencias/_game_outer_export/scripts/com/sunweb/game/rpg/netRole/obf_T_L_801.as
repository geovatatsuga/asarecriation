package com.sunweb.game.rpg.netRole
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.res.ResourceBag;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.buff.BuffInfo;
   import com.sunweb.game.rpg.buff.BuffManager;
   import com.sunweb.game.rpg.map.MapInteractiveObject;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.RoleModel;
   import com.sunweb.game.rpg.role.obf_0_0_8_669;
   import com.sunweb.game.rpg.role.obf_0_9_V_473;
   import com.sunweb.game.rpg.role.obf_Z_Q_3056;
   import com.sunweb.game.rpg.role.obf_e_1465;
   import com.sunweb.game.rpg.world.MonsterInfoUtil;
   import com.sunweb.game.rpg.world.map.MapManager;
   import com.sunweb.game.rpg.world.map.MapPoint;
   import com.sunweb.game.rpg.worldZone.command.monster.CommandCodeMonster;
   import com.sunweb.game.rpg.worldZone.command.monster.MonsterBuffChangeNotify;
   import com.sunweb.game.rpg.worldZone.command.monster.MonsterDiedNotify;
   import com.sunweb.game.rpg.worldZone.command.monster.MonsterHpChangeNotify;
   import com.sunweb.game.rpg.worldZone.command.monster.MonsterMoveNotify;
   import com.sunweb.game.rpg.worldZone.command.monster.MonsterPositionCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.monster.MonsterUseSkillNotify;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import flash.filters.GlowFilter;
   
   public class obf_T_L_801 extends obf_e_1465
   {
      
      private var _config:Object;
      
      public var hp:int;
      
      public var obf_w_I_2773:String;
      
      public var monsterCode:String;
      
      private var randomSayTimeInv:TimeLimiter = new TimeLimiter(10000 + int(Math.random() * 10000));
      
      public function obf_T_L_801(param1:String)
      {
         this._config = MonsterInfoUtil.getMonsterInfo(param1);
         super(this._config.modelCode);
         this._labelTextField.filters = [new GlowFilter(0,1,2,2,1000,1)];
      }
      
      override protected function obf_N_O_3481() : void
      {
         var _loc1_:ResourceBag = AIObjectsBufferManager.getResBag("m_" + this._config.modelCode);
         _loc1_.obf_z_U_2156(RoleModel.getMonsterModelResId(this._config.modelCode));
         _loc1_.load();
      }
      
      override public function onUpdate() : void
      {
         var _loc1_:Array = null;
         super.onUpdate();
         if(this.randomSayTimeInv.checkTimeout())
         {
            _loc1_ = JSONUtil.getObject(this._config,["sayInIdle"]) as Array;
            if(Boolean(this.isInStage) && Boolean(_loc1_) && _loc1_.length > 0)
            {
               this.say(_loc1_[int(Math.random() * (_loc1_.length - 1))]);
            }
            this.randomSayTimeInv = new TimeLimiter(10000 + int(Math.random() * 10000));
         }
      }
      
      override public function setAndShowLabel(param1:String) : void
      {
         super.setAndShowLabel(param1);
         labelColor = 16777215;
         var _loc2_:int = GameContext.localPlayer.level - this.level;
         if(_loc2_ <= -10)
         {
            labelColor = 16711680;
         }
         else if(_loc2_ <= -3)
         {
            labelColor = 16776960;
         }
         else if(_loc2_ >= 10)
         {
            labelColor = 6710886;
         }
         else if(_loc2_ >= 3)
         {
            labelColor = 65280;
         }
      }
      
      public function get config() : Object
      {
         return this._config;
      }
      
      public function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeMonster.MONSTER_MOVE_NOTIFY)
         {
            this.onMonsterMove(param1 as MonsterMoveNotify);
         }
         else if(param1.code == CommandCodeMonster.MONSTER_POSITION_CHECK_NOTIFY)
         {
            this.obf_C_n_4515(param1 as MonsterPositionCheckNotify);
         }
         else if(param1.code == CommandCodeMonster.MONSTER_DIED_NOTIFY)
         {
            this.obf_g_3_2030(param1 as MonsterDiedNotify);
         }
         else if(param1.code == CommandCodeMonster.MONSTER_HP_CHANGE_NOTIFY)
         {
            this.obf_Q_7_1520(param1 as MonsterHpChangeNotify);
         }
         else if(param1.code == CommandCodeMonster.MONSTER_USE_SKILL_NOTIFY)
         {
            this.obf_v_c_1611(param1 as MonsterUseSkillNotify);
         }
         else if(param1.code == CommandCodeMonster.MONSTER_BUFF_CHANGE_NOTIFY)
         {
            this.obf_h_s_2586(param1 as MonsterBuffChangeNotify);
         }
      }
      
      private function onMonsterMove(param1:MonsterMoveNotify) : void
      {
         var _loc3_:Boolean = false;
         this.stopSkill();
         var _loc2_:Array = MapPoint.MapArrayToPoint(param1.pathArray);
         if(Boolean(_loc2_) && _loc2_.length > 0)
         {
            _loc3_ = this.getLineDistancePt(_loc2_[0].x,_loc2_[0].y) < 200;
         }
         this.walkAlongPath(_loc2_,_loc3_);
      }
      
      private function obf_g_3_2030(param1:MonsterDiedNotify) : void
      {
         if(GameContext.localPlayer.obf_0_6_a_430 == this)
         {
            GameContext.localPlayer.obf_3_v_4336();
         }
         this.die();
      }
      
      private function obf_Q_7_1520(param1:MonsterHpChangeNotify) : void
      {
         this.hpPercent = param1.hpPercentCurrent;
         if(GameContext.localPlayer.obf_0_6_a_430 == this)
         {
            obf_K_e_3075.setTargetInfoHpPercent(this.hpPercent);
         }
         if(param1.hpChanged == 0)
         {
            obf_0_9_V_473.showEffectOnObject(GameContext.currentMap,this,"C_NumberMiss");
         }
         else if(param1.hpChanged < 0)
         {
            this.showNumberEffect(Math.abs(param1.hpChanged),param1.isCriticalStrike ? obf_0_0_8_669.obf_w_d_3136 : obf_0_0_8_669.obf_F_F_4169);
            this.showStrickenAction();
         }
         else
         {
            this.showNumberEffect(param1.hpChanged,obf_0_0_8_669.obf_0___1_276);
         }
         if(Boolean(param1.skillCode) && param1.skillCode != "")
         {
            this.showHitEffect(param1.skillCode,param1.isCriticalStrike);
         }
      }
      
      private function obf_C_n_4515(param1:MonsterPositionCheckNotify) : void
      {
         if(GameContext.currentMap)
         {
            if(param1.reasonCode == obf_Z_Q_3056.obf_z_n_3070 && this.isInStage)
            {
               MapManager.instance.showMapFastMoveBlur(this,param1.position.x,param1.position.y);
            }
            else if(this.getLineDistancePt(param1.position.x,param1.position.y) > 200)
            {
               obf_0_9_V_473.showEffectOnObject(GameContext.currentMap,this,"C_RoleTeleport");
            }
         }
         this.walkSpeed = param1.walkSpeed;
         this.moveToPixel(param1.position.x,param1.position.y);
         this.walkAlongPath(MapPoint.MapArrayToPoint(param1.pathArray),false);
         this.obf_9_0_4119();
      }
      
      private function obf_v_c_1611(param1:MonsterUseSkillNotify) : void
      {
         var _loc2_:MapInteractiveObject = null;
         if(GameContext.currentMap)
         {
            _loc2_ = GameContext.currentMap.monsterSet.getObject(param1.targetId);
            if(!_loc2_)
            {
               _loc2_ = GameContext.currentMap.remotePlayerSet.getObject(param1.targetId);
            }
            if(!_loc2_)
            {
               _loc2_ = GameContext.currentMap.animalSet.getObject(param1.targetId);
            }
            if(Boolean(!_loc2_) && Boolean(GameContext.localPlayer) && param1.targetId == GameContext.localPlayer.id)
            {
               _loc2_ = GameContext.localPlayer as MapInteractiveObject;
            }
         }
         this.moveToPixel(param1.x,param1.y);
         if(_loc2_)
         {
            this.useSkillOnObject(0,param1.skillCode,_loc2_,param1.singTime,param1.castTime,param1.skillLevel);
         }
         else if(param1.targetPoint)
         {
            this.useSkillOnPoint(0,param1.skillCode,MapPoint.MapPointToPoint(param1.targetPoint),param1.singTime,param1.castTime,param1.skillLevel);
         }
      }
      
      private function obf_h_s_2586(param1:MonsterBuffChangeNotify) : void
      {
         var _loc3_:int = 0;
         var _loc4_:BuffInfo = null;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc2_:Boolean = GameContext.localPlayer.obf_0_6_a_430 == this;
         for each(_loc3_ in param1.buffsRemoved)
         {
            _loc5_ = BuffManager.getBuffConfigById(_loc3_);
            if(_loc5_)
            {
               if(!_loc5_.isDebuff)
               {
                  this.removeBuffInfo(_loc3_);
                  if(Boolean(obf_K_e_3075.targetInfoUI) && _loc2_)
                  {
                     obf_K_e_3075.targetInfoUI.buffUI.removeBuff(_loc3_);
                  }
               }
               else
               {
                  this.removeDebuffInfo(_loc3_);
                  if(Boolean(obf_K_e_3075.targetInfoUI) && _loc2_)
                  {
                     obf_K_e_3075.targetInfoUI.debuffUI.removeBuff(_loc3_);
                  }
               }
            }
         }
         for each(_loc4_ in param1.buffsAdded)
         {
            _loc6_ = BuffManager.getBuffConfigById(_loc4_.buffId);
            if(_loc6_)
            {
               if(!_loc6_.isDebuff)
               {
                  this.obf_a_8_4261(_loc4_);
                  if(Boolean(obf_K_e_3075.targetInfoUI) && _loc2_)
                  {
                     obf_K_e_3075.targetInfoUI.buffUI.addBuff(_loc4_);
                  }
               }
               else
               {
                  this.obf_i_b_872(_loc4_);
                  if(Boolean(obf_K_e_3075.targetInfoUI) && _loc2_)
                  {
                     obf_K_e_3075.targetInfoUI.debuffUI.addBuff(_loc4_);
                  }
               }
            }
         }
      }
   }
}

