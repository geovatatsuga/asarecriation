package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.farm.obf_0_1_N_478;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.obf_L_l_4100;
   import com.sunweb.game.utils.obf_l_y_733;
   import fl.events.ScrollEvent;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import playerUI.LocationTagUIMC;
   
   public class LocationTagUI extends LocationTagUIMC implements IPlayerUI
   {
      
      private var obf_Q_y_4570:Array;
      
      private var timeInv:TimeLimiter = new TimeLimiter(10000);
      
      public function LocationTagUI()
      {
         super();
         this.initDiversity();
         this.obf_Q_y_4570 = new Array();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         obf_a_Q_3902.minScrollPosition = 0;
         obf_a_Q_3902.maxScrollPosition = 120;
         obf_a_Q_3902.pageSize = 10;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"LocationTagUI","txtTitle");
         DiversityManager.setTextField(txtDeyTagName,"LocationTagUI","txtTagName");
         cmdSaveTag.label = DiversityManager.getString("LocationTagUI","cmdSaveTag");
         DiversityManager.setTextField(txtDeyTime,"LocationTagUI","txtTime",[0]);
      }
      
      private function addListener() : void
      {
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdSaveTag.addEventListener(MouseEvent.CLICK,this.obf_0_W_2320);
         txtLocation.addEventListener(TextEvent.LINK,this.onClickLink);
         obf_a_Q_3902.addEventListener(ScrollEvent.SCROLL,this.obf_6_a_3548);
         inputTagName.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_J_6_2780);
         inputTagName.addEventListener(KeyboardEvent.KEY_UP,this.obf_J_6_2780);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdSaveTag.removeEventListener(MouseEvent.CLICK,this.obf_0_W_2320);
         txtLocation.removeEventListener(TextEvent.LINK,this.onClickLink);
         obf_a_Q_3902.removeEventListener(ScrollEvent.SCROLL,this.obf_6_a_3548);
         inputTagName.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_J_6_2780);
         inputTagName.removeEventListener(KeyboardEvent.KEY_UP,this.obf_J_6_2780);
      }
      
      private function obf_J_6_2780(param1:Event) : void
      {
         param1.stopPropagation();
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
      
      private function obf_6_a_3548(param1:ScrollEvent) : void
      {
         DiversityManager.setTextField(txtDeyTime,"LocationTagUI","txtTime",[int(obf_a_Q_3902.scrollPosition)],true);
      }
      
      private function onClickLink(param1:TextEvent) : void
      {
         var _loc2_:Array = null;
         if(param1.text.indexOf("_DelTag") > -1)
         {
            _loc2_ = param1.text.split(",");
            if(_loc2_.length == 2)
            {
               this.obf_r_X_1519(int(_loc2_[1]));
            }
         }
         else
         {
            obf_7_6_4416.obf_2_F_3313(param1.text);
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(!this.timeInv.checkTimeout())
         {
            return;
         }
         this.obf_H_b_1624();
      }
      
      private function obf_H_b_1624() : void
      {
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc1_:String = "";
         var _loc2_:int = 0;
         while(_loc2_ < this.obf_Q_y_4570.length)
         {
            _loc3_ = this.obf_Q_y_4570[_loc2_];
            _loc4_ = "";
            if(Boolean(_loc3_.timeLimit) && (_loc3_.timeLimit as TimeLimiter).timelimit > 0)
            {
               if(_loc3_.timeLimit.timelimit - _loc3_.timeLimit.totalTimeInMS <= 0)
               {
                  _loc4_ = "(" + DiversityManager.getString("LocationTagUI","timeOut") + ")";
               }
               else
               {
                  _loc4_ = "(" + obf_l_y_733.getTimeStringMin(_loc3_.timeLimit.timelimit - _loc3_.timeLimit.totalTimeInMS) + ")";
               }
            }
            _loc1_ += _loc3_.tagName + "--" + _loc3_.tagLink + " " + _loc4_ + "\t<a href=\'event:_DelTag," + _loc2_ + "\'>" + DiversityManager.getString("LocationTagUI","cmdDeleteTag") + "×</a><br>";
            _loc2_++;
         }
         txtLocation.htmlText = _loc1_;
         obf_L_Q_3141.update();
      }
      
      private function obf_0_W_2320(param1:Event) : void
      {
         var _loc2_:Object = new Object();
         var _loc3_:String = inputTagName.text;
         var _loc4_:obf_0_1_N_478 = GameContext.localPlayer.getFarm();
         if(_loc4_ != null)
         {
            _loc2_.tagLink = obf_7_6_4416.getFarmLinkA(_loc4_.farmName + "(" + GameContext.currentMap.mapName + ")",GameContext.currentMap.mapId,_loc4_.id);
            if(obf_L_l_4100.isEmpty(_loc3_))
            {
               _loc3_ = _loc4_.farmName;
            }
         }
         else
         {
            _loc2_.tagLink = obf_7_6_4416.getMapLinkA(GameContext.currentMap.mapName,GameContext.currentMap.mapId,GameContext.localPlayer.rootPX,GameContext.localPlayer.rootPY);
            if(obf_L_l_4100.isEmpty(_loc3_))
            {
               _loc3_ = GameContext.currentMap.mapName;
            }
         }
         _loc2_.tagName = _loc3_;
         _loc2_.timeLimit = new TimeLimiter(int(obf_a_Q_3902.scrollPosition) * obf_l_y_733.obf_0___a_609);
         this.obf_Q_y_4570.push(_loc2_);
         inputTagName.text = "";
         this.obf_H_b_1624();
      }
      
      private function obf_r_X_1519(param1:int) : void
      {
         this.obf_Q_y_4570.splice(param1,1);
         this.obf_H_b_1624();
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.obf_H_b_1624();
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

