package com.sunweb.game.rpg.playerUI.itemManual
{
   import obf_Z_Y_1344.ItemManualManager;
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.ui.WindowManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import playerUI.ItemManualCeilUIMC;
   
   public class ItemmanualCeilUI extends ItemManualCeilUIMC
   {
      
      private var successId:String;
      
      private var condition:Object;
      
      private var _iconBag:IconItemBag;
      
      public var fashionShow:Boolean = true;
      
      public function ItemmanualCeilUI(param1:IIconItemUI)
      {
         super();
         this.initDiversity();
         this._iconBag = new IconItemBag(iconBar,param1,0);
         this._iconBag.addValidType(GameItemType.ALL);
         this._iconBag.lockDrag = true;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         cmdGet.label = DiversityManager.getString("ItemManualUI","cmdGet");
      }
      
      private function addListener() : void
      {
         cmdGet.addEventListener(MouseEvent.CLICK,this.obf_R_Z_3773);
         iconBar1.addEventListener(MouseEvent.MOUSE_OVER,this.obf_Z_l_1286);
         iconBar1.addEventListener(MouseEvent.MOUSE_OUT,this.obf_0_6_9_109);
      }
      
      private function removeListener() : void
      {
         cmdGet.removeEventListener(MouseEvent.CLICK,this.obf_R_Z_3773);
         iconBar1.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_Z_l_1286);
         iconBar1.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_0_6_9_109);
      }
      
      private function obf_Z_l_1286(param1:MouseEvent) : void
      {
         var _loc6_:Object = null;
         var _loc7_:* = undefined;
         var _loc2_:GameTipUI = new GameTipUI("ItemManualCeilMouseTip");
         var _loc3_:int = 200;
         var _loc4_:Array = ItemManualManager.itemManualSuccess();
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            if(this.successId == _loc4_[_loc5_].id)
            {
               _loc2_.addTipInfo("<P align=\'center\'><FONT size=\'14\' color=\'#FFFF00\'><B>" + _loc4_[_loc5_].name + "</B></FONT></P>",_loc3_,_loc2_.maxRow);
               _loc6_ = _loc4_[_loc5_].attr;
               if(_loc6_)
               {
                  for(_loc7_ in _loc6_)
                  {
                     _loc2_.addTipInfo("<FONT color=\'#00FF00\'>" + RoleAttributesModifierEnum.getAttributesName(_loc7_) + "</FONT>",_loc3_,_loc2_.maxRow + 1);
                     _loc2_.addTipInfo("<P align=\'right\'><FONT color=\'#00FF00\'>" + RoleAttributesModifierEnum.getAttributesValueString(_loc7_,_loc6_[_loc7_]) + "</FONT></P>",_loc3_,_loc2_.maxRow);
                  }
               }
            }
            _loc5_++;
         }
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_0_6_9_109(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("ItemManualCeilMouseTip");
      }
      
      public function get iconBag() : IconItemBag
      {
         return this._iconBag;
      }
      
      private function obf_R_Z_3773(param1:MouseEvent) : void
      {
         if(!obf_K_e_3075.rideBoxUI.haveEmptyBag(1))
         {
            WindowManager.showMessageBox(DiversityManager.getString("CommonPrompt","playerRideBagFull"));
            return;
         }
         if(!obf_K_e_3075.playerBagUI.haveEmptyBag(1))
         {
            WindowManager.showMessageBox(DiversityManager.getString("CommonPrompt","playerBagFull"));
            return;
         }
         if(!obf_K_e_3075.petBoxUI.haveEmptyBag(1))
         {
            WindowManager.showMessageBox(DiversityManager.getString("CommonPrompt","playerPetBagFull"));
            return;
         }
         var _loc2_:Array = ItemManualManager.itemManualSuccess();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_].id == this.successId)
            {
               if(ConditionScript.checkCondition(_loc2_[_loc3_].condition,null,false))
               {
                  ItemManualManager.sendItemManualSuccessAwardReq(this.successId);
                  break;
               }
            }
            _loc3_++;
         }
      }
      
      public function setId(param1:String) : void
      {
         this.successId = param1;
      }
      
      public function setName(param1:String) : void
      {
         txtName.htmlText = param1;
      }
      
      public function setInfo(param1:String) : void
      {
         txtCond.htmlText = param1;
      }
      
      public function setExpBar(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         this.condition = param1;
         for(_loc4_ in param1.ranksNumGE)
         {
            _loc2_ = obf_K_e_3075.itemManualUI.getItemManualAll(int(_loc4_));
            _loc3_ = int(param1.ranksNumGE[_loc4_]);
         }
         txtValue.htmlText = _loc2_ + "/" + _loc3_;
         _loc5_ = 100 * (_loc2_ / _loc3_);
         if(_loc5_ < 2)
         {
            _loc5_ = 2;
         }
         bar.gotoAndStop(_loc5_);
      }
      
      public function setPic(param1:String) : void
      {
         var _loc2_:DisplayObject = ResourceManager.instance.getDisplayObject(param1);
         if(!_loc2_)
         {
            _loc2_ = new Bitmap(new nullItemIcon(1,1));
         }
         iconBar1.addChild(_loc2_);
      }
      
      public function setCond() : Boolean
      {
         if(ConditionScript.checkCondition(this.condition,null,false))
         {
            return true;
         }
         return false;
      }
      
      override public function get height() : Number
      {
         return 80;
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
         while(iconBar1.numChildren > 0)
         {
            iconBar1.removeChildAt(0);
         }
      }
   }
}

