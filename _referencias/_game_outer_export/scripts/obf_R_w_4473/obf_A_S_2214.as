package obf_R_w_4473
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.favor.CommandPlayerFavor;
   import com.sunweb.game.rpg.worldZone.command.favor.PlayerFavorOfferAnswer;
   import com.sunweb.game.rpg.worldZone.command.favor.PlayerFavorOfferRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_A_S_2214
   {
      
      private static var favorConfig:Object;
      
      public function obf_A_S_2214()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         favorConfig = param1;
      }
      
      public static function getStuffs() : Array
      {
         return JSONUtil.getValue(favorConfig,["stuffs"]) as Array;
      }
      
      public static function getItemOffers() : Object
      {
         return JSONUtil.getValue(favorConfig,["itemOffers"]) as Object;
      }
      
      public static function getOfferValues() : Array
      {
         return JSONUtil.getValue(favorConfig,["offerLevel"]) as Array;
      }
      
      public static function getFavorValues() : Array
      {
         return JSONUtil.getValue(favorConfig,["favourLevel"]) as Array;
      }
      
      public static function getRemark() : String
      {
         return JSONUtil.getStr(favorConfig,["remark"]) as String;
      }
      
      public static function sendFavor(param1:Object) : void
      {
         var _loc2_:PlayerFavorOfferRequest = new PlayerFavorOfferRequest();
         _loc2_.items = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandPlayerFavor.PLAYER_FAVOR_OFFER_ANSWER)
         {
            obf_K_e_3075.favorUI.refrshFaverLv((param1 as PlayerFavorOfferAnswer).favorValue);
         }
      }
   }
}

