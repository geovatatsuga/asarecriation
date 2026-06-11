package com.sunweb.game.rpg.playerUI.renew
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.shop.ShopManager;
   import com.sunweb.game.rpg.shop.obf_f_z_1191;
   import com.sunweb.game.utils.JSONUtil;
   import fl.events.ScrollEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import playerUI.RenewPlanUIMC;
   
   public class RenewPlanUI extends RenewPlanUIMC implements IIconItemUI
   {
      
      private var _bag:IconItemBag;
      
      private var _itemCode:String;
      
      private var obf_w_P_3677:String;
      
      private var selectedPlan:obf_0_0_M_111;
      
      public function RenewPlanUI()
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         this._bag = new IconItemBag(bag0,this,0);
         this._bag.lockDrag = true;
         this._bag.addValidType(GameItemType.ALL);
         obf_z_1002.pageSize = obf_z_1002.height;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"RenewPlanUI","txtTitle");
         DiversityManager.setTextField(txtSelectPlan,"RenewPlanUI","txtSelectPlan");
         cmdRenew.label = DiversityManager.getString("RenewPlanUI","cmdRenew");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdRenew.addEventListener(MouseEvent.CLICK,this.obf_e_I_1952);
         obf_z_1002.addEventListener(ScrollEvent.SCROLL,this.obf_3_S_1490);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdRenew.removeEventListener(MouseEvent.CLICK,this.obf_e_I_1952);
         obf_z_1002.removeEventListener(ScrollEvent.SCROLL,this.obf_3_S_1490);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function obf_3_S_1490(param1:Event) : void
      {
         planPoint.scrollRect = new Rectangle(0,obf_z_1002.scrollPosition,obf_z_1002.x - planPoint.x,obf_z_1002.height);
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function obf_e_I_1952(param1:Event) : void
      {
         if(Boolean(this.selectedPlan) && this.selectedPlan.selected)
         {
            if(GameContext.localPlayer.fullInfo.money < this.selectedPlan.money)
            {
               obf_K_e_3075.showShortOfMoney();
               return;
            }
            ShopManager.sendRenewItem(this.selectedPlan.planIndex,this.obf_w_P_3677);
            GameItemInfoManager.removeItemInfo(this.obf_w_P_3677);
            obf_K_e_3075.closeUI(this);
         }
      }
      
      public function showRenewPlan(param1:String, param2:String) : void
      {
         var _loc8_:int = 0;
         var _loc9_:Object = null;
         var _loc10_:String = null;
         var _loc11_:Boolean = false;
         var _loc12_:obf_0_0_M_111 = null;
         this._itemCode = param1;
         this.obf_w_P_3677 = param2;
         this.obf_T_3_1329();
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc3_ || !JSONUtil.getBoolean(_loc3_,["canRenew"]))
         {
            return;
         }
         var _loc4_:int = JSONUtil.getInt(_loc3_,["renewMoneyPerWeek"]);
         var _loc5_:Object = obf_f_z_1191.getPlanConfig(JSONUtil.getStr(_loc3_,["renewPlanId"]));
         this._bag.pushIconItem(IconItemManager.getIconItemByCode(param1,param2));
         var _loc6_:obf_0_0_M_111 = new obf_0_0_M_111(_loc4_,1,DiversityManager.getString("RenewPlanUI","planTime_Week",[1]),1,-1);
         _loc6_.addEventListener(MouseEvent.CLICK,this.obf_1_z_1732);
         planPoint.addChild(_loc6_);
         var _loc7_:int = _loc6_.height;
         if(_loc5_)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc5_.renewRuleList.length)
            {
               _loc9_ = _loc5_.renewRuleList[_loc8_];
               _loc10_ = "";
               _loc11_ = true;
               if(JSONUtil.getBoolean(_loc9_,["isPermanent"]))
               {
                  _loc10_ = DiversityManager.getString("RenewPlanUI","planTime_Permanent");
                  _loc11_ = false;
               }
               else
               {
                  _loc10_ = DiversityManager.getString("RenewPlanUI","planTime_Months",[JSONUtil.getInt(_loc9_,["renewMonths"])]);
               }
               _loc12_ = new obf_0_0_M_111(_loc4_,JSONUtil.getInt(_loc9_,["renewMonths"]) * 4,_loc10_,JSONUtil.getNumber(_loc9_,["discountRate"]),_loc8_,_loc11_);
               _loc12_.y = _loc7_ + 2;
               _loc12_.addEventListener(MouseEvent.CLICK,this.obf_1_z_1732);
               planPoint.addChild(_loc12_);
               _loc7_ = _loc12_.y + _loc12_.height;
               _loc8_++;
            }
         }
         planPoint.scrollRect = new Rectangle(0,0,obf_z_1002.x - planPoint.x,obf_z_1002.height);
         obf_z_1002.visible = false;
         if(_loc7_ > obf_z_1002.height)
         {
            obf_z_1002.maxScrollPosition = _loc7_ - obf_z_1002.height;
            obf_z_1002.visible = true;
         }
         obf_K_e_3075.showUI(this);
      }
      
      private function obf_T_3_1329() : void
      {
         var plan:obf_0_0_M_111 = null;
         this.selectedPlan = null;
         this._bag.dropIconItem();
         while(planPoint.numChildren > 0)
         {
            plan = planPoint.getChildAt(0) as obf_0_0_M_111;
            if(plan)
            {
               try
               {
                  plan.removeEventListener(MouseEvent.CLICK,this.obf_1_z_1732);
               }
               catch(e:Error)
               {
               }
            }
            planPoint.removeChildAt(0);
         }
      }
      
      private function obf_1_z_1732(param1:Event) : void
      {
         var _loc2_:obf_0_0_M_111 = param1.currentTarget as obf_0_0_M_111;
         if(_loc2_)
         {
            if(this.selectedPlan)
            {
               this.selectedPlan.selected = false;
            }
            this.selectedPlan = _loc2_;
            this.selectedPlan.selected = true;
         }
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.obf_T_3_1329();
         this.visible = false;
      }
      
      public function getIconItemBags() : Array
      {
         return [this._bag];
      }
      
      public function destroy() : void
      {
         this.obf_T_3_1329();
         this._bag.destroy();
         this.removeListener();
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

