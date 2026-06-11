package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.obf_l_y_733;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import playerUI.PisUIMC;
   
   public class obf_s_A_2037 extends PisUIMC implements IPlayerUI
   {
      
      private var obf_V_j_3761:int;
      
      private var obf_0_2_v_491:int;
      
      private var checkTime:int;
      
      private var obf_Q_B_4554:Boolean;
      
      public function obf_s_A_2037()
      {
         super();
         txtPisPrompt.mouseEnabled = false;
         this.visible = false;
         this.onResize(null);
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
      }
      
      private function addListener() : void
      {
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.addEventListener(MouseEvent.CLICK,this.onMouseClick);
         inputIDCard.addEventListener(MouseEvent.CLICK,this.obf_0_6_3893);
      }
      
      private function removeListener() : void
      {
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
         inputIDCard.removeEventListener(MouseEvent.CLICK,this.obf_0_6_3893);
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth - 300;
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         if(!GameContext.currentMap || param1.target == inputIDCard)
         {
            return;
         }
         var _loc2_:MouseEvent = new MouseEvent(MouseEvent.CLICK,true,false,0,0,null,param1.ctrlKey,param1.altKey,param1.shiftKey);
         var _loc3_:Point = GameContext.currentMap.globalToLocal(new Point(param1.stageX,param1.stageY));
         _loc2_.localX = _loc3_.x;
         _loc2_.localY = _loc3_.y;
         GameContext.currentMap.dispatchEvent(_loc2_);
      }
      
      private function obf_0_6_3893(param1:MouseEvent) : void
      {
         if(obf_C_o_3363.openActionURL("PisPage"))
         {
            WindowManager.showMessageBox("obf_____________________3。");
         }
      }
      
      public function setPisPrompt(param1:int, param2:int) : void
      {
         this.obf_V_j_3761 = param1;
         this.obf_0_2_v_491 = param2;
         this.checkTime = getTimer();
         if(param1 == 0)
         {
            txtPisPrompt.text = "obf_______________________2。";
         }
         else if(param1 == 1)
         {
            txtPisPrompt.text = "您累计在线时间已满3小时obf________________6。\obf_n__________5_0_16%";
         }
         else if(param1 == 2)
         {
            txtPisPrompt.text = "obf_____________________________________________________1直到您的累计下线时间满5小时后obf________556。";
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(!this.visible)
         {
            return;
         }
         if(!this.obf_Q_B_4554 && this.obf_V_j_3761 == 0 && this.obf_0_2_v_491 * 1000 + (getTimer() - this.checkTime) > obf_l_y_733.MS_PER_HOUR)
         {
            txtPisPrompt.text = "您累计在线时间已满1小时。";
            this.obf_Q_B_4554 = true;
         }
      }
      
      public function get mouseOn() : Boolean
      {
         return false;
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
   }
}

