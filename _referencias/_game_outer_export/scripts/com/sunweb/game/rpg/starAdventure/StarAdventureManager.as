package com.sunweb.game.rpg.starAdventure
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.starAdventure.CommandCodePlayerStars;
   import com.sunweb.game.rpg.worldZone.command.starAdventure.PlayerStarsAdventureAnswer;
   import com.sunweb.game.rpg.worldZone.command.starAdventure.PlayerStarsAdventureRequest;
   import com.sunweb.game.rpg.worldZone.command.starAdventure.PlayerStarsInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.starAdventure.PlayerStarsUpChartRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class StarAdventureManager
   {
      
      private static var starConfig:Object;
      
      public function StarAdventureManager()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         starConfig = param1;
      }
      
      public static function get starOpenCond() : Object
      {
         return JSONUtil.getObject(starConfig,["openCon"]);
      }
      
      public static function get starChartLevels() : Array
      {
         return JSONUtil.getObject(starConfig,["chartLevels"]) as Array;
      }
      
      public static function get starAdventureItems() : Object
      {
         return JSONUtil.getObject(starConfig,["adventureItems"]);
      }
      
      public static function get starAdventure() : Object
      {
         return JSONUtil.getObject(starConfig,["adventure"]);
      }
      
      public static function sendStarsUpReq() : void
      {
         var _loc1_:PlayerStarsUpChartRequest = new PlayerStarsUpChartRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendStarsAdvReq() : void
      {
         var _loc1_:PlayerStarsAdventureRequest = new PlayerStarsAdventureRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerStars.PLAYER_STARS_INFO_NOTIFY)
         {
            obf_O_5_758(param1 as PlayerStarsInfoNotify);
         }
         else if(param1.code == CommandCodePlayerStars.PLAYER_STARS_ADVENTURE_ANSWER)
         {
            obf_y_p_3281(param1 as PlayerStarsAdventureAnswer);
         }
      }
      
      private static function obf_O_5_758(param1:PlayerStarsInfoNotify) : void
      {
         obf_K_e_3075.starAdventureUI.showStarAdvInfo(param1.chartLevel,param1.stars);
      }
      
      private static function obf_y_p_3281(param1:PlayerStarsAdventureAnswer) : void
      {
         obf_K_e_3075.starAdventureUI.showMsg(param1.items);
      }
   }
}

