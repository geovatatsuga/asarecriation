package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.agent.AgentEvent;
   import com.sunweb.game.rpg.agent.AgentItemInfo;
   import com.sunweb.game.rpg.agent.AgentState;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.obf_l_y_733;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.AgentItemBoxUIMC;
   
   public class AgentItemUI extends AgentItemBoxUIMC
   {
      
      private var _itemBag:IconItemBag;
      
      private var obf_x_d_1985:int;
      
      private var obf_g_S_870:int;
      
      private var itemTime:TimeLimiter;
      
      private var obf_V_l_1928:Boolean;
      
      private var _price:Number;
      
      private var obf_B_3_3752:Number;
      
      private var obf_t_E_1016:Boolean;
      
      private var frameInv:TimeLimiter = new TimeLimiter(1000);
      
      public function AgentItemUI(param1:IIconItemUI, param2:AgentItemInfo, param3:Boolean = false)
      {
         super();
         this.initDiversity();
         this.obf_t_E_1016 = param3;
         cmdCancelSell.visible = false;
         cmdTakeBack.visible = false;
         this.obf_x_d_1985 = param2.agentRecId;
         this.obf_g_S_870 = param2.state;
         this._itemBag = new IconItemBag(bagItem,param1,0);
         this._itemBag.lockDrag = true;
         this._itemBag.addValidType(GameItemType.ALL);
         this.itemTime = new TimeLimiter(param2.waitTimeInSec * 1000);
         var _loc4_:IconItem = IconItemManager.getIconItemByCode(param2.itemCode,param2.itemId);
         if(_loc4_)
         {
            _loc4_.itemCount = param2.itemCount;
            txtItemName.textColor = GameItemRank.getRankColor(_loc4_.iconItemRank);
            txtItemName.text = _loc4_.itemName + " x" + param2.itemCount;
            this._itemBag.pushIconItem(_loc4_);
         }
         this._price = param2.price;
         this.obf_B_3_3752 = param2.price * param2.itemCount;
         singleGoldPoint.addChild(obf_a_f_2935.getGoldDisplay(this._price));
         totleGoldPoint.addChild(obf_a_f_2935.getGoldDisplay(this.obf_B_3_3752));
         this.isSelected = false;
         this.doubleClickEnabled = true;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         cmdCancelSell.addEventListener(MouseEvent.CLICK,this.onClickControl);
         cmdTakeBack.addEventListener(MouseEvent.CLICK,this.onClickControl);
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeySingleGold,"AgentItemUI","txtPrice",null,true);
         DiversityManager.setTextField(txtDeyTotleGold,"AgentItemUI","txtTotleValue",null,true);
         cmdTakeBack.label = DiversityManager.getString("AgentItemUI","cmdTakeBack");
         cmdCancelSell.label = DiversityManager.getString("AgentItemUI","cmdCancelSell");
      }
      
      public function get itemBag() : IconItemBag
      {
         return this._itemBag;
      }
      
      public function get agentRecId() : int
      {
         return this.obf_x_d_1985;
      }
      
      public function get state() : int
      {
         return this.obf_g_S_870;
      }
      
      public function get price() : Number
      {
         return this._price;
      }
      
      public function get obf_i_5_3631() : Number
      {
         return this.obf_B_3_3752;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         this.obf_V_l_1928 = param1;
         this.gotoAndStop(param1 ? 3 : 2);
      }
      
      public function get isSelected() : Boolean
      {
         return this.obf_V_l_1928;
      }
      
      private function onClickControl(param1:Event) : void
      {
         var _loc2_:AgentEvent = new AgentEvent(AgentEvent.CLICK_CONTROL);
         _loc2_.itemUI = this;
         this.dispatchEvent(_loc2_);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:String = null;
         if(this.frameInv.checkTimeout())
         {
            _loc2_ = AgentState.getStateName(this.obf_g_S_870);
            if(Boolean(this.itemTime) && this.obf_g_S_870 == AgentState.WAITING)
            {
               _loc2_ += " " + obf_l_y_733.getTimeStringMin(this.itemTime.timelimit - this.itemTime.totalTimeInMS);
            }
            if(Boolean(this.itemTime) && Boolean(this.obf_g_S_870 == AgentState.WAITING) && this.itemTime.timelimit - this.itemTime.totalTimeInMS <= 0)
            {
               this.obf_g_S_870 = AgentState.SELLING;
            }
            txtTime.text = _loc2_;
            if(this.obf_t_E_1016)
            {
               cmdCancelSell.visible = false;
               cmdTakeBack.visible = false;
               if(this.obf_g_S_870 == AgentState.SELLING || this.obf_g_S_870 == AgentState.TIMEOUT)
               {
                  cmdCancelSell.visible = true;
               }
               else if(this.obf_g_S_870 == AgentState.SOLD)
               {
                  cmdTakeBack.visible = true;
               }
            }
         }
      }
      
      public function destroy() : void
      {
         this._itemBag.destroy();
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         cmdCancelSell.removeEventListener(MouseEvent.CLICK,this.onClickControl);
         cmdTakeBack.removeEventListener(MouseEvent.CLICK,this.onClickControl);
      }
   }
}

