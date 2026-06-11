package com.sunweb.game.rpg.playerUI.extractant
{
   import com.sunweb.game.res.obf_0_P_4381;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.extractant.obf_t_f_2299;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemSubtype;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.rpg.worldZone.command.extractant.playerExtractantAnswer;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_l_y_733;
   import fl.data.DataProvider;
   import fl.events.ScrollEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import playerUI.ExtractantUIMC;
   import playerUI.IconBarMC;
   
   public class obf_S_1_1969 extends ExtractantUIMC implements IPlayerUI, IIconItemUI
   {
      
      private var allBags:Array;
      
      private var bags:Array;
      
      private var extIconBag:IconItemBag;
      
      private var extTimeLimit:TimeLimiter;
      
      private var obf_0_7_6_257:Array;
      
      private var obf_0_X_4397:int;
      
      private var obf_5_K_3274:int;
      
      private var obf_a_g_3306:String;
      
      private var obf_t_7_3409:int;
      
      private var obf_7_B_794:int;
      
      private var isOver:Boolean = true;
      
      private var obf_7_O_836:TimeLimiter = new TimeLimiter(200);
      
      private var obf_2_3_3245:int = 0;
      
      private var obf_w_x_3672:int;
      
      public function obf_S_1_1969()
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         txtTime.mouseEnabled = false;
         txtTitle.mouseEnabled = false;
         txtNum.mouseEnabled = false;
         txtConsume.mouseEnabled = false;
         txtAbility.mouseEnabled = false;
         txtRemark.mouseEnabled = false;
         this.allBags = new Array();
         var _loc1_:Array = [{
            "label":DiversityManager.getString("extractantUI","rank_Lv1"),
            "data":GameItemRank.MAGIC
         },{
            "label":DiversityManager.getString("extractantUI","rank_Lv2"),
            "data":GameItemRank.FANTASY
         },{
            "label":DiversityManager.getString("extractantUI","rank_Lv3"),
            "data":GameItemRank.LEGEND
         },{
            "label":DiversityManager.getString("extractantUI","rank_Lv4"),
            "data":GameItemRank.EPIC
         },{
            "label":DiversityManager.getString("extractantUI","rank_Lv5"),
            "data":GameItemRank.obf_f_l_943
         }];
         selectRank.dataProvider = new DataProvider(_loc1_);
         selectRank.selectedIndex = 0;
         this.extIconBag = new IconItemBag(extIcon,this,0);
         this.extIconBag.lockDrag = true;
         this.extIconBag.addValidType(GameItemType.EQUIPMENT);
         this.allBags.push(this.extIconBag);
         this.obf_0_7_6_257 = [this.cmdType1,this.cmdType2,this.cmdType3];
         this.addListener();
      }
      
      private function addListener() : void
      {
         var _loc1_:* = undefined;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdUpLv.addEventListener(MouseEvent.CLICK,this.onUpLv);
         for each(_loc1_ in this.obf_0_7_6_257)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.obf_y_j_1540);
         }
         selectRank.addEventListener(Event.CHANGE,this.obf_2_s_2286);
         obf_H_w_3575.addEventListener(ScrollEvent.SCROLL,this.onScrollList);
      }
      
      private function removeListener() : void
      {
         var _loc1_:* = undefined;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdUpLv.removeEventListener(MouseEvent.CLICK,this.onUpLv);
         for each(_loc1_ in this.obf_0_7_6_257)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.obf_y_j_1540);
         }
         selectRank.removeEventListener(Event.CHANGE,this.obf_2_s_2286);
         obf_H_w_3575.removeEventListener(ScrollEvent.SCROLL,this.onScrollList);
      }
      
      private function onStartDrag(param1:MouseEvent) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      private function onClose(param1:MouseEvent) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function obf_2_s_2286(param1:Event) : void
      {
         this.showItem1(selectRank.selectedItem.data,null);
      }
      
      private function onScrollList(param1:Event) : void
      {
         itemPoint.scrollRect = new Rectangle(0,obf_H_w_3575.scrollPosition,obf_H_w_3575.x - itemPoint.x,itemPoint.height);
      }
      
      private function obf_y_j_1540(param1:MouseEvent) : void
      {
         this.setPattern(this.obf_0_7_6_257.indexOf(param1.currentTarget));
      }
      
      private function setPattern(param1:int) : void
      {
         var _loc2_:* = undefined;
         this.obf_0_X_4397 = param1;
         for each(_loc2_ in this.obf_0_7_6_257)
         {
            _loc2_.enabled = true;
         }
         this.obf_0_7_6_257[param1].enabled = false;
         this.obf_t_7_3409 = JSONUtil.getInt(obf_t_f_2299.getPatternTypeConfig(this.obf_0_X_4397),["gold"]);
         this.obf_7_B_794 = JSONUtil.getInt(obf_t_f_2299.getPatternTypeConfig(this.obf_0_X_4397),["money"]);
         if(this.obf_t_7_3409)
         {
            txtConsume.text = DiversityManager.getString("extractantUI","txtConsume",[this.obf_t_7_3409]);
         }
         else if(this.obf_7_B_794)
         {
            txtConsume.text = DiversityManager.getString("extractantUI","txtConsume2",[this.obf_7_B_794]);
         }
         else
         {
            txtConsume.text = "";
         }
         this.obf_m_D_1819();
      }
      
      private function onUpLv(param1:MouseEvent) : void
      {
         obf_K_e_3075.showUI(obf_K_e_3075.extractantUpUI);
         param1.stopPropagation();
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(this.obf_7_O_836.checkTimeout())
         {
            if(this.obf_2_3_3245 > 0)
            {
               _loc2_ = this.getDurationTimeInMS(this.obf_2_3_3245,this.obf_w_x_3672);
               if(_loc2_ <= 0)
               {
                  _loc2_ = 0;
                  this.obf_2_3_3245 = 0;
                  txtTime.text = "";
               }
               else
               {
                  txtTime.text = DiversityManager.getString("extractantUI","txtTime2",[obf_l_y_733.getTimeStringHHMMSS(_loc2_)]);
               }
            }
         }
      }
      
      public function getDurationTimeInMS(param1:int, param2:int) : Number
      {
         return param1 - (getTimer() - param2);
      }
      
      public function showEffect() : void
      {
         this.isOver = false;
         obf_0_P_4381.obf_q_h_1296("fire@fireEffect",effectPoint,null,true,0,0,this.fun);
      }
      
      private function fun() : void
      {
         this.isOver = true;
         this.extIconBag.dropIconItem();
      }
      
      private function showItem1(param1:int, param2:Array) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Object = null;
         var _loc10_:IconBarMC = null;
         var _loc11_:IconItemBag = null;
         var _loc12_:IconItem = null;
         this.clear();
         if(!param2)
         {
            param2 = obf_K_e_3075.playerBagUI.equipBags;
         }
         var _loc3_:Array = new Array();
         for each(_loc4_ in param2)
         {
            if(_loc4_)
            {
               if(_loc4_.haveIconItem)
               {
                  _loc9_ = GameItemManager.getItemConfig(_loc4_.haveIconItem.itemCode);
                  if(_loc9_)
                  {
                     if(!(_loc9_.rank == GameItemRank.NOMAL || _loc9_.rank == GameItemRank.obf_C_G_3598 || _loc9_.subtype == GameItemSubtype.EQUIPMENT_FASHION_CLOTHES || _loc9_.subtype == GameItemSubtype.EQUIPMENT_FASHION_HAT || _loc9_.subtype == GameItemSubtype.obf_e_i_1884 || _loc9_.subtype == GameItemSubtype.obf_s_2_3291 || _loc9_.subtype == GameItemSubtype.EQUIPMENT_WING || _loc9_.subtype == GameItemSubtype.obf_H_m_3421))
                     {
                        if(_loc9_.rank == param1)
                        {
                           _loc3_.push({
                              "code":_loc9_.code,
                              "id":(_loc4_ as IconItemBag).haveIconItem.itemId
                           });
                        }
                     }
                  }
               }
            }
         }
         this.bags = new Array();
         _loc5_ = -1;
         _loc6_ = 2;
         _loc7_ = 0;
         itemPoint.scrollRect = new Rectangle(0,0,obf_H_w_3575.x - itemPoint.x,obf_H_w_3575.height);
         _loc8_ = 0;
         while(_loc8_ < _loc3_.length)
         {
            _loc10_ = new IconBarMC();
            _loc11_ = new IconItemBag(_loc10_,this,_loc8_);
            _loc11_.addValidType(GameItemType.EQUIPMENT);
            _loc12_ = IconItemManager.getIconItemByCode(_loc3_[_loc8_].code,_loc3_[_loc8_].id);
            if(_loc12_)
            {
               _loc11_.pushIconItem(_loc12_);
            }
            this.bags.push(_loc11_);
            this.allBags.push(_loc11_);
            if(++_loc5_ > 3)
            {
               _loc5_ = 0;
               _loc6_ += _loc11_.height;
            }
            _loc11_.x = 40 * _loc5_;
            _loc11_.y = _loc6_;
            _loc7_ = _loc11_.y + _loc11_.height;
            itemPoint.addChild(_loc11_);
            _loc8_++;
         }
         if(_loc7_ > obf_H_w_3575.height)
         {
            obf_H_w_3575.maxScrollPosition = _loc7_ - obf_H_w_3575.height;
            obf_H_w_3575.visible = true;
         }
         else
         {
            obf_H_w_3575.visible = false;
         }
      }
      
      private function clear() : void
      {
         while(itemPoint.numChildren > 0)
         {
            itemPoint.removeChildAt(0);
         }
      }
      
      public function setCoolTime(param1:int) : void
      {
         this.obf_2_3_3245 = param1 * 1000;
         this.obf_w_x_3672 = getTimer();
      }
      
      private function obf_m_D_1819() : void
      {
         var _loc1_:PeriodCounterItemInfo = null;
         if(obf_t_f_2299.isNum(this.obf_0_X_4397) == true)
         {
            _loc1_ = obf_Y_F_1424.getCounter("$remark_" + this.obf_0_X_4397);
            this.obf_5_K_3274 = obf_t_f_2299.getPatternTypeConfig(this.obf_0_X_4397).number - JSONUtil.getInt(_loc1_,["numOfDay"]);
            txtNum.text = DiversityManager.getString("extractantUI","txtNum",[this.obf_5_K_3274]);
         }
         else
         {
            txtNum.text = "";
         }
      }
      
      private function showRemark() : void
      {
         txtRemark.htmlText = obf_t_f_2299.config.remark;
      }
      
      public function getValue(param1:playerExtractantAnswer) : void
      {
         this.setCoolTime(param1.surplusTime);
         txtAbility.text = "";
         txtAbility.text = DiversityManager.getString("extractantUI","txtAbility",[param1.ability]);
         this.obf_m_D_1819();
         this.showItem1(selectRank.selectedItem.data,null);
      }
      
      public function obf_1_a_2907(param1:int) : void
      {
         txtAbility.text = "";
         txtAbility.text = DiversityManager.getString("extractantUI","txtAbility",[param1]);
      }
      
      private function doSend(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_t_f_2299.sendExtractantRequest(this.obf_a_g_3306,this.obf_0_X_4397);
            this.showEffect();
         }
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
         DiversityManager.setTextField(txtTitle,"extractantUI","txtTitle");
         DiversityManager.setTextField(txtRemark,"extractantUI","txtRemark");
         DiversityManager.setTextField(txtRemark2,"extractantUI","txtRemark2");
         DiversityManager.setTextField(txtSelect,"extractantUI","txtSelect");
         cmdUpLv.label = DiversityManager.getString("extractantUI","cmdUpLv");
         cmdType1.label = DiversityManager.getString("extractantUI","cmdType1");
         cmdType2.label = DiversityManager.getString("extractantUI","cmdType2");
         cmdType3.label = DiversityManager.getString("extractantUI","cmdType3");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.setPattern(0);
         this.showItem1(selectRank.selectedItem.data,null);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function closeUI() : void
      {
         this.extIconBag.dropIconItem();
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function destroy() : void
      {
         this.removeListener();
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
         var _loc4_:PeriodCounterItemInfo = null;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         if(!this.isOver)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("extractantUI","noOver"));
            return;
         }
         if(param3.parentIconUI != obf_K_e_3075.extractantUI)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("extractantUI","nobags"));
            return;
         }
         if(this.obf_2_3_3245 > 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("extractantUI","haveTime"));
            return;
         }
         if(obf_t_f_2299.isNum(this.obf_0_X_4397) == true)
         {
            _loc4_ = obf_Y_F_1424.getCounter("$remark_" + this.obf_0_X_4397);
            this.obf_5_K_3274 = obf_t_f_2299.getPatternTypeConfig(this.obf_0_X_4397).number - JSONUtil.getInt(_loc4_,["numOfDay"]);
            if(this.obf_5_K_3274 <= 0)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("extractantUI","noNum"));
               return;
            }
         }
         this.obf_t_7_3409 = JSONUtil.getInt(obf_t_f_2299.getPatternTypeConfig(this.obf_0_X_4397),["gold"]);
         if(Boolean(this.obf_t_7_3409) && GameContext.localPlayer.fullInfo.gold < this.obf_t_7_3409 * 10000)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("extractantUI","dontGold"));
            return;
         }
         this.obf_7_B_794 = JSONUtil.getInt(obf_t_f_2299.getPatternTypeConfig(this.obf_0_X_4397),["money"]);
         if(Boolean(this.obf_7_B_794) && GameContext.localPlayer.fullInfo.money < this.obf_7_B_794)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("extractantUI","dontMoney"));
            return;
         }
         if(!param1 || !param2)
         {
            return;
         }
         if(param1 == this.extIconBag)
         {
            this.extIconBag.dropIconItem();
            this.extIconBag.pushIconItem(param2);
            _loc5_ = GameItemManager.getItemConfig(param2.itemCode);
            if(_loc5_)
            {
               _loc6_ = JSONUtil.getInt(obf_t_f_2299.getItemTypeConfig(_loc5_.rank),["abilityValue"]);
               _loc7_ = JSONUtil.getInt(obf_t_f_2299.getPatternTypeConfig(this.obf_0_X_4397),["magnification"]);
               _loc8_ = int(_loc7_ * _loc6_);
            }
            this.obf_a_g_3306 = param1.haveIconItem.itemId;
            WindowManager.showConfirmBox(DiversityManager.getString("extractantUI","cost",[_loc8_]),this.doSend);
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
   }
}

