package com.sunweb.game.rpg.playerUI.systems
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.script.DynamicVars;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import playerUI.SystemScoreUIMC;
   
   public class obf_p_q_2942 extends SystemScoreUIMC implements IPlayerUI
   {
      
      private var showVars1:Array;
      
      private var showVars2:Array;
      
      private var showVarsTimeInv:TimeLimiter = new TimeLimiter(1000);
      
      public function obf_p_q_2942()
      {
         super();
         this.x = GameContext.gameStage.stageWidth / 2;
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
      }
      
      private function removeListener() : void
      {
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(!this.visible)
         {
            return;
         }
         if(this.showVarsTimeInv.checkTimeout() && Boolean(DynamicVars.systemVar))
         {
            if(this.showVars1)
            {
               txtSystemInfo1.text = "";
               for each(_loc2_ in this.showVars1)
               {
                  txtSystemInfo1.appendText(DiversityManager.getString("FamilyBoxUI","prompt_FamilyWarVar1",[DynamicVars.systemVar.getStrVar(_loc2_)]) + "\n");
               }
            }
            if(this.showVars2)
            {
               txtSystemInfo2.text = "";
               for each(_loc3_ in this.showVars2)
               {
                  if(DynamicVars.systemVar.getIntVar(_loc3_) != 0)
                  {
                     txtSystemInfo2.appendText(DiversityManager.getString("FamilyBoxUI","prompt_FamilyWarVar2",[DynamicVars.systemVar.getIntVar(_loc3_)]) + "\n");
                  }
                  else
                  {
                     txtSystemInfo2.appendText("\n");
                  }
               }
            }
         }
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:MouseEvent = new MouseEvent(MouseEvent.CLICK,true,false,0,0,null,param1.ctrlKey,param1.altKey,param1.shiftKey);
         var _loc3_:Point = GameContext.currentMap.globalToLocal(new Point(param1.stageX,param1.stageY));
         _loc2_.localX = _loc3_.x;
         _loc2_.localY = _loc3_.y;
         GameContext.currentMap.dispatchEvent(_loc2_);
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth / 2;
      }
      
      public function setShowStrVars(param1:Array, param2:String = "") : void
      {
         this.showVars1 = param1;
         if(!this.contains(txtSystemInfo1))
         {
            this.addChild(txtSystemInfo1);
         }
         if(!obf_L_l_4100.isEmpty(param2))
         {
            txtSystemInfoTitle.text = param2;
         }
         if(!this.contains(txtSystemInfoTitle))
         {
            this.addChild(txtSystemInfoTitle);
         }
      }
      
      public function setShowIntVars(param1:Array, param2:String = "") : void
      {
         this.showVars2 = param1;
         if(!this.contains(txtSystemInfo2))
         {
            this.addChild(txtSystemInfo2);
         }
         if(!obf_L_l_4100.isEmpty(param2))
         {
            txtSystemInfoTitle.text = param2;
         }
         if(!this.contains(txtSystemInfoTitle))
         {
            this.addChild(txtSystemInfoTitle);
         }
      }
      
      public function closeSystemVars() : void
      {
         this.showVars1 = null;
         this.showVars2 = null;
         txtSystemInfo1.text = "";
         txtSystemInfo2.text = "";
         txtSystemInfoTitle.text = "";
         if(this.contains(txtSystemInfo1))
         {
            this.removeChild(txtSystemInfo1);
         }
         if(this.contains(txtSystemInfo2))
         {
            this.removeChild(txtSystemInfo2);
         }
         if(this.contains(txtSystemInfoTitle))
         {
            this.removeChild(txtSystemInfoTitle);
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

