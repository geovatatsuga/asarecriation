package com.sunweb.game.rpg.skill
{
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_0_3_0_538;
   import com.sunweb.game.rpg.role.SkillConfig;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_l_l_940
   {
      
      private static var fateSkillPoint:Object;
      
      private static var _fateSkillCodes:Array;
      
      private static var _totalFateLevelPoint:int;
      
      private static var _petFateSkillCodes:Array;
      
      private static var _totalPetFateLevelPoint:int;
      
      public function obf_l_l_940()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         fateSkillPoint = new Object();
         _fateSkillCodes = new Array();
         for(_loc2_ in param1.fateSkill)
         {
            _fateSkillCodes.push(_loc2_);
            _loc4_ = JSONUtil.getObject(param1,["fateSkill",_loc2_]) as Array;
            fateSkillPoint[_loc2_] = _loc4_;
            for each(_loc5_ in _loc4_)
            {
               _totalFateLevelPoint += _loc5_;
            }
         }
         _petFateSkillCodes = new Array();
         for(_loc3_ in param1.petFateSkill)
         {
            _petFateSkillCodes.push(_loc3_);
            _loc6_ = JSONUtil.getObject(param1,["petFateSkill",_loc3_]) as Array;
            fateSkillPoint[_loc3_] = _loc6_;
            for each(_loc7_ in _loc6_)
            {
               _totalPetFateLevelPoint += _loc7_;
            }
         }
      }
      
      public static function get totalFateLevelPoint() : int
      {
         return _totalFateLevelPoint;
      }
      
      public static function get totalPetFateLevelPoint() : int
      {
         return _totalPetFateLevelPoint;
      }
      
      public static function get fateSkillCodes() : Array
      {
         return _fateSkillCodes;
      }
      
      public static function get petFateSkillCodes() : Array
      {
         return _petFateSkillCodes;
      }
      
      public static function getFateLevelPoint(param1:String, param2:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:Array = JSONUtil.getObject(fateSkillPoint,[param1]) as Array;
         if(!_loc4_ || _loc4_.length == 0)
         {
            return 0;
         }
         var _loc5_:int = 0;
         while(_loc5_ < param2 && _loc5_ < _loc4_.length)
         {
            _loc3_ += _loc4_[_loc5_];
            _loc5_++;
         }
         return _loc3_;
      }
      
      public static function obf_O_c_2215(param1:GameTipUI, param2:int, param3:String, param4:uint) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc5_:Object = SkillConfig.getSkillConfig(param3);
         if(!_loc5_)
         {
            return;
         }
         if(param4 >= _loc5_.levelInfo.length)
         {
            return;
         }
         var _loc6_:Object = JSONUtil.getObject(_loc5_,["levelInfo",param4]);
         if(!_loc6_)
         {
            return;
         }
         param1.addTipInfo("<FONT COLOR=\'#" + obf_0_3_0_538.obf_J_P_1631.toString(16) + "\'><p align=\'center\'>" + _loc5_.name + " Lv" + (param4 + 1) + "</p></FONT>",param2,param1.maxRow + 1);
         param1.addTipInfo(_loc6_.detail,param2,param1.maxRow + 2);
         param1.addTipInfo(ConditionScript.getConditionsHTML(JSONUtil.getValue(_loc6_,"learnRule","condition")),param2,param1.maxRow + 2);
      }
   }
}

