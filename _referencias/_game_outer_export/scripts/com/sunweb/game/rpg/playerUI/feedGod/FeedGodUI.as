package com.sunweb.game.rpg.playerUI.feedGod
{
   import ControlClass.MJCheckBox;
   import obf_c_j_3175.obf_0_6_H_238;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemEquip;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.obf_9_V_1635;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import playerUI.FeedGodPointBg;
   import playerUI.FeedGodUIMC;
   
   public class FeedGodUI extends FeedGodUIMC implements IPlayerUI, IIconItemUI
   {
      
      private var bags:Array;
      
      private var _equipBag:IconItemBag;
      
      private var obf_0_4_244:Object;
      
      private var _useGodName:String;
      
      private var obf_t_d_3974:int = 1;
      
      private var obf_Y_K_2538:Array;
      
      public var selectCheckMap:Object;
      
      private var selectGodName:String;
      
      public function FeedGodUI()
      {
         super();
         this.initDiversity();
         this.visible = false;
         titleBox.mouseEnabled = false;
         bgBox1.mouseEnabled = false;
         bgBox2.mouseEnabled = false;
         this.onResize(null);
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.underline = true;
         txtExplain.setTextFormat(_loc1_);
         this.bags = new Array();
         this._equipBag = new IconItemBag(iconEquip,this,0);
         this._equipBag.lockDrag = true;
         this._equipBag.addValidType(GameItemType.EQUIPMENT);
         this.bags.push(this._equipBag);
         this.addListener();
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         cmdActivate.addEventListener(MouseEvent.CLICK,this.obf_0___d_310);
         cmdHeHun.addEventListener(MouseEvent.CLICK,this.obf_p_b_2139);
         cmdRefine.addEventListener(MouseEvent.CLICK,this.obf_S_v_1347);
         obf_K_e_3075.addUIMouseToolTip(txtExplain,"FeedGodUI_TxtExplain");
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         cmdActivate.removeEventListener(MouseEvent.CLICK,this.obf_0___d_310);
         cmdHeHun.removeEventListener(MouseEvent.CLICK,this.obf_p_b_2139);
         cmdRefine.removeEventListener(MouseEvent.CLICK,this.obf_S_v_1347);
         obf_K_e_3075.removeUIMouseToolTip(txtExplain);
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
         this.y = GameContext.gameStage.stageHeight / 2;
      }
      
      private function obf_0___d_310(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc2_:Object = obf_0_6_H_238.feedGodUseGodItems;
         for(_loc3_ in _loc2_)
         {
            if(obf_K_e_3075.playerBagUI.getItemCount(_loc3_) < _loc2_[_loc3_])
            {
               WindowManager.showMessageBox(DiversityManager.getString("FeedGodUI","warn_NoActivateMater",[GameItemManager.getItemName(_loc3_) + " x" + _loc2_[_loc3_]]));
               return;
            }
         }
         if(obf_L_l_4100.isEmpty(this.selectGodName))
         {
            WindowManager.showMessageBox(DiversityManager.getString("FeedGodUI","warn_SelectFG"));
            return;
         }
         obf_0_6_H_238.sendPlayerUseGodReq(this.selectGodName);
      }
      
      private function obf_p_b_2139(param1:Event) : void
      {
         var _loc3_:String = null;
         if(this.obf_t_d_3974 == obf_0_6_H_238.obf_8_t_4407.length)
         {
            WindowManager.showMessageBox(DiversityManager.getString("FeedGodUI","warn_MaxHeHun"));
            return;
         }
         var _loc2_:Object = obf_0_6_H_238.obf_8_t_4407[this.obf_t_d_3974 - 1].upItems;
         for(_loc3_ in _loc2_)
         {
            if(obf_K_e_3075.playerBagUI.getItemCount(_loc3_) < _loc2_[_loc3_])
            {
               WindowManager.showMessageBox(DiversityManager.getString("FeedGodUI","warn_NoHeHunMater",[GameItemManager.getItemName(_loc3_) + " x" + _loc2_[_loc3_]]));
               return;
            }
         }
         obf_0_6_H_238.sendPlayerSumGodReq();
      }
      
      private function obf_S_v_1347(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:String = null;
         if(!this._equipBag.haveIconItem)
         {
            WindowManager.showMessageBox(DiversityManager.getString("FeedGodUI","warn_PushEquip"));
            return;
         }
         for(_loc2_ in obf_0_6_H_238.feedGodRefineGodItems)
         {
            if(obf_K_e_3075.playerBagUI.getItemCount(_loc2_) < obf_0_6_H_238.feedGodRefineGodItems[_loc2_])
            {
               WindowManager.showMessageBox(DiversityManager.getString("FeedGodUI","warn_NoFGRenfineMater",[GameItemManager.getItemName(_loc2_) + " x" + obf_0_6_H_238.feedGodRefineGodItems[_loc2_]]));
               return;
            }
         }
         _loc3_ = new Array();
         for(_loc4_ in this.selectCheckMap)
         {
            if(this.selectCheckMap[_loc4_] == true)
            {
               _loc3_.push(_loc4_);
            }
         }
         if(_loc3_.length < 2)
         {
            WindowManager.showMessageBox(DiversityManager.getString("FeedGodUI","warn_SelectFeedGod"));
            return;
         }
         if(_loc3_[0] != _loc3_[1])
         {
            WindowManager.showConfirmBox(DiversityManager.getString("FeedGodUI","confirmRefine"),this.confirmRefine,{
               "name1":_loc3_[0],
               "name2":_loc3_[1]
            });
         }
      }
      
      private function confirmRefine(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_0_6_H_238.sendPlayerRefineGodReq(this._equipBag.haveIconItem.itemId,param1.par.name1,param1.par.name2);
         }
      }
      
      public function refreshList(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc6_:String = null;
         var _loc7_:Object = null;
         var _loc8_:obf_v_v_2271 = null;
         var _loc9_:MJCheckBox = null;
         var _loc10_:FeedGodPointBg = null;
         this.obf_0_4_244 = param1;
         this.clearList();
         var _loc2_:int = 0;
         var _loc4_:Array = obf_0_6_H_238.feedGodList;
         if(!_loc4_ || _loc4_.length == 0)
         {
            return;
         }
         this.obf_Y_K_2538 = new Array();
         this.selectCheckMap = new Object();
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            for(_loc6_ in param1)
            {
               if(_loc4_[_loc5_].name == _loc6_)
               {
                  _loc7_ = _loc4_[_loc5_].levelList[param1[_loc6_] - 1];
                  if(_loc7_)
                  {
                     _loc8_ = new obf_v_v_2271(_loc7_);
                     _loc8_.obf_i_m_3285(_loc6_ + " Lv." + param1[_loc6_]);
                     _loc8_.name = _loc6_;
                     _loc8_.filters = [obf_9_V_1635.getGrayFilter()];
                     this.obf_Y_K_2538.push(_loc8_);
                     _loc8_.x = _loc2_;
                     pointMCYangHun.addChild(_loc8_);
                     _loc8_.addEventListener(MouseEvent.CLICK,this.obf_w_j_2452);
                     _loc8_.cmdYangHun.addEventListener(MouseEvent.CLICK,this.obf_L_U_2565);
                     _loc2_ += _loc8_.width + 2;
                     _loc9_ = new MJCheckBox();
                     _loc9_.width = 200;
                     _loc9_.name = _loc6_;
                     _loc9_.label = _loc6_ + " Lv." + param1[_loc6_];
                     this.selectCheckMap[_loc9_.name] = false;
                     _loc9_.addEventListener(MouseEvent.CLICK,this.obf_0_7_l_231);
                     _loc10_ = new FeedGodPointBg();
                     _loc10_.addChild(_loc9_);
                     _loc10_.y += _loc3_;
                     _loc3_ += 30;
                     pointHeHun.addChild(_loc10_);
                  }
               }
            }
            _loc5_++;
         }
         this.useGodName(this._useGodName);
         this.show();
      }
      
      public function useGodName(param1:String) : void
      {
         this._useGodName = param1;
         var _loc2_:int = 0;
         while(_loc2_ < this.obf_Y_K_2538.length)
         {
            if(this.selectGodName == this.obf_Y_K_2538[_loc2_].name)
            {
               this.obf_Y_K_2538[_loc2_].filters = [];
               if(this.selectGodName == this._useGodName)
               {
                  cmdActivate.label = DiversityManager.getString("FeedGodUI","txtActivate");
                  cmdActivate.enabled = false;
               }
               else
               {
                  cmdActivate.label = DiversityManager.getString("FeedGodUI","txtNotActivate");
                  cmdActivate.enabled = true;
               }
            }
            else
            {
               this.obf_Y_K_2538[_loc2_].filters = [obf_9_V_1635.getGrayFilter()];
            }
            _loc2_++;
         }
      }
      
      private function obf_L_U_2565(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:* = undefined;
         this.selectGodName = param1.currentTarget.parent.name;
         var _loc2_:Object = param1.currentTarget.parent.config.upItems;
         for(_loc3_ in _loc2_)
         {
            if(obf_K_e_3075.playerBagUI.getItemCount(_loc3_) < _loc2_[_loc3_])
            {
               WindowManager.showMessageBox(DiversityManager.getString("FeedGodUI","warn_NoYangHunMater",[GameItemManager.getItemName(_loc3_) + " x" + _loc2_[_loc3_]]));
               return;
            }
         }
         for(_loc5_ in this.obf_0_4_244)
         {
            if(this.selectGodName == _loc5_)
            {
               _loc4_ = int(this.obf_0_4_244[_loc5_]);
               break;
            }
         }
         if(_loc4_ != 0 && _loc4_ == obf_0_6_H_238.getFeedGodListLevel(this.selectGodName))
         {
            WindowManager.showMessageBox(DiversityManager.getString("FeedGodUI","warn_MaxYangHun"));
            return;
         }
         obf_0_6_H_238.sendPlayerFeedGodReq(this.selectGodName);
      }
      
      public function sumGodLevel(param1:int) : void
      {
         if(param1 < 1)
         {
            this.obf_t_d_3974 = param1 = 1;
         }
         else
         {
            this.obf_t_d_3974 = param1;
         }
         var _loc2_:Number = obf_0_6_H_238.obf_8_t_4407[param1 - 1].per * 100;
         txtConform.htmlText = DiversityManager.getString("FeedGodUI","txtConform",[_loc2_.toFixed()]);
         this.show();
      }
      
      private function obf_w_j_2452(param1:Event) : void
      {
         this.selectGodName = param1.currentTarget.name;
         var _loc2_:int = 0;
         while(_loc2_ < this.obf_Y_K_2538.length)
         {
            if(this.selectGodName == this.obf_Y_K_2538[_loc2_].name)
            {
               this.obf_Y_K_2538[_loc2_].filters = [];
               if(this.selectGodName == this._useGodName)
               {
                  cmdActivate.label = DiversityManager.getString("FeedGodUI","txtActivate");
                  cmdActivate.enabled = false;
               }
               else
               {
                  cmdActivate.label = DiversityManager.getString("FeedGodUI","txtNotActivate");
                  cmdActivate.enabled = true;
               }
            }
            else
            {
               this.obf_Y_K_2538[_loc2_].filters = [obf_9_V_1635.getGrayFilter()];
            }
            _loc2_++;
         }
      }
      
      public function clearList() : void
      {
         var actBox:obf_v_v_2271 = null;
         while(pointMCYangHun.numChildren > 0)
         {
            actBox = pointMCYangHun.getChildAt(0) as obf_v_v_2271;
            try
            {
               actBox.removeEventListener(MouseEvent.CLICK,this.obf_w_j_2452);
            }
            catch(e:Error)
            {
            }
            pointMCYangHun.removeChildAt(0);
         }
         while(pointHeHun.numChildren > 0)
         {
            pointHeHun.removeChildAt(0);
         }
         txtShowAttrName.text = "";
         txtShowAttrs.text = "";
      }
      
      private function obf_0_7_l_231(param1:MouseEvent) : void
      {
         var _loc4_:String = null;
         var _loc2_:MJCheckBox = param1.currentTarget as MJCheckBox;
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:Array = new Array();
         this.selectCheckMap[_loc2_.name] = _loc2_.selected;
         for(_loc4_ in this.selectCheckMap)
         {
            if(this.selectCheckMap[_loc4_] == true)
            {
               _loc3_.push(_loc4_);
            }
         }
         if(_loc3_.length > 2)
         {
            _loc2_.selected = false;
            this.selectCheckMap[_loc2_.name] = _loc2_.selected;
            WindowManager.showMessageBox(DiversityManager.getString("FeedGodUI","warn_NotSelectMore"));
            return;
         }
         this.show();
      }
      
      private function show() : void
      {
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:* = undefined;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Object = null;
         var _loc11_:* = undefined;
         var _loc1_:Object = this.obf_0_4_244;
         var _loc2_:String = "";
         var _loc3_:String = "";
         txtShowAttrName.text = "";
         txtShowAttrs.text = "";
         var _loc4_:Array = new Array();
         for(_loc5_ in this.selectCheckMap)
         {
            if(this.selectCheckMap[_loc5_] == true)
            {
               _loc4_.push(_loc5_);
            }
         }
         _loc6_ = obf_0_6_H_238.feedGodList;
         for(_loc7_ in _loc1_)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc4_.length)
            {
               if(_loc7_ == _loc4_[_loc8_])
               {
                  _loc9_ = 0;
                  while(_loc9_ < _loc6_.length)
                  {
                     if(_loc7_ == _loc6_[_loc9_].name)
                     {
                        _loc10_ = _loc6_[_loc9_].levelList[_loc1_[_loc7_] - 1].attr;
                        for(_loc11_ in _loc10_)
                        {
                           _loc2_ += RoleAttributesModifierEnum.getAttributesName(int(_loc11_)) + "\n";
                           _loc3_ += RoleAttributesModifierEnum.getAttributesValueString(int(_loc11_),_loc10_[_loc11_] * obf_0_6_H_238.obf_8_t_4407[this.obf_t_d_3974 - 1].per) + "\n";
                        }
                     }
                     _loc9_++;
                  }
               }
               _loc8_++;
            }
         }
         txtShowAttrName.text = _loc2_;
         txtShowAttrs.text = _loc3_;
      }
      
      public function pushEquipIn(param1:IconItemEquip) : void
      {
         if(!param1)
         {
            return;
         }
         this._equipBag.dropIconItem();
         this._equipBag.pushIconItem(param1);
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return bgBox.getBounds(bgBox).contains(bgBox.mouseX,bgBox.mouseY);
         }
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"FeedGodUI","txtDeyTitle");
         txtExplain.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("FeedGodUI","txtExplain") + "</a>";
         txtConform.htmlText = DiversityManager.getString("FeedGodUI","txtConform",[0]);
         DiversityManager.setTextField(txtEquip,"FeedGodUI","txtEquip");
         txtYangHunBtn.label = DiversityManager.getString("FeedGodUI","txtYangHun");
         txtHeHunBtn.label = DiversityManager.getString("FeedGodUI","txtHeHun");
         cmdActivate.label = DiversityManager.getString("FeedGodUI","txtNotActivate");
         cmdHeHun.label = DiversityManager.getString("FeedGodUI","cmdHeHun");
         cmdRefine.label = DiversityManager.getString("FeedGodUI","cmdRefine");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.refreshList(this.obf_0_4_244);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.clearList();
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this.clearList();
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
         if(!param1 || param3.parentIconUI != obf_K_e_3075.playerBagUI)
         {
            return;
         }
         var _loc4_:Object = GameItemManager.getItemConfig(param2.itemCode);
         if(!_loc4_)
         {
            return;
         }
         if(obf_0_6_H_238.obf_s_K_1024.indexOf(_loc4_.properties.kind) == -1)
         {
            WindowManager.showMessageBox(DiversityManager.getString("FeedGodUI","warn_NoRefineEquip"));
            return;
         }
         if(param1 == this._equipBag && param2 is IconItemEquip)
         {
            this.pushEquipIn(param2 as IconItemEquip);
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
   }
}

