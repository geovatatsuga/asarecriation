package obf_g_4695
{
   import obf_9_H_3298.PassTicketManager;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.task.TaskManager;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.PassTicketUIMC;
   
   public class PassTicketUI extends PassTicketUIMC implements IIconItemUI
   {
      
      public var cycleCode:String;
      
      public var leaveDay:int;
      
      public var level:int;
      
      public var exp:int;
      
      private var _bags:Array;
      
      public var isMiddBuy:Boolean;
      
      public var isHighBuy:Boolean;
      
      public var freeLv:int;
      
      public var freeBags:Array;
      
      public var middLv:int;
      
      public var obf_k_o_2512:Array;
      
      public var highLv:int;
      
      public var obf_0_9_6_134:Array;
      
      public var obf_p_2_2094:Array;
      
      public var awardPage:int = 1;
      
      public var awardAp:int;
      
      public var taskIds:Array;
      
      public var obf_0___w_495:int = 1;
      
      public var obf_2_Z_3676:int;
      
      private var showTaskIds:Array;
      
      public function PassTicketUI()
      {
         var _loc3_:int = 0;
         var _loc4_:IconItemBag = null;
         var _loc5_:IconItemBag = null;
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this._bags = new Array();
         this.freeBags = new Array();
         this.obf_k_o_2512 = new Array();
         this.obf_0_9_6_134 = new Array();
         this.obf_p_2_2094 = new Array();
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 3)
         {
            _loc3_ = 0;
            while(_loc3_ < 5)
            {
               _loc5_ = new IconItemBag(awardMc["icon" + _loc2_ + _loc3_],this,_loc1_);
               _loc5_.lockDrag = false;
               _loc5_.addValidType(GameItemType.ALL);
               this._bags.push(_loc5_);
               if(_loc2_ == 0)
               {
                  this.freeBags.push(_loc5_);
               }
               else if(_loc2_ == 1)
               {
                  this.obf_k_o_2512.push(_loc5_);
               }
               else if(_loc2_ == 2)
               {
                  this.obf_0_9_6_134.push(_loc5_);
               }
               _loc1_++;
               _loc3_++;
            }
            _loc4_ = new IconItemBag(awardMc["iconFinish" + _loc2_],this,_loc1_);
            _loc4_.lockDrag = false;
            _loc4_.addValidType(GameItemType.ALL);
            this._bags.push(_loc4_);
            this.obf_p_2_2094.push(_loc4_);
            _loc1_++;
            _loc2_++;
         }
         this.addListener();
         expBar.gotoAndStop(1);
         obf_0_8_q_572.visible = true;
         awardMc.visible = false;
         awardMc.middMc.gotoAndStop(1);
         awardMc.highMc.gotoAndStop(1);
         cmdShop.visible = false;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtTitle,"passTicketUI","txtTitle");
         txtInfo.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("passTicketUI","txtInfo") + "</a>";
         cmdUpLv.label = DiversityManager.getString("passTicketUI","cmdUpLv");
         cmdAward.label = DiversityManager.getString("passTicketUI","cmdAward");
         cmdTask.label = DiversityManager.getString("passTicketUI","cmdTask");
         cmdShop.label = DiversityManager.getString("passTicketUI","cmdShop");
         obf_0_8_q_572.cmdPrev.label = DiversityManager.getString("passTicketUI","cmdPrev");
         obf_0_8_q_572.cmdNext.label = DiversityManager.getString("passTicketUI","cmdNext");
         awardMc.cmdPrev.label = DiversityManager.getString("passTicketUI","cmdPrev");
         awardMc.cmdNext.label = DiversityManager.getString("passTicketUI","cmdNext");
         awardMc.cmdGetAward.label = DiversityManager.getString("passTicketUI","cmdGetAward");
      }
      
      public function addListener() : void
      {
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         obf_K_e_3075.addUIMouseToolTip(txtInfo,"txtPassTicketInfo");
         cmdUpLv.addEventListener(MouseEvent.CLICK,this.onCmdUpLv);
         cmdAward.addEventListener(MouseEvent.CLICK,this.obf_0_6_685);
         cmdTask.addEventListener(MouseEvent.CLICK,this.onCmdTask);
         cmdShop.addEventListener(MouseEvent.CLICK,this.obf_z_l_4610);
         obf_0_8_q_572.cmdPrev.addEventListener(MouseEvent.CLICK,this.obf_e_u_1798);
         obf_0_8_q_572.cmdNext.addEventListener(MouseEvent.CLICK,this.obf_0_7_j_264);
         var _loc1_:int = 0;
         while(_loc1_ < 9)
         {
            obf_0_8_q_572["box" + _loc1_].cmdFinish.addEventListener(MouseEvent.CLICK,this.onTaskFinish);
            _loc1_++;
         }
         awardMc.cmdPrev.addEventListener(MouseEvent.CLICK,this.obf_I_u_2493);
         awardMc.cmdNext.addEventListener(MouseEvent.CLICK,this.obf_C_3_2558);
         awardMc.cmdGetAward.addEventListener(MouseEvent.CLICK,this.obf_d_Z_2238);
      }
      
      public function removeListener() : void
      {
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         obf_K_e_3075.removeUIMouseToolTip(txtInfo);
         cmdUpLv.removeEventListener(MouseEvent.CLICK,this.onCmdUpLv);
         cmdAward.removeEventListener(MouseEvent.CLICK,this.obf_0_6_685);
         cmdTask.removeEventListener(MouseEvent.CLICK,this.onCmdTask);
         cmdShop.removeEventListener(MouseEvent.CLICK,this.obf_z_l_4610);
         obf_0_8_q_572.cmdPrev.removeEventListener(MouseEvent.CLICK,this.obf_e_u_1798);
         obf_0_8_q_572.cmdNext.removeEventListener(MouseEvent.CLICK,this.obf_0_7_j_264);
         var _loc1_:int = 0;
         while(_loc1_ < 9)
         {
            obf_0_8_q_572["box" + _loc1_].cmdFinish.removeEventListener(MouseEvent.CLICK,this.onTaskFinish);
            _loc1_++;
         }
         awardMc.cmdPrev.removeEventListener(MouseEvent.CLICK,this.obf_I_u_2493);
         awardMc.cmdNext.removeEventListener(MouseEvent.CLICK,this.obf_C_3_2558);
         awardMc.cmdGetAward.removeEventListener(MouseEvent.CLICK,this.obf_d_Z_2238);
      }
      
      public function obf_e_u_1798(param1:Event) : void
      {
         if(this.obf_0___w_495 == 1)
         {
            return;
         }
         this.refreshTaskUI(this.obf_0___w_495 - 1);
      }
      
      public function obf_0_7_j_264(param1:Event) : void
      {
         if(this.obf_0___w_495 == this.obf_2_Z_3676)
         {
            return;
         }
         this.refreshTaskUI(this.obf_0___w_495 + 1);
      }
      
      public function onTaskFinish(param1:Event) : void
      {
         var _loc2_:String = param1.currentTarget.parent.name;
         var _loc3_:int = parseInt(_loc2_.substr(3));
         var _loc4_:int = int(this.showTaskIds[_loc3_]);
         PassTicketManager.sendPassTicketFinishTaskRequest(_loc4_);
      }
      
      public function refreshTaskUI(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         this.clearTaskUI();
         if(!this.taskIds || this.taskIds.length == 0)
         {
            return;
         }
         var _loc2_:int = (param1 - 1) * 9;
         if(_loc2_ >= this.taskIds.length)
         {
            return;
         }
         this.showTaskIds = new Array();
         var _loc3_:int = _loc2_;
         while(_loc3_ < _loc2_ + 9)
         {
            if(_loc3_ >= this.taskIds.length)
            {
               break;
            }
            _loc4_ = int(this.taskIds[_loc3_]);
            _loc5_ = TaskManager.getTaskObjById(_loc4_);
            obf_0_8_q_572["box" + _loc3_].txtName.htmlText = _loc5_.name;
            _loc6_ = int(_loc5_.finishRule.onFinished.addPassTicketExp);
            obf_0_8_q_572["box" + _loc3_].txtExp.htmlText = "exp:" + _loc6_;
            if(TaskManager.doingTasks.indexOf(_loc4_) > -1)
            {
               obf_0_8_q_572["box" + _loc3_].cmdFinish.label = DiversityManager.getString("passTicketUI","cmdFinish0");
               obf_0_8_q_572["box" + _loc3_].cmdFinish.enabled = true;
            }
            else
            {
               obf_0_8_q_572["box" + _loc3_].cmdFinish.label = DiversityManager.getString("passTicketUI","cmdFinish1");
               obf_0_8_q_572["box" + _loc3_].cmdFinish.enabled = false;
            }
            this.showTaskIds.push(_loc4_);
            obf_0_8_q_572["box" + _loc3_].visible = true;
            _loc3_++;
         }
         this.obf_2_Z_3676 = (this.taskIds.length - 1) / 9 + 1;
         this.obf_0___w_495 = param1;
         obf_0_8_q_572.txtPage.htmlText = this.obf_0___w_495 + "/" + this.obf_2_Z_3676;
      }
      
      public function clearTaskUI() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 9)
         {
            obf_0_8_q_572["box" + _loc1_].visible = false;
            _loc1_++;
         }
         obf_0_8_q_572.txtPage.htmlText = "";
      }
      
      public function obf_I_u_2493(param1:Event) : void
      {
         if(this.awardPage == 1)
         {
            return;
         }
         this.obf_9_Q_961(this.awardPage - 1);
      }
      
      public function obf_C_3_2558(param1:Event) : void
      {
         if(this.awardPage == this.awardAp)
         {
            return;
         }
         this.obf_9_Q_961(this.awardPage + 1);
      }
      
      public function obf_d_Z_2238(param1:Event) : void
      {
         var _loc2_:Boolean = false;
         if(this.level != this.freeLv)
         {
            _loc2_ = true;
         }
         if(this.isMiddBuy && this.level != this.middLv)
         {
            _loc2_ = true;
         }
         if(this.isHighBuy && this.level != this.highLv)
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            PassTicketManager.sendPassTicketAwardRequest();
         }
      }
      
      public function getAwardPage() : int
      {
         var _loc1_:Object = PassTicketManager.getCycle(this.cycleCode);
         if(!_loc1_)
         {
            return 0;
         }
         var _loc2_:Array = JSONUtil.getValue(_loc1_,["passAwards"]) as Array;
         if(!_loc2_)
         {
            return 0;
         }
         this.awardAp = (_loc2_.length - 1) / 5 + 1;
         if(this.level >= _loc2_.length - 1)
         {
            return this.awardAp;
         }
         return int(this.level / 5 + 1);
      }
      
      public function obf_9_Q_961(param1:int) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Object = null;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         var _loc11_:IconItem = null;
         this.obf_m_4_3332();
         var _loc2_:Object = PassTicketManager.getCycle(this.cycleCode);
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:Array = JSONUtil.getValue(_loc2_,["passAwards"]) as Array;
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:int = (param1 - 1) * 5;
         if(_loc4_ >= _loc3_.length)
         {
            return;
         }
         var _loc5_:int = 0;
         _loc6_ = _loc4_;
         while(_loc6_ < _loc4_ + 5)
         {
            if(_loc6_ >= _loc3_.length)
            {
               break;
            }
            _loc7_ = _loc6_ + 1;
            awardMc["txtLv" + _loc5_].htmlText = "lv." + _loc7_;
            _loc8_ = _loc3_[_loc6_];
            if(_loc8_.freeItems)
            {
               for(_loc9_ in _loc8_.freeItems)
               {
                  _loc10_ = int(_loc8_.freeItems[_loc9_]);
                  _loc11_ = IconItemManager.getIconItemByCode(_loc9_,"");
                  _loc11_.itemCount = _loc10_;
                  this.freeBags[_loc5_].pushIconItem(_loc11_);
                  this.freeBags[_loc5_].visible = true;
               }
               if(this.freeLv >= _loc7_)
               {
                  awardMc["gg0" + _loc5_].visible = true;
               }
            }
            if(_loc8_.middItems)
            {
               for(_loc9_ in _loc8_.middItems)
               {
                  _loc10_ = int(_loc8_.middItems[_loc9_]);
                  _loc11_ = IconItemManager.getIconItemByCode(_loc9_,"");
                  _loc11_.itemCount = _loc10_;
                  this.obf_k_o_2512[_loc5_].pushIconItem(_loc11_);
                  this.obf_k_o_2512[_loc5_].visible = true;
               }
               if(this.middLv >= _loc7_)
               {
                  awardMc["gg1" + _loc5_].visible = true;
               }
            }
            if(_loc8_.highItems)
            {
               for(_loc9_ in _loc8_.highItems)
               {
                  _loc10_ = int(_loc8_.highItems[_loc9_]);
                  _loc11_ = IconItemManager.getIconItemByCode(_loc9_,"");
                  _loc11_.itemCount = _loc10_;
                  this.obf_0_9_6_134[_loc5_].pushIconItem(_loc11_);
                  this.obf_0_9_6_134[_loc5_].visible = true;
               }
               if(this.highLv >= _loc7_)
               {
                  awardMc["gg2" + _loc5_].visible = true;
               }
            }
            _loc5_++;
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < 3)
         {
            if(_loc6_ == 0)
            {
               for(_loc9_ in _loc2_.freeFinal)
               {
                  _loc10_ = int(_loc2_.freeFinal[_loc9_]);
                  _loc11_ = IconItemManager.getIconItemByCode(_loc9_,"");
                  _loc11_.itemCount = _loc10_;
                  this.obf_p_2_2094[_loc6_].pushIconItem(_loc11_);
               }
            }
            else if(_loc6_ == 1)
            {
               for(_loc9_ in _loc2_.middFinal)
               {
                  _loc10_ = int(_loc2_.middFinal[_loc9_]);
                  _loc11_ = IconItemManager.getIconItemByCode(_loc9_,"");
                  _loc11_.itemCount = _loc10_;
                  this.obf_p_2_2094[_loc6_].pushIconItem(_loc11_);
               }
            }
            else if(_loc6_ == 2)
            {
               for(_loc9_ in _loc2_.highFinal)
               {
                  _loc10_ = int(_loc2_.highFinal[_loc9_]);
                  _loc11_ = IconItemManager.getIconItemByCode(_loc9_,"");
                  _loc11_.itemCount = _loc10_;
                  this.obf_p_2_2094[_loc6_].pushIconItem(_loc11_);
               }
            }
            this.obf_p_2_2094[_loc6_].visible = true;
            _loc6_++;
         }
         this.awardAp = (_loc3_.length - 1) / 5 + 1;
         this.awardPage = param1;
         awardMc.txtPage.htmlText = this.awardPage + "/" + this.awardAp;
         if(this.isMiddBuy)
         {
            awardMc.middMc.gotoAndStop(2);
         }
         if(this.isHighBuy)
         {
            awardMc.highMc.gotoAndStop(2);
         }
      }
      
      public function obf_m_4_3332() : void
      {
         var _loc2_:IconItemBag = null;
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            awardMc["txtLv" + _loc1_].htmlText = "";
            awardMc["gg0" + _loc1_].visible = false;
            awardMc["gg1" + _loc1_].visible = false;
            awardMc["gg2" + _loc1_].visible = false;
            _loc1_++;
         }
         for each(_loc2_ in this._bags)
         {
            if(_loc2_.haveIconItem)
            {
               _loc2_.dropIconItem();
               _loc2_.visible = false;
            }
         }
         awardMc.txtPage.htmlText = "";
         awardMc.middMc.gotoAndStop(1);
         awardMc.highMc.gotoAndStop(1);
      }
      
      public function onCmdUpLv(param1:Event) : void
      {
         if(obf_K_e_3075.passTicketBuyUI.visible)
         {
            return;
         }
         var _loc2_:Object = PassTicketManager.getCycle(this.cycleCode);
         if(!_loc2_)
         {
            return;
         }
         param1.stopPropagation();
         obf_K_e_3075.passTicketBuyUI.middMoney = _loc2_.middMoney;
         obf_K_e_3075.passTicketBuyUI.highMoney = _loc2_.highMoney;
         obf_K_e_3075.passTicketBuyUI.middConfig = _loc2_.middItem;
         obf_K_e_3075.passTicketBuyUI.highConfig = _loc2_.highItem;
         obf_K_e_3075.passTicketBuyUI.isMiddBuy = this.isMiddBuy;
         obf_K_e_3075.passTicketBuyUI.isHighBuy = this.isHighBuy;
         obf_K_e_3075.passTicketBuyUI.refresh();
         obf_K_e_3075.showUI(obf_K_e_3075.passTicketBuyUI);
      }
      
      public function obf_0_6_685(param1:Event) : void
      {
         if(awardMc.visible)
         {
            return;
         }
         obf_0_8_q_572.visible = false;
         awardMc.visible = true;
      }
      
      public function onCmdTask(param1:Event) : void
      {
         if(obf_0_8_q_572.visible)
         {
            return;
         }
         awardMc.visible = false;
         obf_0_8_q_572.visible = true;
      }
      
      public function obf_z_l_4610(param1:Event) : void
      {
         if(obf_K_e_3075.varShopBoxUI.visible)
         {
            obf_K_e_3075.varShopBoxUI.init(PassTicketManager.varShopId);
         }
         else
         {
            obf_K_e_3075.varShopBoxUI.init(PassTicketManager.varShopId);
            obf_K_e_3075.showUI(obf_K_e_3075.varShopBoxUI);
         }
      }
      
      public function updateLvExp() : void
      {
         var _loc2_:int = 0;
         txtLevel.htmlText = DiversityManager.getString("passTicketUI","txtLevel",[this.level]);
         var _loc1_:int = PassTicketManager.getExpByLv(this.level);
         if(_loc1_ == 0)
         {
            txtExp.htmlText = "";
            expBar.gotoAndStop(100);
         }
         else
         {
            _loc2_ = Math.round(this.exp * 100 / _loc1_);
            if(_loc2_ <= 0)
            {
               _loc2_ = 1;
            }
            if(_loc2_ > 100)
            {
               _loc2_ = 100;
            }
            expBar.gotoAndStop(_loc2_);
            txtExp.htmlText = this.exp + "/" + _loc1_;
         }
      }
      
      public function updateDay() : void
      {
         var _loc1_:int = this.getAwardPage();
         if(_loc1_ <= 0)
         {
            txtDay.htmlText = DiversityManager.getString("passTicketUI","noStart");
         }
         else
         {
            txtDay.htmlText = DiversityManager.getString("passTicketUI","txtDay",[this.leaveDay]);
         }
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return bg.getBounds(bg).contains(bg.mouseX,bg.mouseY);
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
   }
}

