package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.utils.obf_9_V_1635;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import playerUI.TipInfoUIMC;
   
   public class GameTipUI extends TipInfoUIMC implements IPlayerUI
   {
      
      public static var rowSize:int = 19;
      
      private var _tipName:String;
      
      public var clickToClose:Boolean;
      
      private var obf_I_o_3118:int;
      
      public function GameTipUI(param1:String, param2:Boolean = false)
      {
         super();
         this._tipName = param1;
         this.clickToClose = param2;
         contentMC.filters = [new GlowFilter(0,1,2,2,1000)];
         this.addListener();
         contentMC.doubleClickEnabled = true;
         this.doubleClickEnabled = true;
      }
      
      public function get tipName() : String
      {
         return this._tipName;
      }
      
      public function get maxTipTextWidth() : int
      {
         return this.obf_I_o_3118;
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
         this.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      public function addTipInfo(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:TextField = null;
         _loc4_ = obf_9_V_1635.getNewTextField();
         _loc4_.mouseEnabled = false;
         _loc4_.autoSize = TextFieldAutoSize.LEFT;
         _loc4_.multiline = true;
         _loc4_.wordWrap = true;
         _loc4_.width = param2;
         _loc4_.htmlText = "<FONT COLOR=\'#FFFFFF\'>" + param1 + "</FONT>";
         this.obf_I_o_3118 = Math.max(this.obf_I_o_3118,param2);
         param3--;
         if(param3 < 0)
         {
            param3 = 0;
         }
         _loc4_.y = param3 * rowSize;
         contentMC.addChild(_loc4_);
         this.updateBgBox();
      }
      
      public function obf_l_r_2153(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:TextFormat = new TextFormat();
         _loc4_.align = "center";
         var _loc5_:TextField = obf_9_V_1635.getNewTextField();
         _loc5_.defaultTextFormat = _loc4_;
         _loc5_.mouseEnabled = false;
         _loc5_.autoSize = TextFieldAutoSize.CENTER;
         _loc5_.multiline = true;
         _loc5_.wordWrap = true;
         _loc5_.width = param2;
         _loc5_.htmlText = "<FONT COLOR=\'#FFFFFF\'>" + param1 + "</FONT>";
         this.obf_I_o_3118 = Math.max(this.obf_I_o_3118,param2);
         param3--;
         if(param3 < 0)
         {
            param3 = 0;
         }
         _loc5_.y = param3 * rowSize;
         contentMC.addChild(_loc5_);
         this.updateBgBox();
      }
      
      public function addTipObject(param1:DisplayObject, param2:int) : void
      {
         param1.y = param2 * rowSize - (param1.y + param1.getBounds(param1).y);
         contentMC.addChild(param1);
         this.updateBgBox();
      }
      
      public function updateBgBox() : void
      {
         bgBox.width = contentMC.width + contentMC.x + 12;
         bgBox.height = contentMC.height + contentMC.y + 12;
      }
      
      public function get maxRow() : int
      {
         var _loc1_:int = contentMC.height / rowSize;
         if(contentMC.height % rowSize > 0)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      private function onClick(param1:Event) : void
      {
         if(this.clickToClose)
         {
            GameTipManager.closeTip(this._tipName);
         }
      }
      
      public function get mouseOn() : Boolean
      {
         return false;
      }
      
      public function showUI() : void
      {
         this.visible = false;
      }
      
      public function closeUI() : void
      {
         this.visible = true;
      }
      
      public function destroy() : void
      {
         while(contentMC.numChildren > 0)
         {
            contentMC.removeChildAt(0);
         }
         this.removeListener();
      }
   }
}

