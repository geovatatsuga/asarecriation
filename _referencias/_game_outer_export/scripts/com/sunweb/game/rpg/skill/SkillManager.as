package com.sunweb.game.rpg.skill
{
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.map.MapInteractiveObject;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.SkillConfig;
   import com.sunweb.game.rpg.role.obf_c_y_957;
   import com.sunweb.game.rpg.world.map.MapManager;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public class SkillManager
   {
      
      private static var _instance:SkillManager;
      
      public static const OUTRANGE:int = 1;
      
      public static const USINGSKILL:int = 2;
      
      public static const NOTSKILL:int = 3;
      
      public static const CDFAILE:int = 4;
      
      public static const BUFFFAILE:int = 5;
      
      public static const TARGETFAILE:int = 6;
      
      public static const CONSTFAILE:int = 7;
      
      public static const BLOCKED:int = 8;
      
      public static const SKILLERROR:int = 9;
      
      public static const RIDING:int = 10;
      
      public static const obf_W_R_865:int = 11;
      
      public static const obf_x_i_3656:int = 12;
      
      public static const obf_A_s_3468:int = 13;
      
      public static const obf_g_4221:int = 14;
      
      public var followSkillCode:String = "";
      
      public var followSkillLevel:int;
      
      public var followSkillPoint:Point;
      
      public function SkillManager()
      {
         super();
         _instance = this;
      }
      
      public static function get instance() : SkillManager
      {
         return _instance;
      }
      
      public static function getSkillIcon(param1:String) : DisplayObject
      {
         var _loc2_:Object = SkillConfig.getSkillConfig(param1);
         if(!_loc2_)
         {
            return null;
         }
         return ResourceManager.instance.getDisplayObject(_loc2_.iconRes);
      }
      
      public static function getSkillName(param1:String) : String
      {
         var _loc2_:Object = SkillConfig.getSkillConfig(param1);
         return JSONUtil.getStr(_loc2_,["name"]);
      }
      
      public static function getSkillType(param1:String) : int
      {
         var _loc2_:Object = SkillConfig.getSkillConfig(param1);
         return JSONUtil.getInt(_loc2_,["type"],-1);
      }
      
      public static function getIsCallSkill(param1:String) : Boolean
      {
         var _loc2_:Object = SkillConfig.getSkillConfig(param1);
         return JSONUtil.getBoolean(_loc2_,["isCallSkill"]);
      }
      
      public function destroy() : void
      {
      }
      
      public function checkSkill(param1:Object, param2:int, param3:MapInteractiveObject, param4:Point) : int
      {
         var _loc6_:Point = null;
         if(GameContext.localPlayer.isPassiveRiding)
         {
            return RIDING;
         }
         if(GameContext.localPlayer.isBooth)
         {
            return obf_A_s_3468;
         }
         if(GameContext.localPlayer.isBlessing)
         {
            return obf_g_4221;
         }
         if(GameContext.localPlayer.isDead)
         {
            return obf_x_i_3656;
         }
         var _loc5_:String = JSONUtil.getStr(param1,["cdFlag"]);
         if(obf_L_l_4100.isEmpty(_loc5_))
         {
            _loc5_ = param1.code;
         }
         if(SkillCDManager.checkSkillCD(_loc5_))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("PlayerSkillPrompt","skillNotReady"));
            return CDFAILE;
         }
         if(GameContext.localPlayer.obf_w_e_2707)
         {
            return USINGSKILL;
         }
         if(!PlayerSkillManager.obf_0_6_G_255(param1.code))
         {
            return NOTSKILL;
         }
         if(!MapManager.instance.checkSkillRule(param1.code))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","cantActInMap"));
            return obf_W_R_865;
         }
         if(GameContext.localPlayer.obf_I_z_3437(obf_c_y_957.obf_V_R_4507) && param1.type == obf_M_F_3694.obf_a_w_4267 || GameContext.localPlayer.obf_I_z_3437(obf_c_y_957.obf_T_A_1838) && param1.type == obf_M_F_3694.MAGIC || GameContext.localPlayer.obf_I_z_3437(obf_c_y_957.DISABLE_SKILL_BUFF) && param1.type == obf_M_F_3694.obf_O_I_3584 || GameContext.localPlayer.obf_I_z_3437(obf_c_y_957.obf_0_8_R_671) && param1.type == obf_M_F_3694.obf_k_2_966)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","cantDo"));
            return BUFFFAILE;
         }
         if(param1.aimMode == SkillAimMode.OBJECT)
         {
            if(!this.checkTarget(param1,param3))
            {
               return TARGETFAILE;
            }
         }
         if(param1.aimMode != SkillAimMode.NONE)
         {
            _loc6_ = new Point();
            if(param1.aimMode == SkillAimMode.OBJECT)
            {
               _loc6_.x = param3.rootPX;
               _loc6_.y = param3.rootPY;
            }
            else if(param1.aimMode == SkillAimMode.POINT)
            {
               if(!param4)
               {
                  obf_6_D_3816.obf_0_5_O_723("UseSkill failed! Skill not set targetPoint!");
                  return SKILLERROR;
               }
               _loc6_ = param4;
            }
            if(!this.checkRange(param1,param2,_loc6_))
            {
               return OUTRANGE;
            }
         }
         if(!this.checkCost(param1,param2))
         {
            return CONSTFAILE;
         }
         if(param1.aimMode == SkillAimMode.OBJECT)
         {
            if(!GameContext.currentMap || GameContext.currentMap.isBlocked2Objects(GameContext.localPlayer,param3))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("PlayerSkillPrompt","isBlockedWithTarget"));
               return BLOCKED;
            }
         }
         else if(param1.aimMode == SkillAimMode.POINT)
         {
            if(!param4 || !GameContext.currentMap || GameContext.currentMap.isBlocked(GameContext.localPlayer.rootPX,GameContext.localPlayer.rootPY,param4.x,param4.y))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("PlayerSkillPrompt","isBlockedWithTarget"));
               return BLOCKED;
            }
         }
         return 0;
      }
      
      public function checkTarget(param1:Object, param2:MapInteractiveObject) : Boolean
      {
         if(!param2)
         {
            return false;
         }
         if(Boolean(param1) && GameContext.localPlayer.obf_r_7_2244(param1.target,param1.notTarget,param2))
         {
            return true;
         }
         return false;
      }
      
      private function checkRange(param1:Object, param2:int, param3:Point) : Boolean
      {
         if(!GameContext.localPlayer)
         {
            return false;
         }
         var _loc4_:Number = Point.distance(new Point(GameContext.localPlayer.rootPX,GameContext.localPlayer.rootPY),param3);
         var _loc5_:int = 9999;
         var _loc6_:Object = param1.levelInfo[param2];
         if(_loc6_ != null)
         {
            _loc5_ = int(_loc6_.castRule.range);
         }
         if(_loc4_ > _loc5_)
         {
            return false;
         }
         return true;
      }
      
      private function checkCost(param1:Object, param2:int) : Boolean
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:Object = null;
         var _loc13_:String = null;
         if(param2 >= param1.levelInfo.length)
         {
            obf_6_D_3816.obf_0_5_O_723("UseSkill failed! Level " + param2 + " Error!");
            return false;
         }
         var _loc3_:Object = param1.levelInfo[param2];
         var _loc4_:Object = _loc3_.castRule.castCost;
         if(_loc4_)
         {
            _loc5_ = JSONUtil.getInt(_loc4_,["hp"]);
            _loc5_ = _loc5_ + JSONUtil.getNumber(_loc4_,["hp%"]) / 100 * GameContext.localPlayer.fullInfo.attributes.hpMax;
            if(_loc5_ > 0 && GameContext.localPlayer.fullInfo.attributes.hp < _loc5_)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMoreHP"));
               return false;
            }
            _loc6_ = JSONUtil.getInt(_loc4_,["mp"]);
            _loc6_ = _loc6_ + JSONUtil.getNumber(_loc4_,["mp%"]) / 100 * GameContext.localPlayer.fullInfo.attributes.mpMax;
            if(_loc6_ > 0 && GameContext.localPlayer.fullInfo.attributes.mp < _loc6_)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMoreMP"));
               return false;
            }
            _loc7_ = JSONUtil.getInt(_loc4_,["sp"]);
            _loc7_ = _loc7_ + JSONUtil.getNumber(_loc4_,["sp%"]) / 100 * GameContext.localPlayer.fullInfo.attributes.spMax;
            if(_loc7_ > 0 && GameContext.localPlayer.fullInfo.attributes.sp < _loc7_)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMoreSP"));
               return false;
            }
            _loc8_ = JSONUtil.getInt(_loc4_,["charmValue"]);
            if(_loc8_ > 0 && GameContext.localPlayer.fullInfo.charmValue < _loc8_)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMoreCharmValue"));
               return false;
            }
            _loc9_ = JSONUtil.getInt(_loc4_,["charmInt"]);
            if(_loc9_ > 0 && GameContext.localPlayer.fullInfo.charmInt < _loc9_)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMoreCharmInt"));
               return false;
            }
            _loc10_ = JSONUtil.getInt(_loc4_,["gold"]);
            if(_loc10_ > 0 && GameContext.localPlayer.fullInfo.gold < _loc10_)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMoreGold"));
               return false;
            }
            _loc11_ = JSONUtil.getInt(_loc4_,["money"]);
            if(_loc11_ > 0 && GameContext.localPlayer.fullInfo.money < _loc11_)
            {
               obf_K_e_3075.showShortOfMoney();
               return false;
            }
            _loc12_ = _loc4_.items;
            if(_loc12_)
            {
               if(!obf_K_e_3075.playerBagUI)
               {
                  return false;
               }
               for(_loc13_ in _loc12_)
               {
                  if(obf_K_e_3075.playerBagUI.getItemCount(_loc13_) < _loc12_[_loc13_])
                  {
                     obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMoreItemNeedCount",[_loc12_[_loc13_],GameItemManager.getItemName(_loc13_)]));
                     return false;
                  }
               }
            }
         }
         return true;
      }
   }
}

