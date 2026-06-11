package com.sunweb.game.rpg.playerUI
{
   import obf_g_A_3629.ChatDecoder;
   import com.adobe.serialization.json.JSON;
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import fl.events.ScrollEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import playerUI.DaysPromptUIMC;
   
   public class DaysActPromptUI extends DaysPromptUIMC implements IPlayerUI
   {
      
      private var lineSprite:Sprite = new Sprite();
      
      public function DaysActPromptUI()
      {
         super();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         scrollDaysAct.pageSize = scrollDaysAct.height;
         this.initDiversity();
         this.addListener();
         this.showContent();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"DaysActPromptUI","txtDeyTitle");
         DiversityManager.setTextField(txtDeyName,"DaysActPromptUI","txtDeyName");
         DiversityManager.setTextField(txtDeyTimes,"DaysActPromptUI","txtDeyTimes");
         DiversityManager.setTextField(txtDeyLevel,"DaysActPromptUI","txtDeyLevel");
         DiversityManager.setTextField(txtDeyRemark,"DaysActPromptUI","txtDeyRemark");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         scrollDaysAct.addEventListener(ScrollEvent.SCROLL,this.obf_3_S_1490);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         scrollDaysAct.removeEventListener(ScrollEvent.SCROLL,this.obf_3_S_1490);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function onClickLink(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function obf_3_S_1490(param1:ScrollEvent) : void
      {
         daysActPoint.scrollRect = new Rectangle(0,param1.position,scrollDaysAct.x - daysActPoint.x,scrollDaysAct.height);
      }
      
      public function showContent() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc5_:TextField = null;
         var _loc6_:TextField = null;
         var _loc7_:TextField = null;
         var _loc8_:TextField = null;
         this.clearContent();
         this.lineSprite.graphics.clear();
         daysActPoint.addChild(this.lineSprite);
         daysActPoint.scrollRect = new Rectangle(0,0,scrollDaysAct.x - daysActPoint.x,scrollDaysAct.height);
         if(obf_L_l_4100.isEmpty(ResourceManager.instance.getText("idp")))
         {
            return;
         }
         var _loc1_:Array = com.adobe.serialization.json.JSON.decode(ResourceManager.instance.getText("idp"));
         this.lineSprite.graphics.lineStyle(1,10066329);
         for each(_loc3_ in _loc1_)
         {
            this.lineSprite.graphics.moveTo(0,_loc2_);
            this.lineSprite.graphics.lineTo(daysActPoint.scrollRect.width,_loc2_);
            _loc5_ = this.getNewTextField();
            _loc5_.x = txtDeyName.x - daysActPoint.x;
            _loc5_.width = txtDeyName.width;
            _loc5_.y = _loc2_;
            _loc5_.htmlText = JSONUtil.getStr(_loc3_,["name"]);
            daysActPoint.addChild(_loc5_);
            _loc4_ = _loc5_.height;
            _loc6_ = this.getNewTextField();
            _loc6_.x = txtDeyTimes.x - daysActPoint.x;
            _loc6_.width = txtDeyTimes.width;
            _loc6_.y = _loc2_;
            _loc6_.htmlText = JSONUtil.getStr(_loc3_,["timeLimit"]);
            daysActPoint.addChild(_loc6_);
            if(_loc6_.height > _loc4_)
            {
               _loc4_ = _loc6_.height;
            }
            _loc7_ = this.getNewTextField();
            _loc7_.x = txtDeyLevel.x - daysActPoint.x;
            _loc7_.width = txtDeyLevel.width;
            _loc7_.y = _loc2_;
            _loc7_.htmlText = JSONUtil.getStr(_loc3_,["levelLimit"]);
            daysActPoint.addChild(_loc7_);
            if(_loc7_.height > _loc4_)
            {
               _loc4_ = _loc7_.height;
            }
            _loc8_ = this.getNewTextField();
            _loc8_.x = txtDeyRemark.x - daysActPoint.x;
            _loc8_.width = txtDeyRemark.width;
            _loc8_.y = _loc2_;
            _loc8_.htmlText = ChatDecoder.decode(JSONUtil.getStr(_loc3_,["detail"]));
            _loc8_.addEventListener(TextEvent.LINK,this.onClickLink);
            daysActPoint.addChild(_loc8_);
            if(_loc8_.height > _loc4_)
            {
               _loc4_ = _loc8_.height;
            }
            _loc2_ += _loc4_;
         }
         this.lineSprite.graphics.endFill();
         scrollDaysAct.visible = false;
         if(_loc2_ > scrollDaysAct.height)
         {
            scrollDaysAct.maxScrollPosition = _loc2_ - scrollDaysAct.height;
            scrollDaysAct.visible = true;
         }
      }
      
      public function clearContent() : void
      {
         var thisTxt:TextField = null;
         if(daysActPoint.contains(this.lineSprite))
         {
            daysActPoint.removeChild(this.lineSprite);
         }
         while(daysActPoint.numChildren > 0)
         {
            thisTxt = daysActPoint.getChildAt(0) as TextField;
            if(thisTxt)
            {
               try
               {
                  thisTxt.removeEventListener(TextEvent.LINK,this.onClickLink);
               }
               catch(e:Error)
               {
               }
            }
            daysActPoint.removeChildAt(0);
         }
      }
      
      private function getNewTextField() : TextField
      {
         var _loc1_:TextField = new TextField();
         _loc1_.selectable = false;
         _loc1_.textColor = 16777215;
         _loc1_.autoSize = TextFieldAutoSize.LEFT;
         _loc1_.wordWrap = true;
         return _loc1_;
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
         this.clearContent();
      }
   }
}

