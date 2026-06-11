package com.sunweb.game.rpg.playerUI.roulette
{
   import obf_b_P_3069.obf_n_x_1562;
   import obf_g_A_3629.ChatDecoder;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import playerUI.RouletteUIMC;
   
   public class RouletteUI extends RouletteUIMC implements IIconItemUI
   {
      
      private var config:Object;
      
      private var bags:Array;
      
      private var obf_O_V_2592:Array;
      
      private var obf_W_P_1610:Array;
      
      public var obf_l_7_1453:Array;
      
      private var _time:int;
      
      private var obf_I_U_3360:int;
      
      public var cursorActionList:Array;
      
      private var currentResultItemList:Array;
      
      private var cofig:Object;
      
      private var startButtonActTimeInv:TimeLimiter;
      
      private var obf_O_W_1440:TimeLimiter;
      
      private var cursorActTimeInv:TimeLimiter;
      
      private var obf_b_r_e_a_k_168:TimeLimiter;
      
      public function RouletteUI()
      {
         var _loc2_:MovieClip = null;
         var _loc3_:IconItemBag = null;
         this.currentResultItemList = [];
         this.cofig = obf_n_x_1562.config;
         this.obf_O_W_1440 = new TimeLimiter(500);
         this.obf_b_r_e_a_k_168 = new TimeLimiter(1000);
         super();
         this.onResize(null);
         this.visible = false;
         cmdStart.visible = false;
         this.bags = new Array();
         this.obf_O_V_2592 = new Array();
         var _loc1_:int = 1;
         while(_loc1_ <= 16)
         {
            _loc2_ = this["iconBar" + _loc1_];
            if(_loc2_)
            {
               _loc3_ = new IconItemBag(_loc2_,this,_loc1_);
               _loc3_.addValidType(GameItemType.ALL);
               _loc3_.lockDrag = true;
               this.obf_O_V_2592.push(_loc3_);
               this.bags.push(_loc3_);
            }
            _loc1_++;
         }
         this.obf_l_7_1453 = new Array();
         this.setChildIndex(pointEffect,this.numChildren - 1);
         obf_0_7_g_595.obf_G_T_3353 = this.obf_O_V_2592;
         obf_0_7_g_595.obf_s_J_3685 = pointEffect;
         this.addListener();
      }
      
      public function get obf_n_S_1442() : Array
      {
         return this.obf_O_V_2592;
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdStart.addEventListener(MouseEvent.CLICK,this.onStart);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         showExpendItem.addEventListener(TextEvent.LINK,this.obf_B_k_1962);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdStart.removeEventListener(MouseEvent.CLICK,this.onStart);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         showExpendItem.removeEventListener(TextEvent.LINK,this.obf_B_k_1962);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function obf_B_k_1962(param1:TextEvent) : void
      {
         var _loc2_:String = param1.text;
         var _loc3_:Array = _loc2_.split("^");
         if(_loc3_[0] == ChatDecoder.obf_W_v_983)
         {
            GameContext.localPlayer.sendViewRemote(_loc3_[1]);
         }
         else
         {
            obf_7_6_4416.obf_2_F_3313(param1.text);
         }
      }
      
      private function showItemString() : String
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc1_:String = DiversityManager.getString("RouletteUI","needItems") + "\n";
         var _loc2_:Object = JSONUtil.getObject(this.cofig,["rouletteAward","onlineAwardNeedItems"]);
         if(_loc2_)
         {
            for(_loc3_ in _loc2_)
            {
               if(_loc3_)
               {
                  _loc4_ = int(GameItemManager.getItemConfig(_loc3_).rank);
                  _loc5_ = GameItemRank.getRankColor(_loc4_).toString(16);
                  _loc1_ += "<FONT COLOR=\'#" + _loc5_ + "\'><A HREF=\"event:" + ChatDecoder.obf_d_Y_2785 + "^" + _loc3_ + "\">[<U>" + GameItemManager.getItemName(_loc3_) + "</U>]</A></FONT>" + "X" + _loc2_[_loc3_] + " ";
               }
            }
         }
         return _loc1_;
      }
      
      private function onClose(param1:Event) : void
      {
         while(pointEffect.numChildren > 0)
         {
            pointEffect.removeChildAt(0);
         }
         obf_K_e_3075.closeUI(this);
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
      }
      
      public function obf_m_r_2254(param1:String) : void
      {
         var _loc3_:IconItemBag = null;
         while(pointEffect.numChildren > 0)
         {
            pointEffect.removeChildAt(0);
         }
         this.obf_l_7_1453 = new Array();
         this.cursorActionList = null;
         var _loc2_:int = -1;
         for each(_loc3_ in this.obf_O_V_2592)
         {
            if(_loc3_.haveIconItem.itemCode == param1)
            {
               _loc2_ = this.obf_O_V_2592.indexOf(_loc3_);
            }
         }
         if(_loc2_ > -1)
         {
            this.cursorActionList = obf_t_K_4342.get1CursorActionList(_loc2_,16);
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:obf_0_7_g_595 = null;
         var _loc3_:Boolean = false;
         var _loc4_:obf_0_7_g_595 = null;
         for each(_loc2_ in this.obf_l_7_1453)
         {
            if(_loc2_)
            {
               _loc2_.obf_m_3205();
            }
         }
         if(this.obf_O_W_1440.checkTimeout() && Boolean(this.cursorActionList))
         {
            _loc3_ = true;
            for each(_loc4_ in this.obf_l_7_1453)
            {
               if(!_loc4_.isDone)
               {
                  _loc3_ = false;
               }
            }
            if(Boolean(this.cursorActTimeInv) && Boolean(this.cursorActTimeInv.checkTimeout()) || _loc3_)
            {
               this.obf_z_e_4625();
            }
         }
      }
      
      public function showItemsReward() : void
      {
         var _loc2_:IconItemBag = null;
         var _loc3_:int = 0;
         var _loc4_:IconItem = null;
         showExpendItem.htmlText = this.showItemString();
         var _loc1_:Array = JSONUtil.getObject(this.cofig,["rouletteAward","onlineAwardItems"]) as Array;
         if(!_loc1_)
         {
            return;
         }
         for each(_loc2_ in this.obf_O_V_2592)
         {
            if(_loc2_.haveIconItem)
            {
               _loc2_.dropIconItem();
            }
         }
         _loc3_ = 0;
         while(_loc3_ < this.obf_O_V_2592.length)
         {
            if(!(!_loc1_ || _loc3_ >= _loc1_.length))
            {
               _loc4_ = IconItemManager.getIconItemByCode(_loc1_[_loc3_].itemCode,"");
               if(_loc4_)
               {
                  _loc4_.itemCount = _loc1_[_loc3_].itemCount;
                  IconItemBag(this.obf_O_V_2592[_loc3_]).pushIconItem(_loc4_);
               }
            }
            _loc3_++;
         }
      }
      
      public function obf_z_e_4625() : void
      {
         var _loc1_:obf_t_K_4342 = null;
         if(Boolean(this.cursorActionList) && this.cursorActionList.length > 0)
         {
            _loc1_ = this.cursorActionList.shift();
         }
         if(_loc1_)
         {
            this.obf_3_Q_777(_loc1_);
         }
      }
      
      private function obf_3_Q_777(param1:obf_t_K_4342) : void
      {
         var _loc2_:obf_0_7_g_595 = null;
         if(param1.timeInvLimit > 0)
         {
            this.cursorActTimeInv = new TimeLimiter(param1.timeInvLimit);
         }
         for each(_loc2_ in param1.removeCursor)
         {
            this.obf_l_7_1453.splice(this.obf_l_7_1453.indexOf(_loc2_),1);
         }
         this.obf_l_7_1453 = this.obf_l_7_1453.concat(param1.getInsertCursors());
      }
      
      private function onStart(param1:Event) : void
      {
         if(!this.cofig)
         {
            return;
         }
         if(Boolean(this.cursorActionList) || JSONUtil.getInt(this.obf_l_7_1453,["length"]) > 0)
         {
            return;
         }
         obf_n_x_1562.sendStartGambleRoull();
         cmdStart.visible = false;
         this.startButtonActTimeInv = new TimeLimiter(2000);
         while(pointEffect.numChildren > 0)
         {
            pointEffect.removeChildAt(0);
         }
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
      }
      
      public function showUI() : void
      {
         if(!ConditionScript.checkCondition({"equalItemsInBag":JSONUtil.getObject(this.cofig,["rouletteAward","onlineAwardNeedItems"])},null,true))
         {
            return;
         }
         this.visible = true;
         this.showItemsReward();
         this.onStart(null);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         var _loc1_:IconItemBag = null;
         this.removeListener();
         for each(_loc1_ in this.obf_O_V_2592)
         {
            if(_loc1_.haveIconItem)
            {
               _loc1_.dropIconItem();
            }
         }
      }
   }
}

