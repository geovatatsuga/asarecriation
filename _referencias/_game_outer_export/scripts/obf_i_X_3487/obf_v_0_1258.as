package obf_i_X_3487
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.rpg.worldZone.command.tree.CommandCodePlayerTree;
   import com.sunweb.game.rpg.worldZone.command.tree.TreeAddExpAnswer;
   import com.sunweb.game.rpg.worldZone.command.tree.TreeAddExpRequest;
   import com.sunweb.game.rpg.worldZone.command.tree.TreeGetItemAnswer;
   import com.sunweb.game.rpg.worldZone.command.tree.TreeGetItemRequest;
   import com.sunweb.game.rpg.worldZone.command.tree.TreeInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.tree.TreeUpRankAnswer;
   import com.sunweb.game.rpg.worldZone.command.tree.TreeUpRankRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_v_0_1258
   {
      
      private static var treeConfig:Object;
      
      private static var getItemSign:String = "$treeItem";
      
      public function obf_v_0_1258()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         treeConfig = param1;
      }
      
      public static function get openCondition() : Object
      {
         return JSONUtil.getObject(treeConfig,["openCondition"]);
      }
      
      public static function get rankMax() : int
      {
         var _loc1_:Array = JSONUtil.getObject(treeConfig,["treeRanks"]) as Array;
         if(_loc1_.length <= 0)
         {
            return 0;
         }
         return _loc1_.length;
      }
      
      public static function getRankConfig(param1:int) : Object
      {
         var _loc2_:Array = JSONUtil.getObject(treeConfig,["treeRanks"]) as Array;
         if(!_loc2_ || _loc2_.length <= 0 || param1 > _loc2_.length)
         {
            return null;
         }
         return _loc2_[param1 - 1];
      }
      
      public static function getLevelMax(param1:int) : int
      {
         var _loc2_:Object = getRankConfig(param1);
         if(!_loc2_ || !_loc2_.levels || _loc2_.levels.length <= 0)
         {
            return 0;
         }
         return _loc2_.levels.length;
      }
      
      public static function getLevelConfig(param1:int, param2:int) : Object
      {
         var _loc3_:Object = getRankConfig(param1);
         if(!_loc3_ || !_loc3_.levels || _loc3_.levels.length <= 0)
         {
            return 0;
         }
         return _loc3_.levels[param2 - 1];
      }
      
      public static function getTreeCost() : Object
      {
         var _loc1_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter(getItemSign);
         var _loc2_:int = JSONUtil.getInt(_loc1_,["numOfDay"]);
         var _loc3_:Array = JSONUtil.getObject(treeConfig,["treeCost"]) as Array;
         if(!_loc3_ || _loc3_.length <= 0 || _loc2_ >= _loc3_.length)
         {
            return null;
         }
         return _loc3_[_loc2_];
      }
      
      public static function get treeItemCode() : String
      {
         return JSONUtil.getStr(treeConfig,["treeItemCode"]);
      }
      
      public static function get upRankItem() : String
      {
         return JSONUtil.getStr(treeConfig,["upRankItem"]);
      }
      
      public static function get expItem() : String
      {
         return JSONUtil.getStr(treeConfig,["expItem"]);
      }
      
      public static function get addExp() : int
      {
         return JSONUtil.getInt(treeConfig,["addExp"]);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerTree.TREE_INFO_NOTIFY)
         {
            obf_w_g_2297(param1 as TreeInfoNotify);
         }
         if(param1.code == CommandCodePlayerTree.TREE_ADD_EXP_ANSWER)
         {
            obf_n_U_973(param1 as TreeAddExpAnswer);
         }
         if(param1.code == CommandCodePlayerTree.TREE_UP_RANK_ANSWER)
         {
            obf_l_E_2048(param1 as TreeUpRankAnswer);
         }
         if(param1.code == CommandCodePlayerTree.TREE_GET_ITEM_ANSWER)
         {
            obf_t_e_2677(param1 as TreeGetItemAnswer);
         }
      }
      
      public static function obf_w_g_2297(param1:TreeInfoNotify) : void
      {
         obf_K_e_3075.treeBoxUI.setInfo(param1.rank,param1.level,param1.exp);
      }
      
      public static function obf_n_U_973(param1:TreeAddExpAnswer) : void
      {
         obf_K_e_3075.treeBoxUI.setTreeLevel(param1.level);
         obf_K_e_3075.treeBoxUI.setTreeExp(param1.exp);
      }
      
      public static function obf_l_E_2048(param1:TreeUpRankAnswer) : void
      {
         obf_K_e_3075.treeBoxUI.setInfo(param1.rank,param1.level,param1.exp);
      }
      
      public static function obf_t_e_2677(param1:TreeGetItemAnswer) : void
      {
         obf_K_e_3075.treeBoxUI.changeGetItem();
      }
      
      public static function sendTreeAddExpRequest() : void
      {
         var _loc1_:TreeAddExpRequest = new TreeAddExpRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendTreeUpRankRequest() : void
      {
         var _loc1_:TreeUpRankRequest = new TreeUpRankRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendTreeGetItemRequest() : void
      {
         var _loc1_:TreeGetItemRequest = new TreeGetItemRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
   }
}

