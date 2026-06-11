package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.netRole.obf_X_L_985;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.util.TimeLimiter;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.BitmapFilterType;
   import flash.filters.GradientGlowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class PlayerAttrChangeUI extends Sprite implements IPlayerUI
   {
      
      private var attrText:TextField;
      
      private var timeLimiter:TimeLimiter;
      
      private var timeLimiter2:TimeLimiter;
      
      private var spaceTime:TimeLimiter = new TimeLimiter(200);
      
      private var isStartAlpha:Boolean;
      
      public function PlayerAttrChangeUI()
      {
         super();
         this.initDiversity();
         this.cacheAsBitmap = true;
         this.visible = false;
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.align = TextFormatAlign.CENTER;
         _loc1_.font = "SimSun";
         this.attrText = new TextField();
         this.attrText.defaultTextFormat = _loc1_;
         this.attrText.mouseEnabled = false;
         this.attrText.multiline = true;
         var _loc2_:Array = [0,0];
         var _loc3_:Array = [0,1];
         var _loc4_:Array = [0,63,126,255];
         this.attrText.filters = [new GradientGlowFilter(0,45,_loc2_,_loc3_,_loc4_,1.5,1.5,1,BitmapFilterQuality.HIGH,BitmapFilterType.OUTER,false)];
         this.attrText.width = 300;
         this.attrText.height = 300;
         this.addChild(this.attrText);
         this.x = GameContext.gameStage.stageWidth / 2 - 150;
         this.y = 80;
         this.obf_x_v_2806();
      }
      
      private function obf_x_v_2806() : void
      {
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function removeListen() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.removeEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(!this.spaceTime.checkTimeout())
         {
            return;
         }
         if(Boolean(this.timeLimiter) && this.timeLimiter.checkTimeout())
         {
            this.timeLimiter = null;
            this.attrText.text = "";
            this.isStartAlpha = false;
            obf_K_e_3075.closeUI(this);
         }
         if(Boolean(this.timeLimiter2) && this.timeLimiter2.checkTimeout())
         {
            this.isStartAlpha = true;
            this.timeLimiter2 = null;
         }
         if(this.isStartAlpha)
         {
            this.attrText.alpha -= 0.2;
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(!GameContext.currentMap)
         {
            return;
         }
         var _loc2_:MouseEvent = new MouseEvent(MouseEvent.CLICK,true,false,0,0,null,param1.ctrlKey,param1.altKey,param1.shiftKey);
         var _loc3_:Point = GameContext.currentMap.globalToLocal(new Point(param1.stageX,param1.stageY));
         _loc2_.localX = _loc3_.x;
         _loc2_.localY = _loc3_.y;
         GameContext.currentMap.dispatchEvent(_loc2_);
      }
      
      public function showAttrText(param1:Object) : void
      {
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         if(!param1)
         {
            return;
         }
         var _loc2_:String = "";
         this.attrText.alpha = 1;
         this.isStartAlpha = false;
         for(_loc3_ in param1)
         {
            _loc4_ = 65280;
            if(param1[_loc3_] < 0)
            {
               _loc4_ = 16711680;
            }
            _loc5_ = "";
            if(obf_X_L_985.playerAttrIsPercentage[_loc3_])
            {
               _loc5_ = Math.round(param1[_loc3_] * 100) + "%";
            }
            else
            {
               _loc5_ = param1[_loc3_];
            }
            if(param1[_loc3_] > 0)
            {
               _loc5_ = "+" + _loc5_;
            }
            _loc2_ += "<FONT COLOR=\'#" + _loc4_.toString(16) + "\'>" + DiversityManager.getString("PlayerAttrChangeUI",_loc3_) + _loc5_ + "</FONT><BR>";
         }
         this.attrText.htmlText = _loc2_;
         this.timeLimiter = new TimeLimiter(6000);
         this.timeLimiter2 = new TimeLimiter(5000);
         obf_K_e_3075.showUI(this);
      }
      
      public function get mouseOn() : Boolean
      {
         return false;
      }
      
      public function get uiIndex() : int
      {
         return 0;
      }
      
      public function initDiversity() : void
      {
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
         this.removeListen();
      }
   }
}

