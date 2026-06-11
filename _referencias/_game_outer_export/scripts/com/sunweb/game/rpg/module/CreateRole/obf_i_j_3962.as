package com.sunweb.game.rpg.module.CreateRole
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import playerUI.HeadSelectBox;
   
   public class obf_i_j_3962 extends HeadSelectBox
   {
      
      private var obf_R_y_4593:Boolean;
      
      public var headCode:int;
      
      public var sex:int;
      
      public function obf_i_j_3962(param1:DisplayObject)
      {
         super();
         selectBox.mouseEnabled = false;
         selectBox.visible = false;
         pointHead.addChild(param1);
         this.isOn = false;
         this.addListener();
      }
      
      public function set isOn(param1:Boolean) : void
      {
         var _loc2_:Array = null;
         this.obf_R_y_4593 = param1;
         if(!param1)
         {
            _loc2_ = [0.3,0,0,0,0,0,0.3,0,0,0,0,0,0.3,0,0,0,0,0,1,0];
            pointHead.filters = [new ColorMatrixFilter(_loc2_)];
         }
         else
         {
            pointHead.filters = null;
         }
      }
      
      public function get isOn() : Boolean
      {
         return this.obf_R_y_4593;
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
         selectBox.visible = true;
      }
      
      private function onMouseOut(param1:Event) : void
      {
         selectBox.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

