package com.sunweb.game.rpg.extractant
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.extractant.CommandPlayerExtractant;
   import com.sunweb.game.rpg.worldZone.command.extractant.playerExtractantAnswer;
   import com.sunweb.game.rpg.worldZone.command.extractant.playerExtractantRequest;
   import com.sunweb.game.rpg.worldZone.command.extractant.playerExtractantUplvAnswer;
   import com.sunweb.game.rpg.worldZone.command.extractant.playerExtractantUplvRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_t_f_2299
   {
      
      private static var extractantConfig:Object;
      
      public function obf_t_f_2299()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         extractantConfig = param1;
      }
      
      public static function get config() : Object
      {
         return extractantConfig;
      }
      
      public static function getItemTypeConfig(param1:int) : Object
      {
         var _loc2_:Array = JSONUtil.getValue(extractantConfig,["itemTypeConfig"]) as Array;
         var _loc3_:Object = new Object();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.itemType == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public static function getPatternTypeConfig(param1:int) : Object
      {
         var _loc2_:Array = JSONUtil.getValue(extractantConfig,["patternConfig"]) as Array;
         var _loc3_:Object = new Object();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.pattern == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public static function getUpLvTypeConfig(param1:int) : Object
      {
         var _loc2_:Array = JSONUtil.getValue(extractantConfig,["upLvConfig"]) as Array;
         var _loc3_:Object = new Object();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.upType == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public static function isNum(param1:int) : Boolean
      {
         var _loc2_:Array = JSONUtil.getValue(extractantConfig,["patternConfig"]) as Array;
         return JSONUtil.getBoolean(_loc2_[param1],["number"]);
      }
      
      public static function getUpConfig() : Array
      {
         return JSONUtil.getValue(extractantConfig,["upLvConfig"]) as Array;
      }
      
      public static function sendExtractantRequest(param1:String, param2:int) : void
      {
         var _loc3_:playerExtractantRequest = new playerExtractantRequest();
         _loc3_.itemId = param1;
         _loc3_.patternType = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendExtractantUpLvRequest(param1:int) : void
      {
         var _loc2_:playerExtractantUplvRequest = new playerExtractantUplvRequest();
         _loc2_.type = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandPlayerExtractant.REMARK_TIMEINFO_NOTIFY)
         {
            obf_K_e_3075.extractantUI.getValue(param1 as playerExtractantAnswer);
            obf_K_e_3075.extractantUpUI.getAbility((param1 as playerExtractantAnswer).ability);
         }
         else if(param1.code == CommandPlayerExtractant.REMARK_EXTRACTANT_UP_LV_ANSWER)
         {
            obf_K_e_3075.extractantUpUI.getValue(param1 as playerExtractantUplvAnswer);
            obf_K_e_3075.extractantUI.obf_1_a_2907((param1 as playerExtractantUplvAnswer).ability);
         }
      }
   }
}

