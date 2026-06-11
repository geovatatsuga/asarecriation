package obf_D_Y_975
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.player.pocket.CommandPlayerPocket;
   import com.sunweb.game.rpg.worldZone.command.player.pocket.PocketAddStoneAnswer;
   import com.sunweb.game.rpg.worldZone.command.player.pocket.PocketAddStoneRequest;
   import com.sunweb.game.rpg.worldZone.command.player.pocket.PocketInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.player.pocket.PocketItemInOutAnswer;
   import com.sunweb.game.rpg.worldZone.command.player.pocket.PocketItemInOutRequest;
   import com.sunweb.game.rpg.worldZone.command.player.pocket.PocketRefineryRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_7_q_3477
   {
      
      public static var _pocketConfig:Object;
      
      public function obf_7_q_3477()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         _pocketConfig = new Object();
         _pocketConfig = param1;
      }
      
      public static function get openCondition() : Object
      {
         return JSONUtil.getObject(_pocketConfig,["openCondition"]);
      }
      
      public static function get assemble() : String
      {
         return JSONUtil.getStr(_pocketConfig,["assemble"]);
      }
      
      public static function get lockItems() : Array
      {
         return JSONUtil.getValue(_pocketConfig,["lockItem"]) as Array;
      }
      
      public static function getLockItemConfig(param1:String) : Object
      {
         var _loc2_:Object = null;
         for each(_loc2_ in lockItems)
         {
            if(_loc2_.itemCode == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function get refineryNeedNum() : int
      {
         return JSONUtil.getInt(_pocketConfig,["refinery","needNum"]);
      }
      
      public static function get refineryItemCode() : String
      {
         return JSONUtil.getStr(_pocketConfig,["refinery","itemCode"]);
      }
      
      public static function get pocketSlots() : Array
      {
         return JSONUtil.getValue(_pocketConfig,["pocketSlot"]) as Array;
      }
      
      public static function get stoneLoop() : Array
      {
         return JSONUtil.getValue(_pocketConfig,["stoneLoop"]) as Array;
      }
      
      public static function obf_B_l_1212(param1:int, param2:int, param3:String) : void
      {
         var _loc4_:PocketAddStoneRequest = new PocketAddStoneRequest();
         _loc4_.type = param1;
         _loc4_.pocketIndex = param2;
         _loc4_.itemCode = param3;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public static function obf_w_c_1946(param1:int, param2:String, param3:int) : void
      {
         var _loc4_:PocketItemInOutRequest = new PocketItemInOutRequest();
         _loc4_.type = param1;
         _loc4_.itemCode = param2;
         _loc4_.itemNum = param3;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public static function obf_i_z_4130() : void
      {
         var _loc1_:PocketRefineryRequest = new PocketRefineryRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandPlayerPocket.POCKET_INFO_NOTIFY)
         {
            obf_s_9_2693(param1 as PocketInfoNotify);
         }
         else if(param1.code == CommandPlayerPocket.POCKET_ADD_STONE_ANSWER)
         {
            obf_z_9_1253(param1 as PocketAddStoneAnswer);
         }
         else if(param1.code == CommandPlayerPocket.POCKET_ITEM_IN_OUT_ANSWER)
         {
            obf_0_9_Y_60(param1 as PocketItemInOutAnswer);
         }
      }
      
      public static function obf_s_9_2693(param1:PocketInfoNotify) : void
      {
         obf_K_e_3075.pocketSlotUI.setStones(param1.stones);
         obf_K_e_3075.pocketItemUI.setItems(param1.pocketItems);
      }
      
      public static function obf_z_9_1253(param1:PocketAddStoneAnswer) : void
      {
         obf_K_e_3075.pocketSlotUI.setStones(param1.stones);
      }
      
      public static function obf_0_9_Y_60(param1:PocketItemInOutAnswer) : void
      {
         obf_K_e_3075.pocketItemUI.setItems(param1.pocketItems);
      }
   }
}

