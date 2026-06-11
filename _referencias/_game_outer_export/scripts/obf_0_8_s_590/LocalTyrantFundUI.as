package obf_0_8_s_590
{
   import obf_l_I_3561.obf_g_0_3344;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.utils.JSONUtil;
   import fl.events.ScrollEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import playerUI.FundUIMC;
   
   public class LocalTyrantFundUI extends FundUIMC implements IIconItemUI
   {
      
      private var bags:Array = new Array();
      
      public function LocalTyrantFundUI()
      {
         super();
         this.visible = false;
         rewardPoint.scrollRect = new Rectangle(0,0,obf_H_w_3575.x - rewardPoint.x,obf_H_w_3575.height - 5);
         obf_H_w_3575.pageSize = obf_H_w_3575.height;
         isVipTxt.visible = false;
         vipIsTxt.visible = false;
         this.initDiversity();
         this.addListener();
      }
      
      private function addListener() : void
      {
         cmdBuy.addEventListener(MouseEvent.CLICK,this.obf_b_i_1293);
         obf_H_w_3575.addEventListener(ScrollEvent.SCROLL,this.onScrollList);
      }
      
      private function removeListener() : void
      {
         cmdBuy.removeEventListener(MouseEvent.CLICK,this.obf_b_i_1293);
         obf_H_w_3575.removeEventListener(ScrollEvent.SCROLL,this.onScrollList);
      }
      
      private function onScrollList(param1:Event) : void
      {
         rewardPoint.scrollRect = new Rectangle(0,obf_H_w_3575.scrollPosition,obf_H_w_3575.x - rewardPoint.x,rewardPoint.height);
      }
      
      private function obf_b_i_1293(param1:Event) : void
      {
         var _loc2_:int = JSONUtil.getInt(obf_g_0_3344.getLocalTyrantFund(),["needMoney"]);
         if(GameContext.localPlayer.fullInfo.money < _loc2_)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FundUI","noMoney"));
            return;
         }
         obf_g_0_3344.sendFundBuyRequest(2);
      }
      
      private function obf_2_Y_3019() : void
      {
         vipIsTxt.textColor = GameContext.localPlayer.fullInfo.vipLevel > 0 ? 16711680 : 3407616;
         var _loc1_:int = obf_g_0_3344.buyNum;
         DiversityManager.setTextField(obf_p_W_1357,"FundUI","number",[_loc1_]);
         this.obf_7_E_4314(obf_g_0_3344.isbuyLocalTyrantFund);
      }
      
      public function obf_K_X_4449(param1:int) : void
      {
         DiversityManager.setTextField(obf_p_W_1357,"FundUI","number",[param1]);
      }
      
      public function obf_B_v_1525() : void
      {
         var _loc2_:SmallGetBoxUI = null;
         var _loc8_:String = null;
         var _loc9_:IconItem = null;
         var _loc10_:String = null;
         var _loc1_:int = -1;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Object = obf_g_0_3344.rewardList;
         this.bags = new Array();
         var _loc6_:Array = obf_g_0_3344.getLocalFundList();
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_.length)
         {
            _loc2_ = new SmallGetBoxUI(this,2,_loc6_[_loc7_],true);
            _loc8_ = JSONUtil.getStr(_loc6_[_loc7_],["itemCode"]);
            _loc9_ = IconItemManager.getIconItemByCode(_loc8_,"");
            if(_loc9_)
            {
               _loc2_.iconBag.pushIconItem(_loc9_);
               this.bags.push(_loc2_.iconBag);
               if(++_loc1_ > 1)
               {
                  _loc1_ = 0;
                  _loc3_ += _loc2_.height - 40;
               }
               _loc2_.x = _loc2_.width * _loc1_;
               _loc2_.y = _loc3_;
               _loc4_ = _loc2_.y + _loc2_.height;
            }
            for(_loc10_ in _loc5_)
            {
               if(_loc6_[_loc7_].id == _loc10_)
               {
                  _loc2_.obf_O_L_2941(_loc5_[_loc10_]);
               }
            }
            rewardPoint.addChild(_loc2_);
            if(_loc4_ > obf_H_w_3575.height)
            {
               if(rewardPoint.scrollRect.y > _loc4_ - obf_H_w_3575.height)
               {
                  rewardPoint.scrollRect = new Rectangle(0,_loc4_ - obf_H_w_3575.height,obf_H_w_3575.x - rewardPoint.x,obf_H_w_3575.height);
               }
               obf_H_w_3575.maxScrollPosition = _loc4_ - obf_H_w_3575.height;
               obf_H_w_3575.scrollPosition = rewardPoint.scrollRect.y;
            }
            _loc7_++;
         }
      }
      
      public function obf_7_E_4314(param1:Boolean) : void
      {
         cmdBuy.label = param1 ? DiversityManager.getString("FundUI","bought") : DiversityManager.getString("FundUI","buy");
         cmdBuy.visible = !param1;
         cmdBuy.mouseEnabled = !param1;
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
      
      public function get mouseOn() : Boolean
      {
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(isVipTxt,"FundUI","isVip");
         DiversityManager.setTextField(curBuyTxt,"FundUI","curBuy");
         DiversityManager.setTextField(vipIsTxt,"FundUI","vip");
         txtRemark.htmlText = JSONUtil.getStr(obf_g_0_3344.getLocalTyrantFund(),["explanation"]);
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.obf_2_Y_3019();
         this.obf_B_v_1525();
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         obf_H_w_3575.maxScrollPosition = 0;
      }
      
      public function destroy() : void
      {
         this.removeListener();
         obf_H_w_3575.maxScrollPosition = 0;
      }
   }
}

