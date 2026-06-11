package com.sunweb.game.rpg.playerUI.ride
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.rideEquip.RideEquipSoulType;
   import com.sunweb.game.rpg.rideEquip.RideEquipmentInfo;
   import com.sunweb.game.rpg.rideEquip.obf_Y_7_1544;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.RideEquStrengthUIMC;
   
   public class obf_0_3_H_64 extends RideEquStrengthUIMC implements IIconItemUI
   {
      
      private var rideMaterialBags:Array;
      
      private var allBags:Array;
      
      private var obf_6_P_1979:GameItemFullInfo;
      
      private var obf_0_3_k_543:int;
      
      private var obf_L_v_4211:GameItemFullInfo;
      
      private var obf_r_0_1714:Array;
      
      public var obf_M_t_3718:int;
      
      public var equipSoulArr:Array;
      
      private var infoTimeInv:TimeLimiter;
      
      public function obf_0_3_H_64()
      {
         var _loc2_:MovieClip = null;
         var _loc3_:IconItemBag = null;
         this.infoTimeInv = new TimeLimiter(300);
         super();
         this.initDiversity();
         this.visible = false;
         this.rideMaterialBags = new Array();
         this.allBags = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            _loc2_ = this["icon" + _loc1_];
            _loc3_ = new IconItemBag(_loc2_,this,_loc1_);
            _loc3_.lockDrag = true;
            _loc3_.addValidType(GameItemType.ALL);
            this.rideMaterialBags.push(_loc3_);
            this.allBags.push(_loc3_);
            _loc1_++;
         }
         this.addListener();
      }
      
      private function addListener() : void
      {
         refine.addEventListener(MouseEvent.CLICK,this.obf_O_D_752);
      }
      
      private function removeListener() : void
      {
         refine.removeEventListener(MouseEvent.CLICK,this.obf_O_D_752);
      }
      
      private function obf_O_D_752(param1:Event) : void
      {
         obf_Y_7_1544.sendEquipCommand(this.obf_L_v_4211.itemId,false,this.obf_0_3_k_543,1);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.infoTimeInv.checkTimeout() && !this.obf_L_v_4211)
         {
            this.obf_L_v_4211 = GameItemInfoManager.getItemInfo(obf_K_e_3075.rideBoxUI.selectedRideId);
            if(Boolean(this.obf_L_v_4211) && Boolean(this.obf_0_3_k_543))
            {
               this.showEquipAtt(this.obf_0_3_k_543);
            }
            else
            {
               GameContext.bagItemManager.sendViewItem(obf_K_e_3075.rideBoxUI.selectedRideId);
            }
         }
      }
      
      public function showEquipAtt(param1:int) : void
      {
         this.obf_L_v_4211 = null;
         this.equipSoulArr = [];
         equipImg.gotoAndStop(param1);
         this.obf_0_3_k_543 = param1;
         GameContext.bagItemManager.sendViewItem(obf_K_e_3075.rideBoxUI.selectedRideId);
         this.obf_L_v_4211 = GameItemInfoManager.getItemInfo(obf_K_e_3075.rideBoxUI.selectedRideId);
         if(!this.obf_L_v_4211)
         {
            return;
         }
         var _loc2_:Object = this.obf_L_v_4211.rideInfo.equipmenet[param1];
         var _loc3_:int = 1;
         while(_loc3_ < 5)
         {
            this.equipSoulArr.push(RideEquipSoulType.getSoulName(this.obf_L_v_4211.rideInfo.equipmenet[_loc3_].soul));
            _loc3_++;
         }
         this.showView(_loc2_,param1);
      }
      
      private function showView(param1:Object, param2:int) : void
      {
         var _loc14_:String = null;
         var _loc15_:int = 0;
         var _loc16_:String = null;
         var _loc17_:String = null;
         var _loc18_:int = 0;
         var _loc19_:Object = null;
         var _loc20_:Object = null;
         var _loc21_:Object = null;
         var _loc22_:IconItemBag = null;
         var _loc23_:IconItem = null;
         this.clear();
         var _loc3_:Array = param1.attrSoul;
         var _loc4_:Array = param1.attr;
         var _loc5_:Array = param1.attrFinal;
         var _loc6_:int = int(param1.soul);
         this.obf_M_t_3718 = param1.level;
         txtLevel.text = DiversityManager.getString("RideBoxUI","lv",[param1.level]);
         txtAttName.text = DiversityManager.getString("RideBoxUI","txtAttName",[RideEquipSoulType.getSoulName(_loc6_)]);
         var _loc7_:int = -1;
         var _loc8_:int = 0;
         while(_loc8_ < _loc3_.length)
         {
            if(_loc6_ == _loc3_[_loc8_])
            {
               _loc7_++;
            }
            _loc8_++;
         }
         var _loc9_:Object = obf_Y_7_1544.getRideEquiStrengthCon();
         var _loc10_:Array = JSONUtil.getValue(_loc9_,["attMultiples"]) as Array;
         var _loc11_:String = "";
         if(_loc7_ >= 1)
         {
            _loc11_ = "+" + int(_loc10_[_loc7_] * 100) + "%";
         }
         else
         {
            _loc11_ = "";
         }
         txtAttName.text += _loc11_;
         var _loc12_:int = 1;
         while(_loc12_ < 4)
         {
            _loc16_ = RideEquipSoulType.getSoulName(_loc3_[_loc12_ - 1]);
            _loc17_ = RoleAttributesModifierEnum.getAttributesName(_loc4_[_loc12_ - 1]);
            _loc18_ = int(_loc5_[_loc12_ - 1]);
            this["txtAtt" + _loc12_].text = "(" + _loc16_ + ") " + _loc17_ + ":" + _loc18_;
            _loc12_++;
         }
         var _loc13_:Array = JSONUtil.getValue(_loc9_,["levelConfig"]) as Array;
         if(_loc13_[param1.level - 1].stuff)
         {
            _loc19_ = _loc13_[param1.level - 1].stuff;
         }
         this.obf_r_0_1714 = new Array();
         for(_loc14_ in _loc19_)
         {
            _loc20_ = new Object();
            _loc20_.itemCode = _loc14_;
            _loc20_.itemNum = _loc19_[_loc14_];
            this.obf_r_0_1714.push(_loc20_);
         }
         _loc15_ = 0;
         while(_loc15_ < this.obf_r_0_1714.length)
         {
            if(_loc15_ >= this.rideMaterialBags.length)
            {
               break;
            }
            _loc21_ = GameItemManager.getItemConfig(this.obf_r_0_1714[_loc15_].itemCode);
            if(_loc21_)
            {
               _loc22_ = this.rideMaterialBags[_loc15_];
               _loc23_ = IconItemManager.getIconItemByCode(this.obf_r_0_1714[_loc15_].itemCode,"");
               _loc23_.itemCount = this.obf_r_0_1714[_loc15_].itemNum;
               _loc22_.pushIconItem(_loc23_);
            }
            _loc15_++;
         }
      }
      
      private function clear() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.rideMaterialBags.length)
         {
            if(this.rideMaterialBags[_loc1_].haveIconItem)
            {
               this.rideMaterialBags[_loc1_].dropIconItem();
            }
            _loc1_++;
         }
         txtAttName.text = "";
         txtAtt1.text = "";
         txtAtt2.text = "";
         txtAtt3.text = "";
         txtLevel.text = "";
      }
      
      public function obf_2_Y_3019(param1:RideEquipmentInfo) : void
      {
         var _loc13_:String = null;
         var _loc14_:int = 0;
         var _loc15_:Object = null;
         var _loc16_:Object = null;
         var _loc17_:IconItemBag = null;
         var _loc18_:IconItem = null;
         GameContext.bagItemManager.sendViewItem(obf_K_e_3075.rideBoxUI.selectedRideId);
         this.clear();
         this.obf_M_t_3718 = param1.level;
         txtLevel.text = DiversityManager.getString("RideBoxUI","lv",[param1.level]);
         txtAttName.text = DiversityManager.getString("RideBoxUI","txtAttName",[RideEquipSoulType.getSoulName(param1.soul)]);
         var _loc2_:Array = param1.attrSoul;
         var _loc3_:Array = param1.attr;
         var _loc4_:Array = param1.attrFinal;
         var _loc5_:int = -1;
         var _loc6_:int = 0;
         while(_loc6_ < _loc2_.length)
         {
            if(param1.soul == _loc2_[_loc6_])
            {
               _loc5_++;
            }
            _loc6_++;
         }
         var _loc7_:Object = obf_Y_7_1544.getRideEquiStrengthCon();
         var _loc8_:Array = JSONUtil.getValue(_loc7_,["attMultiples"]) as Array;
         var _loc9_:String = "";
         if(_loc5_ >= 1)
         {
            _loc9_ = "+" + int(_loc8_[_loc5_] * 100) + "%";
         }
         else
         {
            _loc9_ = "";
         }
         txtAttName.text += _loc9_;
         var _loc10_:int = 1;
         while(_loc10_ < 4)
         {
            this["txtAtt" + _loc10_].text = "(" + RideEquipSoulType.getSoulName(_loc2_[_loc10_ - 1]) + ")" + RoleAttributesModifierEnum.getAttributesName(_loc3_[_loc10_ - 1]) + ":" + _loc4_[_loc10_ - 1];
            _loc10_++;
         }
         var _loc11_:Array = JSONUtil.getValue(_loc7_,["levelConfig"]) as Array;
         var _loc12_:Object = _loc11_[param1.level - 1].stuff;
         this.obf_r_0_1714 = new Array();
         for(_loc13_ in _loc12_)
         {
            _loc15_ = new Object();
            _loc15_.itemCode = _loc13_;
            _loc15_.itemNum = _loc12_[_loc13_];
            this.obf_r_0_1714.push(_loc15_);
         }
         _loc14_ = 0;
         while(_loc14_ < this.obf_r_0_1714.length)
         {
            if(_loc14_ >= this.rideMaterialBags.length)
            {
               break;
            }
            _loc16_ = GameItemManager.getItemConfig(this.obf_r_0_1714[_loc14_].itemCode);
            if(_loc16_)
            {
               _loc17_ = this.rideMaterialBags[_loc14_];
               _loc18_ = IconItemManager.getIconItemByCode(this.obf_r_0_1714[_loc14_].itemCode,"");
               _loc18_.itemCount = this.obf_r_0_1714[_loc14_].itemNum;
               _loc17_.pushIconItem(_loc18_);
            }
            _loc14_++;
         }
      }
      
      public function getIconItemBags() : Array
      {
         return this.allBags;
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
         refine.label = DiversityManager.getString("RideBoxUI","strength");
         DiversityManager.setTextField(txtNeedMaterial,"RideBoxUI","NeedMaterial");
         DiversityManager.setTextField(txtLevel,"RideBoxUI","lv");
         DiversityManager.setTextField(txtEquRemark,"RideBoxUI","txtEquRemark");
      }
      
      public function showUI() : void
      {
         this.obf_0_3_k_543 = 1;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.showEquipAtt(this.obf_0_3_k_543);
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

