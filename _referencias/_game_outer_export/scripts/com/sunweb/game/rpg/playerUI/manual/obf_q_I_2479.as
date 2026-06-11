package com.sunweb.game.rpg.playerUI.manual
{
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.utils.obf_9_V_1635;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.manualItemBoxMC;
   
   public class obf_q_I_2479 extends manualItemBoxMC
   {
      
      public static const obf_U_A_3305:String = "clickmanual";
      
      public var _code:String;
      
      public var obf_i_U_1224:String;
      
      public var obf_s_w_989:String;
      
      public var _name:String;
      
      public var obf_w_B_3992:String;
      
      public var _rank:int;
      
      public var obf_4_3_816:int;
      
      public var obf_0_c_2225:int;
      
      public var _absorbItems:Object;
      
      public var _baseAttr:Object;
      
      public var _absorbTimes:int;
      
      public var isRavel:Boolean = false;
      
      private var icon:DisplayObject;
      
      private var _qualityMask:DisplayObject;
      
      public function obf_q_I_2479(param1:String)
      {
         super();
         this.obf_i_U_1224 = param1;
         this.icon = ResourceManager.instance.getDisplayObject(param1);
         if(this.icon)
         {
            this.addChild(this.icon);
         }
         this.setGray(this.isRavel);
         this.obf_q_N_2525();
      }
      
      private function obf_q_N_2525() : void
      {
         this.addEventListener(MouseEvent.CLICK,this.onClick);
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      private function removerListem() : void
      {
         this.removeEventListener(MouseEvent.CLICK,this.onClick);
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      public function setGray(param1:Boolean) : void
      {
         if(this.icon)
         {
            if(param1)
            {
               this.icon.filters = [];
            }
            else
            {
               this.icon.filters = [obf_9_V_1635.getGrayFilter()];
            }
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         dispatchEvent(new Event(obf_U_A_3305));
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("manual");
         _loc2_.addTipInfo(this.obf_w_B_3992,200,0);
         GameTipManager.showTip(_loc2_);
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("manual");
      }
      
      public function set rankMask(param1:DisplayObject) : void
      {
         if(!param1)
         {
            return;
         }
         if(Boolean(this._qualityMask) && this.contains(this._qualityMask))
         {
            this.removeChild(this._qualityMask);
         }
         this._qualityMask = param1;
         if(this._qualityMask is InteractiveObject)
         {
            (this._qualityMask as InteractiveObject).mouseEnabled = false;
         }
         this.addChild(this._qualityMask);
         this._qualityMask.y = 1;
      }
      
      public function destroy() : void
      {
         this.removerListem();
      }
      
      override public function get width() : Number
      {
         return 38;
      }
      
      override public function get height() : Number
      {
         return 38;
      }
   }
}

