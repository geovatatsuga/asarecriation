package obf_0_6_Z_584
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.varShop.CommandCodeVarShop;
   import com.sunweb.game.rpg.worldZone.command.varShop.VarShopBuyAnswer;
   import com.sunweb.game.rpg.worldZone.command.varShop.VarShopBuyRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_5_M_1027
   {
      
      private static var _shopTypes:Object;
      
      private static var _shopKinds:Object;
      
      public function obf_5_M_1027()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc2_:Array = JSONUtil.getValue(param1,["shopTypes"]) as Array;
         if(_loc2_)
         {
            _shopTypes = new Object();
            for each(_loc4_ in _loc2_)
            {
               _shopTypes[JSONUtil.getStr(_loc4_,["id"])] = _loc4_;
            }
         }
         var _loc3_:Array = JSONUtil.getValue(param1,["shopKinds"]) as Array;
         if(_loc3_)
         {
            _shopKinds = new Object();
            for each(_loc5_ in _loc3_)
            {
               _shopKinds[JSONUtil.getInt(_loc5_,["kind"])] = _loc5_;
            }
         }
      }
      
      public static function get shopTypes() : Object
      {
         return _shopTypes;
      }
      
      public static function get shopKinds() : Object
      {
         return _shopKinds;
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeVarShop.VAR_SHOP_BUY_ANSWER)
         {
            obf_d_s_4061(param1 as VarShopBuyAnswer);
         }
      }
      
      public static function obf_d_s_4061(param1:VarShopBuyAnswer) : void
      {
         obf_K_e_3075.varShopBoxUI.setPlayerVarValue();
      }
      
      public static function obf_e_f_2690(param1:String, param2:int, param3:String) : void
      {
         var _loc4_:VarShopBuyRequest = new VarShopBuyRequest();
         _loc4_.shopId = param1;
         _loc4_.kind = param2;
         _loc4_.itemCode = param3;
         GameContext.worldClient.sendCommand(_loc4_);
      }
   }
}

