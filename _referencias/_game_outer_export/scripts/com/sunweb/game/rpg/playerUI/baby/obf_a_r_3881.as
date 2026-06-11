package com.sunweb.game.rpg.playerUI.baby
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.baby.obf_s_1265;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import playerUI.BloodUIMC;
   
   public class obf_a_r_3881 extends BloodUIMC implements IIconItemUI
   {
      
      private var materiaBag:IconItemBag;
      
      private var totalPhase:int = 3;
      
      private var lvBox:Array;
      
      private var obf_Y_Z_3801:int;
      
      private var currentBloodLv:int;
      
      public function obf_a_r_3881()
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         this.lvBox = new Array();
         super();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         titleBox.mouseEnabled = false;
         txtDeyTitle.mouseEnabled = false;
         barLv.gotoAndStop(1);
         this.initDiversity();
         this.materiaBag = new IconItemBag(materialIconBar,this,0);
         this.materiaBag.lockDrag = true;
         this.materiaBag.addValidType(GameItemType.ALL);
         var _loc1_:int = 1;
         while(_loc1_ <= this.totalPhase)
         {
            (this["Lv" + _loc1_] as MovieClip).doubleClickEnabled = true;
            this.lvBox.push(this["Lv" + _loc1_]);
            _loc3_ = 1;
            while(_loc3_ <= 10)
            {
               _loc4_ = this["Lv" + _loc1_]["b" + _loc3_];
               _loc4_.gotoAndStop("hide");
               _loc3_++;
            }
            _loc1_++;
         }
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.underline = true;
         remark.setTextFormat(_loc2_);
         this.addListener();
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         bgBox.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdBlood.addEventListener(MouseEvent.CLICK,this.obf_0_O_1748);
         obf_K_e_3075.addUIMouseToolTip(remark,"remarkBlood");
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         bgBox.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdBlood.removeEventListener(MouseEvent.CLICK,this.obf_0_O_1748);
         obf_K_e_3075.removeUIMouseToolTip(remark);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function obf_0_O_1748(param1:Event) : void
      {
         var _loc2_:String = obf_s_1265.getBloodConfig().itemCode;
         if(obf_K_e_3075.playerBagUI.getItemCount(_loc2_) < this.obf_Y_Z_3801)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("BoyUI","cantMaterial"));
            return;
         }
         if(this.currentBloodLv >= 30)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("BoyUI","maxBlood"));
            return;
         }
         obf_s_1265.sendBabyBloodUpRequest();
      }
      
      private function obf_W_7_1006(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         txtLvBarValue.text = "";
         if(this.currentBloodLv < 30)
         {
            txtLvBarValue.text = param1 + "/" + param2;
            _loc3_ = 100 * Number(param1 / param2);
            if(_loc3_ < 2)
            {
               _loc3_ = 2;
            }
            barLv.gotoAndStop(_loc3_);
         }
         else
         {
            txtLvBarValue.text = DiversityManager.getString("BoyUI","maxLv");
            barLv.gotoAndStop(0);
         }
      }
      
      public function showData(param1:int, param2:int) : void
      {
         var _loc7_:Object = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc13_:Object = null;
         this.obf_E_j_2700();
         this.currentBloodLv = param1;
         var _loc3_:Object = obf_s_1265.getBloodConfig();
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:Array = JSONUtil.getValue(_loc3_,["levelConfig"]) as Array;
         this.obf_Y_Z_3801 = _loc4_[param1 - 1].itemNum;
         this.showItem(this.obf_Y_Z_3801);
         var _loc5_:String = "";
         var _loc6_:String = "";
         for each(_loc7_ in _loc4_[param1 - 1].attr)
         {
            _loc5_ += RoleAttributesModifierEnum.getAttributesName(int(_loc7_["attr"])) + ":\r";
            _loc6_ += "+" + _loc7_["value"] + "\r";
         }
         txtAttr.text = _loc5_;
         txtAttrNum.text = _loc6_;
         _loc8_ = "";
         _loc9_ = "";
         if(_loc4_[param1])
         {
            for each(_loc13_ in _loc4_[param1].attr)
            {
               _loc8_ += RoleAttributesModifierEnum.getAttributesName(int(_loc13_["attr"])) + ":\r";
               _loc9_ += "+" + _loc13_["value"] + "\r";
            }
            txtNextAttr.text = _loc8_;
            txtNextAttrNum.text = _loc9_;
         }
         var _loc10_:int = int(_loc4_[param1 - 1].exp);
         this.obf_W_7_1006(param2,_loc10_);
         var _loc11_:int = param1 / 10;
         if(param1 % 10 > 0)
         {
            _loc11_++;
         }
         if(_loc11_ < 1)
         {
            _loc11_ = 1;
         }
         var _loc12_:int = param1 % 10;
         if(param1 % 10 == 0)
         {
            _loc12_ = 10;
         }
         bloodLv.text = _loc12_ + "";
         bloodPhase.htmlText = DiversityManager.getString("BoyUI",_loc11_ + "");
         this.obf_H_v_3988(_loc11_,_loc12_);
      }
      
      private function showItem(param1:int) : void
      {
         this.materiaBag.dropIconItem();
         var _loc2_:IconItem = IconItemManager.getIconItemByCode(obf_s_1265.getBloodConfig().itemCode,"");
         if(!_loc2_)
         {
            return;
         }
         _loc2_.itemCount = param1;
         if(GameContext.bagItemManager.getHaveItemCount(_loc2_.itemCode,true) < _loc2_.itemCount)
         {
            _loc2_.countTextColor = 16711680;
         }
         this.materiaBag.pushIconItem(_loc2_);
      }
      
      public function obf_H_v_3988(param1:int, param2:int) : void
      {
         var lvSp:MovieClip = null;
         var j:int = 0;
         var pointMC:MovieClip = null;
         var phase:int = param1;
         var lv:int = param2;
         for each(lvSp in this.lvBox)
         {
            try
            {
               this.removeChild(lvSp);
            }
            catch(e:Error)
            {
            }
         }
         this.addChild(this.lvBox[phase - 1]);
         obf_1_v_2729.gotoAndStop(phase);
         j = 1;
         while(j <= lv)
         {
            pointMC = this["Lv" + phase]["b" + j];
            if(pointMC)
            {
               pointMC.gotoAndStop("none");
            }
            else
            {
               pointMC.gotoAndStop("hide");
            }
            j++;
         }
      }
      
      private function obf_E_j_2700() : void
      {
         bloodPhase.text = "";
         bloodLv.text = "";
         txtAttr.text = "";
         txtAttrNum.text = "";
         txtNextAttr.text = "";
         txtNextAttrNum.text = "";
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      public function getIconItemBags() : Array
      {
         return [this.materiaBag];
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
         DiversityManager.setTextField(txtDeyTitle,"BoyUI","cmdBlood");
         DiversityManager.setTextField(txtAtrrName,"BoyUI","txtAtrrName2");
         DiversityManager.setTextField(txtNextAtrrName,"BoyUI","txtNextAtrrName");
         DiversityManager.setTextField(txtDayBloodLv,"BoyUI","txtDayBloodLv");
         cmdBlood.label = DiversityManager.getString("BoyUI","cmdBloods");
         DiversityManager.setTextField(txtLvPlan,"BoyUI","txtLvPlan2");
         remark.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("BoyUI","remark") + "</a>";
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.showItem(this.obf_Y_Z_3801);
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

