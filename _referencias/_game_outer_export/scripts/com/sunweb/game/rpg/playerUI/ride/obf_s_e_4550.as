package com.sunweb.game.rpg.playerUI.ride
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.gameItem.ItemPlayerRideInfo;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.rideEquip.obf_Y_7_1544;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import fl.events.ScrollEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import playerUI.IconBarMC;
   import playerUI.RideEquInheritUIMC;
   
   public class obf_s_e_4550 extends RideEquInheritUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      private var rideInheritBags:Array;
      
      private var obf_X_A_1222:String;
      
      private var obf_D_9_3842:String;
      
      private var rideInherited:IconItemBag;
      
      private var rideInherit:IconItemBag;
      
      private var doId:String;
      
      private var obf_q_T_3595:String;
      
      private var obf_L_v_4211:GameItemFullInfo;
      
      private var infoTimeInv:TimeLimiter = new TimeLimiter(300);
      
      public function obf_s_e_4550()
      {
         super();
         this.visible = false;
         this.initDiversity();
         this.rideInherited = new IconItemBag(icon0,this,0);
         this.rideInherited.addValidType(GameItemType.RIDE);
         this.rideInherited.lockDrag = true;
         this.rideInherit = new IconItemBag(icon1,this,1);
         this.rideInherit.addValidType(GameItemType.RIDE);
         this.rideInherit.lockDrag = true;
         this.addListener();
      }
      
      private function addListener() : void
      {
         obf_H_w_3575.addEventListener(ScrollEvent.SCROLL,this.onScrollList);
         cmdCancel.addEventListener(MouseEvent.CLICK,this.obf_0_4_h_132);
         cmdOk.addEventListener(MouseEvent.CLICK,this.onOk);
         cmdOk.addEventListener(MouseEvent.MOUSE_OVER,this.obf_l_F_1156);
         cmdOk.addEventListener(MouseEvent.MOUSE_OUT,this.obf_0_0_m_724);
      }
      
      private function removeListener() : void
      {
         obf_H_w_3575.removeEventListener(ScrollEvent.SCROLL,this.onScrollList);
         cmdCancel.removeEventListener(MouseEvent.CLICK,this.obf_0_4_h_132);
         cmdOk.removeEventListener(MouseEvent.CLICK,this.onOk);
         cmdOk.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_l_F_1156);
         cmdOk.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_0_0_m_724);
      }
      
      private function onOk(param1:Event) : void
      {
         var _loc2_:Object = null;
         if(Boolean(this.rideInherited.haveIconItem) && Boolean(this.rideInherit.haveIconItem))
         {
            if(obf_K_e_3075.playerBagUI.getItemCount(JSONUtil.getStr(obf_Y_7_1544.getRideInheritCon(),["item"])) < 1)
            {
               _loc2_ = GameItemManager.getItemConfig(JSONUtil.getStr(obf_Y_7_1544.getRideInheritCon(),["item"]));
               obf_K_e_3075.showTipInfo(DiversityManager.getString("RideBoxUI","inheritCost",[_loc2_.name]));
               return;
            }
            obf_Y_7_1544.sendInherit(this.doId,this.obf_q_T_3595);
         }
      }
      
      private function obf_l_F_1156(param1:MouseEvent) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("inheritOkTip");
         var _loc3_:int = 200;
         var _loc4_:Object = GameItemManager.getItemConfig(JSONUtil.getStr(obf_Y_7_1544.getRideInheritCon(),["item"]));
         _loc2_.addTipInfo(DiversityManager.getString("RideBoxUI","inheritCost",[_loc4_.name]),_loc3_,1);
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_0_0_m_724(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("inheritOkTip");
      }
      
      private function obf_0_4_h_132(param1:Event) : void
      {
         this.clear();
      }
      
      private function onScrollList(param1:Event) : void
      {
         iconPoint.scrollRect = new Rectangle(0,obf_H_w_3575.scrollPosition,obf_H_w_3575.x - iconPoint.x,iconPoint.height);
      }
      
      private function showRide() : void
      {
         var _loc6_:IconBarMC = null;
         var _loc7_:IconItemBag = null;
         var _loc8_:IconItem = null;
         this.obf_S_2_2619();
         this.bags = [];
         var _loc1_:int = -1;
         var _loc2_:int = 2;
         var _loc3_:int = 0;
         var _loc4_:Array = obf_K_e_3075.rideBoxUI.getAllRide();
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc6_ = new IconBarMC();
            _loc7_ = new IconItemBag(_loc6_,this,_loc5_);
            _loc7_.addValidType(GameItemType.RIDE);
            _loc7_.lockDrag = true;
            _loc8_ = IconItemManager.getIconItemByCode(_loc4_[_loc5_].itemCode,_loc4_[_loc5_].itemId);
            if(_loc8_)
            {
               _loc7_.pushIconItem(_loc8_);
            }
            this.bags.push(_loc7_);
            this.bags.push(this.rideInherited);
            this.bags.push(this.rideInherit);
            if(++_loc1_ > 9)
            {
               _loc1_ = 0;
               _loc2_ += _loc7_.height;
            }
            _loc7_.x = 38 * _loc1_ + 20;
            _loc7_.y = _loc2_;
            _loc3_ = _loc7_.y + _loc7_.height;
            iconPoint.addChild(_loc7_);
            _loc5_++;
         }
         if(_loc3_ > obf_H_w_3575.height)
         {
            obf_H_w_3575.maxScrollPosition = _loc3_ - obf_H_w_3575.height;
            obf_H_w_3575.visible = true;
         }
         else
         {
            obf_H_w_3575.visible = false;
         }
      }
      
      private function obf_S_2_2619() : void
      {
         while(iconPoint.numChildren > 0)
         {
            iconPoint.removeChildAt(0);
         }
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
         if(this.bags.indexOf(param1) > -1)
         {
            if(param1.haveIconItem)
            {
               this.obf_X_A_1222 = param1.haveIconItem.itemCode;
               this.obf_D_9_3842 = param1.haveIconItem.itemId;
               this.obf_L_v_4211 = null;
            }
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.infoTimeInv.checkTimeout() && !this.obf_L_v_4211 && !obf_L_l_4100.isEmpty(this.obf_D_9_3842))
         {
            this.obf_L_v_4211 = GameItemInfoManager.getItemInfo(this.obf_D_9_3842);
            if(this.obf_L_v_4211)
            {
               this.obf_a_Y_2069();
            }
            else
            {
               GameContext.bagItemManager.sendViewItem(this.obf_D_9_3842);
            }
         }
      }
      
      private function obf_a_Y_2069() : void
      {
         var _loc1_:IconItem = null;
         var _loc2_:ItemPlayerRideInfo = null;
         if(obf_L_l_4100.isEmpty(this.obf_D_9_3842) || obf_L_l_4100.isEmpty(this.obf_X_A_1222))
         {
            return;
         }
         if(this.rideInherited.haveIconItem)
         {
            if(this.rideInherit.haveIconItem)
            {
               return;
            }
            if(this.rideInherited.haveIconItem.itemId == this.obf_D_9_3842)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("RideBoxUI","haveRideInherited"));
               return;
            }
            _loc1_ = IconItemManager.getIconItemByCode(this.obf_X_A_1222,this.obf_D_9_3842);
            if(_loc1_)
            {
               this.rideInherit.pushIconItem(_loc1_);
               this.doId = this.obf_D_9_3842;
            }
         }
         else
         {
            _loc1_ = IconItemManager.getIconItemByCode(this.obf_X_A_1222,this.obf_D_9_3842);
            if(_loc1_)
            {
               this.rideInherited.pushIconItem(_loc1_);
               this.obf_q_T_3595 = this.obf_D_9_3842;
               _loc2_ = this.obf_L_v_4211.rideInfo;
            }
         }
      }
      
      public function inheritAnswer() : void
      {
         WindowManager.showMessageBox(DiversityManager.getString("RideBoxUI","inheritSuss"));
         this.clear();
         this.showRide();
      }
      
      private function clear() : void
      {
         if(Boolean(this.rideInherited.haveIconItem) || Boolean(this.rideInherit.haveIconItem))
         {
            this.rideInherited.dropIconItem();
            this.rideInherit.dropIconItem();
            this.doId = "";
            this.obf_q_T_3595 = "";
         }
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
         cmdCancel.label = DiversityManager.getString("RideBoxUI","cancel");
         cmdOk.label = DiversityManager.getString("RideBoxUI","ok");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.showRide();
      }
      
      public function closeUI() : void
      {
         this.clear();
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

