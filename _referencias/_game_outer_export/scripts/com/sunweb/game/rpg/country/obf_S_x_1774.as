package com.sunweb.game.rpg.country
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.country.CommandCodePlayerCountry;
   import com.sunweb.game.rpg.worldZone.command.country.PlayerCountryInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.country.PlayerCreaturesNotify;
   import com.sunweb.game.rpg.worldZone.command.country.PlayerOriginsNotify;
   import com.sunweb.game.rpg.worldZone.command.country.PlayerUpCountryAnswer;
   import com.sunweb.game.rpg.worldZone.command.country.PlayerUpCountryRequest;
   import com.sunweb.game.rpg.worldZone.command.country.PlayerUpLandAnswer;
   import com.sunweb.game.rpg.worldZone.command.country.PlayerUpLandRequest;
   import com.sunweb.game.rpg.worldZone.command.country.PlayerWillsNotify;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_S_x_1774
   {
      
      private static var countryConfig:Object;
      
      public function obf_S_x_1774()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         countryConfig = param1;
      }
      
      public static function countryLevelsObject(param1:int) : Object
      {
         var _loc2_:Array = JSONUtil.getObject(countryConfig,["countryLevels"]) as Array;
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_[param1];
      }
      
      public static function countryMaxLevels() : int
      {
         var _loc1_:Array = JSONUtil.getObject(countryConfig,["countryLevels"]) as Array;
         return _loc1_.length;
      }
      
      public static function get countryLandList() : Array
      {
         return JSONUtil.getObject(countryConfig,["landList"]) as Array;
      }
      
      public static function get countryOpenCond() : Object
      {
         return JSONUtil.getObject(countryConfig,["openCondition"]);
      }
      
      public static function sendUpCountryReq() : void
      {
         var _loc1_:PlayerUpCountryRequest = new PlayerUpCountryRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendUpLandReq(param1:String) : void
      {
         var _loc2_:PlayerUpLandRequest = new PlayerUpLandRequest();
         _loc2_.landName = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerCountry.PLAYER_COUNTRY_INFO_NOTIFY)
         {
            obf_0_g_4455(param1 as PlayerCountryInfoNotify);
         }
         else if(param1.code == CommandCodePlayerCountry.PLAYER_UP_COUNTRY_ANSWER)
         {
            obf_I_6_1187(param1 as PlayerUpCountryAnswer);
         }
         else if(param1.code == CommandCodePlayerCountry.PLAYER_UP_LAND_ANSWER)
         {
            obf_k_z_1571(param1 as PlayerUpLandAnswer);
         }
         else if(param1.code == CommandCodePlayerCountry.PLAYER_WILLS_NOTIFY)
         {
            obf_H_M_3168(param1 as PlayerWillsNotify);
         }
         else if(param1.code == CommandCodePlayerCountry.PLAYER_CREATURES_NOTIFY)
         {
            obf_Q_q_867(param1 as PlayerCreaturesNotify);
         }
         else if(param1.code == CommandCodePlayerCountry.PLAYER_ORIGINS_NOTIFY)
         {
            obf_0_0_A_100(param1 as PlayerOriginsNotify);
         }
      }
      
      private static function obf_0_g_4455(param1:PlayerCountryInfoNotify) : void
      {
         obf_K_e_3075.countryUI.showCountryInfo(param1.countryLevel);
         obf_K_e_3075.countryUI.getLandObject(param1.landsLevel);
         obf_K_e_3075.countryUI.showWills(param1.wills);
         obf_K_e_3075.countryUI.showCreatures(param1.creatures);
         obf_K_e_3075.countryUI.showOrigins(param1.origins);
      }
      
      private static function obf_I_6_1187(param1:PlayerUpCountryAnswer) : void
      {
         obf_K_e_3075.countryUI.showCountryInfo(param1.countryLevel);
         obf_K_e_3075.countryUI.showWills(param1.wills);
      }
      
      private static function obf_k_z_1571(param1:PlayerUpLandAnswer) : void
      {
         obf_K_e_3075.countryUI.getLandObject(param1.landsLevel);
         obf_K_e_3075.countryUI.showCreatures(param1.creatures);
         obf_K_e_3075.countryUI.showOrigins(param1.origins);
      }
      
      private static function obf_H_M_3168(param1:PlayerWillsNotify) : void
      {
         obf_K_e_3075.countryUI.showWills(param1.wills);
      }
      
      private static function obf_Q_q_867(param1:PlayerCreaturesNotify) : void
      {
         obf_K_e_3075.countryUI.showCreatures(param1.creatures);
      }
      
      private static function obf_0_0_A_100(param1:PlayerOriginsNotify) : void
      {
         obf_K_e_3075.countryUI.showOrigins(param1.origins);
      }
   }
}

