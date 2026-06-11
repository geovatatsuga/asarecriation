package obf_V_K_965
{
   import obf_O_e_3875.obf_0_4_5_176;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemBriefInfo;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.WindowManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import playerUI.ChristmasUIMC;
   
   public class ChristmasUI extends ChristmasUIMC implements IIconItemUI, IPlayerUI
   {
      
      private static const obf_A_o_3318:int = 50;
      
      private var bags:Array;
      
      private var itemIcons:Array;
      
      private var specialItemIcons:Array;
      
      private var obf_o_n_2531:Array;
      
      private var obf_P_z_3192:Array;
      
      public function ChristmasUI()
      {
         var _loc3_:MovieClip = null;
         var _loc4_:IconItemBag = null;
         var _loc5_:MovieClip = null;
         var _loc6_:IconItemBag = null;
         super();
         this.initDiversity();
         this.onResize(null);
         this.visible = false;
         titleBox.mouseEnabled = false;
         this.obf_o_n_2531 = obf_0_4_5_176.christmasConfig.items;
         this.obf_P_z_3192 = new Array();
         this.bags = new Array();
         this.itemIcons = new Array();
         this.specialItemIcons = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 20)
         {
            _loc3_ = this["icon" + _loc1_] as MovieClip;
            if(_loc3_ != null)
            {
               _loc4_ = new IconItemBag(_loc3_,this,_loc1_);
               _loc4_.lockDrag = true;
               _loc4_.addValidType(GameItemType.ALL);
               this.itemIcons.push(_loc4_);
               this.bags.push(_loc4_);
            }
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < 2)
         {
            _loc5_ = this["conferIcon" + _loc2_] as MovieClip;
            if(_loc5_ != null)
            {
               _loc6_ = new IconItemBag(_loc5_,this,_loc2_);
               _loc6_.lockDrag = true;
               _loc6_.addValidType(GameItemType.ALL);
               this.specialItemIcons.push(_loc6_);
               this.bags.push(_loc6_);
            }
            _loc2_++;
         }
         this.showGoods(this.obf_o_n_2531);
         this.showConsume();
         this.addListener();
      }
      
      private function addListener() : void
      {
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         cmdSearch0.addEventListener(MouseEvent.CLICK,this.obf_x_G_4013);
         cmdSearch1.addEventListener(MouseEvent.CLICK,this.obf_3_P_1674);
         cmdSearch10.addEventListener(MouseEvent.CLICK,this.onClickCmdSearch10);
         cmdCentShop.addEventListener(MouseEvent.CLICK,this.obf_6_3_2304);
         txtDrgAward.addEventListener(TextEvent.LINK,this.onClickLink);
         txtOtherDrgAward.addEventListener(TextEvent.LINK,this.onClickLink);
         txtItemName.addEventListener(TextEvent.LINK,this.onClickLink);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         cmdSearch0.removeEventListener(MouseEvent.CLICK,this.obf_x_G_4013);
         cmdSearch1.removeEventListener(MouseEvent.CLICK,this.obf_3_P_1674);
         cmdSearch10.removeEventListener(MouseEvent.CLICK,this.onClickCmdSearch10);
         cmdCentShop.removeEventListener(MouseEvent.CLICK,this.obf_6_3_2304);
         txtDrgAward.removeEventListener(TextEvent.LINK,this.onClickLink);
         txtOtherDrgAward.removeEventListener(TextEvent.LINK,this.onClickLink);
         txtItemName.removeEventListener(TextEvent.LINK,this.onClickLink);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth / 2 - 150;
         this.y = GameContext.gameStage.stageHeight / 2 - 50;
      }
      
      private function obf_x_G_4013(param1:Event) : void
      {
         var _loc2_:String = obf_0_4_5_176.christmasConfig.freeItem;
         if(obf_K_e_3075.playerBagUI.getItemCount(_loc2_) < 1)
         {
            WindowManager.showMessageBox(DiversityManager.getString("ChristmasUI","hasItem",[GameItemManager.getItemName(_loc2_)]));
            return;
         }
         obf_0_4_5_176.sendChristmasDrawReq(0);
      }
      
      private function obf_3_P_1674(param1:Event) : void
      {
         if(obf_0_4_5_176.christmasConfig.oneNeed > GameContext.localPlayer.fullInfo.money)
         {
            WindowManager.showMessageBox(DiversityManager.getString("ChristmasUI","notMony",[obf_0_4_5_176.christmasConfig.oneNeed]));
            return;
         }
         obf_0_4_5_176.sendChristmasDrawReq(1);
      }
      
      private function onClickCmdSearch10(param1:Event) : void
      {
         if(obf_0_4_5_176.christmasConfig.tenNeed > GameContext.localPlayer.fullInfo.money)
         {
            WindowManager.showMessageBox(DiversityManager.getString("ChristmasUI","notMony",[obf_0_4_5_176.christmasConfig.tenNeed]));
            return;
         }
         obf_0_4_5_176.sendChristmasDrawReq(2);
      }
      
      private function obf_6_3_2304(param1:Event) : void
      {
         param1.stopPropagation();
         if(!obf_K_e_3075.centShopUI)
         {
            return;
         }
         if(obf_K_e_3075.centShopUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.centShopUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.centShopUI);
         }
      }
      
      private function onClickLink(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      private function showGoods(param1:Array) : void
      {
         var _loc2_:IconItemBag = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc7_:IconItem = null;
         var _loc8_:IconItem = null;
         if(param1.length == 0)
         {
            return;
         }
         for each(_loc2_ in this.bags)
         {
            _loc2_.dropIconItem();
         }
         _loc3_ = [param1[0],param1[1]];
         _loc4_ = param1.slice(2,param1.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            if(_loc5_ > this.specialItemIcons.length)
            {
               return;
            }
            _loc7_ = IconItemManager.getIconItemByCode(_loc3_[_loc5_].itemCode,"");
            if(_loc7_)
            {
               _loc7_.itemCount = _loc3_[_loc5_].itemNum;
               this.specialItemIcons[_loc5_].pushIconItem(_loc7_);
            }
            _loc5_++;
         }
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.length)
         {
            if(_loc6_ > this.itemIcons.length || !_loc4_[_loc6_])
            {
               return;
            }
            _loc8_ = IconItemManager.getIconItemByCode(_loc4_[_loc6_].itemCode,"");
            if(_loc8_)
            {
               _loc8_.itemCount = _loc4_[_loc6_].itemNum;
               this.itemIcons[_loc6_].pushIconItem(_loc8_);
            }
            _loc6_++;
         }
      }
      
      private function showConsume() : void
      {
         var _loc1_:String = "";
         _loc1_ = obf_7_6_4416.getItemLinkA(obf_0_4_5_176.christmasConfig.freeItem,"");
         txtItemName.htmlText = _loc1_;
         DiversityManager.setTextField(txtMoney1,"ChristmasUI","txtMoney",[obf_0_4_5_176.christmasConfig.oneNeed]);
         DiversityManager.setTextField(txtMoney10,"ChristmasUI","txtMoney",[obf_0_4_5_176.christmasConfig.tenNeed]);
      }
      
      public function showOtherInfo(param1:String, param2:String) : void
      {
         var _loc3_:String = param1 + DiversityManager.getString("ChristmasUI","haveItem",[obf_7_6_4416.getItemLinkA(param2,"")]);
         this.obf_P_z_3192.push(_loc3_);
         if(this.obf_P_z_3192.length > obf_A_o_3318)
         {
            this.obf_I_4_2571();
            return;
         }
         txtOtherDrgAward.htmlText += _loc3_ + "\n";
         txtOtherDrgAward.scrollV = int.MAX_VALUE;
         obf_5_f_1277.update();
      }
      
      public function obf_I_4_2571() : void
      {
         var _loc1_:String = null;
         if(this.obf_P_z_3192.length > obf_A_o_3318)
         {
            this.obf_P_z_3192.splice(0,this.obf_P_z_3192.length - obf_A_o_3318);
         }
         txtOtherDrgAward.htmlText = "";
         for each(_loc1_ in this.obf_P_z_3192)
         {
            txtOtherDrgAward.htmlText += _loc1_ + "\n";
         }
         txtOtherDrgAward.scrollV = int.MAX_VALUE;
         obf_5_f_1277.update();
      }
      
      public function onHaveItems(param1:Object) : void
      {
         var _loc4_:GameItemBriefInfo = null;
         var _loc2_:String = "";
         var _loc3_:Array = new Array();
         for each(_loc4_ in param1)
         {
            if(_loc4_)
            {
               _loc2_ += DiversityManager.getString("ChristmasUI","prompt_HaveItem",[obf_7_6_4416.getItemLinkA(_loc4_.itemCode,_loc4_.itemId) + "x" + _loc4_.itemCount]) + "\n";
               if(_loc3_.indexOf(_loc4_.itemCode) == -1)
               {
                  _loc3_.push(_loc4_.itemCode);
               }
            }
         }
         txtDrgAward.htmlText += _loc2_;
         txtDrgAward.scrollV = int.MAX_VALUE;
         obf_z_f_2307.update();
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
         DiversityManager.setTextField(txtDeyTitle,"ChristmasUI","txtChristmasTitle");
         DiversityManager.setTextField(txtConfer,"ChristmasUI","txtConfer");
         DiversityManager.setTextField(txtTrace,"ChristmasUI","txtTrace");
         DiversityManager.setTextField(txtItem,"ChristmasUI","txtItem");
         DiversityManager.setTextField(txtMyTrace,"ChristmasUI","txtMyTrace");
         cmdSearch0.label = DiversityManager.getString("ChristmasUI","cmdSearch0");
         cmdSearch1.label = DiversityManager.getString("ChristmasUI","cmdSearch1");
         cmdSearch10.label = DiversityManager.getString("ChristmasUI","cmdSearch10");
         cmdCentShop.label = DiversityManager.getString("ChristmasUI","cmdCentShop");
      }
      
      public function showUI() : void
      {
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
   }
}

