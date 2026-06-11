package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.onlineBonus.obf_v_1_1352;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.MacroScript;
   import com.sunweb.game.utils.obf_l_y_733;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.OnlineBonusUIMC;
   
   public class OnlineBonusUI extends OnlineBonusUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      private var itemShow:Array;
      
      public function OnlineBonusUI()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         txtTime.visible = false;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"OnlineBonusUI","txtTitle");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdSubmit.addEventListener(MouseEvent.CLICK,this.obf_2_t_2264);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdSubmit.removeEventListener(MouseEvent.CLICK,this.obf_2_t_2264);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
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
      
      private function obf_2_t_2264(param1:Event) : void
      {
         obf_v_1_1352.obf_M_S_2137();
         obf_K_e_3075.closeUI(this);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(!this.visible || !obf_v_1_1352.obf_z_D_1932)
         {
            return;
         }
         if(obf_v_1_1352.obf_z_D_1932.totalTimeInMS < obf_v_1_1352.obf_z_D_1932.timelimit)
         {
            txtTime.text = obf_l_y_733.getTimeStringHHMMSS(obf_v_1_1352.obf_z_D_1932.timelimit - obf_v_1_1352.obf_z_D_1932.totalTimeInMS);
         }
         else
         {
            DiversityManager.setTextField(txtTime,"OnlineBonusUI","canGetBonus",null,true);
         }
      }
      
      public function showOnlineBonus() : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:DisplayObject = null;
         var _loc1_:Object = obf_v_1_1352.obf_0_G_4126();
         if(!_loc1_)
         {
            return;
         }
         this.obf_W_S_2563();
         var _loc2_:Array = new Array();
         for(_loc3_ in _loc1_.macro)
         {
            _loc2_ = _loc2_.concat(MacroScript.getMacroDisplay(_loc3_,_loc1_.macro[_loc3_]));
         }
         _loc4_ = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc2_.length)
         {
            _loc7_ = _loc2_[_loc6_];
            if(_loc7_ is ItemShowBoxUI)
            {
               (_loc7_ as ItemShowBoxUI).dockParentUI(this,this.bags);
            }
            _loc7_.x = (_loc6_ + 2) % 2 * 140;
            _loc7_.y = _loc4_;
            if(_loc7_.y + _loc7_.height > _loc5_)
            {
               _loc5_ = _loc7_.y + _loc7_.height;
            }
            if((_loc6_ + 2) % 2 == 1 || _loc6_ == _loc2_.length - 1)
            {
               _loc4_ += _loc5_;
            }
            bonusPoint.addChild(_loc7_);
            _loc6_++;
         }
      }
      
      private function obf_W_S_2563() : void
      {
         var _loc1_:DisplayObject = null;
         while(bonusPoint.numChildren > 0)
         {
            _loc1_ = bonusPoint.getChildAt(0);
            if(_loc1_ is ItemShowBoxUI)
            {
               (_loc1_ as ItemShowBoxUI).destroy();
            }
            bonusPoint.removeChildAt(0);
         }
         this.bags = new Array();
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
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this.bags = null;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
   }
}

