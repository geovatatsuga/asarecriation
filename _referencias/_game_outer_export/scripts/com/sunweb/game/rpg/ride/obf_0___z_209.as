package com.sunweb.game.rpg.ride
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   import com.sunweb.game.rpg.worldZone.command.player.ride.PlayerRideFusionAnswer;
   import com.sunweb.game.rpg.worldZone.command.player.ride.PlayerRideFusionRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_0___z_209
   {
      
      public static var isRideAss:Boolean = true;
      
      public static var isRideFusion:Boolean = true;
      
      public static const obf_C_W_1491:String = "lifeApt";
      
      public static const obf_A_C_2113:String = "defenseApt";
      
      public static const ATTACK_APT:String = "attackApt";
      
      public static const obf_n_w_1135:String = "cureApt";
      
      public function obf_0___z_209()
      {
         super();
      }
      
      public static function getRideLevelConfig(param1:int) : Object
      {
         return WorldConfig.getValue("rideConfig","rideLevelArray",param1 - 1);
      }
      
      public static function get rideFoodItemCode() : String
      {
         return WorldConfig.getValue("rideConfig","rideExpItemCode");
      }
      
      public static function get rideFusionConfig() : Object
      {
         return WorldConfig.getValue("rideConfig","fusion");
      }
      
      public static function getMaxAptAtLevel(param1:String, param2:int, param3:String) : int
      {
         var _loc4_:Object = getRideLevelConfig(param2);
         if(!_loc4_)
         {
            return 0;
         }
         return getAptValueAtLevel(param1,param2,param3,JSONUtil.getInt(_loc4_,["availableExtraApt"]));
      }
      
      public static function getAptValueAtLevel(param1:String, param2:int, param3:String, param4:int) : int
      {
         var _loc7_:int = 0;
         var _loc5_:Object = GameItemManager.getItemConfig(param1);
         var _loc6_:Object = getRideLevelConfig(param2);
         if(!_loc5_ || !_loc6_)
         {
            return 0;
         }
         if(param3 == obf_C_W_1491)
         {
            _loc7_ = JSONUtil.getInt(_loc5_,["properties","lifeApt"]);
         }
         else if(param3 == obf_A_C_2113)
         {
            _loc7_ = JSONUtil.getInt(_loc5_,["properties","defenseApt"]);
         }
         else if(param3 == ATTACK_APT)
         {
            _loc7_ = JSONUtil.getInt(_loc5_,["properties","attackApt"]);
         }
         else
         {
            if(param3 != obf_n_w_1135)
            {
               return 0;
            }
            _loc7_ = JSONUtil.getInt(_loc5_,["properties","cureApt"]);
         }
         return (_loc7_ + param4) * (1 + JSONUtil.getNumber(_loc6_,["aptAddRate"]));
      }
      
      public static function sendRideFusion(param1:String, param2:String, param3:Object, param4:Object) : void
      {
         var _loc5_:PlayerRideFusionRequest = new PlayerRideFusionRequest();
         _loc5_.mainRideId = param1;
         _loc5_.minorRideId = param2;
         _loc5_.changeItem = param3;
         _loc5_.fusionItem = param4;
         GameContext.worldClient.sendCommand(_loc5_);
      }
      
      public static function get getRideBagsNum() : int
      {
         if(!WorldConfig.getValue("playerRideBag"))
         {
            return 8;
         }
         return WorldConfig.getValue("playerRideBag");
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayer.PLAYER_RIDE_FUSION_ANSWER)
         {
            obf_m_6_4107(param1 as PlayerRideFusionAnswer);
         }
      }
      
      private static function obf_m_6_4107(param1:PlayerRideFusionAnswer) : void
      {
         if(param1.isSucceeded)
         {
            obf_K_e_3075.rideFusionUI.obf_X_5_2917();
            obf_K_e_3075.rideFusionUI.obf_Z_6_2502();
            obf_K_e_3075.rideFusionUI.obf_2_B_4604();
            obf_K_e_3075.rideFusionUI.obf_v_m_991(param1.rideCode,param1.rideId);
            obf_K_e_3075.showCenterInfo(DiversityManager.getString("RideFusionUI","prompt_FusionComplete"));
         }
         else
         {
            obf_K_e_3075.showCenterInfo(DiversityManager.getString("RideFusionUI","prompt_FusionFailed"));
         }
      }
   }
}

