package obf_I_x_2551
{
   import obf_D_Y_975.obf_7_q_3477;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import playerUI.pocketSlotUIMC;
   
   public class obf_C_5_3793 extends pocketSlotUIMC implements IPlayerUI, IIconItemUI
   {
      
      private var _slotList:Array;
      
      private var _bags:Array;
      
      private var stones:Object;
      
      private var stoneLoopLv:int = 0;
      
      public function obf_C_5_3793()
      {
         var _loc3_:Object = null;
         var _loc4_:obf_N_b_2646 = null;
         super();
         this.initDiversity();
         this.visible = false;
         titleBox.mouseEnabled = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this._slotList = new Array();
         this._bags = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 16)
         {
            _loc3_ = obf_7_q_3477.pocketSlots[_loc1_];
            if(_loc3_)
            {
               _loc4_ = new obf_N_b_2646(this,this["slot" + _loc1_],_loc3_.canType,_loc1_);
               this._slotList.push(_loc4_);
               this._bags.push(_loc4_.bag);
            }
            _loc1_++;
         }
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.underline = true;
         txtInfo.setTextFormat(_loc2_);
         this.addListener();
      }
      
      public function setStoneLoopLv(param1:int) : void
      {
         if(this.stoneLoopLv == param1)
         {
            return;
         }
         this.stoneLoopLv = param1;
         obf_K_e_3075.pocketItemUI.refreshItem();
      }
      
      public function get stoneLoopLevel() : int
      {
         return this.stoneLoopLv;
      }
      
      public function setStones(param1:Object) : void
      {
         this.stones = param1;
         if(this.stones)
         {
            this.refresh();
         }
         else
         {
            this.obf_w_p_3796();
         }
      }
      
      public function obf_w_p_3796() : void
      {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         DiversityManager.setTextField(txtLvInfo,"pocketSlotUI","txtLvInfo",["0"]);
         var _loc1_:Object = obf_7_q_3477.stoneLoop[0];
         if(_loc1_)
         {
            _loc2_ = GameItemManager.getItemConfig(_loc1_.itemCode);
            _loc3_ = "<FONT COLOR=\'#" + GameItemRank.getRankColor(_loc2_.rank).toString(16) + "\'>[" + _loc2_.name + "]</FONT>";
            DiversityManager.setTextField(txtLockInfo,"pocketSlotUI","txtLockInfo",[_loc3_]);
         }
      }
      
      public function refresh() : void
      {
         var _loc7_:obf_N_b_2646 = null;
         var _loc8_:String = null;
         var _loc9_:Object = null;
         var _loc10_:Object = null;
         var _loc11_:String = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:String = null;
         var _loc17_:Number = NaN;
         var _loc18_:int = 0;
         var _loc19_:Array = null;
         var _loc20_:String = null;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:String = null;
         var _loc24_:Number = NaN;
         var _loc25_:int = 0;
         var _loc26_:Object = null;
         var _loc27_:String = null;
         var _loc1_:Boolean = true;
         var _loc2_:int = 0;
         var _loc3_:Object = new Object();
         var _loc4_:Array = new Array();
         var _loc5_:int = 0;
         while(_loc5_ < 16)
         {
            _loc7_ = this._slotList[_loc5_];
            _loc7_.clearItem();
            _loc8_ = this.stones[_loc5_];
            if(_loc8_)
            {
               _loc9_ = GameItemManager.getItemConfig(_loc8_);
               _loc7_.setItem(_loc9_);
               _loc10_ = JSONUtil.getObject(_loc9_,["properties","pocketAttr"]);
               for(_loc11_ in _loc10_)
               {
                  _loc12_ = int(_loc10_[_loc11_]);
                  _loc13_ = int(_loc3_[_loc11_]);
                  if(_loc13_)
                  {
                     _loc13_ += _loc12_;
                  }
                  else
                  {
                     _loc13_ = _loc12_;
                  }
                  _loc3_[_loc11_] = _loc13_;
                  if(_loc4_.indexOf(int(_loc11_)) < 0)
                  {
                     _loc4_.push(int(_loc11_));
                  }
               }
               if(_loc1_ && (_loc2_ == 0 || _loc2_ > _loc9_.itemLevel))
               {
                  _loc2_ = int(_loc9_.itemLevel);
               }
            }
            else
            {
               _loc1_ = false;
               _loc2_ = 0;
            }
            _loc5_++;
         }
         this.setStoneLoopLv(_loc2_);
         _loc4_.sort();
         if(_loc4_.length > 0)
         {
            _loc14_ = 0;
            while(_loc14_ < _loc4_.length)
            {
               _loc15_ = int(_loc4_[_loc14_]);
               _loc16_ = RoleAttributesModifierEnum.getAttributesName(_loc15_);
               _loc17_ = Number(_loc3_[_loc15_ + ""]);
               this["txtAttrName" + _loc14_].text = _loc16_;
               if(_loc17_ < 1)
               {
                  this["txtAttrValue" + _loc14_].text = "+" + _loc17_ * 100 + "%";
               }
               else
               {
                  this["txtAttrValue" + _loc14_].text = "+" + _loc17_;
               }
               _loc14_++;
            }
         }
         else
         {
            _loc18_ = 0;
            while(_loc18_ < 4)
            {
               this["txtAttrName" + _loc18_].text = "";
               this["txtAttrValue" + _loc18_].text = "";
               _loc18_++;
            }
         }
         var _loc6_:Object = obf_7_q_3477.stoneLoop[_loc2_ - 1];
         if(_loc6_)
         {
            DiversityManager.setTextField(txtLvInfo,"pocketSlotUI","txtLvInfo",[_loc2_ + ""]);
            _loc19_ = new Array();
            for(_loc20_ in _loc6_.attr)
            {
               _loc19_.push(int(_loc20_));
            }
            _loc19_.sort();
            _loc21_ = 0;
            while(_loc21_ < _loc19_.length)
            {
               _loc22_ = int(_loc19_[_loc21_]);
               _loc23_ = RoleAttributesModifierEnum.getAttributesName(_loc22_);
               _loc24_ = Number(_loc6_.attr[_loc22_ + ""]);
               this["txtNextName" + _loc21_].text = _loc23_;
               if(_loc24_ < 1)
               {
                  this["txtNextValue" + _loc21_].text = "+" + int(_loc24_ * 100) + "%";
               }
               else
               {
                  this["txtNextValue" + _loc21_].text = "+" + _loc24_;
               }
               _loc21_++;
            }
         }
         else
         {
            DiversityManager.setTextField(txtLvInfo,"pocketSlotUI","txtLvInfo",[_loc2_ + ""]);
            _loc25_ = 0;
            while(_loc25_ < 6)
            {
               this["txtNextName" + _loc25_].text = "";
               this["txtNextValue" + _loc25_].text = "";
               _loc25_++;
            }
         }
         if(_loc2_ >= obf_7_q_3477.stoneLoop.length)
         {
            txtLockInfo.text = "";
         }
         else
         {
            _loc6_ = obf_7_q_3477.stoneLoop[_loc2_];
            if(_loc6_)
            {
               _loc26_ = GameItemManager.getItemConfig(_loc6_.itemCode);
               _loc27_ = "<FONT COLOR=\'#" + GameItemRank.getRankColor(_loc26_.rank).toString(16) + "\'>[" + _loc26_.name + "]</FONT>";
               DiversityManager.setTextField(txtLockInfo,"pocketSlotUI","txtLockInfo",[_loc27_]);
            }
         }
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtTitle,"pocketSlotUI","txtTitle");
         txtInfo.htmlText = "<a HREF=\'event:#\'>" + DiversityManager.getString("pocketSlotUI","txtInfo") + "</a>";
         DiversityManager.setTextField(txtAllAttr,"pocketSlotUI","txtAllAttr");
         DiversityManager.setTextField(txtThisAttr,"pocketSlotUI","txtThisAttr");
         DiversityManager.setTextField(txtLvInfo,"pocketSlotUI","txtLvInfo",["0"]);
         cmdAssemble.label = DiversityManager.getString("pocketSlotUI","cmdAssemble");
         cmdPocket.label = DiversityManager.getString("pocketSlotUI","cmdPocket");
      }
      
      public function addListener() : void
      {
         var _loc2_:obf_N_b_2646 = null;
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdPocket.addEventListener(MouseEvent.CLICK,this.obf_I_4656);
         cmdAssemble.addEventListener(MouseEvent.CLICK,this.obf_w_i_3412);
         obf_K_e_3075.addUIMouseToolTip(txtInfo,"Pocket_TxtInfo");
         var _loc1_:int = 0;
         while(_loc1_ < 16)
         {
            _loc2_ = this._slotList[_loc1_];
            _loc2_.addListener();
            _loc1_++;
         }
      }
      
      private function removeListener() : void
      {
         var _loc2_:obf_N_b_2646 = null;
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdPocket.removeEventListener(MouseEvent.CLICK,this.obf_I_4656);
         cmdAssemble.removeEventListener(MouseEvent.CLICK,this.obf_w_i_3412);
         obf_K_e_3075.removeUIMouseToolTip(txtInfo);
         var _loc1_:int = 0;
         while(_loc1_ < 16)
         {
            _loc2_ = this._slotList[_loc1_];
            _loc2_.removeListener();
            _loc1_++;
         }
      }
      
      public function obf_I_4656(param1:Event) : void
      {
         if(obf_K_e_3075.pocketItemUI.visible)
         {
            return;
         }
         obf_K_e_3075.closeUI(obf_K_e_3075.pocketSlotUI);
         obf_K_e_3075.showUI(obf_K_e_3075.pocketItemUI);
      }
      
      public function obf_w_i_3412(param1:Event) : void
      {
         obf_K_e_3075.assembleBoxUI.show("","",null,[obf_7_q_3477.assemble]);
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
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return bg.getBounds(bg).contains(bg.mouseX,bg.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         if(!this.stones)
         {
            this.obf_w_p_3796();
         }
         this.visible = true;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function getIconItemBags() : Array
      {
         return this._bags;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.stones = null;
         this.removeListener();
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
         if(!param1.haveIconItem)
         {
            return;
         }
         if(!obf_K_e_3075.playerBagUI.haveEmptyBag(1))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","playerBagFull"));
            return;
         }
         obf_7_q_3477.obf_B_l_1212(2,param1.itemIndex,param1.haveIconItem.itemCode);
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         if(!param1)
         {
            return;
         }
         if(!param1 || param3.parentIconUI != obf_K_e_3075.playerBagUI)
         {
            return;
         }
         var _loc4_:obf_N_b_2646 = this._slotList[param1.itemIndex];
         if(!_loc4_)
         {
            return;
         }
         if(_loc4_.bag.haveIconItem)
         {
            return;
         }
         var _loc5_:Array = _loc4_.obf_Z_H_3327;
         if(!_loc5_)
         {
            return;
         }
         var _loc6_:Object = GameItemManager.getItemConfig(param2.itemCode);
         if(!_loc6_)
         {
            return;
         }
         var _loc7_:int = JSONUtil.getInt(_loc6_,["properties","pocketType"]);
         if(_loc5_.indexOf(_loc7_) > -1)
         {
            obf_7_q_3477.obf_B_l_1212(1,param1.itemIndex,param2.itemCode);
         }
         else
         {
            WindowManager.showMessageBox(DiversityManager.getString("pocketSlotUI","typeCannot"));
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
   }
}

