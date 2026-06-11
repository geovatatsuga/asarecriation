package obf_Z_Y_1344
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.itemManual.CommandCodeItemManual;
   import com.sunweb.game.rpg.worldZone.command.itemManual.ItemManualInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.itemManual.ItemManualListNotify;
   import com.sunweb.game.rpg.worldZone.command.itemManual.ItemManualLotteryAnswer;
   import com.sunweb.game.rpg.worldZone.command.itemManual.ItemManualLotteryRequest;
   import com.sunweb.game.rpg.worldZone.command.itemManual.ItemManualSellAnswer;
   import com.sunweb.game.rpg.worldZone.command.itemManual.ItemManualSellRequest;
   import com.sunweb.game.rpg.worldZone.command.itemManual.ItemManualStarValueNotify;
   import com.sunweb.game.rpg.worldZone.command.itemManual.ItemManualSuccessAnswer;
   import com.sunweb.game.rpg.worldZone.command.itemManual.ItemManualSuccessAwardAnswer;
   import com.sunweb.game.rpg.worldZone.command.itemManual.ItemManualSuccessAwardRequest;
   import com.sunweb.game.rpg.worldZone.command.itemManual.ItemManualSuccessRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class ItemManualManager
   {
      
      public static var itemManualConfig:Object;
      
      public function ItemManualManager()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         itemManualConfig = param1;
      }
      
      public static function get itemManualOpenCond() : Object
      {
         return JSONUtil.getObject(itemManualConfig,["openCondition"]);
      }
      
      public static function itemManualKind() : Array
      {
         return JSONUtil.getObject(itemManualConfig,["kind"]) as Array;
      }
      
      public static function itemManualLottery() : Object
      {
         return JSONUtil.getObject(itemManualConfig,["lottery"]);
      }
      
      public static function itemManualLotteryNeed() : int
      {
         return JSONUtil.getInt(itemManualConfig,["lotteryNeed"]);
      }
      
      public static function itemManualSuccess() : Array
      {
         return JSONUtil.getObject(itemManualConfig,["success"]) as Array;
      }
      
      public static function sendItemManualLotteryReq(param1:int) : void
      {
         var _loc2_:ItemManualLotteryRequest = new ItemManualLotteryRequest();
         _loc2_.type = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendItemManualSuccessReq(param1:String) : void
      {
         var _loc2_:ItemManualSuccessRequest = new ItemManualSuccessRequest();
         _loc2_.successId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendItemManualSuccessAwardReq(param1:String) : void
      {
         var _loc2_:ItemManualSuccessAwardRequest = new ItemManualSuccessAwardRequest();
         _loc2_.successId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendItemManualSellReq(param1:String, param2:int) : void
      {
         var _loc3_:ItemManualSellRequest = new ItemManualSellRequest();
         _loc3_.sellCode = param1;
         _loc3_.type = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeItemManual.ITEM_MANUAL_INFO_NOTIFY)
         {
            obf_c_G_2028(param1 as ItemManualInfoNotify);
         }
         else if(param1.code == CommandCodeItemManual.ITEM_MANUAL_LIST_NOTIFY)
         {
            obf_0_8_5_481(param1 as ItemManualListNotify);
         }
         else if(param1.code == CommandCodeItemManual.ITEM_MANUAL_LOTTERY_ANSWER)
         {
            obf_v_j_2080(param1 as ItemManualLotteryAnswer);
         }
         else if(param1.code == CommandCodeItemManual.ITEM_MANUAL_SELL_ANSWER)
         {
            obf_1_8_803(param1 as ItemManualSellAnswer);
         }
         else if(param1.code == CommandCodeItemManual.ITEM_MANUAL_STAR_VALUE_NOTIFY)
         {
            native(param1 as ItemManualStarValueNotify);
         }
         else if(param1.code == CommandCodeItemManual.ITEM_MANUAL_SUCCESS_ANSWER)
         {
            obf_r_v_904(param1 as ItemManualSuccessAnswer);
         }
         else if(param1.code == CommandCodeItemManual.ITEM_MANUAL_SUCCESS_AWARD_ANSWER)
         {
            obf_f_9_1392(param1 as ItemManualSuccessAwardAnswer);
         }
      }
      
      private static function obf_c_G_2028(param1:ItemManualInfoNotify) : void
      {
         obf_K_e_3075.itemManualUI.itemManualMap(param1.itemManualMap);
         obf_K_e_3075.itemManualUI.starValue(param1.starValue);
         obf_K_e_3075.itemManualUI.successIds(param1.successIds);
         obf_K_e_3075.itemManualUI.awardSuccessIds(param1.awardSuccessIds);
      }
      
      private static function obf_0_8_5_481(param1:ItemManualListNotify) : void
      {
         obf_K_e_3075.itemManualUI.itemManualMap(param1.itemManualMap);
      }
      
      private static function obf_v_j_2080(param1:ItemManualLotteryAnswer) : void
      {
         obf_K_e_3075.itemManualUI.getCodes(param1.getCodes);
      }
      
      private static function obf_1_8_803(param1:ItemManualSellAnswer) : void
      {
         obf_K_e_3075.itemManualUI.itemManualChange(param1.change);
      }
      
      private static function native(param1:ItemManualStarValueNotify) : void
      {
         obf_K_e_3075.itemManualUI.starValue(param1.starValue);
      }
      
      private static function obf_r_v_904(param1:ItemManualSuccessAnswer) : void
      {
         obf_K_e_3075.itemManualUI.successIds(param1.successIds);
         obf_K_e_3075.itemManualUI.awardSuccessIds(param1.awardSuccessIds);
      }
      
      private static function obf_f_9_1392(param1:ItemManualSuccessAwardAnswer) : void
      {
         obf_K_e_3075.itemManualUI.awardSuccessIds(param1.awardSuccessIds);
      }
   }
}

