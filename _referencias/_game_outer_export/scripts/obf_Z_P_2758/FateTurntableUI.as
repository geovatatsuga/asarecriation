package obf_Z_P_2758
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.fateTurntable.FateInfo;
   import com.sunweb.game.rpg.fateTurntable.obf_0_7_a_267;
   import com.sunweb.game.rpg.fateTurntable.obf_3_i_1942;
   import com.sunweb.game.rpg.fateTurntable.obf_S_4_4436;
   import com.sunweb.game.rpg.fateTurntable.obf_y_I_905;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_9_V_1635;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import playerUI.FateTurntableUIMC;
   import playerUI.Test.InnerBlackStopEffect;
   import playerUI.Test.InnerStopEffect;
   import playerUI.Test.MiddleBlackStopEffect;
   import playerUI.Test.MiddleStopEffect;
   import playerUI.Test.OuterBlackStopEffect;
   import playerUI.Test.OuterStopEffect;
   
   public class FateTurntableUI extends FateTurntableUIMC implements IPlayerUI
   {
      
      private var obf_Y_4699:Array;
      
      private var obf_J_M_2867:Array;
      
      private var obf_Q_n_1447:Array;
      
      private var obf_l_7_1453:Array;
      
      private var cursorActionList:Array;
      
      private var wheelCursors2:Array;
      
      private var cursorActionList2:Array;
      
      private var wheelCursors3:Array;
      
      private var cursorActionList3:Array;
      
      private var obf_x_Q_4276:Array = [1,8];
      
      private var obf_X_j_1528:Array;
      
      private var obf_z_d_1921:int;
      
      public var obf_6_k_3002:int;
      
      public var obf_o_u_3835:int;
      
      public var obf_u_v_4445:int;
      
      public var _result:Object;
      
      private var startButtonActTimeInv:TimeLimiter;
      
      private var obf_O_W_1440:TimeLimiter = new TimeLimiter(500);
      
      private var obf_B_z_1988:TimeLimiter = new TimeLimiter(500);
      
      private var obf_G_x_3907:TimeLimiter = new TimeLimiter(500);
      
      private var cursorActTimeInv:TimeLimiter;
      
      private var cursorActTimeInv2:TimeLimiter;
      
      private var cursorActTimeInv3:TimeLimiter;
      
      public function FateTurntableUI()
      {
         super();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.initDiversity();
         this.obf_X_j_1528 = new Array();
         this.obf_Y_4699 = new Array();
         this.obf_J_M_2867 = new Array();
         this.obf_Q_n_1447 = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            this.obf_Y_4699.push(this["a" + _loc1_] as MovieClip);
            _loc1_++;
         }
         var _loc2_:int = 6;
         while(_loc2_ < 10)
         {
            this.obf_J_M_2867.push(this["a" + _loc2_] as MovieClip);
            _loc2_++;
         }
         var _loc3_:int = 10;
         while(_loc3_ < 13)
         {
            this.obf_Q_n_1447.push(this["a" + _loc3_] as MovieClip);
            _loc3_++;
         }
         FateAwardCursorBase.obf_n_S_1442 = this.obf_Y_4699;
         FateAwardCursorBase.obf_0_4_k_446 = aPoint;
         FateAwardCursorBase.wheelBags2 = this.obf_J_M_2867;
         FateAwardCursorBase.obf_0_0_4_725 = bPoint;
         FateAwardCursorBase.wheelBags3 = this.obf_Q_n_1447;
         FateAwardCursorBase.obf_5_D_1690 = cPoint;
         this.addListener();
         txtFateDot.mouseEnabled = false;
         txtNum.mouseEnabled = false;
         txtDeyTitle.mouseEnabled = false;
         var _loc4_:TextFormat = new TextFormat();
         _loc4_.underline = true;
         txtRemark.setTextFormat(_loc4_);
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         bgBox.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdColse.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdFate.addEventListener(MouseEvent.CLICK,this.obf_5_m_3932);
         obf_K_e_3075.addUIMouseToolTip(txtRemark,"remarkFateTurntable");
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         bgBox.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdColse.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdFate.removeEventListener(MouseEvent.CLICK,this.obf_5_m_3932);
         obf_K_e_3075.removeUIMouseToolTip(txtRemark);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function obf_5_m_3932(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(!this.isAllOpen())
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("MoulageUI","noOpen"));
            return;
         }
         if(obf_3_i_1942.freeDayTimes < 1)
         {
            _loc2_ = JSONUtil.getInt(JSONUtil.getValue(obf_3_i_1942.fateTurntableConfig,"turnConfig"),["needFate"]);
            WindowManager.showConfirmBox(DiversityManager.getString("FateTurntableUI","sure",[_loc2_]),this.obf_0_0_c_390,{"needFate":_loc2_});
         }
         else
         {
            obf_3_i_1942.sendStartTurntableRequest();
         }
      }
      
      private function obf_0_0_c_390(param1:Object) : void
      {
         if(param1.confirm)
         {
            if(this.obf_z_d_1921 < param1.par.needFate)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("FateTurntableUI","noFateDot"));
               return;
            }
            obf_3_i_1942.sendStartTurntableRequest();
         }
      }
      
      public function onStart(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = undefined;
         this._result = param1;
         txtNum.text = "";
         txtNum.text = obf_3_i_1942.freeDayTimes + "";
         while(aPoint.numChildren > 0)
         {
            aPoint.removeChildAt(0);
         }
         while(bPoint.numChildren > 0)
         {
            bPoint.removeChildAt(0);
         }
         while(cPoint.numChildren > 0)
         {
            cPoint.removeChildAt(0);
         }
         this.obf_l_7_1453 = new Array();
         this.wheelCursors2 = new Array();
         this.wheelCursors3 = new Array();
         for(_loc5_ in param1)
         {
            if(_loc5_ < 3)
            {
               _loc4_ = _loc5_;
               this.obf_u_v_4445 = param1[_loc5_];
            }
            else if(_loc5_ >= 3 && _loc5_ <= 6)
            {
               _loc3_ = _loc5_ - 3;
               this.obf_o_u_3835 = param1[_loc5_];
            }
            else if(_loc5_ >= 7)
            {
               _loc2_ = _loc5_ - 7;
               this.obf_6_k_3002 = param1[_loc5_];
            }
         }
         this.cursorActionList = obf_X_v_3630.get1CursorActionList(_loc2_,this.obf_Y_4699.length,1);
         this.cursorActionList2 = obf_X_v_3630.get2CursorActionList(_loc3_,this.obf_J_M_2867.length,2);
         this.cursorActionList3 = obf_X_v_3630.get3CursorActionList(_loc4_,this.obf_Q_n_1447.length,3);
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
         var _loc2_:FateAwardCursorBase = null;
         var _loc3_:FateAwardCursorBase = null;
         var _loc4_:FateAwardCursorBase = null;
         var _loc5_:Boolean = false;
         var _loc6_:FateAwardCursorBase = null;
         var _loc7_:Boolean = false;
         var _loc8_:FateAwardCursorBase = null;
         var _loc9_:Boolean = false;
         var _loc10_:FateAwardCursorBase = null;
         for each(_loc2_ in this.obf_l_7_1453)
         {
            if(_loc2_)
            {
               _loc2_.obf_m_3205();
            }
         }
         if(this.obf_O_W_1440.checkTimeout() && Boolean(this.cursorActionList))
         {
            _loc5_ = true;
            for each(_loc6_ in this.obf_l_7_1453)
            {
               if(!_loc6_.isDone)
               {
                  _loc5_ = false;
               }
            }
            if(Boolean(this.cursorActTimeInv) && Boolean(this.cursorActTimeInv.checkTimeout()) || _loc5_)
            {
               this.obf_z_e_4625();
            }
         }
         if(Boolean(this.startButtonActTimeInv) && this.startButtonActTimeInv.checkTimeout())
         {
            this.startButtonActTimeInv = null;
         }
         for each(_loc3_ in this.wheelCursors2)
         {
            if(_loc3_)
            {
               _loc3_.obf_m_3205();
            }
         }
         if(this.obf_B_z_1988.checkTimeout() && Boolean(this.cursorActionList2))
         {
            _loc7_ = true;
            for each(_loc8_ in this.wheelCursors2)
            {
               if(!_loc8_.isDone)
               {
                  _loc7_ = false;
               }
            }
            if(Boolean(this.cursorActTimeInv2) && Boolean(this.cursorActTimeInv2.checkTimeout()) || _loc7_)
            {
               this.obf_t_H_1368();
            }
         }
         for each(_loc4_ in this.wheelCursors3)
         {
            if(_loc4_)
            {
               _loc4_.obf_m_3205();
            }
         }
         if(this.obf_G_x_3907.checkTimeout() && Boolean(this.cursorActionList3))
         {
            _loc9_ = true;
            for each(_loc10_ in this.wheelCursors3)
            {
               if(!_loc10_.isDone)
               {
                  _loc9_ = false;
               }
            }
            if(Boolean(this.cursorActTimeInv3) && Boolean(this.cursorActTimeInv3.checkTimeout()) || _loc9_)
            {
               this.obf_0_7_N_153();
            }
         }
      }
      
      public function obf_z_e_4625() : void
      {
         var _loc1_:obf_X_v_3630 = null;
         if(Boolean(this.cursorActionList) && this.cursorActionList.length > 0)
         {
            _loc1_ = this.cursorActionList.shift();
         }
         if(_loc1_)
         {
            this.obf_3_Q_777(_loc1_);
         }
      }
      
      public function obf_t_H_1368() : void
      {
         var _loc1_:obf_X_v_3630 = null;
         if(Boolean(this.cursorActionList2) && this.cursorActionList2.length > 0)
         {
            _loc1_ = this.cursorActionList2.shift();
         }
         if(_loc1_)
         {
            this.obf_g_B_1951(_loc1_);
         }
      }
      
      public function obf_0_7_N_153() : void
      {
         var _loc1_:obf_X_v_3630 = null;
         if(Boolean(this.cursorActionList3) && this.cursorActionList3.length > 0)
         {
            _loc1_ = this.cursorActionList3.shift();
         }
         if(_loc1_)
         {
            this.obf_S_T_3701(_loc1_);
         }
      }
      
      private function obf_3_Q_777(param1:obf_X_v_3630) : void
      {
         var _loc2_:FateAwardCursorBase = null;
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
      
      private function obf_g_B_1951(param1:obf_X_v_3630) : void
      {
         var _loc2_:FateAwardCursorBase = null;
         if(param1.timeInvLimit > 0)
         {
            this.cursorActTimeInv2 = new TimeLimiter(param1.timeInvLimit);
         }
         for each(_loc2_ in param1.removeCursor)
         {
            this.wheelCursors2.splice(this.obf_l_7_1453.indexOf(_loc2_),1);
         }
         this.wheelCursors2 = this.wheelCursors2.concat(param1.getInsertCursors());
      }
      
      private function obf_S_T_3701(param1:obf_X_v_3630) : void
      {
         var _loc2_:FateAwardCursorBase = null;
         if(param1.timeInvLimit > 0)
         {
            this.cursorActTimeInv3 = new TimeLimiter(param1.timeInvLimit);
         }
         for each(_loc2_ in param1.removeCursor)
         {
            this.wheelCursors3.splice(this.obf_l_7_1453.indexOf(_loc2_),1);
         }
         this.wheelCursors3 = this.wheelCursors3.concat(param1.getInsertCursors());
      }
      
      public function obf_i_4_2766() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 13)
         {
            if((this.obf_X_j_1528[_loc1_] as FateInfo).level > 0)
            {
               (this["a" + _loc1_] as MovieClip).alpha = 0;
               this["a" + _loc1_].filters = [];
            }
            else
            {
               (this["a" + _loc1_] as MovieClip).alpha = 100;
               this["a" + _loc1_].filters = [obf_9_V_1635.getGrayFilter()];
            }
            _loc1_++;
         }
      }
      
      public function obf_0_1_U_421(param1:int) : void
      {
         this.obf_z_d_1921 = param1;
         var _loc2_:int = 100 * Number(param1 / 100000);
         bar.gotoAndStop(_loc2_);
         txtFateDot.text = param1 + "";
      }
      
      public function obf_k_T_4034() : void
      {
         var _loc5_:obf_c_K_1115 = null;
         this.clear();
         var _loc1_:int = -1;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < this.obf_X_j_1528.length)
         {
            _loc5_ = new obf_c_K_1115(this,this.obf_X_j_1528[_loc4_] as FateInfo);
            _loc5_.addEventListener(obf_c_K_1115.obf_N_I_1539,this.onUpLv);
            if(++_loc1_ > 1)
            {
               _loc1_ = 0;
               _loc2_ += _loc5_.height - 7;
            }
            _loc5_.x = (_loc5_.width - 6) * _loc1_;
            _loc5_.y = _loc2_;
            _loc3_ = _loc5_.y + _loc5_.height;
            moulageTypePoint.addChild(_loc5_);
            _loc4_++;
         }
      }
      
      private function onUpLv(param1:Event) : void
      {
         var _loc4_:String = null;
         var _loc5_:Object = null;
         var _loc2_:Object = JSONUtil.getValue(obf_3_i_1942.fateTurntableConfig,"upLevel");
         if(!_loc2_)
         {
            return;
         }
         if(!this.isAllOpen())
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("MoulageUI","noOpen"));
            return;
         }
         if(param1.currentTarget._config.level >= JSONUtil.getInt(_loc2_,["maxLevel"]))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("MoulageUI","maxLv"));
            return;
         }
         var _loc3_:int = int(_loc2_.needFate);
         for(_loc4_ in _loc2_.items)
         {
            _loc5_ = GameItemManager.getItemConfig(_loc4_);
            if(obf_K_e_3075.playerBagUI.getItemCount(_loc4_) < _loc2_.items[_loc4_])
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("MoulageUI","noStuff",[_loc5_.name,_loc2_.items[_loc4_]]));
               return;
            }
         }
         if(this.obf_z_d_1921 < _loc3_)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("MoulageUI","noFateDot"));
            return;
         }
         obf_3_i_1942.sendFateUpLevelRequest(param1.currentTarget._config.id);
      }
      
      private function isAllOpen() : Boolean
      {
         var _loc1_:FateInfo = null;
         for each(_loc1_ in this.obf_X_j_1528)
         {
            if(_loc1_.level <= 0)
            {
               return false;
            }
         }
         return true;
      }
      
      public function getMoulageArr(param1:Array) : void
      {
         this.obf_X_j_1528 = param1;
         this.obf_X_j_1528.sortOn("id",Array.NUMERIC);
         this.obf_k_T_4034();
         this.obf_i_4_2766();
      }
      
      public function refurbishResult(param1:Object) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:MovieClip = null;
         if(!param1)
         {
            return;
         }
         this._result = param1;
         while(aPoint.numChildren > 0)
         {
            aPoint.removeChildAt(0);
         }
         while(bPoint.numChildren > 0)
         {
            bPoint.removeChildAt(0);
         }
         while(cPoint.numChildren > 0)
         {
            cPoint.removeChildAt(0);
         }
         for(_loc2_ in param1)
         {
            if(_loc2_ < 3)
            {
               if(param1[_loc2_] == 1)
               {
                  _loc3_ = new InnerStopEffect();
               }
               else if(param1[_loc2_] == 2)
               {
                  _loc3_ = new InnerBlackStopEffect();
               }
               _loc4_ = JSONUtil.getObject(this.obf_Q_n_1447,[_loc2_]) as MovieClip;
               _loc3_.x = _loc4_.x;
               _loc3_.y = _loc4_.y;
               _loc3_.rotation = obf_y_I_905.getDegree(_loc2_);
               cPoint.addChild(_loc3_);
            }
            else if(_loc2_ >= 3 && _loc2_ <= 6)
            {
               if(param1[_loc2_] == 1)
               {
                  _loc3_ = new MiddleStopEffect();
               }
               else if(param1[_loc2_] == 2)
               {
                  _loc3_ = new MiddleBlackStopEffect();
               }
               _loc4_ = JSONUtil.getObject(this.obf_J_M_2867,[_loc2_ - 3]) as MovieClip;
               _loc3_.x = _loc4_.x;
               _loc3_.y = _loc4_.y;
               _loc3_.rotation = obf_S_4_4436.getDegree(_loc2_ - 3);
               bPoint.addChild(_loc3_);
            }
            else if(_loc2_ >= 7)
            {
               if(param1[_loc2_] == 1)
               {
                  _loc3_ = new OuterStopEffect();
               }
               else if(param1[_loc2_] == 2)
               {
                  _loc3_ = new OuterBlackStopEffect();
               }
               _loc4_ = JSONUtil.getObject(this.obf_Y_4699,[_loc2_ - 7]) as MovieClip;
               _loc3_.x = _loc4_.x;
               _loc3_.y = _loc4_.y;
               _loc3_.rotation = obf_0_7_a_267.getDegree(_loc2_ - 7);
               aPoint.addChild(_loc3_);
            }
         }
         this.obf_k_T_4034();
      }
      
      private function clear() : void
      {
         var _loc1_:obf_c_K_1115 = null;
         while(moulageTypePoint.numChildren > 0)
         {
            _loc1_ = moulageTypePoint.getChildAt(0) as obf_c_K_1115;
            if(_loc1_)
            {
               _loc1_.removeEventListener(obf_c_K_1115.obf_N_I_1539,this.onUpLv);
               _loc1_.destroy();
            }
            moulageTypePoint.removeChildAt(0);
         }
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
         DiversityManager.setTextField(txtDeyTitle,"FateTurntableUI","txtDeyTitle");
         DiversityManager.setTextField(txtMoulage1,"FateTurntableUI","txtMoulage");
         DiversityManager.setTextField(txtLv1,"FateTurntableUI","txtLv");
         DiversityManager.setTextField(txtAttr1,"FateTurntableUI","txtAttr");
         DiversityManager.setTextField(txtMoulage2,"FateTurntableUI","txtMoulage");
         DiversityManager.setTextField(txtLv2,"FateTurntableUI","txtLv");
         DiversityManager.setTextField(txtAttr2,"FateTurntableUI","txtAttr");
         DiversityManager.setTextField(txtDayFateDot,"FateTurntableUI","txtDayFateDot");
         DiversityManager.setTextField(txtDayNum,"FateTurntableUI","txtDayNum");
         cmdFate.label = DiversityManager.getString("FateTurntableUI","cmdMoulage");
         txtRemark.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("FateTurntableUI","txtRemark") + "</a>";
      }
      
      public function showUI() : void
      {
         this.visible = true;
         txtNum.text = obf_3_i_1942.freeDayTimes + "";
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

