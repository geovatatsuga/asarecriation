package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.equ.EquipmentManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.equ.PlayerViewRepairInfoAnswer;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.EquipRepairUIMC;
   
   public class EquipRepairUI extends EquipRepairUIMC implements IIconItemUI
   {
      
      private var equipBag:IconItemBag;
      
      public function EquipRepairUI()
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         titleBox.mouseEnabled = false;
         this.equipBag = new IconItemBag(equipBar,this,0);
         this.equipBag.lockDrag = true;
         this.equipBag.addValidType(GameItemType.EQUIPMENT);
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"EquipRepairUI","txtTitle");
         cmdRepair.label = DiversityManager.getString("EquipRepairUI","cmdRepair");
         cmdPerfectRepair.label = DiversityManager.getString("EquipRepairUI","cmdPerfectRepair");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdRepair.addEventListener(MouseEvent.CLICK,this.obf_Y_S_3731);
         cmdPerfectRepair.addEventListener(MouseEvent.CLICK,this.obf_Y_S_3731);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdRepair.removeEventListener(MouseEvent.CLICK,this.obf_Y_S_3731);
         cmdPerfectRepair.removeEventListener(MouseEvent.CLICK,this.obf_Y_S_3731);
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
      
      public function showEquipRepair(param1:String, param2:String) : void
      {
         cmdRepair.enabled = false;
         cmdPerfectRepair.enabled = false;
         txtEquName.text = "";
         DiversityManager.setTextField(txtPrompt1,"EquipRepairUI","prompt_GettingInfo",null,true);
         txtPrompt2.text = "";
         while(pointGold.numChildren > 0)
         {
            pointGold.removeChildAt(0);
         }
         while(pointMoney.numChildren > 0)
         {
            pointMoney.removeChildAt(0);
         }
         this.equipBag.dropIconItem();
         if(!obf_L_l_4100.isEmpty(param2))
         {
            this.equipBag.pushIconItem(IconItemManager.getIconItemByCode(param1,param2));
            txtEquName.text = GameItemManager.getItemName(param1);
         }
         else
         {
            this.equipBag.dropIconItem();
            DiversityManager.setTextField(txtEquName,"EquipRepairUI","prompt_AllEqu",null,true);
         }
         EquipmentManager.sendViewRepair(param2);
         obf_K_e_3075.showUI(this);
      }
      
      public function showRepairInfo(param1:PlayerViewRepairInfoAnswer) : void
      {
         var _loc3_:DisplayObject = null;
         if(Boolean(this.equipBag.haveIconItem) && this.equipBag.haveIconItem.itemId != param1.equipmentId)
         {
            return;
         }
         if(param1.isWornOut)
         {
            DiversityManager.setTextField(txtPrompt1,"EquipRepairUI","prompt_CantRepair",null,true);
            return;
         }
         if(param1.isFullDurability || param1.repairGold <= 0)
         {
            DiversityManager.setTextField(txtPrompt1,"EquipRepairUI","prompt_NotNeedRepair",null,true);
            return;
         }
         DiversityManager.setTextField(txtPrompt1,"EquipRepairUI","prompt_RepairCostGold",null,true);
         var _loc2_:DisplayObject = obf_a_f_2935.getGoldDisplay(param1.repairGold);
         if(_loc2_)
         {
            _loc2_.x = -(_loc2_.width / 2);
            pointGold.addChild(_loc2_);
            cmdRepair.enabled = true;
         }
         if(param1.perfectRepairGold > 0)
         {
            DiversityManager.setTextField(txtPrompt2,"EquipRepairUI","prompt_PerfectRepairCost",null,true);
            _loc3_ = obf_a_f_2935.getGoldDisplay(param1.perfectRepairGold);
            if(_loc3_)
            {
               _loc3_.x = -(_loc3_.width / 2);
               pointMoney.addChild(_loc3_);
               cmdPerfectRepair.enabled = true;
            }
         }
      }
      
      private function obf_Y_S_3731(param1:Event) : void
      {
         cmdRepair.enabled = false;
         cmdPerfectRepair.enabled = false;
         var _loc2_:String = "";
         if(this.equipBag.haveIconItem)
         {
            _loc2_ = this.equipBag.haveIconItem.itemId;
         }
         EquipmentManager.sendRepairEquip(_loc2_,param1.currentTarget == cmdPerfectRepair);
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
         return [this.equipBag];
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
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
   }
}

