package com.sunweb.game.rpg.playerUI.managers
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObject;
   
   public class ButtonToItemManager
   {
      
      private static var _config:Object;
      
      public function ButtonToItemManager()
      {
         super();
      }
      
      public static function init(param1:Array) : void
      {
         var _loc2_:Object = null;
         _config = new Object();
         for each(_loc2_ in param1)
         {
            _config[_loc2_.id] = _loc2_;
         }
      }
      
      public static function getBTIConfig(param1:String) : Object
      {
         return JSONUtil.getObject(_config,[param1]);
      }
      
      public static function useBTIById(param1:String, param2:* = null, param3:Boolean = false) : void
      {
         var _loc7_:String = null;
         var _loc8_:Object = null;
         var _loc9_:DisplayObject = null;
         var _loc4_:Object = getBTIConfig(param1);
         if(!_loc4_ || obf_L_l_4100.isEmpty(_loc4_.itemCode) || !obf_K_e_3075.playerBagUI)
         {
            return;
         }
         var _loc5_:Array = String(_loc4_.itemCode).split(",");
         var _loc6_:String = _loc5_[_loc5_.length - 1];
         for each(_loc7_ in _loc5_)
         {
            if(obf_K_e_3075.playerBagUI.getItemCount(_loc7_) > 0)
            {
               _loc6_ = _loc7_;
               break;
            }
         }
         _loc8_ = GameItemManager.getItemConfig(_loc6_);
         _loc9_ = GameItemManager.getItemIcon(_loc6_);
         if(_loc9_)
         {
            _loc9_.x = -16;
            _loc9_.y = -16;
         }
         if(obf_K_e_3075.playerBagUI.getItemCount(_loc6_) > 0)
         {
            if(!obf_L_l_4100.isEmpty(_loc4_.confirm) && !param3)
            {
               WindowManager.showConfirmBox(JSONUtil.getStr(_loc8_,["remark"]) + "\n\n" + String(_loc4_.confirm).replace("_%0_",obf_7_6_4416.getItemLinkA(_loc6_,"")),confirmUseItem,{
                  "itemCode":_loc6_,
                  "autoBuy":_loc4_.autoBuyInStore,
                  "useItemPar":param2
               },[_loc9_]);
            }
            else
            {
               useItem(_loc6_,param2,param3);
            }
         }
         else if(_loc4_.autoBuyInStore)
         {
            if(param3)
            {
               useItem(_loc6_,param2,param3);
            }
            else
            {
               WindowManager.showConfirmBox(JSONUtil.getStr(_loc8_,["remark"]) + "\n\n" + DiversityManager.getString("ItemPrompt","autoBuyItemConfirm",[obf_7_6_4416.getItemLinkA(_loc6_,""),obf_a_f_2935.getMoneyString(GameItemManager.getItemMoneyBuy(_loc6_))]),confirmAutoBuyToUse,{
                  "itemCode":_loc6_,
                  "par":param2
               },[_loc9_]);
            }
         }
         else
         {
            WindowManager.showMessageBox(DiversityManager.getString("ItemPrompt","useItemError_NeedOtherItem",[GameItemManager.getItemName(_loc6_)]) + "\n\n" + JSONUtil.getStr(_loc8_,["remark"]));
         }
      }
      
      private static function confirmUseItem(param1:Object) : void
      {
         if(param1.confirm)
         {
            useItem(param1.par.itemCode,param1.par.useItemPar);
         }
      }
      
      private static function useItem(param1:String, param2:* = null, param3:Boolean = false) : void
      {
         if(!obf_K_e_3075.playerBagUI)
         {
            return;
         }
         var _loc4_:IconItemBag = obf_K_e_3075.playerBagUI.getIconItemBagByCode(param1);
         if((Boolean(_loc4_)) && Boolean(_loc4_.haveIconItem))
         {
            _loc4_.haveIconItem.useIcon(param2);
         }
         else if(param3)
         {
            GameContext.bagItemManager.sendBuyAndUseItem(param1,null,null,param2);
         }
         else
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_NeedOtherItem",[GameItemManager.getItemName(param1)]));
         }
      }
      
      private static function confirmAutoBuyToUse(param1:Object) : void
      {
         if(param1.confirm)
         {
            if(GameContext.localPlayer.fullInfo.money < GameItemManager.getItemMoneyBuy(JSONUtil.getStr(param1,["par","itemCode"])))
            {
               obf_K_e_3075.showShortOfMoney();
               return;
            }
            GameContext.bagItemManager.sendBuyAndUseItem(JSONUtil.getStr(param1,["par","itemCode"]),null,null,JSONUtil.getObject(param1,["par","par"]));
         }
      }
   }
}

