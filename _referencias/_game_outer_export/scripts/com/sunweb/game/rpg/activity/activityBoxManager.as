package com.sunweb.game.rpg.activity
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.activityBox.CommandTermConfig;
   import com.sunweb.game.rpg.worldZone.command.activityBox.ConsumeRankItemNotify;
   import com.sunweb.game.rpg.worldZone.command.activityBox.ConsumeRankNotify;
   import com.sunweb.game.rpg.worldZone.command.activityBox.Specially214BuyRequest;
   import com.sunweb.game.rpg.worldZone.command.activityBox.SpeciallyBuyRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class activityBoxManager
   {
      
      private static var termConfig:Object;
      
      public function activityBoxManager()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         termConfig = param1;
      }
      
      public static function getTermActivity() : Array
      {
         return JSONUtil.getValue(termConfig,["termActivity"]) as Array;
      }
      
      public static function getSpeciallyItemConfig() : Object
      {
         return JSONUtil.getObject(termConfig,["speciallyActivity"]);
      }
      
      public static function getSpecially214() : Object
      {
         return JSONUtil.getObject(termConfig,["specially214"]);
      }
      
      public static function getConsumeRank() : Object
      {
         return JSONUtil.getObject(termConfig,["consumeRank"]);
      }
      
      public static function sendBuyItem(param1:String, param2:int) : void
      {
         var _loc3_:SpeciallyBuyRequest = new SpeciallyBuyRequest();
         _loc3_.itemCode = param1;
         _loc3_.itemNum = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendSpecialBuyItem(param1:String) : void
      {
         var _loc2_:Specially214BuyRequest = new Specially214BuyRequest();
         _loc2_.itemCode = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandTermConfig.CONSUME_RANK_NOTIFY)
         {
            obf_K_e_3075.consumeRankingUI.obf_N_n_916(param1 as ConsumeRankNotify);
         }
         else if(param1.code == CommandTermConfig.CONSUME_RANK_ITEM_NOTIFY)
         {
            obf_K_e_3075.consumeRankingUI.showAwerdsTip(param1 as ConsumeRankItemNotify);
         }
      }
   }
}

