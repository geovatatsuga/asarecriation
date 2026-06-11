package obf_0_0_k_571
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.activity.obf_J_F_3431;
   import com.sunweb.game.rpg.activity.activityBoxManager;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.SplitBoxUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.shop.ShopManager;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import com.sunweb.game.utils.obf_l_y_733;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.AdhocBoxUIMC;
   
   public class obf_d_2906 extends AdhocBoxUIMC implements IIconItemUI
   {
      
      private var obf_N_t_3283:int;
      
      private var pageSize:int = 9;
      
      private var bags:Array = new Array();
      
      private var obf_0_2269:Array;
      
      private var obf_O_E_2553:Array;
      
      public var serverDate:String;
      
      public var serverTime:String;
      
      public function obf_d_2906()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         var _loc1_:Object = activityBoxManager.getSpecially214();
         this.obf_O_E_2553 = JSONUtil.getValue(_loc1_,"items") as Array;
         this.addListener();
      }
      
      private function addListener() : void
      {
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onDragDown);
         cmdPrvPage.addEventListener(MouseEvent.CLICK,this.obf_k_X_2379);
         cmdNextPage.addEventListener(MouseEvent.CLICK,this.obf_k_X_2379);
      }
      
      private function removeListener() : void
      {
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onDragDown);
         cmdPrvPage.removeEventListener(MouseEvent.CLICK,this.obf_k_X_2379);
         cmdNextPage.removeEventListener(MouseEvent.CLICK,this.obf_k_X_2379);
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onDragDown(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function obf_k_X_2379(param1:Event) : void
      {
         if(param1.currentTarget == cmdPrvPage)
         {
            this.showConvertVisualize(this.obf_0_2269,this.obf_N_t_3283 - 1);
         }
         else if(param1.currentTarget == cmdNextPage)
         {
            this.showConvertVisualize(this.obf_0_2269,this.obf_N_t_3283 + 1);
         }
      }
      
      private function showConvertVisualize(param1:Array, param2:int = 1) : void
      {
         var _loc7_:Object = null;
         var _loc8_:obf_K_4685 = null;
         var _loc9_:IconItem = null;
         var _loc10_:Object = null;
         this.obf_S_z_4502();
         this.obf_0_2269 = param1;
         var _loc3_:int = param1.length / this.pageSize;
         if(param1.length % this.pageSize > 0)
         {
            _loc3_++;
         }
         if(_loc3_ < 1)
         {
            _loc3_ = 1;
         }
         if(param2 * this.pageSize > param1.length)
         {
            param2 = _loc3_;
         }
         if(param2 < 1)
         {
            param2 = 1;
         }
         this.obf_N_t_3283 = param2;
         param1 = param1.slice((this.obf_N_t_3283 - 1) * this.pageSize,this.obf_N_t_3283 * this.pageSize);
         DiversityManager.setTextField(txtPage,"ShopBoxUI","prompt_CurrentPage",[this.obf_N_t_3283,_loc3_],true);
         this.bags = new Array();
         var _loc4_:int = -1;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         for each(_loc7_ in param1)
         {
            _loc8_ = new obf_K_4685(this);
            _loc9_ = IconItemManager.getIconItemByCode(_loc7_.itemCode,"");
            if(_loc9_)
            {
               _loc10_ = GameItemManager.getItemConfig(_loc7_.itemCode);
               _loc8_.iconBag.pushIconItem(_loc9_);
               _loc8_.itemConfig = _loc7_;
               if(Boolean(_loc8_._iconBag.haveIconItem) && Boolean(_loc10_))
               {
                  _loc8_.txtName.htmlText = "<font color=\'#" + GameItemRank.getRankColor(_loc8_._iconBag.haveIconItem.iconItemRank).toString(16) + "\'>" + _loc8_._iconBag.haveIconItem.itemName + "</font>";
                  if(_loc10_.moneyPrice > 0)
                  {
                     _loc8_.setMoney(_loc10_.moneyPrice);
                  }
                  if(_loc7_.price > 0)
                  {
                     _loc8_.setNowMoney(_loc7_.price);
                  }
               }
               _loc8_.addEventListener(obf_K_4685.obf_v_u_1705,this.onBuyItem);
               this.bags.push(_loc8_.iconBag);
               if(++_loc4_ > 2)
               {
                  _loc4_ = 0;
                  _loc5_ += _loc8_.height + 8;
               }
               _loc8_.x = _loc8_.width * _loc4_;
               _loc8_.y = _loc5_;
               _loc6_ = _loc8_.y + _loc8_.height;
               itemPoint.addChild(_loc8_);
            }
         }
      }
      
      private function obf_S_z_4502() : void
      {
         var _loc1_:obf_K_4685 = null;
         while(itemPoint.numChildren > 0)
         {
            _loc1_ = itemPoint.getChildAt(0) as obf_K_4685;
            if(_loc1_)
            {
               _loc1_.removeEventListener(obf_K_4685.obf_v_u_1705,this.onBuyItem);
               _loc1_.destroy();
            }
            itemPoint.removeChildAt(0);
         }
      }
      
      public function setMoney() : void
      {
         var _loc1_:DisplayObject = obf_a_f_2935.getMoneyDisplay(GameContext.localPlayer.fullInfo.money);
         while(moneyPoint.numChildren > 0)
         {
            moneyPoint.removeChildAt(0);
         }
         moneyPoint.addChild(_loc1_);
      }
      
      private function onBuyItem(param1:Event) : void
      {
         var _loc2_:Object = param1.currentTarget.itemConfig;
         var _loc3_:Object = GameItemManager.getItemConfig(_loc2_.itemCode);
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:int = int(_loc2_.price);
         if(!obf_K_e_3075.playerBagUI.haveEmptyBag(1))
         {
            WindowManager.showMessageBox(DiversityManager.getString("CommonPrompt","playerBagFull"));
            return;
         }
         var _loc5_:SplitBoxUI = new SplitBoxUI(this.sendStoreBuyItem,[_loc3_.code],1,1,SplitBoxUI.obf_x_x_1366,_loc4_);
         WindowManager.showWindow(_loc5_);
      }
      
      private function sendStoreBuyItem(param1:String, param2:int) : void
      {
         if(GameContext.localPlayer.fullInfo.money < ShopManager.obf_8_q_3951)
         {
            WindowManager.showMessageBox(DiversityManager.getString("taxisBoxUI","noMoney"));
            return;
         }
         activityBoxManager.sendSpecialBuyItem(param1);
      }
      
      public function setServerTime(param1:String, param2:String) : void
      {
         this.serverDate = param1;
         this.serverTime = param2;
      }
      
      private function obf_0_2_B_370(param1:Event) : void
      {
         var _loc2_:Object = activityBoxManager.getSpecially214();
         if(!obf_J_F_3431.obf_4_4696(_loc2_.activityCode))
         {
            return;
         }
         var _loc3_:String = obf_J_F_3431.getActConfig(_loc2_.activityCode).dateLimit;
         var _loc4_:Array = String(_loc3_).split("~");
         var _loc5_:Array = String(_loc4_[_loc4_.length - 1]).split("-");
         var _loc6_:Date = new Date();
         _loc6_.setFullYear(_loc5_[0],_loc5_[1] - 1,_loc5_[2]);
         _loc6_.setHours(23);
         _loc6_.setMinutes(59);
         _loc6_.setSeconds(59);
         var _loc7_:Date = new Date();
         var _loc8_:Array = String(this.serverDate).split("-");
         var _loc9_:Array = String(this.serverTime).split(":");
         _loc7_.setFullYear(_loc8_[0],_loc8_[1] - 1,_loc8_[2]);
         _loc7_.setHours(_loc9_[0]);
         _loc7_.setMinutes(_loc9_[1]);
         var _loc10_:Number = _loc7_.getTime();
         var _loc11_:String = this.getTimeStringHHMM(_loc6_.getTime() - _loc10_);
         txtTime.text = DiversityManager.getString("taxisBoxUI","time") + _loc11_;
         if(_loc11_ == "00 HR 00 MIN")
         {
            obf_K_e_3075.closeUI(this);
         }
      }
      
      private function getTimeStringHHMM(param1:Number) : String
      {
         if(param1 < 1000)
         {
            return "00 HR 00 MIN";
         }
         var _loc2_:String = "";
         var _loc3_:int = param1 / obf_l_y_733.MS_PER_HOUR;
         _loc2_ += obf_L_l_4100.obf_1_m_1767(_loc3_ + "",2,"0") + " HR ";
         param1 -= _loc3_ * obf_l_y_733.MS_PER_HOUR;
         var _loc4_:int = param1 / obf_l_y_733.obf_0___a_609;
         _loc2_ += obf_L_l_4100.obf_1_m_1767(_loc4_ + "",2,"0") + " MIN";
         param1 -= _loc4_ * obf_l_y_733.obf_0___a_609;
         return _loc2_;
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
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         cmdPrvPage.label = DiversityManager.getString("taxisBoxUI","cmdPrvPage");
         cmdNextPage.label = DiversityManager.getString("taxisBoxUI","cmdNextPage");
         DiversityManager.setTextField(txtspTitle,"taxisBoxUI","txtSpecially");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.addEventListener(Event.ENTER_FRAME,this.obf_0_2_B_370);
         if(this.obf_O_E_2553.length == 0)
         {
            return;
         }
         this.showConvertVisualize(this.obf_O_E_2553,1);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.obf_0_2_B_370);
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

