package obf_y_y_3106
{
   import obf_Q_c_4394.obf_Z_j_930;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import flash.events.MouseEvent;
   import playerUI.RewardShopBoxMC;
   
   public class obf_F_j_4177 extends RewardShopBoxMC implements IIconItemUI
   {
      
      private var _boxList:Array;
      
      private var _page:int;
      
      private var obf_7_2_2783:int;
      
      public function obf_F_j_4177()
      {
         var _loc3_:Object = null;
         var _loc4_:obf_S_4645 = null;
         super();
         this.initDiversity();
         this.addListener();
         var _loc1_:Array = obf_Z_j_930.rewardShopConfig;
         if(!_loc1_)
         {
            return;
         }
         this._boxList = new Array();
         var _loc2_:int = 1;
         while(_loc2_ <= _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_ - 1];
            _loc4_ = new obf_S_4645();
            _loc4_.obf_5_d_847(_loc3_);
            this._boxList.push(_loc4_);
            _loc2_++;
         }
         this.obf_7_2_2783 = (_loc1_.length - 1) / 16 + 1;
         this._page = 1;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         cmdPrvPage.label = DiversityManager.getString("rewardShopBoxUI","cmdPrvPage");
         cmdNextPage.label = DiversityManager.getString("rewardShopBoxUI","cmdNextPage");
      }
      
      private function addListener() : void
      {
         cmdPrvPage.addEventListener(MouseEvent.CLICK,this.obf_0_7_R_475);
         cmdNextPage.addEventListener(MouseEvent.CLICK,this.obf_C_R_4204);
      }
      
      private function removeListener() : void
      {
         cmdPrvPage.removeEventListener(MouseEvent.CLICK,this.obf_0_7_R_475);
         cmdNextPage.removeEventListener(MouseEvent.CLICK,this.obf_C_R_4204);
      }
      
      private function obf_0_7_R_475(param1:MouseEvent) : void
      {
         if(this._page <= 1)
         {
            return;
         }
         --this._page;
         this.refreshShopUI();
      }
      
      private function obf_C_R_4204(param1:MouseEvent) : void
      {
         if(this._page >= this.obf_7_2_2783)
         {
            return;
         }
         this._page += 1;
         this.refreshShopUI();
      }
      
      public function refreshShopUI() : void
      {
         var _loc4_:Object = null;
         var _loc1_:int = 1;
         while(_loc1_ <= 16)
         {
            while(this["box" + _loc1_].numChildren > 0)
            {
               this["box" + _loc1_].removeChildAt(0);
            }
            _loc1_++;
         }
         DiversityManager.setTextField(txtPage,"rewardShopBoxUI","txtPage",[this._page + "/" + this.obf_7_2_2783]);
         var _loc2_:int = 16 * (this._page - 1);
         var _loc3_:int = 1;
         while(_loc3_ <= 16)
         {
            _loc4_ = this._boxList[_loc2_];
            if(_loc4_)
            {
               this["box" + _loc3_].addChild(_loc4_);
               _loc2_++;
            }
            _loc3_++;
         }
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return bgBox.getBounds(bgBox).contains(bgBox.mouseX,bgBox.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         this._page = 1;
         this.refreshShopUI();
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
      
      public function getIconItemBags() : Array
      {
         var _loc2_:Object = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in this._boxList)
         {
            _loc1_.push(_loc2_.iconBag);
         }
         return _loc1_;
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
   }
}

