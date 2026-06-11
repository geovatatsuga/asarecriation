package com.sunweb.game.rpg.playerUI.godStyle
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.godStyle.GodStyleRankInfo;
   import com.sunweb.game.rpg.godStyle.obf_d_M_1152;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.GodStyleUIMC;
   
   public class obf_0___K_424 extends GodStyleUIMC implements IPlayerUI, IIconItemUI
   {
      
      private var _type:int = -1;
      
      private var obf_l_g_837:Object;
      
      private var _rankMap:Object;
      
      private var obf_k_G_2546:Object;
      
      private var obf_n_L_971:Object;
      
      private var _bags:Array;
      
      private var obf_0_2_m_414:Object;
      
      public function obf_0___K_424()
      {
         var _loc2_:IconItemBag = null;
         var _loc3_:int = 0;
         var _loc4_:IconItemBag = null;
         super();
         this.visible = false;
         this.initDiversity();
         titleBox.mouseEnabled = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         type0.gotoAndStop(1);
         type1.gotoAndStop(1);
         type2.gotoAndStop(1);
         this._bags = new Array();
         this.obf_0_2_m_414 = new Object();
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            _loc2_ = new IconItemBag(this["icon" + _loc1_],this,_loc1_);
            _loc2_.addValidType(GameItemType.ALL);
            _loc2_.lockDrag = true;
            this._bags.push(_loc2_);
            this.obf_0_2_m_414[_loc1_] = _loc2_;
            _loc3_ = 0;
            while(_loc3_ < 3)
            {
               _loc4_ = new IconItemBag(this["item" + _loc1_ + "_" + _loc3_],this,(_loc1_ + 1) * 10 + _loc3_);
               _loc4_.addValidType(GameItemType.ALL);
               _loc4_.lockDrag = true;
               this._bags.push(_loc4_);
               this.obf_0_2_m_414[(_loc1_ + 1) * 10 + _loc3_] = _loc4_;
               _loc3_++;
            }
            _loc1_++;
         }
         this.addListener();
      }
      
      public function get ids() : Object
      {
         return this.obf_l_g_837;
      }
      
      public function setType(param1:int) : void
      {
         this._type = param1;
      }
      
      public function get type() : int
      {
         return this._type;
      }
      
      public function updateRankMap(param1:String, param2:Array) : void
      {
         if(!this._rankMap)
         {
            this._rankMap = new Object();
         }
         this._rankMap[param1] = param2;
      }
      
      public function setGodStyleMap(param1:String, param2:int) : void
      {
         if(!this.obf_n_L_971)
         {
            this.obf_n_L_971 = new Object();
         }
         this.obf_n_L_971[param1] = param2;
      }
      
      public function obf_0_9_F_324(param1:String) : Boolean
      {
         if(!this.obf_n_L_971)
         {
            return false;
         }
         var _loc2_:* = this.obf_n_L_971[param1];
         if(!_loc2_)
         {
            return false;
         }
         return true;
      }
      
      public function getLevelById(param1:String) : int
      {
         if(!this.obf_n_L_971)
         {
            return 0;
         }
         var _loc2_:* = this.obf_n_L_971[param1];
         if(!_loc2_)
         {
            return 0;
         }
         return _loc2_;
      }
      
      public function initDiversity() : void
      {
         txtTip.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("godStyleUI","txtTip") + "</a>";
         DiversityManager.setTextField(txtTitle,"godStyleUI","txtTitle");
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this["cmdButton" + _loc1_].label = DiversityManager.getString("godStyleUI","cmdButton0");
            _loc1_++;
         }
      }
      
      private function addListener() : void
      {
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         obf_K_e_3075.addUIMouseToolTip(txtTip,"txtGodStyleInfo");
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this["type" + _loc1_].addEventListener(MouseEvent.CLICK,this.obf_P_G_3138);
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < 3)
         {
            this["cmdButton" + _loc2_].addEventListener(MouseEvent.MOUSE_OVER,this.obf_G_k_3294);
            this["cmdButton" + _loc2_].addEventListener(MouseEvent.MOUSE_OUT,this.obf_6_b_2643);
            this["cmdButton" + _loc2_].addEventListener(MouseEvent.CLICK,this.onCmdButton);
            _loc2_++;
         }
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         obf_K_e_3075.removeUIMouseToolTip(txtTip);
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this["type" + _loc1_].removeEventListener(MouseEvent.CLICK,this.obf_P_G_3138);
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < 3)
         {
            this["cmdButton" + _loc2_].removeEventListener(MouseEvent.MOUSE_OVER,this.obf_G_k_3294);
            this["cmdButton" + _loc2_].removeEventListener(MouseEvent.MOUSE_OUT,this.obf_6_b_2643);
            this["cmdButton" + _loc2_].removeEventListener(MouseEvent.CLICK,this.onCmdButton);
            _loc2_++;
         }
      }
      
      private function obf_G_k_3294(param1:Event) : void
      {
         var _loc2_:String = this.obf_k_G_2546[param1.currentTarget.name];
         var _loc3_:GameTipUI = new GameTipUI("godStyle");
         var _loc4_:int = 100;
         var _loc5_:Object = obf_d_M_1152.getStyleConfig(_loc2_);
         if(!_loc5_)
         {
            return;
         }
         var _loc6_:Array = JSONUtil.getValue(_loc5_,["upNeeds"]) as Array;
         var _loc7_:int = 0;
         if(this.obf_0_9_F_324(_loc2_))
         {
            _loc7_ = int(_loc6_[this.getLevelById(_loc2_)]);
         }
         else
         {
            _loc7_ = int(_loc6_[0]);
         }
         var _loc8_:String = DiversityManager.getString("godStyleUI","cmdButtonTip",[_loc7_]);
         _loc3_.addTipInfo(_loc8_,_loc4_,1);
         GameTipManager.showTip(_loc3_);
      }
      
      private function obf_6_b_2643(param1:Event) : void
      {
         GameTipManager.closeTip("godStyle");
      }
      
      private function obf_P_G_3138(param1:Event) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:int = Number(_loc2_.substr(4));
         if(this._type == _loc3_)
         {
            return;
         }
         this.obf_e_x_t_e_n_d_s_32(_loc3_);
      }
      
      public function obf_e_x_t_e_n_d_s_32(param1:int) : void
      {
         var _loc5_:Object = null;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:IconItemBag = null;
         var _loc10_:String = null;
         var _loc11_:IconItem = null;
         var _loc12_:int = 0;
         this.setType(param1);
         type0.gotoAndStop(1);
         type1.gotoAndStop(1);
         type2.gotoAndStop(1);
         this["type" + param1].gotoAndStop(2);
         this.obf_l_g_837 = new Object();
         var _loc2_:Array = obf_d_M_1152.getGodStyleConfig(this._type);
         if(!_loc2_)
         {
            return;
         }
         this.obf_k_G_2546 = new Object();
         var _loc3_:int = -1;
         var _loc4_:int = 0;
         while(_loc4_ < 3)
         {
            _loc5_ = _loc2_[_loc4_];
            _loc6_ = JSONUtil.getStr(_loc5_,["id"]);
            this.obf_l_g_837[_loc6_] = _loc4_;
            this["styleTitle" + _loc4_].text = JSONUtil.getStr(_loc5_,["name"]);
            _loc7_ = JSONUtil.getValue(_loc5_,["awardItems"]) as Array;
            _loc8_ = 0;
            while(_loc8_ < 3)
            {
               _loc9_ = this.obf_0_2_m_414[(_loc4_ + 1) * 10 + _loc8_];
               if(_loc9_.haveIconItem)
               {
                  _loc9_.dropIconItem();
               }
               _loc10_ = _loc7_[_loc8_];
               _loc11_ = IconItemManager.getIconItemByCode(_loc10_,"");
               if(_loc11_)
               {
                  _loc9_.pushIconItem(_loc11_);
               }
               _loc8_++;
            }
            this.obf_N_n_916(_loc6_);
            this.refreshItem(_loc6_);
            this.obf_k_G_2546[this["cmdButton" + _loc4_].name] = _loc6_;
            this["cmdButton" + _loc4_].label = DiversityManager.getString("godStyleUI","cmdButton0");
            this["cmdButton" + _loc4_].visible = true;
            if(this.obf_0_9_F_324(_loc6_))
            {
               this["cmdButton" + _loc4_].label = DiversityManager.getString("godStyleUI","cmdButton1");
               _loc3_ = _loc4_;
            }
            this.obf_n_n_1093(_loc6_);
            _loc4_++;
         }
         if(_loc3_ != -1)
         {
            _loc12_ = 0;
            while(_loc12_ < 3)
            {
               if(_loc3_ != _loc12_)
               {
                  this["cmdButton" + _loc12_].visible = false;
               }
               _loc12_++;
            }
         }
      }
      
      public function obf_N_n_916(param1:String) : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:GodStyleRankInfo = null;
         var _loc8_:String = null;
         if(!this._rankMap || !this.obf_l_g_837)
         {
            return;
         }
         var _loc2_:* = this.obf_l_g_837[param1];
         if(_loc2_ != 0 && _loc2_ != 1 && _loc2_ != 2)
         {
            return;
         }
         var _loc3_:Array = this._rankMap[param1];
         var _loc4_:int = 0;
         while(_loc4_ < 10)
         {
            _loc5_ = "";
            _loc6_ = "";
            if(_loc3_)
            {
               _loc7_ = _loc3_[_loc4_];
               if(_loc7_)
               {
                  _loc8_ = GameContext.localPlayer.fullInfo.name;
                  if(_loc8_ == _loc7_.name)
                  {
                     _loc5_ = "<FONT COLOR=\'#FF0000\'>" + _loc7_.name + "</FONT>";
                     _loc6_ = "<FONT COLOR=\'#FF0000\'>" + _loc7_.value + "</FONT>";
                  }
                  else
                  {
                     _loc5_ = "<FONT COLOR=\'#00FF00\'>" + _loc7_.name + "</FONT>";
                     _loc6_ = "<FONT COLOR=\'#00FF00\'>" + _loc7_.value + "</FONT>";
                  }
               }
            }
            this["rankName" + _loc2_ + "_" + _loc4_].htmlText = _loc5_;
            this["rankValue" + _loc2_ + "_" + _loc4_].htmlText = _loc6_;
            _loc4_++;
         }
      }
      
      public function refreshItem(param1:String) : void
      {
         var _loc6_:Array = null;
         var _loc2_:int = int(this.obf_l_g_837[param1]);
         if(this.obf_0_2_m_414[_loc2_].haveIconItem)
         {
            this.obf_0_2_m_414[_loc2_].dropIconItem();
         }
         var _loc3_:Object = obf_d_M_1152.getStyleConfig(param1);
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:String = null;
         if(this.obf_0_9_F_324(param1))
         {
            _loc6_ = JSONUtil.getValue(_loc3_,["godItems"]) as Array;
            _loc4_ = _loc6_[this.getLevelById(param1) - 1];
         }
         else
         {
            _loc4_ = JSONUtil.getStr(_loc3_,["maxItem"]);
         }
         var _loc5_:IconItem = IconItemManager.getIconItemByCode(_loc4_,"");
         if(!_loc5_)
         {
            return;
         }
         this.obf_0_2_m_414[_loc2_].pushIconItem(_loc5_);
      }
      
      public function obf_n_n_1093(param1:String) : void
      {
         var _loc2_:int = int(this.obf_l_g_837[param1]);
         var _loc3_:Object = obf_d_M_1152.getStyleConfig(param1);
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:int = GameContext.localPlayer.dynamicVars.getIntVar(JSONUtil.getStr(_loc3_,["varName"]));
         this["myValue" + _loc2_].text = DiversityManager.getString("godStyleUI","myValue",[_loc4_]);
      }
      
      private function onCmdButton(param1:Event) : void
      {
         var _loc2_:String = this.obf_k_G_2546[param1.currentTarget.name];
         var _loc3_:Object = obf_d_M_1152.getStyleConfig(_loc2_);
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:Array = JSONUtil.getValue(_loc3_,["upNeeds"]) as Array;
         var _loc5_:int = 0;
         if(this.obf_0_9_F_324(_loc2_))
         {
            _loc5_ = int(_loc4_[this.getLevelById(_loc2_)]);
         }
         else
         {
            _loc5_ = int(_loc4_[0]);
         }
         var _loc6_:int = GameContext.localPlayer.dynamicVars.getIntVar(JSONUtil.getStr(_loc3_,["varName"]));
         if(_loc6_ < _loc5_)
         {
            WindowManager.showMessageBox(DiversityManager.getString("godStyleUI","notEnough"));
            return;
         }
         obf_d_M_1152.obf_p_P_3626(_loc2_);
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
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function showUI() : void
      {
         if(this._type == -1)
         {
            this.obf_e_x_t_e_n_d_s_32(0);
         }
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
      
      public function getIconItemBags() : Array
      {
         return this._bags;
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

