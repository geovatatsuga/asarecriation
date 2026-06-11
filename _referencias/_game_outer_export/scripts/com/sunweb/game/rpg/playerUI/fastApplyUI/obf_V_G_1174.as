package com.sunweb.game.rpg.playerUI.fastApplyUI
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.equ.EquipmentManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.EquipmentFastApplyUIMC;
   
   public class obf_V_G_1174 extends EquipmentFastApplyUIMC implements IIconItemUI
   {
      
      private var obf_R_P_3252:String;
      
      private var equipBag:IconItemBag;
      
      public function obf_V_G_1174(param1:String, param2:String)
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2 + 350;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.obf_R_P_3252 = param1;
         this.equipBag = new IconItemBag(bagEquip,this,0);
         this.equipBag.addValidType(GameItemType.ALL);
         this.equipBag.lockDrag = true;
         this.equipBag.pushIconItem(IconItemManager.getIconItemByCode(param1,param2));
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         txtEquipment.htmlText = "<font color=\'#" + GameItemRank.getRankColor(JSONUtil.getInt(_loc3_,["rank"])).toString(16) + "\'>" + EquipmentManager.getItemFullName(param1) + "</font>";
         this.addListener();
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdEquipment.addEventListener(MouseEvent.CLICK,this.obf_v_6_3071);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdEquipment.removeEventListener(MouseEvent.CLICK,this.obf_v_6_3071);
      }
      
      private function obf_v_6_3071(param1:Event) : void
      {
         if(this.equipBag.haveIconItem)
         {
            obf_K_e_3075.playerBagUI.useItemById(this.equipBag.haveIconItem.itemId);
         }
         obf_X_t_4110.closeFastApplyUI(this);
      }
      
      private function onClose(param1:Event) : void
      {
         obf_X_t_4110.closeFastApplyUI(this);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"FastEquipmentUI","txtTitle");
         cmdEquipment.label = DiversityManager.getString("FastEquipmentUI","cmdOK");
      }
      
      public function getIconItemBags() : Array
      {
         return [this.equipBag];
      }
      
      public function showUI() : void
      {
         if(!EquipmentManager.obf_3_Z_1689(this.obf_R_P_3252))
         {
            obf_X_t_4110.closeFastApplyUI(this);
            return;
         }
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function destroy() : void
      {
         this.equipBag.dropIconItem();
         this.equipBag.destroy();
         this.removeListener();
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

