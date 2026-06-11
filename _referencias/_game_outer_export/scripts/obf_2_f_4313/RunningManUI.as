package obf_2_f_4313
{
   import obf_6_4_3428.obf_s_W_2408;
   import com.sunweb.game.res.obf_0_P_4381;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.activity.obf_J_F_3431;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_l_y_733;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import playerUI.RunningManUIMC;
   
   public class RunningManUI extends RunningManUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      private var obf_6_G_3772:Array;
      
      private var timeLimiter:TimeLimiter;
      
      private var tempT:int = -1;
      
      private var obf_M_3735:MovieClip;
      
      private var _time:int;
      
      private var obf_3_k_3987:int;
      
      private var dis:DisplayObject;
      
      private var obf_2_d_1417:Object;
      
      public function RunningManUI()
      {
         var _loc3_:MovieClip = null;
         var _loc4_:IconItemBag = null;
         this.timeLimiter = new TimeLimiter(1000);
         this.obf_2_d_1417 = new Object();
         super();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         txtDeyTitle.mouseEnabled = false;
         cmdAward.visible = false;
         this.initDiversity();
         this.bags = new Array();
         var _loc1_:int = 1;
         while(_loc1_ <= 5)
         {
            _loc3_ = this["icon" + _loc1_];
            if(_loc3_)
            {
               _loc4_ = new IconItemBag(_loc3_,this,_loc1_);
               _loc4_.addValidType(GameItemType.ALL);
               _loc4_.lockDrag = true;
               this.bags.push(_loc4_);
            }
            _loc1_++;
         }
         var _loc2_:int = 1;
         while(_loc2_ <= 7)
         {
            (this["num" + _loc2_] as MovieClip).gotoAndStop(1);
            _loc2_++;
         }
         this.obf_6_G_3772 = [num1,num2,num3,num4,num5,num6,num7];
         this.addListener();
      }
      
      private function addListener() : void
      {
         var _loc1_:* = undefined;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         titleBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdAward.addEventListener(MouseEvent.CLICK,this.obf_x_1085);
         for each(_loc1_ in this.obf_6_G_3772)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.onSelect);
         }
      }
      
      private function removeListener() : void
      {
         var _loc1_:* = undefined;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         titleBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdAward.removeEventListener(MouseEvent.CLICK,this.obf_x_1085);
         for each(_loc1_ in this.obf_6_G_3772)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onSelect);
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
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!GameContext.localPlayer)
         {
            return;
         }
         if(this.timeLimiter.checkTimeout())
         {
            txtTime.text = DiversityManager.getString("RunningManUI","time",[obf_l_y_733.getTimeStringHHMMSS(getTimer() - this.tempT + this._time * 60 * 1000)]);
            _loc2_ = obf_l_y_733.getTimeStringMM(getTimer() - this.tempT + this._time * 60 * 1000);
            _loc3_ = this.getMeter(_loc2_);
            if(_loc3_ > this.obf_3_k_3987)
            {
               this.obf_3_k_3987 = _loc3_;
               this.obf_M_3735 = this.obf_6_G_3772[this.obf_3_k_3987 - 1];
               this.obf_H_R_4286();
            }
            if(!obf_J_F_3431.obf_4_4696(JSONUtil.getStr(obf_s_W_2408.runConfig,["activityCode"])))
            {
               this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            }
         }
      }
      
      private function obf_x_1085(param1:Event) : void
      {
         var _loc2_:Array = JSONUtil.getValue(obf_s_W_2408.runConfig,["awardList"]) as Array;
         var _loc3_:int = this.obf_6_G_3772.indexOf(this.obf_M_3735) + 1;
         if(!ConditionScript.checkCondition(JSONUtil.getObject(_loc2_[_loc3_ - 1],["condition"]),null,true))
         {
            return;
         }
         obf_s_W_2408.obf_k_b_2296(_loc3_ + "");
         cmdAward.visible = false;
      }
      
      private function onSelect(param1:Event) : void
      {
         this.obf_M_3735 = param1.currentTarget as MovieClip;
         this.showContent(this.obf_M_3735);
      }
      
      private function showContent(param1:MovieClip) : void
      {
         var _loc2_:MovieClip = null;
         var _loc5_:String = null;
         var _loc6_:IconItemBag = null;
         var _loc7_:IconItem = null;
         for each(_loc2_ in this.obf_6_G_3772)
         {
            if(_loc2_ == param1)
            {
               if(this.obf_6_G_3772.indexOf(param1) + 1 == this.obf_3_k_3987)
               {
                  _loc2_.gotoAndStop(2);
               }
               else
               {
                  _loc2_.gotoAndStop(3);
               }
            }
            else
            {
               _loc2_.gotoAndStop(1);
            }
         }
         if(this.obf_2_d_1417[this.obf_6_G_3772.indexOf(param1) + 1] == 0)
         {
            cmdAward.visible = true;
         }
         else
         {
            cmdAward.visible = false;
         }
         this.clear();
         var _loc3_:Object = obf_s_W_2408.awardObj(this.obf_6_G_3772.indexOf(param1) + 1);
         var _loc4_:int = -1;
         for(_loc5_ in _loc3_.items)
         {
            _loc4_++;
            _loc6_ = this.bags[_loc4_];
            if(_loc6_)
            {
               _loc6_.dropIconItem();
               _loc7_ = IconItemManager.getIconItemByCode(_loc5_,"");
               _loc7_.itemCount = _loc3_.items[_loc5_];
               _loc6_.pushIconItem(_loc7_);
            }
         }
      }
      
      public function setRunNum(param1:int) : void
      {
         this._time = param1;
         if(param1 == 0)
         {
            this.tempT = getTimer();
         }
         if(this.tempT < 0)
         {
            this.tempT = getTimer();
         }
         this.obf_3_k_3987 = this.getMeter(this._time);
         this.obf_M_3735 = this.obf_6_G_3772[this.obf_3_k_3987 - 1];
         this.obf_H_R_4286();
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function obf_H_R_4286() : void
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in this.obf_6_G_3772)
         {
            if(this.obf_6_G_3772.indexOf(_loc1_) + 1 == this.obf_3_k_3987)
            {
               _loc1_.gotoAndStop(2);
            }
            else
            {
               _loc1_.gotoAndStop(1);
            }
         }
         cmdAward.visible = false;
         this.clear();
         if(this.obf_M_3735)
         {
            this.showContent(this.obf_M_3735);
         }
      }
      
      private function clear() : void
      {
         var _loc1_:IconItemBag = null;
         for each(_loc1_ in this.bags)
         {
            if(_loc1_.haveIconItem)
            {
               _loc1_.dropIconItem();
            }
         }
      }
      
      private function getMeter(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc4_:Object = null;
         var _loc3_:Array = JSONUtil.getValue(obf_s_W_2408.runConfig,["awardList"]) as Array;
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_.onlineTime <= param1)
            {
               _loc2_ = int(_loc4_.id);
            }
         }
         return _loc2_;
      }
      
      private function obf_8_6_1149() : void
      {
         var _loc2_:Object = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.obf_6_G_3772.length)
         {
            this.dis = obf_0_P_4381.obf_q_h_1296(JSONUtil.getStr(obf_s_W_2408.runConfig,["icon"]));
            this["iconPont" + (_loc1_ + 1)].visible = true;
            while(this["iconPont" + (_loc1_ + 1)].numChildren > 0)
            {
               this["iconPont" + (_loc1_ + 1)].removeChildAt(0);
            }
            _loc2_ = obf_s_W_2408.awardObj(_loc1_ + 1);
            if(Boolean(_loc2_.items) && Boolean(this.dis))
            {
               this["iconPont" + (_loc1_ + 1)].addChild(this.dis);
            }
            if(this.obf_2_d_1417[_loc1_ + 1] >= 1)
            {
               this["iconPont" + (_loc1_ + 1)].visible = false;
            }
            _loc1_++;
         }
      }
      
      public function setAwardFettle(param1:Object) : void
      {
         this.obf_2_d_1417 = param1;
         if(this.obf_M_3735)
         {
            if(this.obf_2_d_1417[this.obf_6_G_3772.indexOf(this.obf_M_3735) + 1] == 0)
            {
               cmdAward.visible = true;
            }
            else
            {
               cmdAward.visible = false;
            }
         }
         this.obf_8_6_1149();
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
         cmdAward.label = DiversityManager.getString("RunningManUI","cmdAward");
         DiversityManager.setTextField(txtDeyTitle,"RunningManUI","txtDeyTitle");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.obf_8_6_1149();
         this.obf_M_3735 = this.obf_6_G_3772[this.obf_3_k_3987 - 1];
         this.obf_H_R_4286();
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.clear();
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
   }
}

