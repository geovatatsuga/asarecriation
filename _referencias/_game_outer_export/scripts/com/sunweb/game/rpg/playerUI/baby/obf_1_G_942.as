package com.sunweb.game.rpg.playerUI.baby
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.baby.StudyType;
   import com.sunweb.game.rpg.baby.obf_s_1265;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.obf_9_V_1635;
   import com.sunweb.game.utils.obf_l_y_733;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import flash.utils.getTimer;
   import playerUI.NurserySchoolUIMC;
   
   public class obf_1_G_942 extends NurserySchoolUIMC implements IPlayerUI
   {
      
      private var obf_q_L_4310:TimeLimiter;
      
      private var stopTime:int;
      
      private var isAward:Boolean;
      
      private var obf_n_2_1416:int = 0;
      
      private var obf_j_B_1080:int;
      
      private var obf_7_O_836:TimeLimiter = new TimeLimiter(200);
      
      public function obf_1_G_942()
      {
         super();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         titleBox.mouseEnabled = false;
         txtDeyTitle.mouseEnabled = false;
         this.initDiversity();
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.underline = true;
         remark.setTextFormat(_loc1_);
         this.addListener();
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         bgBox.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdLearn.addEventListener(MouseEvent.CLICK,this.obf_W_8_1496);
         cmdAward.addEventListener(MouseEvent.CLICK,this.obf_x_1085);
         obf_K_e_3075.addUIMouseToolTip(remark,"remarkNurserySchool");
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         bgBox.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdLearn.removeEventListener(MouseEvent.CLICK,this.obf_W_8_1496);
         cmdAward.removeEventListener(MouseEvent.CLICK,this.obf_x_1085);
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
      
      private function obf_W_8_1496(param1:Event) : void
      {
         obf_s_1265.sendBabyStudyRequest(StudyType.KINDER,-1);
      }
      
      private function obf_x_1085(param1:Event) : void
      {
         obf_s_1265.sendBabyStudyOverRequest(StudyType.KINDER,-1);
      }
      
      public function getStopTime(param1:Object) : void
      {
         if(param1[StudyType.KINDER] >= 0)
         {
            this.isAward = true;
            this.obf_n_2_1416 = param1[StudyType.KINDER] * 1000;
            this.obf_j_B_1080 = getTimer();
         }
         else
         {
            this.isAward = false;
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(this.obf_7_O_836.checkTimeout())
         {
            if(this.obf_n_2_1416 > 0 && this.isAward)
            {
               _loc2_ = this.getDurationTimeInMS(this.obf_n_2_1416,this.obf_j_B_1080);
               if(_loc2_ <= 0)
               {
                  cmdLearn.mouseEnabled = true;
                  cmdLearn.filters = [];
                  _loc2_ = 0;
                  this.obf_n_2_1416 = 0;
                  cmdAward.visible = true;
                  leavingsTime.text = DiversityManager.getString("BoyUI","canAward");
               }
               else
               {
                  cmdLearn.mouseEnabled = false;
                  cmdLearn.filters = [obf_9_V_1635.getGrayFilter()];
                  leavingsTime.text = obf_l_y_733.getTimeStringHHMMSS(_loc2_);
                  cmdAward.visible = false;
               }
            }
            else if(this.obf_n_2_1416 <= 0 && !this.isAward)
            {
               cmdLearn.mouseEnabled = true;
               cmdLearn.filters = [];
               leavingsTime.text = DiversityManager.getString("BoyUI","canLearn");
               cmdAward.visible = false;
            }
            else if(this.obf_n_2_1416 <= 0 && this.isAward)
            {
               cmdLearn.mouseEnabled = false;
               cmdLearn.filters = [obf_9_V_1635.getGrayFilter()];
               leavingsTime.text = DiversityManager.getString("BoyUI","canAward");
               cmdAward.visible = true;
            }
         }
      }
      
      public function getDurationTimeInMS(param1:int, param2:int) : Number
      {
         var _loc3_:int = getTimer();
         return param1 - (_loc3_ - param2);
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
         DiversityManager.setTextField(txtDeyTitle,"BoyUI","cmdNurserySchool");
         cmdAward.label = DiversityManager.getString("BoyUI","cmdAward");
         remark.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("BoyUI","remark") + "</a>";
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

