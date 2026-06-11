package obf_V_n_3191
{
   import obf_g_A_3629.obf_r_Y_1874;
   import obf_x_O_4078.obf_A_V_935;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.equ.EquipmentManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import playerUI.EquipLetteringUIMC;
   
   public class obf_T_X_2585 extends EquipLetteringUIMC implements IIconItemUI
   {
      
      private var equipmentBag:IconItemBag;
      
      public function obf_T_X_2585()
      {
         super();
         this.initDiversity();
         titleBox.mouseEnabled = false;
         this.x = GameContext.gameStage.stageWidth / 2 - 200;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.equipmentBag = new IconItemBag(bagEquip,this,0);
         this.equipmentBag.addValidType(GameItemType.ALL);
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"EquipmentLetteringUI","txtTitle");
         DiversityManager.setTextField(txtDeyPushEquipment,"EquipmentLetteringUI","txtPushEquipment");
         DiversityManager.setTextField(txtDeyInput,"EquipmentLetteringUI","txtInput");
         cmdOK.label = DiversityManager.getString("EquipmentLetteringUI","cmdOK");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdOK.addEventListener(MouseEvent.CLICK,this.onClickLettering);
         inputLettering.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_J_6_2780);
         inputLettering.addEventListener(KeyboardEvent.KEY_UP,this.obf_J_6_2780);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdOK.removeEventListener(MouseEvent.CLICK,this.onClickLettering);
         inputLettering.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_J_6_2780);
         inputLettering.removeEventListener(KeyboardEvent.KEY_UP,this.obf_J_6_2780);
      }
      
      private function onClickLettering(param1:Event) : void
      {
         if(!this.equipmentBag.haveIconItem)
         {
            return;
         }
         if(obf_L_l_4100.isEmpty(inputLettering.text))
         {
            return;
         }
         if(inputLettering.text.length > EquipmentManager.getConfigValue("lettering","wordSize"))
         {
            WindowManager.showMessageBox(DiversityManager.getString("InputBox","inputTooLong",[EquipmentManager.getConfigValue("lettering","wordSize")]));
            return;
         }
         if(obf_r_Y_1874.isUnlawful(inputLettering.text))
         {
            WindowManager.showMessageBox(DiversityManager.getString("InputBox","prompt_InvalidContent"));
            return;
         }
         if(!ConditionScript.checkCondition(EquipmentManager.getConfigValue("lettering","condition"),null,true))
         {
            return;
         }
         obf_A_V_935.sendEquipLettering(this.equipmentBag.haveIconItem.itemId,inputLettering.text);
      }
      
      public function clearContent() : void
      {
         this.equipmentBag.dropIconItem();
         inputLettering.text = "";
      }
      
      private function obf_J_6_2780(param1:Event) : void
      {
         param1.stopPropagation();
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
            return bgBox.getBounds(bgBox).contains(bgBox.mouseX,bgBox.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         this.clearContent();
         this.visible = true;
      }
      
      public function getIconItemBags() : Array
      {
         return [this.equipmentBag];
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
         if(!param2)
         {
            return;
         }
         var _loc4_:Object = GameItemManager.getItemConfig(param2.itemCode);
         if(!_loc4_)
         {
            return;
         }
         if(!JSONUtil.getBoolean(_loc4_,["properties","canLettering"]))
         {
            WindowManager.showMessageBox(DiversityManager.getString("EquipmentLetteringUI","prompt_CantLettering"));
            return;
         }
         this.equipmentBag.dropIconItem();
         this.equipmentBag.pushIconItem(param2);
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
   }
}

