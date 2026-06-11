package com.sunweb.game.rpg.equ
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_y_a_2168
   {
      
      private static var upgradeConfig:Object;
      
      public function obf_y_a_2168()
      {
         super();
      }
      
      public static function init(param1:Array) : void
      {
         var _loc2_:Object = null;
         upgradeConfig = new Object();
         for each(_loc2_ in param1)
         {
            upgradeConfig[_loc2_.equItemBase] = _loc2_;
         }
      }
      
      public static function getUpgradeConfig(param1:String) : Object
      {
         return JSONUtil.getObject(upgradeConfig,[param1]);
      }
      
      public static function getUpgradeEquipmentList() : Array
      {
         var _loc2_:String = null;
         var _loc1_:Array = new Array();
         for(_loc2_ in upgradeConfig)
         {
            _loc1_.push(_loc2_);
         }
         _loc1_.sort();
         return _loc1_;
      }
      
      public static function equipmentCanUpgrade(param1:GameItemFullInfo, param2:Boolean = true) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         var _loc3_:Object = getUpgradeConfig(param1.itemCode);
         if(!_loc3_)
         {
            return false;
         }
         if(param1.equipmentInfo.refineLevel < _loc3_.costRefineLevel)
         {
            if(param2)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ArtifactUpgradeUI","prompt_RefineLevelError",[_loc3_.costRefineLevel]));
            }
            return false;
         }
         return ConditionScript.checkCondition(_loc3_.condition,null,param2);
      }
   }
}

