package com.sunweb.game.rpg.role
{
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   
   public class SkillConfig
   {
      
      private static var _skillConfig:Object;
      
      private static var obf_C_f_4490:Object;
      
      private static var animalSkills:Array;
      
      private static var obf_0_8_S_315:Array;
      
      public function SkillConfig()
      {
         super();
      }
      
      public static function set skillConfig(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Array = null;
         _skillConfig = param1;
         obf_C_f_4490 = new Object();
         for each(_loc3_ in param1.jobSkill)
         {
            addSkillConfigs(_loc3_);
         }
         addSkillConfigs(param1.commonSkill as Array);
         addSkillConfigs(param1.familySkill as Array);
         addSkillConfigs(param1.teamSkill as Array);
         addSkillConfigs(param1.equipmentSkill as Array);
         addSkillConfigs(param1.petSkill as Array);
         addSkillConfigs(param1.bookSkill as Array);
         addSkillConfigs(param1.monsterSkill as Array);
         addSkillConfigs(param1.fateSkill as Array);
         addSkillConfigs(param1.beliefSkill as Array);
         addSkillConfigs(param1.animalSkill as Array);
         animalSkills = param1.animalSkill as Array;
         addSkillConfigs(param1.playerBookSkill as Array);
         addSkillConfigs(param1.devilGodSkill as Array);
      }
      
      private static function addSkillConfigs(param1:Array) : void
      {
         var _loc2_:Object = null;
         if(param1 == null)
         {
            return;
         }
         for each(_loc2_ in param1)
         {
            obf_C_f_4490[_loc2_.code] = _loc2_;
         }
      }
      
      public static function get skillConfig() : Object
      {
         return _skillConfig;
      }
      
      public static function getSkillConfig(param1:String) : Object
      {
         return obf_C_f_4490[param1];
      }
      
      public static function isAnimalSkill(param1:String) : Boolean
      {
         var _loc2_:Object = null;
         if(!animalSkills)
         {
            return false;
         }
         for each(_loc2_ in animalSkills)
         {
            if(JSONUtil.getStr(_loc2_,["code"]) == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function getChangePlayerSkill(param1:String) : Object
      {
         var _loc4_:int = 0;
         var _loc2_:Object = {};
         var _loc3_:Array = WorldConfig.getValue("modelChange") as Array;
         if(Boolean(_loc3_) && !obf_L_l_4100.isEmpty(param1))
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               if(_loc3_[_loc4_].code == param1)
               {
                  _loc2_ = _loc3_[_loc4_].skills;
                  break;
               }
               _loc4_++;
            }
         }
         return _loc2_;
      }
   }
}

