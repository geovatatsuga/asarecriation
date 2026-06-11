package com.sunweb.game.rpg.module
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.script.DynamicVars;
   import com.sunweb.game.rpg.worldZone.command.gm.GM_CommandRequest;
   import fl.events.ComponentEvent;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import mmorpg.GMControlUI;
   
   public class GMControlBox extends GMControlUI implements IPlayerUI
   {
      
      public function GMControlBox()
      {
         super();
         labelScroll.scrollTarget = txtLabel;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.initDiversity();
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         txtDeyTitle.mouseEnabled = false;
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         txtInput.addEventListener(KeyboardEvent.KEY_UP,this.onBreakKey);
         txtInput.addEventListener(KeyboardEvent.KEY_DOWN,this.onBreakKey);
         txtInput.addEventListener(ComponentEvent.ENTER,this.onEnterCommand);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         txtInput.removeEventListener(KeyboardEvent.KEY_UP,this.onBreakKey);
         txtInput.removeEventListener(KeyboardEvent.KEY_DOWN,this.onBreakKey);
         txtInput.removeEventListener(ComponentEvent.ENTER,this.onEnterCommand);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function onBreakKey(param1:KeyboardEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function onClose(param1:Event) : void
      {
         this.visible = !this.visible;
      }
      
      public function appendLabelText(param1:String) : void
      {
         txtLabel.appendText(param1);
         txtLabel.scrollV = txtLabel.maxScrollV;
         labelScroll.update();
      }
      
      private function onEnterCommand(param1:Event) : void
      {
         if(txtInput.text == "")
         {
            return;
         }
         if(this.obf_0_9_T_55(txtInput.text))
         {
            txtInput.text = "";
            return;
         }
         this.appendLabelText("> " + txtInput.text + "\n");
         this.sendGMCommand(txtInput.text);
         txtInput.text = "";
      }
      
      private function obf_0_9_T_55(param1:String) : Boolean
      {
         var _loc3_:DynamicVars = null;
         var _loc2_:String = "";
         if(param1.toLocaleUpperCase() == "SHOWSYSVAR")
         {
            _loc3_ = DynamicVars.systemVar;
         }
         else if(param1.toLocaleUpperCase() == "SHOWMAPVAR")
         {
            _loc3_ = DynamicVars.mapVar;
         }
         else if(param1.toLocaleUpperCase() == "SHOWFAMILYVAR")
         {
            _loc3_ = DynamicVars.familyVar;
         }
         else if(param1.toLocaleUpperCase() == "SHOWPLAYERVAR")
         {
            _loc3_ = GameContext.localPlayer.dynamicVars;
         }
         else if(param1.toLocaleUpperCase() == "SHOWMATEVAR")
         {
            _loc3_ = GameContext.localPlayer.fullInfo.mateVars;
         }
         if(_loc3_)
         {
            _loc2_ = param1 + "============\n" + _loc3_.getVarsShow() + "\n\n";
         }
         if(_loc2_ != "")
         {
            this.appendLabelText(_loc2_);
            return true;
         }
         return false;
      }
      
      public function sendGMCommand(param1:String) : void
      {
         if(!GameContext.localPlayer.fullInfo.isGM)
         {
            return;
         }
         var _loc2_:GM_CommandRequest = new GM_CommandRequest();
         _loc2_.cmdLine = param1;
         GameContext.worldClient.sendCommand(_loc2_);
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

