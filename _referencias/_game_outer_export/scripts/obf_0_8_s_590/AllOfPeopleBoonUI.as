package obf_0_8_s_590
{
   import obf_l_I_3561.obf_g_0_3344;
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
   import playerUI.AllOfPeopleBoonUIMC;
   
   public class AllOfPeopleBoonUI extends AllOfPeopleBoonUIMC implements IIconItemUI
   {
      
      private var bags:Array = new Array();
      
      public function AllOfPeopleBoonUI()
      {
         super();
         this.visible = false;
         rewardPoint.scrollRect = new Rectangle(0,0,obf_H_w_3575.x - rewardPoint.x,obf_H_w_3575.height - 5);
         obf_H_w_3575.pageSize = obf_H_w_3575.height;
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
      
      private function obf_b_i_1293(param1:Event) : void
      {
         if(!obf_g_0_3344.isbuyFund)
         {
            obf_K_e_3075.fundBgBoxUI.showOther(1);
         }
         else if(!obf_g_0_3344.isbuyLocalTyrantFund)
         {
            obf_K_e_3075.fundBgBoxUI.showOther(2);
         }
      }
      
      private function onScrollList(param1:Event) : void
      {
         rewardPoint.scrollRect = new Rectangle(0,obf_H_w_3575.scrollPosition,obf_H_w_3575.x - rewardPoint.x,rewardPoint.height);
      }
      
      public function obf_2_Y_3019() : void
      {
         var _loc1_:SmallGetBoxUI = null;
         var _loc6_:String = null;
         var _loc7_:IconItem = null;
         var _loc8_:String = null;
         var _loc2_:int = 0;
         this.bags = new Array();
         var _loc3_:Object = obf_g_0_3344.rewardList;
         numberTxt.text = obf_g_0_3344.buyNum + "";
         if(obf_g_0_3344.isbuyFund && obf_g_0_3344.isbuyLocalTyrantFund)
         {
            cmdBuy.visible = false;
         }
         var _loc4_:Array = obf_g_0_3344.getBoonList();
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc1_ = new SmallGetBoxUI(this,3,_loc4_[_loc5_]);
            _loc6_ = JSONUtil.getStr(_loc4_[_loc5_],["itemCode"]);
            _loc7_ = IconItemManager.getIconItemByCode(_loc6_,"");
            if(_loc7_)
            {
               _loc1_.iconBag.pushIconItem(_loc7_);
               this.bags.push(_loc1_.iconBag);
               _loc1_.y = _loc2_;
               _loc2_ += _loc1_.height - 40;
            }
            for(_loc8_ in _loc3_)
            {
               if(_loc4_[_loc5_].id == _loc8_)
               {
                  _loc1_.obf_O_L_2941(_loc3_[_loc8_]);
               }
            }
            rewardPoint.addChild(_loc1_);
            _loc5_++;
         }
         if(_loc2_ > obf_H_w_3575.height)
         {
            if(rewardPoint.scrollRect.y > _loc2_ - obf_H_w_3575.height)
            {
               rewardPoint.scrollRect = new Rectangle(0,_loc2_ - obf_H_w_3575.height,obf_H_w_3575.x - rewardPoint.x,obf_H_w_3575.height);
            }
            obf_H_w_3575.maxScrollPosition = _loc2_ - obf_H_w_3575.height;
            obf_H_w_3575.scrollPosition = rewardPoint.scrollRect.y;
         }
      }
      
      public function obf_K_X_4449(param1:int) : void
      {
         numberTxt.text = param1 + "";
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
         DiversityManager.setTextField(curBuyTxt,"AllOfPeopleBoonUI","curBuy");
         cmdBuy.label = DiversityManager.getString("AllOfPeopleBoonUI","buy");
         txtRemark.htmlText = JSONUtil.getStr(obf_g_0_3344.getBoon(),["explanation"]);
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.obf_2_Y_3019();
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

