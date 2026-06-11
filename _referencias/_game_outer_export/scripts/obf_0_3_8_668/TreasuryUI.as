package obf_0_3_8_668
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.rpg.treasury.TreasuryDepotInfo;
   import com.sunweb.game.rpg.treasury.obf_M_a_3122;
   import com.sunweb.game.rpg.treasury.obf_Z_g_3185;
   import com.sunweb.game.rpg.treasury.obf_t_8_2995;
   import com.sunweb.game.ui.HeadIconCode;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.TreasuryUIMC;
   
   public class TreasuryUI extends TreasuryUIMC implements IPlayerUI, IIconItemUI
   {
      
      private var _bags:Array;
      
      private var obf_j_G_2734:IconItemBag;
      
      private var boxBag:Object;
      
      public var type:int = 0;
      
      private var obf_1_V_1550:obf_t_8_2995;
      
      private var awardList:Array;
      
      private var attrObject:Object;
      
      private var levelObject:Object;
      
      private var expObject:Object;
      
      private var indexObject:Object;
      
      private const RIGHT:Array;
      
      private const DOWN:Array;
      
      private const LEFT:Array;
      
      private const UP:Array;
      
      private var moves:int = 0;
      
      private var tempIndex:int;
      
      private var dif:int = 0;
      
      private const obf_0___0_427:int = 2;
      
      private const speed:int = 10;
      
      public function TreasuryUI()
      {
         var _loc2_:IconItemBag = null;
         this._bags = new Array();
         this.boxBag = new Object();
         this.RIGHT = [0,1,2,3];
         this.DOWN = [4,5,6,7,8,9];
         this.LEFT = [10,11,12,13];
         this.UP = [14,15,16,17,18,19];
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         titleBox.mouseEnabled = false;
         this.obf_j_G_2734 = new IconItemBag(needItem,this,0);
         this.obf_j_G_2734.addValidType(GameItemType.ALL);
         this.obf_j_G_2734.isLocked = false;
         this._bags.push(this.obf_j_G_2734);
         var _loc1_:int = 0;
         while(_loc1_ < 20)
         {
            this["box" + _loc1_].gotoAndStop(1);
            _loc2_ = new IconItemBag(this["bag" + _loc1_],this,0);
            _loc2_.addValidType(GameItemType.ALL);
            _loc2_.isLocked = false;
            this._bags.push(_loc2_);
            this.boxBag[_loc1_] = _loc2_;
            _loc1_++;
         }
         expBar.gotoAndStop(1);
         dice1.gotoAndStop(65);
         dice2.gotoAndStop(1);
         dice2.visible = false;
         dice3.gotoAndStop(1);
         dice3.visible = false;
         dice4.gotoAndStop(1);
         dice4.visible = false;
         dice5.gotoAndStop(1);
         dice5.visible = false;
         dice6.gotoAndStop(1);
         dice6.visible = false;
         this.addListener();
      }
      
      public function initDiversity() : void
      {
         txtInfo.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("TreasuryUI","txtInfo") + "</a>";
         DiversityManager.setTextField(txtTitleAttr,"TreasuryUI","txtTitleAttr");
         DiversityManager.setTextField(txtLvTitle,"TreasuryUI","txtLvTitle");
         DiversityManager.setTextField(txtExpTitle,"TreasuryUI","txtExpTitle");
         cmdUseItem.label = DiversityManager.getString("TreasuryUI","cmdUseItem");
      }
      
      private function addListener() : void
      {
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdUseItem.addEventListener(MouseEvent.CLICK,this.onUseItem);
         cmdGoto.addEventListener(MouseEvent.CLICK,this.obf_h_z_4608);
         obf_K_e_3075.addUIMouseToolTip(txtInfo,"treasuryInfo");
      }
      
      private function removeListener() : void
      {
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdUseItem.removeEventListener(MouseEvent.CLICK,this.onUseItem);
         cmdGoto.removeEventListener(MouseEvent.CLICK,this.obf_h_z_4608);
         obf_K_e_3075.removeUIMouseToolTip(txtInfo);
      }
      
      private function onUseItem(param1:Event) : void
      {
         var _loc2_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter("$treasuryDepot" + this.type);
         var _loc3_:int = JSONUtil.getInt(_loc2_,["numOfDay"]);
         var _loc4_:int = this.obf_1_V_1550.freeNum - _loc3_;
         if(_loc4_ > 0)
         {
            if(--_loc4_ <= 0)
            {
               txtFree.visible = false;
            }
            else
            {
               txtFree.text = DiversityManager.getString("TreasuryUI","txtFree",[_loc4_ + ""]);
            }
         }
         else if(obf_K_e_3075.playerBagUI.getItemCount(this.obf_1_V_1550.itemCode) < 1)
         {
            WindowManager.showMessageBox(DiversityManager.getString("TreasuryUI","noItem"));
            return;
         }
         obf_M_a_3122.sendTreasuryUseItemRequest(this.type);
         cmdUseItem.enabled = false;
      }
      
      private function obf_h_z_4608(param1:Event) : void
      {
         if(this.moves > 0)
         {
            return;
         }
         if(this.type == 1)
         {
            this.obf_0_4_8_274(2);
         }
         else if(this.type == 2)
         {
            this.obf_0_4_8_274(1);
         }
      }
      
      public function setInfo(param1:TreasuryDepotInfo) : void
      {
         if(!param1)
         {
            return;
         }
         if(!this.attrObject)
         {
            this.attrObject = new Object();
         }
         this.attrObject[param1.type] = param1.attrMap;
         if(!this.levelObject)
         {
            this.levelObject = new Object();
         }
         this.levelObject[param1.type] = param1.level;
         if(!this.expObject)
         {
            this.expObject = new Object();
         }
         this.expObject[param1.type] = param1.exp;
         if(!this.indexObject)
         {
            this.indexObject = new Object();
         }
         this.indexObject[param1.type] = param1.index;
      }
      
      public function obf_0_4_8_274(param1:int) : void
      {
         var _loc10_:int = 0;
         var _loc11_:obf_Z_g_3185 = null;
         var _loc12_:String = null;
         var _loc13_:IconItem = null;
         var _loc14_:String = null;
         var _loc15_:int = 0;
         if(this.type == param1)
         {
            return;
         }
         this.type = param1;
         if(this.type == 1)
         {
            this.obf_1_V_1550 = new obf_t_8_2995(obf_M_a_3122.depot1);
            txtGoto.text = obf_M_a_3122.depot2.name;
            cmdGoto.gotoAndStop(2);
         }
         else if(this.type == 2)
         {
            this.obf_1_V_1550 = new obf_t_8_2995(obf_M_a_3122.depot2);
            txtGoto.text = obf_M_a_3122.depot1.name;
            cmdGoto.gotoAndStop(1);
         }
         this.awardList = this.obf_1_V_1550.awards;
         this.obf_j_G_2734.dropIconItem();
         var _loc2_:IconItem = IconItemManager.getIconItemByCode(this.obf_1_V_1550.itemCode,null);
         this.obf_j_G_2734.pushIconItem(_loc2_);
         txtTitle.text = this.obf_1_V_1550.name;
         showTitle.gotoAndStop(this.type);
         var _loc3_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter("$treasuryDepot" + this.type);
         var _loc4_:int = JSONUtil.getInt(_loc3_,["numOfDay"]);
         if(_loc4_ >= this.obf_1_V_1550.freeNum)
         {
            txtFree.visible = false;
         }
         else
         {
            _loc10_ = this.obf_1_V_1550.freeNum - _loc4_;
            txtFree.visible = true;
            txtFree.text = DiversityManager.getString("TreasuryUI","txtFree",[_loc10_ + ""]);
         }
         var _loc5_:int = 0;
         while(_loc5_ < 20)
         {
            _loc11_ = this.awardList[_loc5_];
            if(_loc11_)
            {
               this.boxBag[_loc5_].dropIconItem();
               this["bag" + _loc5_].visible = false;
               this["attr" + _loc5_].text = "";
               this["box" + _loc5_].gotoAndStop(_loc11_.type);
               if(_loc11_.type == 2)
               {
                  this["bag" + _loc5_].visible = true;
                  for(_loc12_ in _loc11_.items)
                  {
                     _loc13_ = IconItemManager.getIconItemByCode(_loc12_,null);
                     _loc13_.itemCount = _loc11_.items[_loc12_];
                     this.boxBag[_loc5_].pushIconItem(_loc13_);
                  }
               }
               else if(_loc11_.type == 3)
               {
                  for(_loc14_ in _loc11_.attr)
                  {
                     _loc15_ = int(_loc11_.attr[_loc14_]);
                     this["attr" + _loc5_].text = RoleAttributesModifierEnum.getAttributesName(int(_loc14_)) + "+" + _loc15_;
                  }
               }
            }
            _loc5_++;
         }
         var _loc6_:Object = null;
         if(Boolean(this.attrObject) && Boolean(this.attrObject[this.type]))
         {
            _loc6_ = this.attrObject[this.type];
         }
         this.obf_x_j_3753(_loc6_,this.type);
         var _loc7_:int = 0;
         if(Boolean(this.levelObject) && Boolean(this.levelObject[this.type]))
         {
            _loc7_ = int(this.levelObject[this.type]);
         }
         this.obf_Z_5_3720(_loc7_,this.type);
         var _loc8_:int = 0;
         if(Boolean(this.expObject) && Boolean(this.expObject[this.type]))
         {
            _loc8_ = int(this.expObject[this.type]);
         }
         this.obf_X_X_1656(_loc8_,this.type);
         var _loc9_:int = 0;
         if(Boolean(this.indexObject) && Boolean(this.indexObject[this.type]))
         {
            _loc9_ = int(this.indexObject[this.type]);
         }
         this.refreshPlayerIndex(_loc9_,this.type);
      }
      
      public function obf_x_j_3753(param1:Object, param2:int) : void
      {
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(!param1)
         {
            return;
         }
         if(!this.attrObject)
         {
            this.attrObject = new Object();
         }
         this.attrObject[param2] = param1;
         if(this.type != param2)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < 4)
         {
            this["txtAttr" + _loc3_].text = "";
            this["txtAttrValue" + _loc3_].text = "";
            _loc3_++;
         }
         var _loc4_:Array = new Array();
         for(_loc5_ in param1)
         {
            _loc4_.push(_loc5_);
         }
         _loc4_.sort();
         _loc6_ = 0;
         while(_loc6_ < 4)
         {
            _loc7_ = _loc4_[_loc6_];
            if(_loc7_)
            {
               _loc8_ = int(param1[_loc7_]);
               this["txtAttr" + _loc6_].text = RoleAttributesModifierEnum.getAttributesName(int(_loc7_));
               if(this.obf_1_V_1550.maxAttr)
               {
                  _loc9_ = int(this.obf_1_V_1550.maxAttr[_loc7_]);
                  if(_loc9_)
                  {
                     this["txtAttrValue" + _loc6_].text = _loc8_ + "/" + _loc9_;
                  }
                  else
                  {
                     this["txtAttrValue" + _loc6_].text = _loc8_ + "";
                  }
               }
               else
               {
                  this["txtAttrValue" + _loc6_].text = _loc8_ + "";
               }
            }
            _loc6_++;
         }
      }
      
      public function obf_Z_5_3720(param1:int, param2:int) : void
      {
         var _loc5_:String = null;
         if(this.type == 0 || !this.obf_1_V_1550)
         {
            return;
         }
         if(!this.levelObject)
         {
            this.levelObject = new Object();
         }
         var _loc3_:int = int(this.levelObject[param2]);
         if(!_loc3_ || _loc3_ != param1)
         {
            this.levelObject[param2] = param1;
         }
         if(this.type != param2)
         {
            return;
         }
         txtLvValue.text = param1 + "";
         var _loc4_:int = 0;
         while(_loc4_ < 9)
         {
            _loc5_ = this.obf_1_V_1550.levelAttr[_loc4_].txt;
            if(param1 >= _loc4_ + 1)
            {
               _loc5_ = "<font color=\'#ff0000\'>" + _loc5_ + "</font>";
            }
            else
            {
               _loc5_ = "<font color=\'#999999\'>" + _loc5_ + "</font>";
            }
            this["txtLv" + _loc4_].htmlText = _loc5_;
            _loc4_++;
         }
      }
      
      public function obf_X_X_1656(param1:int, param2:int) : void
      {
         var _loc6_:int = 0;
         if(this.type == 0 || !this.obf_1_V_1550)
         {
            return;
         }
         if(!this.levelObject)
         {
            this.levelObject = new Object();
         }
         var _loc3_:int = int(this.levelObject[param2]);
         if(!_loc3_)
         {
            _loc3_ = 0;
         }
         if(!this.expObject)
         {
            this.expObject = new Object();
         }
         var _loc4_:int = int(this.expObject[param2]);
         if(!_loc4_ || _loc4_ != param1)
         {
            this.expObject[param2] = param1;
         }
         if(this.type != param2)
         {
            return;
         }
         var _loc5_:int = int(this.obf_1_V_1550.levelExp[_loc3_]);
         if(_loc5_)
         {
            txtExp.text = param1 + "/" + _loc5_;
            _loc6_ = int(param1 / _loc5_ * 100);
            expBar.gotoAndStop(_loc6_);
         }
         else
         {
            txtExp.text = "";
            expBar.gotoAndStop(100);
         }
      }
      
      public function refreshPlayerIndex(param1:int, param2:int) : void
      {
         var _loc4_:DisplayObject = null;
         if(param1 < 0 || param1 > 19)
         {
            return;
         }
         if(player.numChildren <= 0)
         {
            _loc4_ = HeadIconCode.getHeadIconByInt(GameContext.localPlayer.fullInfo.headIconIndex);
            _loc4_.scaleX = 0.6;
            _loc4_.scaleY = 0.6;
            _loc4_.x = -20;
            _loc4_.y = -20;
            player.addChild(_loc4_);
         }
         if(!this.indexObject)
         {
            this.indexObject = new Object();
         }
         var _loc3_:int = int(this.indexObject[param2]);
         if(!_loc3_ || _loc3_ != param1)
         {
            this.indexObject[param2] = param1;
         }
         if(this.type != param2)
         {
            return;
         }
         player.x = this["point" + param1].x;
         player.y = this["point" + param1].y;
         this.setChildIndex(player,this.numChildren - 1);
      }
      
      public function showDice(param1:int, param2:int) : void
      {
         if(param1 < 1 || param1 > 6)
         {
            return;
         }
         this.tempIndex = param2;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 1;
         while(_loc4_ <= 6)
         {
            if(_loc4_ == param1)
            {
               this["dice" + _loc4_].visible = true;
               _loc3_ = this["dice" + _loc4_];
            }
            else
            {
               this["dice" + _loc4_].visible = false;
            }
            _loc4_++;
         }
         _loc3_.gotoAndStop(1);
         _loc3_.addEventListener(Event.ENTER_FRAME,this.obf_K_J_2866);
         _loc3_.play();
      }
      
      private function obf_K_J_2866(param1:Event) : void
      {
         if(param1.target.currentFrame == param1.target.totalFrames)
         {
            param1.target.removeEventListener(Event.ENTER_FRAME,this.obf_K_J_2866);
            this.movePlayer(this.tempIndex);
         }
      }
      
      public function movePlayer(param1:int) : void
      {
         if(!this.indexObject)
         {
            return;
         }
         var _loc2_:int = int(this.indexObject[this.type]);
         if(_loc2_ == param1)
         {
            return;
         }
         if(param1 == 0)
         {
            this.moves = 20 - _loc2_;
         }
         else
         {
            this.moves = param1 - _loc2_;
         }
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.dif > 0)
         {
            --this.dif;
            return;
         }
         if(this.moves <= 0)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            this.windowMsg(this.indexObject[this.type]);
            cmdUseItem.enabled = true;
            return;
         }
         var _loc2_:int = int(this.indexObject[this.type]);
         var _loc3_:int = _loc2_ + 1;
         if(_loc3_ > 19)
         {
            _loc3_ = 0;
         }
         var _loc4_:Number = Number(this["point" + _loc3_].x);
         var _loc5_:Number = Number(this["point" + _loc3_].y);
         if(this.RIGHT.indexOf(_loc2_) > -1)
         {
            if(player.x >= _loc4_)
            {
               this.dif = this.obf_0___0_427;
               this.indexObject[this.type] = _loc3_;
               --this.moves;
               return;
            }
            player.x += this.speed;
         }
         else if(this.DOWN.indexOf(_loc2_) > -1)
         {
            if(player.y >= _loc5_)
            {
               this.dif = this.obf_0___0_427;
               this.indexObject[this.type] = _loc3_;
               --this.moves;
               return;
            }
            player.y += this.speed;
         }
         else if(this.LEFT.indexOf(_loc2_) > -1)
         {
            if(player.x <= _loc4_)
            {
               this.dif = this.obf_0___0_427;
               this.indexObject[this.type] = _loc3_;
               --this.moves;
               return;
            }
            player.x -= this.speed;
         }
         else if(this.UP.indexOf(_loc2_) > -1)
         {
            if(player.y <= _loc5_)
            {
               this.dif = this.obf_0___0_427;
               this.indexObject[this.type] = _loc3_;
               --this.moves;
               return;
            }
            player.y -= this.speed;
         }
      }
      
      private function windowMsg(param1:int) : void
      {
         var _loc2_:obf_Z_g_3185 = _loc2_ = this.awardList[param1];
         if(_loc2_.type == 1)
         {
            obf_K_e_3075.obf_n_q_2526.setShowContent(_loc2_.items,_loc2_.attr);
            obf_K_e_3075.showUI(obf_K_e_3075.obf_n_q_2526);
         }
         else if(_loc2_.type == 6)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.obf_t_h_r_o_w_539);
         }
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
         this.visible = true;
         if(this.type == 0)
         {
            this.obf_0_4_8_274(1);
         }
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         var _loc1_:IconItemBag = null;
         for each(_loc1_ in this._bags)
         {
            _loc1_.destroy();
         }
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

