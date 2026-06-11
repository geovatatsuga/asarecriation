package com.sunweb.game.rpg.playerUI.totem
{
   import com.sunweb.game.res.obf_0_P_4381;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.netRole.obf_9_c_4534;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.obf_z_A_3653;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.action.obf_S_c_3330;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.rpg.totem.TotemInfo;
   import com.sunweb.game.rpg.totem.obf_J_w_1685;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_9_V_1635;
   import fl.data.DataProvider;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import playerUI.TotemBoxUIMC;
   
   public class TotemBoxUI extends TotemBoxUIMC implements obf_z_A_3653, IIconItemUI
   {
      
      private var allBags:Array;
      
      private var obf_5_F_4317:Array;
      
      private var obf_0_5_I_285:Dictionary;
      
      private var obf_0_3_n_308:Object;
      
      private var obf_3_f_3480:Object;
      
      private var obf_B_O_1864:int;
      
      private var currentLv:int;
      
      private var totem:obf_9_c_4534;
      
      private var obf_t_o_1744:Object;
      
      private var time:TimeLimiter = new TimeLimiter(500);
      
      public function TotemBoxUI()
      {
         super();
         this.visible = false;
         this.initDiversity();
         this.allBags = new Array();
         point.mouseEnabled = false;
         effectPoint.mouseEnabled = false;
         this.obf_5_F_4317 = new Array();
         this.obf_t_o_1744 = new Object();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.obf_0_5_I_285 = new Dictionary();
         this.obf_0_5_I_285[tabTrial] = obf_K_e_3075.totemTrialUI;
         this.obf_0_5_I_285[tabOffer] = obf_K_e_3075.totemOfferUI;
         this.obf_0_5_I_285[tabEvolve] = obf_K_e_3075.totemEvolveUI;
         obf_K_e_3075.showChildUI(this,this.obf_0_5_I_285[tabTrial]);
         this.refreshTableButton();
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.underline = true;
         txtReamark.setTextFormat(_loc1_);
         this.addListener();
      }
      
      private function addListener() : void
      {
         var _loc1_:* = undefined;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         list.addEventListener(Event.CHANGE,this.obf_0_7_c_329);
         cmdOpen.addEventListener(MouseEvent.CLICK,this.obf_s_p_1721);
         cmdOpen.addEventListener(MouseEvent.MOUSE_OVER,this.obf_G_k_3294);
         cmdOpen.addEventListener(MouseEvent.MOUSE_OUT,this.obf_6_b_2643);
         for(_loc1_ in this.obf_0_5_I_285)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.onClickTableButton);
         }
         obf_K_e_3075.addUIMouseToolTip(txtReamark,"remarkTotemBox");
      }
      
      private function removeListener() : void
      {
         var _loc1_:* = undefined;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         list.removeEventListener(Event.CHANGE,this.obf_0_7_c_329);
         cmdOpen.addEventListener(MouseEvent.CLICK,this.obf_s_p_1721);
         cmdOpen.addEventListener(MouseEvent.MOUSE_OVER,this.obf_G_k_3294);
         cmdOpen.addEventListener(MouseEvent.MOUSE_OUT,this.obf_6_b_2643);
         for(_loc1_ in this.obf_0_5_I_285)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onClickTableButton);
         }
         obf_K_e_3075.removeUIMouseToolTip(txtReamark);
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
      
      private function onClickTableButton(param1:MouseEvent) : void
      {
         obf_K_e_3075.closeAllChildUI(this);
         var _loc2_:IPlayerUI = this.obf_0_5_I_285[param1.currentTarget] as IPlayerUI;
         if(_loc2_)
         {
            obf_K_e_3075.showChildUI(this,_loc2_);
         }
      }
      
      private function obf_0_7_c_329(param1:Event) : void
      {
         this.clear();
         obf_K_e_3075.closeAllChildUI(this);
         obf_K_e_3075.showChildUI(this,this.obf_0_5_I_285[tabTrial]);
         this.refreshTableButton();
         if(list.dataProvider.length > 0)
         {
            this.obf_0_3_n_308 = list.selectedItem.data;
         }
         if(!this.obf_0_3_n_308)
         {
            return;
         }
         obf_K_e_3075.totemOfferUI.init(this.obf_0_3_n_308);
         obf_K_e_3075.totemEvolveUI.init(this.obf_0_3_n_308);
         if(this.obf_t_o_1744[list.selectedIndex])
         {
            this.obf_B_O_1864 = (this.obf_t_o_1744[list.selectedIndex] as TotemInfo).stage;
            this.currentLv = (this.obf_t_o_1744[list.selectedIndex] as TotemInfo).level;
         }
         else
         {
            this.obf_B_O_1864 = 0;
            this.currentLv = 1;
         }
         this.obf_F_3_4205();
         this.totem = new obf_9_c_4534(JSONUtil.getStr(this.obf_0_3_n_308,["image"]));
         if(this.totem)
         {
            this.totem.x = 0;
            point.addChild(this.totem);
            this.totem.doAction(obf_S_c_3330.obf_r_q_3113,0,true);
            if(this.obf_t_o_1744[list.selectedIndex])
            {
               this.totem.filters = [];
               cmdOpen.visible = false;
            }
            else
            {
               this.totem.filters = [obf_9_V_1635.getGrayFilter()];
               cmdOpen.visible = true;
            }
         }
         obf_K_e_3075.totemOfferUI.obf_0_4_u_689(this.obf_B_O_1864,this.currentLv);
         obf_K_e_3075.totemEvolveUI.obf_0_4_u_689(this.obf_B_O_1864,this.currentLv);
      }
      
      private function obf_G_k_3294(param1:MouseEvent) : void
      {
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:Object = null;
         var _loc2_:GameTipUI = new GameTipUI("totemBoxUITip");
         var _loc3_:int = 150;
         var _loc4_:String = "";
         var _loc5_:Object = JSONUtil.getObject(this.obf_0_3_n_308,["openItem"]);
         var _loc6_:int = JSONUtil.getInt(this.obf_0_3_n_308,["openGold"]);
         var _loc7_:String = DiversityManager.getString("TotemBoxUI","needGold",[obf_a_f_2935.getGoldString(_loc6_)]);
         for(_loc8_ in _loc5_)
         {
            _loc10_ = GameItemManager.getItemConfig(_loc8_);
            if(_loc10_)
            {
               _loc4_ += JSONUtil.getStr(_loc10_,["name"]) + " x" + _loc5_[_loc8_] + "\n";
            }
         }
         _loc4_ += _loc7_;
         _loc9_ = DiversityManager.getString("TotemBoxUI","totemBoxUITip",[_loc4_]);
         _loc2_.addTipInfo(_loc9_,_loc3_,0);
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_6_b_2643(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("totemBoxUITip");
      }
      
      private function obf_s_p_1721(param1:Event) : void
      {
         var _loc4_:String = null;
         if(!this.obf_0_3_n_308)
         {
            return;
         }
         var _loc2_:Object = JSONUtil.getObject(this.obf_0_3_n_308,["openItem"]);
         var _loc3_:int = JSONUtil.getInt(this.obf_0_3_n_308,["openGold"]);
         if(_loc3_ > GameContext.localPlayer.fullInfo.gold)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("TotemBoxUI","noGold"));
            return;
         }
         for(_loc4_ in _loc2_)
         {
            if(_loc2_[_loc4_] > obf_K_e_3075.playerBagUI.getItemCount(_loc4_))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("TotemBoxUI","noStuff"));
               return;
            }
         }
         obf_J_w_1685.sendUpLv(obf_K_e_3075.totemBoxUI.list.selectedIndex,1);
         cmdOpen.visible = false;
      }
      
      private function obf_F_3_4205() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         this.obf_3_f_3480 = new Object();
         if(this.obf_B_O_1864 <= this.obf_0_3_n_308["stage"].length && this.obf_B_O_1864 > 0)
         {
            this.obf_3_f_3480 = this.obf_0_3_n_308["stage"][this.obf_B_O_1864 - 1];
         }
         else if(this.obf_B_O_1864 <= 0)
         {
            this.obf_3_f_3480 = this.obf_0_3_n_308["stage"][this.obf_B_O_1864];
         }
         if(this.obf_3_f_3480)
         {
            txtLv.text = this.currentLv + "";
            if(this.obf_B_O_1864 > 0)
            {
               txtStage.text = DiversityManager.getString("TotemBoxUI",this.obf_B_O_1864 + "");
            }
            else
            {
               txtStage.text = DiversityManager.getString("TotemBoxUI",this.obf_B_O_1864 + 1 + "");
            }
            this.obf_0_6_6_194();
            _loc1_ = "";
            _loc2_ = "";
            _loc3_ = JSONUtil.getObject(this.obf_3_f_3480,["level",this.currentLv - 1,"attr"]);
            for(_loc4_ in _loc3_)
            {
               _loc1_ += RoleAttributesModifierEnum.getAttributesValueString(int(_loc4_),_loc3_[_loc4_]) + "\r";
               _loc2_ += RoleAttributesModifierEnum.getAttributesName(int(_loc4_)) + ":\r";
            }
            txtAttr.text = _loc1_;
            txtDayAttr.text = _loc2_;
         }
      }
      
      private function obf_0_6_6_194() : void
      {
         while(effectPoint.numChildren > 0)
         {
            effectPoint.removeChildAt(0);
         }
         if(this.obf_B_O_1864 <= 0)
         {
            obf_0_P_4381.obf_m_X_1194("totem" + (this.obf_B_O_1864 + 1) + "@totemEffect",effectPoint);
         }
         else
         {
            obf_0_P_4381.obf_m_X_1194("totem" + this.obf_B_O_1864 + "@totemEffect",effectPoint);
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.time.checkTimeout() && Boolean(this.totem))
         {
            this.totem.onUpdate();
         }
      }
      
      private function refreshTableButton() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in this.obf_0_5_I_285)
         {
            if(_loc1_)
            {
               _loc1_.gotoAndStop(this.obf_5_F_4317.indexOf(this.obf_0_5_I_285[_loc1_]) > -1 ? 2 : 1);
            }
         }
      }
      
      private function refreshActivityList() : void
      {
         var _loc3_:* = undefined;
         var _loc4_:Object = null;
         var _loc1_:Array = new Array();
         var _loc2_:Array = obf_J_w_1685.totemList;
         if(!_loc2_)
         {
            return;
         }
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_)
            {
               if(_loc3_)
               {
                  _loc4_ = new Object();
                  _loc4_.labelName = _loc3_.name;
                  _loc4_.data = _loc3_;
                  _loc1_.push(_loc4_);
               }
            }
         }
         list.dataProvider = new DataProvider(_loc1_);
         list.labelField = "labelName";
         list.rowHeight = 40;
         if(list.dataProvider.length > 0)
         {
            list.selectedIndex = 0;
         }
         this.obf_0_7_c_329(null);
      }
      
      private function clear() : void
      {
         txtLv.text = "";
         txtStage.text = "";
         txtAttr.text = "";
         txtDayAttr.text = "";
         while(point.numChildren > 0)
         {
            point.removeChildAt(0);
         }
         if(this.totem)
         {
            this.totem.destroy();
         }
         this.totem = null;
      }
      
      public function getTotemMap(param1:Object) : void
      {
         this.obf_t_o_1744 = param1;
      }
      
      public function obf_E_N_1183(param1:int, param2:int) : void
      {
         this.obf_B_O_1864 = param1;
         this.currentLv = param2;
         this.obf_F_3_4205();
         if(this.totem)
         {
            if(this.obf_t_o_1744[list.selectedIndex])
            {
               this.totem.filters = [];
               cmdOpen.visible = false;
            }
            else
            {
               this.totem.filters = [obf_9_V_1635.getGrayFilter()];
               cmdOpen.visible = true;
            }
         }
      }
      
      public function get obf_l_v_2495() : Array
      {
         return this.obf_5_F_4317;
      }
      
      public function get obf_R_4_1122() : DisplayObjectContainer
      {
         return childrenPoint;
      }
      
      public function obf_7_h_998(param1:IPlayerUI) : void
      {
         this.refreshTableButton();
      }
      
      public function removeChildPlayerUI(param1:IPlayerUI) : void
      {
         this.refreshTableButton();
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
         DiversityManager.setTextField(txtDeyTitle,"TotemBoxUI","txtDeyTitle");
         DiversityManager.setTextField(txtDayLv,"TotemBoxUI","txtDayLv");
         DiversityManager.setTextField(txtDayStage,"TotemBoxUI","txtDayStage");
         txtReamark.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("TotemBoxUI","txtReamark") + "</a>";
         cmdOpen.label = DiversityManager.getString("TotemBoxUI","cmdOpen");
         DiversityManager.setTextField(this.tabTrial.txtLabel,"TotemBoxUI","tabTrial",null,true);
         DiversityManager.setTextField(this.tabOffer.txtLabel,"TotemBoxUI","tabOffer",null,true);
         DiversityManager.setTextField(this.tabEvolve.txtLabel,"TotemBoxUI","tabEvolve",null,true);
      }
      
      public function showUI() : void
      {
         this.refreshActivityList();
         this.visible = true;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function destroy() : void
      {
         this.removeListener();
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

