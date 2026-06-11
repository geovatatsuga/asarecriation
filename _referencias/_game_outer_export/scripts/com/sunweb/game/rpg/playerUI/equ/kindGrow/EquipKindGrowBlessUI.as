package com.sunweb.game.rpg.playerUI.equ.kindGrow
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.equ.EquipmentKind;
   import com.sunweb.game.rpg.equipKindGrow.EquipKindGrowManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemEquip;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.equipKindGrowBlessUIMC;
   
   public class EquipKindGrowBlessUI extends equipKindGrowBlessUIMC implements IIconItemUI, IPlayerUI
   {
      
      private var _kind:int;
      
      private var iconBagEquip:IconItemBag;
      
      private var iconBagMaterial:IconItemBag;
      
      public function EquipKindGrowBlessUI()
      {
         super();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.iconBagEquip = new IconItemBag(iconEquip,this,0);
         this.iconBagEquip.addValidType(GameItemType.ALL);
         this.iconBagEquip.lockDrag = true;
         this.iconBagMaterial = new IconItemBag(iconMaterial,this,0);
         this.iconBagMaterial.addValidType(GameItemType.ALL);
         this.iconBagMaterial.lockDrag = true;
         this.initDiversity();
         this.addListener();
      }
      
      public function setKind(param1:int) : void
      {
         this._kind = param1;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         var _loc2_:String = null;
         var _loc3_:IconItem = null;
         DiversityManager.setTextField(txtTitle,"equipKindGrowBlessUI","txtTitle");
         DiversityManager.setTextField(txtMaterial,"equipKindGrowBlessUI","txtMaterial");
         cmdBless.label = DiversityManager.getString("equipKindGrowBlessUI","cmdBless");
         var _loc1_:String = null;
         for(_loc2_ in EquipKindGrowManager.blessCode)
         {
            _loc1_ = _loc2_;
         }
         _loc3_ = IconItemManager.getIconItemByCode(_loc1_,"");
         if(_loc3_)
         {
            _loc3_.itemCount = EquipKindGrowManager.blessCode[_loc1_];
            this.iconBagMaterial.pushIconItem(_loc3_);
         }
      }
      
      public function addListener() : void
      {
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdBless.addEventListener(MouseEvent.CLICK,this.obf_K_t_1144);
      }
      
      public function removeListener() : void
      {
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdBless.removeEventListener(MouseEvent.CLICK,this.obf_K_t_1144);
      }
      
      public function refresh() : void
      {
         this.iconBagEquip.dropIconItem();
         DiversityManager.setTextField(txtEquip,"equipKindGrowBlessUI","txtEquip",[EquipmentKind.getKindName(this._kind)]);
      }
      
      private function obf_K_t_1144(param1:Event) : void
      {
         if(!this.iconBagEquip.haveIconItem)
         {
            return;
         }
         var _loc2_:int = int(obf_K_e_3075.equipKindGrowUI.kindInfoMap[this._kind].level);
         if(_loc2_ <= 0 || GameContext.localPlayer.level < _loc2_)
         {
            return;
         }
         var _loc3_:String = this.iconBagEquip.haveIconItem.itemId;
         if(!obf_K_e_3075.playerBagUI.getIconItemBagByID(_loc3_))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","notHaveItemInBag"));
            return;
         }
         if(obf_K_e_3075.playerBagUI.getItemCount(this.iconBagMaterial.haveIconItem.itemCode) < 1)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","notHaveItemInBag"));
            return;
         }
         EquipKindGrowManager.onKindGrowBlessRequest(this._kind,_loc3_);
         obf_K_e_3075.closeUI(this);
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
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return bg.getBounds(bg).contains(bg.mouseX,bg.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         this.visible = true;
      }
      
      public function getIconItemBags() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push(this.iconBagEquip,this.iconBagMaterial);
         return _loc1_;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
         if(param1.haveIconItem)
         {
            param1.dropIconItem();
         }
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         if(!param1 || param3.parentIconUI != obf_K_e_3075.playerBagUI)
         {
            return;
         }
         if(param1 == this.iconBagEquip && param2 is IconItemEquip)
         {
            this.pushEquipIn(param2 as IconItemEquip);
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
      
      private function pushEquipIn(param1:IconItemEquip) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:Object = GameItemManager.getItemConfig(param1.itemCode);
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:int = JSONUtil.getInt(_loc2_,["properties","kind"]);
         if(this._kind != _loc3_)
         {
            return;
         }
         if(this.iconBagEquip.haveIconItem)
         {
            this.iconBagEquip.dropIconItem();
         }
         this.iconBagEquip.pushIconItem(param1);
      }
   }
}

