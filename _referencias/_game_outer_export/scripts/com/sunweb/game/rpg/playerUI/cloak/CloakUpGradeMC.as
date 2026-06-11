package com.sunweb.game.rpg.playerUI.cloak
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.UpGradeMC;
   
   public class CloakUpGradeMC extends UpGradeMC
   {
      
      public static const upGradeMCEvent:String = "UpGradeMC_EVENT";
      
      private var cloakMaterialArr:Array;
      
      private var itemConfigArr:Array;
      
      private var level:int = 1;
      
      public function CloakUpGradeMC(param1:IIconItemUI, param2:Array, param3:int = 1)
      {
         var _loc5_:IconItemBag = null;
         var _loc6_:MovieClip = null;
         var _loc7_:IconItemBag = null;
         this.itemConfigArr = new Array();
         super();
         this.initDiversity();
         this.itemConfigArr = param2;
         this.level = param3;
         this.cloakMaterialArr = new Array();
         var _loc4_:int = 0;
         while(_loc4_ < 2)
         {
            _loc6_ = this["upIcon" + (_loc4_ + 1)] as MovieClip;
            if(_loc6_ != null)
            {
               _loc7_ = new IconItemBag(_loc6_,param1,_loc4_);
               _loc7_.lockDrag = true;
               _loc7_.addValidType(GameItemType.ALL);
               this.cloakMaterialArr.push(_loc7_);
            }
            _loc4_++;
         }
         for each(_loc5_ in this.cloakMaterialArr)
         {
            _loc5_.dropIconItem();
         }
         if(this.level < this.itemConfigArr.length)
         {
            cmdUp.visible = true;
            this.obf_d_b_2442(this.itemConfigArr[this.level - 1].items);
         }
         else
         {
            cmdUp.visible = false;
         }
         this.addListener();
      }
      
      private function obf_d_b_2442(param1:Object) : void
      {
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:IconItemBag = null;
         var _loc7_:IconItem = null;
         var _loc2_:Array = new Array();
         var _loc3_:Object = param1;
         if(!_loc3_)
         {
            return;
         }
         for(_loc4_ in _loc3_)
         {
            _loc2_.push({
               "itemCode":_loc4_,
               "itemCount":_loc3_[_loc4_]
            });
         }
         _loc2_.sortOn("itemCode");
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            if(_loc5_ >= this.cloakMaterialArr.length)
            {
               break;
            }
            _loc6_ = this.cloakMaterialArr[_loc5_];
            _loc7_ = IconItemManager.getIconItemByCode(_loc2_[_loc5_].itemCode,"");
            _loc7_.itemCount = _loc2_[_loc5_].itemCount;
            _loc6_.dropIconItem();
            _loc6_.pushIconItem(_loc7_);
            _loc5_++;
         }
      }
      
      private function addListener() : void
      {
         cmdUp.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function removeListener() : void
      {
         cmdUp.removeEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:Event) : void
      {
         dispatchEvent(new Event(upGradeMCEvent));
      }
      
      public function setName(param1:String) : void
      {
         upName.text = param1;
      }
      
      public function setLevel(param1:int) : void
      {
         upLv.text = param1 + "";
      }
      
      public function setRemark(param1:String) : void
      {
         txtUpExplain.htmlText = param1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtUpName,"CloakBoxUI","txtUnlockName");
         DiversityManager.setTextField(txtUpLv,"CloakBoxUI","txtUnlockLv");
         DiversityManager.setTextField(txtUpMaterial,"CloakBoxUI","txtUnlockMaterial");
         cmdUp.label = DiversityManager.getString("CloakBoxUI","cmdUp");
      }
      
      public function getIconItemBags() : Array
      {
         return this.cloakMaterialArr;
      }
      
      public function destroy() : void
      {
         var _loc1_:IconItemBag = null;
         this.removeListener();
         for each(_loc1_ in this.cloakMaterialArr)
         {
            _loc1_.destroy();
            this.removeChild(_loc1_);
            _loc1_ = null;
         }
      }
   }
}

