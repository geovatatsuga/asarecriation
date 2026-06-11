package com.sunweb.game.rpg.playerUI.angel
{
   import com.sunweb.game.rpg.angel.obf_O_7_1100;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.WindowManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.AngelCeilUIMC;
   
   public class obf_K_q_2694 extends AngelCeilUIMC
   {
      
      private var _iconBag:IconItemBag;
      
      private var config:Object;
      
      public function obf_K_q_2694(param1:IIconItemUI)
      {
         super();
         this.initDiversity();
         this.config = new Object();
         this._iconBag = new IconItemBag(iconBar,param1,0);
         this._iconBag.addValidType(GameItemType.ALL);
         this._iconBag.showInfoTip = true;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         cmdCall.label = DiversityManager.getString("AngelBoxUI","cmdCall");
      }
      
      private function addListener() : void
      {
         cmdCall.addEventListener(MouseEvent.CLICK,this.onClickCall);
      }
      
      private function removeListener() : void
      {
         cmdCall.removeEventListener(MouseEvent.CLICK,this.onClickCall);
      }
      
      public function pushIconItem(param1:IconItem) : void
      {
         if(!param1)
         {
            return;
         }
         param1.x = 0;
         param1.y = 0;
         this._iconBag.addChildAt(param1,1);
      }
      
      public function get iconBag() : IconItemBag
      {
         return this._iconBag;
      }
      
      private function onClickCall(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(!this.config)
         {
            return;
         }
         if(param1.currentTarget.label == DiversityManager.getString("AngelBoxUI","cmdCall"))
         {
            for(_loc2_ in this.config.openItems)
            {
               if(obf_K_e_3075.playerBagUI.getEqualItemCount(_loc2_) < this.config.openItems[_loc2_])
               {
                  WindowManager.showMessageBox(DiversityManager.getString("AngelBoxUI","cmdCallItem",[GameItemManager.getItemName(_loc2_) + " x" + this.config.openItems[_loc2_]]));
                  return;
               }
            }
         }
         else
         {
            for(_loc3_ in this.config.addExpItems)
            {
               if(obf_K_e_3075.playerBagUI.getEqualItemCount(_loc3_) < this.config.addExpItems[_loc3_])
               {
                  WindowManager.showMessageBox(DiversityManager.getString("AngelBoxUI","cmdCultivateItem",[GameItemManager.getItemName(_loc3_) + " x" + this.config.addExpItems[_loc3_]]));
                  return;
               }
            }
         }
         obf_O_7_1100.sendPlayerAngelUpReq(this.config.id);
      }
      
      public function setConfig(param1:Object) : void
      {
         this.config = param1;
         this.showInfo();
      }
      
      private function showInfo() : void
      {
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         txtName.htmlText = this.config.name;
         txtValueExplain.text = "";
         var _loc1_:String = "";
         var _loc2_:String = "";
         _loc2_ = DiversityManager.getString("AngelBoxUI","txtIntelligence") + this.config.grow + "\n";
         var _loc3_:String = "";
         var _loc4_:String = "";
         var _loc5_:String = "";
         for(_loc6_ in this.config.openItems)
         {
            _loc9_ = GameItemManager.getItemName(_loc6_);
            _loc4_ = DiversityManager.getString("AngelBoxUI","txtCallNum",[_loc9_,this.config.openItems[_loc6_]]);
         }
         this._iconBag.lockDrag = true;
         cmdCall.label = DiversityManager.getString("AngelBoxUI","cmdCall");
         txtValueExplain.text = _loc2_ + _loc4_;
         _loc7_ = obf_O_7_1100.angelList;
         _loc8_ = 0;
         while(_loc8_ < _loc7_.length)
         {
            if(_loc7_[_loc8_].id == this.config.id)
            {
               this._iconBag.lockDrag = false;
               _loc3_ = DiversityManager.getString("AngelBoxUI","txtLevel",[_loc7_[_loc8_].level]) + "\n";
               if(_loc7_[_loc8_].level >= obf_O_7_1100.angelExpList.length)
               {
                  cmdCall.label = DiversityManager.getString("AngelBoxUI","cmdCultivateMax");
                  cmdCall.enabled = false;
               }
               else
               {
                  cmdCall.label = DiversityManager.getString("AngelBoxUI","cmdCultivate");
                  _loc5_ = DiversityManager.getString("AngelBoxUI","txtExp",[_loc7_[_loc8_].exp]) + "/" + obf_O_7_1100.angelExpList[_loc7_[_loc8_].level - 1];
                  cmdCall.addEventListener(MouseEvent.MOUSE_OVER,this.obf_1_d_3346);
                  cmdCall.addEventListener(MouseEvent.MOUSE_OUT,this.obf_0_7_x_507);
               }
               txtValueExplain.text = _loc2_ + _loc3_ + _loc5_;
               break;
            }
            _loc8_++;
         }
      }
      
      private function obf_1_d_3346(param1:Event) : void
      {
         var _loc4_:String = null;
         var _loc2_:GameTipUI = new GameTipUI("AngelCmdCallTip");
         var _loc3_:int = 200;
         for(_loc4_ in this.config.addExpItems)
         {
            _loc2_.addTipInfo(DiversityManager.getString("AngelBoxUI","cmdCultivateItem",[GameItemManager.getItemName(_loc4_) + " x" + this.config.addExpItems[_loc4_]]),_loc3_,1);
         }
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_0_7_x_507(param1:Event) : void
      {
         GameTipManager.closeTip("AngelCmdCallTip");
      }
      
      override public function get height() : Number
      {
         return bg.height;
      }
      
      public function destroy() : void
      {
         this.removeListener();
         if(Boolean(this._iconBag) && this._iconBag.parent == this)
         {
            this._iconBag.destroy();
            this.removeChild(this._iconBag);
         }
         this._iconBag = null;
      }
   }
}

