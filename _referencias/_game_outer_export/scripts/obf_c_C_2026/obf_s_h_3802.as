package obf_c_C_2026
{
   import obf_g_A_3629.ChatDecoder;
   import com.sunweb.game.rpg.booth.BoothItemPurchaseInfo;
   import com.sunweb.game.rpg.booth.obf_c_o_n_t_i_n_u_e_24;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.PlayerBagUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import playerUI.BoothBfmWindowUI;
   
   public class obf_s_h_3802 extends BoothBfmWindowUI implements IIconItemUI
   {
      
      public static const obf_Q_T_4344:String = "price_mode_gold";
      
      public static const obf_x_x_1366:String = "price_mode_money";
      
      public static const obf_Y_z_2955:String = "price_mode_coin";
      
      private var _itemCode:String;
      
      private var countMin:int;
      
      private var countMax:int;
      
      private var countValue:int;
      
      private var bagMax:int;
      
      private var obf_w_P_3677:String;
      
      private var itemIndex:int;
      
      private var playerName:String;
      
      private var obf_4_b_3131:String;
      
      private var _itemPrice:int;
      
      private var iconBag:IconItemBag;
      
      public function obf_s_h_3802(param1:String, param2:int, param3:String, param4:int = 1, param5:int = 1, param6:String = "", param7:int = 0)
      {
         var _loc11_:IconItem = null;
         super();
         this.initDiversity();
         this.iconBag = new IconItemBag(iconBar,this,0);
         this.iconBag.addValidType(GameItemType.ALL);
         this.iconBag.lockDrag = true;
         this._itemCode = param1;
         this.bagMax = obf_K_e_3075.playerBagUI.getItemCount(param1);
         this.countMin = param4;
         if(this.bagMax > param5)
         {
            this.countMax = param5;
         }
         else
         {
            this.countMax = this.bagMax;
         }
         this.countValue = this.countMin;
         this.obf_4_b_3131 = param6;
         this._itemPrice = param7;
         this.itemIndex = param2;
         this.playerName = param3;
         var _loc8_:int = int(GameItemManager.getItemConfig(param1).rank);
         var _loc9_:String = GameItemRank.getRankColor(_loc8_).toString(16);
         var _loc10_:String = "<FONT COLOR=\'#" + _loc9_ + "\'><A HREF=\"event:" + ChatDecoder.obf_d_Y_2785 + "^" + param1 + "\">[<U>" + GameItemManager.getItemName(param1) + "</U>]</A></FONT>";
         DiversityManager.setTextField(txtItem,"BoothUI","txtItem",[_loc10_],true);
         if(obf_K_e_3075.playerBagUI.getItemCount(param1) > 0)
         {
            _loc11_ = IconItemManager.getIconItemByCode(param1,"");
            _loc11_.itemCount = 1;
            this.iconBag.pushIconItem(_loc11_);
            this.checkInputValue(1);
         }
         this.addListener();
      }
      
      private function addListener() : void
      {
         this.bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         cmdLeft.addEventListener(MouseEvent.CLICK,this.onClickLeft);
         cmdRight.addEventListener(MouseEvent.CLICK,this.onClickRight);
         cmdOK.addEventListener(MouseEvent.CLICK,this.onClickOK);
         cmdCancle.addEventListener(MouseEvent.CLICK,this.onClickCancle);
         txtInput.addEventListener(Event.CHANGE,this.onInputValue);
         txtInput.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         txtInput.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         txtItem.addEventListener(TextEvent.LINK,this.obf_c_P_2201);
      }
      
      private function removeListener() : void
      {
         this.bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         this.removeEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         cmdLeft.removeEventListener(MouseEvent.CLICK,this.onClickLeft);
         cmdRight.removeEventListener(MouseEvent.CLICK,this.onClickRight);
         cmdOK.removeEventListener(MouseEvent.CLICK,this.onClickOK);
         cmdCancle.removeEventListener(MouseEvent.CLICK,this.onClickCancle);
         txtInput.removeEventListener(Event.CHANGE,this.onInputValue);
         txtInput.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         txtInput.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         txtItem.removeEventListener(TextEvent.LINK,this.obf_c_P_2201);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function obf_m_I_3657(param1:Event) : void
      {
         param1.stopPropagation();
      }
      
      private function obf_c_P_2201(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      private function onInputValue(param1:Event) : void
      {
         this.checkInputValue(int(txtInput.text));
      }
      
      private function onClickLeft(param1:Event) : void
      {
         this.checkInputValue(this.countValue - 1);
      }
      
      private function onClickRight(param1:Event) : void
      {
         this.checkInputValue(this.countValue + 1);
      }
      
      private function checkInputValue(param1:int) : void
      {
         var _loc2_:DisplayObject = null;
         if(param1 < this.countMin)
         {
            param1 = this.countMin;
         }
         else if(param1 > this.countMax)
         {
            param1 = this.countMax;
         }
         this.countValue = param1;
         txtInput.text = param1 + "";
         while(goldPoint.numChildren > 0)
         {
            goldPoint.removeChildAt(0);
         }
         if(this.obf_4_b_3131 == obf_Q_T_4344)
         {
            _loc2_ = obf_a_f_2935.getGoldDisplay(this.countValue * this._itemPrice);
         }
         else if(this.obf_4_b_3131 == obf_x_x_1366)
         {
            _loc2_ = obf_a_f_2935.getMoneyDisplay(this.countValue * this._itemPrice);
         }
         else if(this.obf_4_b_3131 == obf_Y_z_2955)
         {
            _loc2_ = obf_a_f_2935.getCoinDisplay(this.countValue * this._itemPrice);
         }
         if(_loc2_)
         {
            goldPoint.addChild(_loc2_);
         }
      }
      
      private function onClickOK(param1:Event) : void
      {
         var _loc2_:BoothItemPurchaseInfo = new BoothItemPurchaseInfo();
         _loc2_.itemCode = this._itemCode;
         _loc2_.itemId = this.obf_w_P_3677;
         _loc2_.itemCount = this.countValue;
         _loc2_.itemPrice = this._itemPrice;
         _loc2_.itemIndex = this.itemIndex;
         obf_c_o_n_t_i_n_u_e_24.sendSellItem(this.playerName,_loc2_);
         obf_K_e_3075.closeUI(this);
         param1.stopPropagation();
      }
      
      private function onClickCancle(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
         param1.stopPropagation();
      }
      
      public function setIconBar(param1:IconItem) : void
      {
         if(!param1)
         {
            return;
         }
         this.iconBag.pushIconItem(param1);
      }
      
      private function onAddToStage(param1:Event) : void
      {
         this.x = this.stage.mouseX;
         this.y = this.stage.mouseY;
      }
      
      public function getIconItemBags() : Array
      {
         return [this.iconBag];
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         if(!param2 || !(param3.parentIconUI is PlayerBagUI))
         {
            return;
         }
         if(param1 == this.iconBag && param2.itemCode == this._itemCode)
         {
            param2.itemCount = 1;
            this.iconBag.pushIconItem(param2);
            this.obf_w_P_3677 = param2.itemId;
            this.checkInputValue(1);
         }
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
         cmdOK.label = DiversityManager.getString("InputBox","ok");
         cmdCancle.label = DiversityManager.getString("InputBox","cancel");
         DiversityManager.setTextField(txtGold,"BoothUI","txtGold");
      }
      
      public function showUI() : void
      {
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.destroy();
      }
      
      public function destroy() : void
      {
         if(Boolean(this.iconBag) && this.iconBag.parent == this)
         {
            this.iconBag.destroy();
            this.removeChild(this.iconBag);
         }
         this.iconBag = null;
         this.removeListener();
      }
   }
}

