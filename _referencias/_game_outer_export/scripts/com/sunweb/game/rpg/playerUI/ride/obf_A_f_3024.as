package com.sunweb.game.rpg.playerUI.ride
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.netRole.obf_Y_E_3667;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.obf_z_A_3653;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.rideEquip.RideEquipPartType;
   import com.sunweb.game.rpg.rideEquip.obf_Y_7_1544;
   import com.sunweb.game.rpg.role.action.obf_D_0_1300;
   import com.sunweb.game.rpg.role.action.obf_S_c_3330;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import playerUI.RideEquBoxUIMC;
   
   public class obf_A_f_3024 extends RideEquBoxUIMC implements IIconItemUI, obf_z_A_3653
   {
      
      private var allBags:Array;
      
      private var obf_0_5_I_285:Dictionary;
      
      private var obf_5_F_4317:Array;
      
      private var _player:obf_Y_E_3667;
      
      private var obf_w_4_1469:IPlayerUI;
      
      public function obf_A_f_3024()
      {
         super();
         this.initDiversity();
         this.obf_5_F_4317 = new Array();
         this.allBags = [];
         this.obf_0_5_I_285 = new Dictionary();
         this.obf_0_5_I_285[strength] = obf_K_e_3075.rideStrengthUI;
         this.obf_0_5_I_285[refine] = obf_K_e_3075.rideEquipRefineUI;
         this.obf_0_5_I_285[recreate] = obf_K_e_3075.rideEquipRecreateUI;
         this.obf_0_5_I_285[inherit] = obf_K_e_3075.rideEquipInheritUI;
         this.visible = false;
         txtDeyTitle.mouseEnabled = false;
         ridePoint.mouseEnabled = false;
         titleBox.mouseEnabled = false;
         this.x = GameContext.gameStage.stageWidth >> 1;
         this.y = GameContext.gameStage.stageHeight >> 1;
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.underline = true;
         txtExplain.setTextFormat(_loc1_);
         this.addListener();
      }
      
      private function addListener() : void
      {
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         strength.addEventListener(MouseEvent.CLICK,this.onClick);
         refine.addEventListener(MouseEvent.CLICK,this.onClick);
         recreate.addEventListener(MouseEvent.CLICK,this.onClick);
         inherit.addEventListener(MouseEvent.CLICK,this.onClick);
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         part1.addEventListener(MouseEvent.CLICK,this.obf_0_6_y_449);
         part2.addEventListener(MouseEvent.CLICK,this.obf_0_6_y_449);
         part3.addEventListener(MouseEvent.CLICK,this.obf_0_6_y_449);
         part4.addEventListener(MouseEvent.CLICK,this.obf_0_6_y_449);
         txtExplain.addEventListener(MouseEvent.MOUSE_OVER,this.obf_G_k_3294);
         txtExplain.addEventListener(MouseEvent.MOUSE_OUT,this.obf_i_n_1001);
      }
      
      private function removeListener() : void
      {
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         strength.removeEventListener(MouseEvent.CLICK,this.onClick);
         refine.removeEventListener(MouseEvent.CLICK,this.onClick);
         recreate.removeEventListener(MouseEvent.CLICK,this.onClick);
         inherit.removeEventListener(MouseEvent.CLICK,this.onClick);
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         part1.removeEventListener(MouseEvent.CLICK,this.obf_0_6_y_449);
         part2.removeEventListener(MouseEvent.CLICK,this.obf_0_6_y_449);
         part3.removeEventListener(MouseEvent.CLICK,this.obf_0_6_y_449);
         part4.removeEventListener(MouseEvent.CLICK,this.obf_0_6_y_449);
         txtExplain.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_G_k_3294);
         txtExplain.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_i_n_1001);
      }
      
      private function obf_G_k_3294(param1:MouseEvent) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("rideEquipExplain");
         var _loc3_:int = 250;
         _loc2_.addTipInfo(JSONUtil.getStr(obf_Y_7_1544.getRideEquiConfig(),["remark"]),_loc3_,1);
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_i_n_1001(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("rideEquipExplain");
      }
      
      private function obf_0_6_y_449(param1:Event) : void
      {
         var _loc2_:int = RideEquipPartType.getPartType(param1.currentTarget.name);
         this.obf_8_n_1939(_loc2_);
         if(this.obf_w_4_1469 == obf_K_e_3075.rideStrengthUI)
         {
            obf_K_e_3075.rideStrengthUI.showEquipAtt(_loc2_);
         }
         else if(this.obf_w_4_1469 == obf_K_e_3075.rideEquipRefineUI)
         {
            obf_K_e_3075.rideEquipRefineUI.showRefine(_loc2_);
         }
         else if(this.obf_w_4_1469 == obf_K_e_3075.rideEquipRecreateUI)
         {
            obf_K_e_3075.rideEquipRecreateUI.showInfo(_loc2_);
         }
      }
      
      private function isEnablePart(param1:Boolean) : void
      {
         var _loc2_:int = 1;
         while(_loc2_ < 5)
         {
            this["part" + _loc2_].mouseEnabled = param1;
            _loc2_++;
         }
      }
      
      public function showModel(param1:String) : void
      {
         this.obf_G_C_2151();
         this._player = new obf_Y_E_3667(GameContext.localPlayer.fullInfo.jobCode,GameContext.localPlayer.fullInfo.sex,GameContext.localPlayer.fullInfo.hairStyleIndex);
         this._player.setEquipmentModels(GameContext.localPlayer.getEquipmentModels());
         this._player.setRideModel(param1);
         this._player.ride(true);
         this._player.moveToPixel(0,0);
         this._player.doAction(obf_S_c_3330.obf_h_4_3537,obf_D_0_1300.DOWN,true);
         this._player.scaleX = this._player.scaleY = 1;
         ridePoint.addChild(this._player);
      }
      
      private function obf_G_C_2151() : void
      {
         while(ridePoint.numChildren > 0)
         {
            ridePoint.removeChildAt(0);
         }
         if(this._player)
         {
            this._player.destroy();
         }
         this._player = null;
      }
      
      private function onClick(param1:Event) : void
      {
         var _loc3_:int = 0;
         obf_K_e_3075.closeAllChildUI(this);
         var _loc2_:IPlayerUI = this.obf_0_5_I_285[param1.currentTarget] as IPlayerUI;
         if(_loc2_)
         {
            this.obf_w_4_1469 = _loc2_;
            _loc3_ = 1;
            while(_loc3_ < 5)
            {
               if(_loc3_ == 1)
               {
                  this["part" + _loc3_].gotoAndStop(2);
               }
               else
               {
                  this["part" + _loc3_].gotoAndStop(1);
               }
               _loc3_++;
            }
            if(this.obf_w_4_1469 == this.obf_0_5_I_285[inherit])
            {
               this.isEnablePart(false);
            }
            else
            {
               this.isEnablePart(true);
            }
            obf_K_e_3075.showChildUI(this,_loc2_);
         }
      }
      
      private function obf_8_n_1939(param1:int) : void
      {
         var _loc2_:int = 1;
         while(_loc2_ < 5)
         {
            if(this["part" + param1] == this["part" + _loc2_])
            {
               this["part" + _loc2_].gotoAndStop(2);
            }
            else
            {
               this["part" + _loc2_].gotoAndStop(1);
            }
            this["part" + _loc2_].mouseEnabled = true;
            _loc2_++;
         }
      }
      
      private function onClose(param1:Event) : void
      {
         if(obf_K_e_3075.rideEquipRecreateUI.isSave || obf_K_e_3075.rideEquipRefineUI.isSave)
         {
            WindowManager.showConfirmBox(DiversityManager.getString("RideBoxUI","isClose"),this.isClose);
            return;
         }
         obf_K_e_3075.closeUI(this);
      }
      
      private function isClose(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_K_e_3075.closeUI(this);
         }
      }
      
      public function getIconItemBags() : Array
      {
         var _loc2_:IPlayerUI = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in this.obf_5_F_4317)
         {
            if(Boolean(_loc2_) && _loc2_ is IIconItemUI)
            {
               _loc1_ = _loc1_.concat((_loc2_ as IIconItemUI).getIconItemBags());
            }
         }
         return this.allBags.concat(_loc1_);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
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
         strength.label = DiversityManager.getString("RideBoxUI","strength");
         recreate.label = DiversityManager.getString("RideBoxUI","recreate");
         refine.label = DiversityManager.getString("RideBoxUI","refine");
         inherit.label = DiversityManager.getString("RideBoxUI","inherit");
         DiversityManager.setTextField(txtDeyTitle,"RideBoxUI","txtEquipTitle");
         txtExplain.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("RideBoxUI","explain") + "</a>";
      }
      
      private function showSoul() : void
      {
         var _loc2_:Array = null;
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = obf_K_e_3075.rideStrengthUI.equipSoulArr;
            this["txtName" + _loc1_].text = "";
            if(_loc2_.length > 0)
            {
               this["txtName" + _loc1_].text = DiversityManager.getString("RideBoxUI",_loc1_ + "",[_loc2_[_loc1_]]);
            }
            _loc1_++;
         }
      }
      
      public function showUI() : void
      {
         obf_K_e_3075.closeAllChildUI(this);
         obf_K_e_3075.showChildUI(this,this.obf_0_5_I_285[strength]);
         this.showSoul();
         this.obf_8_n_1939(1);
         this.obf_w_4_1469 = this.obf_0_5_I_285[strength];
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         obf_K_e_3075.rideEquipRefineUI.initDection();
         obf_K_e_3075.rideEquipRecreateUI.initDection();
         obf_K_e_3075.rideEquipRecreateUI.isSave = false;
         obf_K_e_3075.rideEquipRefineUI.isSave = false;
         obf_K_e_3075.rideStrengthUI.equipSoulArr = [];
         this.visible = false;
         while(ridePoint.numChildren > 0)
         {
            ridePoint.removeChildAt(0);
         }
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this._player.destroy();
         while(ridePoint.numChildren > 0)
         {
            ridePoint.removeChildAt(0);
         }
      }
      
      public function get obf_l_v_2495() : Array
      {
         return this.obf_5_F_4317;
      }
      
      public function get obf_R_4_1122() : DisplayObjectContainer
      {
         return partPoint;
      }
      
      public function obf_7_h_998(param1:IPlayerUI) : void
      {
      }
      
      public function removeChildPlayerUI(param1:IPlayerUI) : void
      {
      }
   }
}

