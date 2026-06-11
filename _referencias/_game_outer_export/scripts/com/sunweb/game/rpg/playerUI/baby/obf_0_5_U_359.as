package com.sunweb.game.rpg.playerUI.baby
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.baby.StudyType;
   import com.sunweb.game.rpg.baby.obf_s_1265;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_l_y_733;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import flash.utils.getTimer;
   import playerUI.CollegeUIMC;
   
   public class obf_0_5_U_359 extends CollegeUIMC implements IPlayerUI
   {
      
      private var obf_o_W_3348:Array;
      
      private var learnEmptyArr:Array;
      
      private var openButtonArr:Array;
      
      private var awardButtonArr:Array;
      
      private var obf_K_O_1228:int = 2;
      
      private var learningObj:Object;
      
      private var isAwardArea1:Boolean;
      
      private var isAwardArea2:Boolean;
      
      private var isAwardArea3:Boolean;
      
      private var isAwardArea4:Boolean;
      
      private var areaStopTime1:int = 0;
      
      private var areaStopTime2:int = 0;
      
      private var areaStopTime3:int = 0;
      
      private var areaStopTime4:int = 0;
      
      private var obf_j_B_1080:int;
      
      private var obf_7_O_836:TimeLimiter = new TimeLimiter(200);
      
      public function obf_0_5_U_359()
      {
         super();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         titleBox.mouseEnabled = false;
         txtDeyTitle.mouseEnabled = false;
         this.initDiversity();
         this.learningObj = new Object();
         learn1.gotoAndStop(1);
         learn2.gotoAndStop(1);
         learn3.gotoAndStop(1);
         learn4.gotoAndStop(1);
         this.obf_o_W_3348 = [obf_0_3_c_166,obf_W_e_3811,obf_Q_x_789,obf_0_3_u_603];
         this.openButtonArr = [cmdOpen1,cmdOpen2,cmdOpen3,cmdOpen4];
         this.learnEmptyArr = [learn1,learn2,learn3,learn4];
         this.awardButtonArr = [award1,award2,award3,award4];
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.underline = true;
         remark.setTextFormat(_loc1_);
         this.addListener();
      }
      
      private function addListener() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         bgBox.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         for each(_loc1_ in this.obf_o_W_3348)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.obf_W_8_1496);
            _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.obf_S_C_3990);
            _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this.obf_K_o_2954);
         }
         for each(_loc2_ in this.openButtonArr)
         {
            _loc2_.addEventListener(MouseEvent.CLICK,this.obf_x_h_2072);
         }
         for each(_loc3_ in this.awardButtonArr)
         {
            _loc3_.addEventListener(MouseEvent.CLICK,this.obf_x_1085);
         }
         cmdAll.addEventListener(MouseEvent.CLICK,this.obf_a_4_2054);
         cmdAll.addEventListener(MouseEvent.MOUSE_OVER,this.obf_G_k_3294);
         cmdAll.addEventListener(MouseEvent.MOUSE_OUT,this.obf_6_b_2643);
         obf_K_e_3075.addUIMouseToolTip(remark,"remarkCollege");
      }
      
      private function removeListener() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         bgBox.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         for each(_loc1_ in this.obf_o_W_3348)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.obf_W_8_1496);
            _loc1_.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_S_C_3990);
            _loc1_.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_K_o_2954);
         }
         for each(_loc2_ in this.openButtonArr)
         {
            _loc2_.removeEventListener(MouseEvent.CLICK,this.obf_x_h_2072);
         }
         for each(_loc3_ in this.awardButtonArr)
         {
            _loc3_.removeEventListener(MouseEvent.CLICK,this.obf_x_1085);
         }
         cmdAll.removeEventListener(MouseEvent.CLICK,this.obf_a_4_2054);
         cmdAll.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_G_k_3294);
         cmdAll.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_6_b_2643);
         obf_K_e_3075.removeUIMouseToolTip(remark);
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
      
      private function obf_S_C_3990(param1:MouseEvent) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("babyCollegeTip");
         var _loc3_:int = 60;
         var _loc4_:Array = obf_s_1265.getCollegeConfig().collegeNames;
         var _loc5_:String = _loc4_[this.obf_o_W_3348.indexOf(param1.currentTarget)];
         _loc2_.addTipInfo(_loc5_,_loc3_,1);
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_K_o_2954(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("babyCollegeTip");
      }
      
      private function obf_G_k_3294(param1:MouseEvent) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("babyFastTip");
         var _loc3_:int = 100;
         _loc2_.addTipInfo(DiversityManager.getString("BoyUI","fastRemark"),_loc3_,1);
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_6_b_2643(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("babyFastTip");
      }
      
      private function obf_a_4_2054(param1:Event) : void
      {
         WindowManager.showConfirmBox(DiversityManager.getString("BoyUI","sure4",[obf_s_1265.getCollegeConfig().costMoney]),this.obf_r_1_3933);
      }
      
      private function obf_r_1_3933(param1:Object) : void
      {
         if(param1.confirm)
         {
            if(GameContext.localPlayer.fullInfo.money < obf_s_1265.getCollegeConfig().costMoney)
            {
               WindowManager.showMessageBox(DiversityManager.getString("BoyUI","noMoney"));
               return;
            }
            obf_s_1265.sendBabyFastLearnRequest();
         }
      }
      
      private function obf_W_8_1496(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         if(this.obf_N_X_2362() <= 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("BoyUI","noArea"));
            return;
         }
         for each(_loc3_ in this.learnEmptyArr)
         {
            if(_loc3_.currentFrame - 1 == this.obf_o_W_3348.indexOf(param1.currentTarget) + 2)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("BoyUI","learning"));
               return;
            }
         }
         _loc4_ = 1;
         while(_loc4_ <= 4)
         {
            if(!this.learningObj[_loc4_])
            {
               this.learningObj[_loc4_] = param1.currentTarget;
               _loc2_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         obf_s_1265.sendBabyStudyRequest(this.obf_o_W_3348.indexOf(param1.currentTarget) + 2,_loc2_);
      }
      
      private function obf_x_h_2072(param1:Event) : void
      {
         var _loc2_:int = this.openButtonArr.indexOf(param1.currentTarget) + 1;
         var _loc3_:Array = JSONUtil.getValue(obf_s_1265.getCollegeConfig(),["buyMoney"]) as Array;
         if(_loc2_ > 2 && (this.learnEmptyArr[_loc2_ - 2] as MovieClip).currentFrame <= 1)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("BoyUI","open"));
            return;
         }
         WindowManager.showConfirmBox(DiversityManager.getString("BoyUI","sure3",[_loc3_[_loc2_ - 1]]),this.obf_i_k_2402,{"money":_loc3_[_loc2_ - 1]});
      }
      
      private function obf_i_k_2402(param1:Object) : void
      {
         if(param1.confirm)
         {
            if(GameContext.localPlayer.fullInfo.money < param1.par.money)
            {
               WindowManager.showMessageBox(DiversityManager.getString("BoyUI","noMoney"));
               return;
            }
            obf_s_1265.sendBabyBuyCollegeRequest();
         }
      }
      
      private function obf_x_1085(param1:Event) : void
      {
         var _loc2_:int = this.awardButtonArr.indexOf(param1.currentTarget) + 1;
         var _loc3_:int = this.obf_o_W_3348.indexOf(this.learningObj[_loc2_]) + 2;
         obf_s_1265.sendBabyStudyOverRequest(_loc3_,_loc2_);
         this.learningObj[_loc2_] = null;
      }
      
      public function reshShow(param1:Object) : void
      {
         var _loc2_:* = undefined;
         for(_loc2_ in param1)
         {
            this["learn" + _loc2_].gotoAndStop(param1[_loc2_] + 1);
            if(param1[_loc2_] + 1 != 1)
            {
               this.openButtonArr[_loc2_ - 1].visible = false;
            }
            if(param1[_loc2_] + 1 > 2)
            {
               this.learningObj[_loc2_] = this.obf_o_W_3348[param1[_loc2_] + 1 - 3];
            }
         }
      }
      
      public function reshAreaTime(param1:Object, param2:Object) : void
      {
         var _loc3_:* = undefined;
         for(_loc3_ in param2)
         {
            if(param2[_loc3_] == StudyType.STRENGTH)
            {
               if(param1[StudyType.STRENGTH] >= 0)
               {
                  this["isAwardArea" + _loc3_] = true;
                  this["areaStopTime" + _loc3_] = param1[StudyType.STRENGTH] * 1000;
               }
               else
               {
                  this["isAwardArea" + _loc3_] = false;
               }
            }
            else if(param2[_loc3_] == StudyType.AGILITY)
            {
               if(param1[StudyType.AGILITY] >= 0)
               {
                  this["isAwardArea" + _loc3_] = true;
                  this["areaStopTime" + _loc3_] = param1[StudyType.AGILITY] * 1000;
               }
               else
               {
                  this["isAwardArea" + _loc3_] = false;
               }
            }
            else if(param2[_loc3_] == StudyType.WISDOM)
            {
               if(param1[StudyType.WISDOM] >= 0)
               {
                  this["isAwardArea" + _loc3_] = true;
                  this["areaStopTime" + _loc3_] = param1[StudyType.WISDOM] * 1000;
               }
               else
               {
                  this["isAwardArea" + _loc3_] = false;
               }
            }
            else if(param2[_loc3_] == StudyType.VITALITY)
            {
               if(param1[StudyType.VITALITY] >= 0)
               {
                  this["isAwardArea" + _loc3_] = true;
                  this["areaStopTime" + _loc3_] = param1[StudyType.VITALITY] * 1000;
               }
               else
               {
                  this["isAwardArea" + _loc3_] = false;
               }
            }
            else
            {
               this["isAwardArea" + _loc3_] = false;
            }
         }
         this.obf_j_B_1080 = getTimer();
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this.obf_7_O_836.checkTimeout())
         {
            _loc2_ = 0;
            _loc3_ = 1;
            while(_loc3_ <= 4)
            {
               if((this.learnEmptyArr[_loc3_ - 1] as MovieClip).currentFrame > 1)
               {
                  if(this["areaStopTime" + _loc3_] > 0 && Boolean(this["isAwardArea" + _loc3_]))
                  {
                     _loc4_ = this.getDurationTimeInMS(this["areaStopTime" + _loc3_],this.obf_j_B_1080);
                     if(_loc4_ <= 0)
                     {
                        this["areaStopTime" + _loc3_] = 0;
                        _loc4_ = 0;
                        this["award" + _loc3_].visible = true;
                        this["leavingsTime" + _loc3_].text = DiversityManager.getString("BoyUI","canAward");
                     }
                     else
                     {
                        this["leavingsTime" + _loc3_].text = obf_l_y_733.getTimeStringHHMMSS(_loc4_);
                        this["award" + _loc3_].visible = false;
                        _loc2_++;
                     }
                  }
                  else if(this["areaStopTime" + _loc3_] <= 0 && !this["isAwardArea" + _loc3_])
                  {
                     this["leavingsTime" + _loc3_].text = DiversityManager.getString("BoyUI","canLearn");
                     this["award" + _loc3_].visible = false;
                  }
                  else if(this["areaStopTime" + _loc3_] <= 0 && Boolean(this["isAwardArea" + _loc3_]))
                  {
                     this["leavingsTime" + _loc3_].text = DiversityManager.getString("BoyUI","canAward");
                     this["award" + _loc3_].visible = true;
                  }
               }
               else
               {
                  this["award" + _loc3_].visible = false;
               }
               _loc3_++;
            }
            if(_loc2_ > 0)
            {
               cmdAll.visible = true;
            }
            else
            {
               cmdAll.visible = false;
            }
         }
      }
      
      public function getDurationTimeInMS(param1:int, param2:int) : Number
      {
         var _loc3_:int = getTimer();
         return param1 - (_loc3_ - param2);
      }
      
      private function obf_N_X_2362() : int
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.learnEmptyArr)
         {
            if(_loc2_.currentFrame == 2)
            {
               _loc1_++;
            }
         }
         return _loc1_;
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
         remark.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("BoyUI","remark") + "</a>";
         DiversityManager.setTextField(txtDeyTitle,"BoyUI","cmdCollege");
         cmdAll.label = DiversityManager.getString("BoyUI","cmdAll");
         cmdOpen1.label = DiversityManager.getString("BoyUI","cmdOpen");
         cmdOpen2.label = DiversityManager.getString("BoyUI","cmdOpen");
         cmdOpen3.label = DiversityManager.getString("BoyUI","cmdOpen");
         cmdOpen4.label = DiversityManager.getString("BoyUI","cmdOpen");
         award1.label = DiversityManager.getString("BoyUI","canAward");
         award2.label = DiversityManager.getString("BoyUI","canAward");
         award3.label = DiversityManager.getString("BoyUI","canAward");
         award4.label = DiversityManager.getString("BoyUI","canAward");
      }
      
      public function showUI() : void
      {
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
   }
}

