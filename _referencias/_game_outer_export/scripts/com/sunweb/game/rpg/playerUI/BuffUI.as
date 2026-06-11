package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.buff.BuffInfo;
   import com.sunweb.game.rpg.buff.BuffManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class BuffUI extends Sprite implements IPlayerUI
   {
      
      private var allBuff:Object;
      
      private var buffList:Array;
      
      private var _sortBuff:Boolean;
      
      private var obf_n_5_3174:Boolean;
      
      private var obf_T_q_1128:TimeLimiter = new TimeLimiter(1000);
      
      public function BuffUI(param1:Boolean = false)
      {
         super();
         this.allBuff = new Object();
         this.buffList = new Array();
         this.obf_n_5_3174 = param1;
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
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.obf_T_q_1128.checkTimeout())
         {
            this.doSortBuff();
         }
      }
      
      public function obf_z_o_2257(param1:Array) : void
      {
         var _loc2_:BuffInfo = null;
         for each(_loc2_ in param1)
         {
            this.addBuff(_loc2_);
         }
      }
      
      public function addBuff(param1:BuffInfo) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:Object = BuffManager.getBuffConfigById(param1.buffId);
         if(!_loc2_ || !JSONUtil.getBoolean(_loc2_,["enableDisplay"],true))
         {
            return;
         }
         var _loc3_:int = this.width;
         var _loc4_:BuffIconUI = this.getChildByName(param1.buffId + "") as BuffIconUI;
         if(_loc4_)
         {
            _loc3_ = _loc4_.x;
            _loc4_.destroy();
            this.removeChild(_loc4_);
         }
         var _loc5_:BuffIconUI = new BuffIconUI(param1,this.obf_n_5_3174);
         _loc5_.name = param1.buffId + "";
         _loc5_.x = _loc3_;
         this.addChild(_loc5_);
         this.allBuff[param1.buffId] = _loc5_;
         this.buffList.push(_loc5_);
      }
      
      public function removeBuff(param1:int) : void
      {
         var _loc2_:BuffIconUI = this.allBuff[param1 + ""];
         if(!_loc2_)
         {
            return;
         }
         _loc2_.destroy();
         if(_loc2_.parent == this)
         {
            this.removeChild(_loc2_);
         }
         delete this.allBuff[param1 + ""];
         this.buffList.splice(this.buffList.indexOf(_loc2_),1);
         this.sortBuff();
      }
      
      public function sortBuff() : void
      {
         this._sortBuff = true;
      }
      
      private function doSortBuff() : void
      {
         var _loc1_:BuffIconUI = null;
         if(!this._sortBuff)
         {
            return;
         }
         while(numChildren > 0)
         {
            this.removeChildAt(0);
         }
         for each(_loc1_ in this.buffList)
         {
            _loc1_.x = this.width;
            this.addChild(_loc1_);
         }
         this._sortBuff = false;
      }
      
      public function clearAllBuff() : void
      {
         var _loc1_:BuffIconUI = null;
         for each(_loc1_ in this.buffList)
         {
            _loc1_.destroy();
            if(_loc1_.parent == this)
            {
               this.removeChild(_loc1_);
            }
         }
         this.allBuff = new Object();
         this.buffList = new Array();
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
         this.clearAllBuff();
      }
   }
}

