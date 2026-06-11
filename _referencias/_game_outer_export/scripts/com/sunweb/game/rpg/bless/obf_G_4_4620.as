package com.sunweb.game.rpg.bless
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.bless.BlessBuyBuffRequest;
   import com.sunweb.game.rpg.worldZone.command.bless.BlessCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.bless.BlessStartRequest;
   import com.sunweb.game.rpg.worldZone.command.bless.BlessStopRequest;
   import com.sunweb.game.rpg.worldZone.command.bless.BlessVisitAnswer;
   import com.sunweb.game.rpg.worldZone.command.bless.BlessVisitRequest;
   import com.sunweb.game.rpg.worldZone.command.bless.CommandCodeBless;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_G_4_4620
   {
      
      private static var _config:Object;
      
      private static var obf_4_l_2645:Object;
      
      private static var obf_U_e_3155:Object;
      
      public function obf_G_4_4620()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Array = null;
         _config = param1;
         obf_4_l_2645 = new Object();
         obf_U_e_3155 = new Object();
         for each(_loc2_ in _config.godBlessList)
         {
            obf_4_l_2645[_loc2_.code] = _loc2_;
            if(!obf_U_e_3155.hasOwnProperty(_loc2_.godType))
            {
               obf_U_e_3155[_loc2_.godType] = new Array();
            }
            _loc3_ = obf_U_e_3155[_loc2_.godType];
            if(_loc3_.indexOf(_loc2_.code) == -1)
            {
               _loc3_.push(_loc2_.code);
            }
         }
      }
      
      public static function getMaxGodLevel() : int
      {
         if(!_config || !_config.godLevel)
         {
            return 0;
         }
         return _config.godLevel.length;
      }
      
      public static function getGodTypeList() : Array
      {
         var _loc2_:String = null;
         var _loc1_:Array = new Array();
         for(_loc2_ in obf_U_e_3155)
         {
            _loc1_.push(int(_loc2_));
         }
         return _loc1_;
      }
      
      public static function getGodBlessList(param1:int) : Array
      {
         return JSONUtil.getObject(obf_U_e_3155,[param1]) as Array;
      }
      
      public static function getGodLevelUpCondition(param1:int) : Object
      {
         return JSONUtil.getObject(_config,["godLevel",param1 - 1,"levelUpCond"]);
      }
      
      public static function getGodLevelName(param1:int) : String
      {
         return JSONUtil.getStr(_config,["godLevel",param1 - 1,"name"]);
      }
      
      public static function getGodTypeName(param1:int) : String
      {
         return DiversityManager.getString("BlessUI","txtGodTypeName_" + param1);
      }
      
      public static function getBlessName(param1:String) : String
      {
         return JSONUtil.getStr(obf_4_l_2645,[param1,"name"]);
      }
      
      public static function getAllBlessCode() : Array
      {
         var _loc2_:String = null;
         var _loc1_:Array = new Array();
         for(_loc2_ in obf_4_l_2645)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public static function getBlessLevelConfig(param1:String, param2:int) : Object
      {
         return JSONUtil.getObject(obf_4_l_2645,[param1,"levelInfoList",param2 - 1]);
      }
      
      public static function getBlessLevelLowPrice(param1:String, param2:int) : int
      {
         return JSONUtil.getInt(obf_4_l_2645,[param1,"lowPrice",param2 - 1]);
      }
      
      public static function sendStartBless(param1:String, param2:int) : void
      {
         var _loc3_:BlessStartRequest = new BlessStartRequest();
         _loc3_.blessCode = param1;
         _loc3_.blessPrice = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendStopBless() : void
      {
         var _loc1_:BlessStopRequest = new BlessStopRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendViewBlessBooth(param1:String) : void
      {
         var _loc2_:BlessVisitRequest = new BlessVisitRequest();
         _loc2_.blessOwnerId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendBuyBless(param1:String, param2:int, param3:int, param4:String) : void
      {
         var _loc5_:BlessBuyBuffRequest = new BlessBuyBuffRequest();
         _loc5_.blessCode = param1;
         _loc5_.blessLevel = param2;
         _loc5_.blessPrice = param3;
         _loc5_.blessOwnerId = param4;
         GameContext.worldClient.sendCommand(_loc5_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeBless.BLESS_CHECK_NOTIFY)
         {
            obf_s_j_1197(param1 as BlessCheckNotify);
         }
         else if(param1.code == CommandCodeBless.BLESS_VISIT_ANSWER)
         {
            obf_Q_t_3972(param1 as BlessVisitAnswer);
         }
      }
      
      private static function obf_s_j_1197(param1:BlessCheckNotify) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         if(obf_K_e_3075.blessBoothUI)
         {
            obf_K_e_3075.blessBoothUI.setBless(param1.isBless);
         }
         GameContext.localPlayer.setBlessing(param1.isBless,JSONUtil.getValue(param1.blessIngInfo,"blessCode"),JSONUtil.getValue(param1.blessIngInfo,"blessLevel"));
      }
      
      private static function obf_Q_t_3972(param1:BlessVisitAnswer) : void
      {
         if(obf_K_e_3075.obf_d_7_1584)
         {
            obf_K_e_3075.obf_d_7_1584.showBlessBooth(param1.blessIngInfo,param1.blessOwnerId);
         }
      }
   }
}

