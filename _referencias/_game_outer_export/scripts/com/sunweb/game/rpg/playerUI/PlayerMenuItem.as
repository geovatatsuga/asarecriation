package com.sunweb.game.rpg.playerUI
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.MenuItemUIMC;
   
   public class PlayerMenuItem extends MenuItemUIMC
   {
      
      public var callBackPar:Array;
      
      public var callBackFun:Function;
      
      private var _itemEnabled:Boolean = true;
      
      public function PlayerMenuItem(param1:String, param2:Function, param3:Array)
      {
         super();
         this.gotoAndStop(1);
         txtItemLabel.text = param1;
         this.callBackFun = param2;
         this.callBackPar = param3;
         this.addListener();
      }
      
      public function set itemEnabled(param1:Boolean) : void
      {
         if(param1)
         {
            txtItemLabel.textColor = 16777215;
         }
         else
         {
            txtItemLabel.textColor = 10066329;
         }
         this._itemEnabled = param1;
      }
      
      public function get itemEnabled() : Boolean
      {
         return this._itemEnabled;
      }
      
      private function addListener() : void
      {
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      private function onMouseOver(param1:Event) : void
      {
         if(this._itemEnabled)
         {
            this.gotoAndStop(2);
         }
      }
      
      private function onMouseOut(param1:Event) : void
      {
         this.gotoAndStop(1);
      }
      
      public function doAction() : void
      {
         if(this.callBackFun != null && this.enabled)
         {
            if(this.callBackPar != null)
            {
               this.callBackFun.apply(null,this.callBackPar);
            }
            else
            {
               this.callBackFun.apply(null);
            }
         }
      }
      
      public function destroy() : void
      {
         this.callBackFun = null;
         this.callBackPar = null;
         this.removeListener();
      }
   }
}

