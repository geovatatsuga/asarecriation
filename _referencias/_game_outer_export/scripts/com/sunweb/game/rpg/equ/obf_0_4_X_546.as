package com.sunweb.game.rpg.equ
{
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_0_4_X_546
   {
      
      private static var fusionConfig:Object;
      
      public function obf_0_4_X_546()
      {
         super();
      }
      
      public static function init(param1:Array) : void
      {
         var _loc2_:Object = null;
         fusionConfig = new Object();
         for each(_loc2_ in param1)
         {
            fusionConfig[_loc2_.fusionId] = _loc2_;
         }
      }
      
      public static function getFusionConfig(param1:int) : Object
      {
         return JSONUtil.getObject(fusionConfig,[param1]);
      }
      
      public static function equipmentCanFusion(param1:String, param2:String) : Boolean
      {
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         var _loc4_:Object = GameItemManager.getItemConfig(param2);
         if(!_loc3_ || !_loc4_)
         {
            return false;
         }
         var _loc5_:Object = obf_0_4_X_546.getFusionConfig(JSONUtil.getInt(_loc3_,["properties","fusionId"]));
         if(!_loc5_)
         {
            return false;
         }
         if(!JSONUtil.getBoolean(_loc4_,["properties","isFusionItem"],true))
         {
            return false;
         }
         if(JSONUtil.getInt(_loc3_,["properties","kind"]) != JSONUtil.getInt(_loc4_,["properties","kind"]))
         {
            return false;
         }
         return ConditionScript.checkCondition(_loc5_.condition);
      }
   }
}

