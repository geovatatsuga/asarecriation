package obf_N_r_3650
{
   import obf_S_0_4540.DevilGodManager;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.obf_U_N_1827;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.WindowManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.DevilGodUsePetUIMC;
   
   public class DevilGodUsePetUI extends DevilGodUsePetUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      private var petBag:IconItemBag;
      
      public function DevilGodUsePetUI()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.bags = new Array();
         this.petBag = new IconItemBag(petIcon,this,0);
         this.petBag.addValidType(GameItemType.PET);
         this.petBag.isLocked = false;
         this.bags.push(this.petBag);
         this.addListener();
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdSure.addEventListener(MouseEvent.CLICK,this.obf_0_9_726);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdSure.removeEventListener(MouseEvent.CLICK,this.obf_0_9_726);
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
      
      private function obf_0_9_726(param1:Event) : void
      {
         if(!this.petBag || !this.petBag.haveIconItem)
         {
            WindowManager.showMessageBox(DiversityManager.getString("DevilGodUsePetUI","pushPet"));
            return;
         }
         if(DevilGodManager.devilPowerByPet + obf_K_e_3075.devilGodUI.powerValue > DevilGodManager.devilGodPowerMax)
         {
            WindowManager.showMessageBox(DiversityManager.getString("DevilGodUsePetUI","pushPetMaxValue"));
            return;
         }
         DevilGodManager.sendDevilGodEatPetReq(this.petBag.haveIconItem.itemId);
      }
      
      public function obf_0_0_2_552() : void
      {
         this.petBag.dropIconItem();
         DiversityManager.setTextField(txtPower,"DevilGodUsePetUI","txtPower",[0]);
         DiversityManager.setTextField(txtGrow,"DevilGodUsePetUI","txtGrow",[0]);
      }
      
      public function pushPetIn(param1:obf_U_N_1827) : void
      {
         var _loc3_:* = undefined;
         if(!param1)
         {
            return;
         }
         this.obf_0_0_2_552();
         this.petBag.pushIconItem(param1);
         DiversityManager.setTextField(txtPower,"DevilGodUsePetUI","txtPower",[DevilGodManager.devilPowerByPet]);
         var _loc2_:Object = DevilGodManager.devilGodGrowByPet;
         for(_loc3_ in _loc2_)
         {
            if(_loc3_ == param1.iconItemRank)
            {
               DiversityManager.setTextField(txtGrow,"DevilGodUsePetUI","txtGrow",[_loc2_[_loc3_]]);
               break;
            }
         }
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         if(!param1 || param3.parentIconUI != obf_K_e_3075.petBoxUI)
         {
            return;
         }
         if(param1 == this.petBag && param2 is obf_U_N_1827)
         {
            this.pushPetIn(param2 as obf_U_N_1827);
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
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
         DiversityManager.setTextField(txtExplain1,"DevilGodUsePetUI","txtExplain1");
         DiversityManager.setTextField(txtExplain2,"DevilGodUsePetUI","txtExplain2");
         DiversityManager.setTextField(txtPower,"DevilGodUsePetUI","txtPower",[0]);
         DiversityManager.setTextField(txtGrow,"DevilGodUsePetUI","txtGrow",[0]);
         cmdSure.label = DiversityManager.getString("DevilGodUsePetUI","cmdSure");
      }
      
      public function showUI() : void
      {
         this.x = 300;
         this.y = GameContext.gameStage.stageHeight / 2;
         obf_K_e_3075.petBoxContainerUI.x = this.x + 550;
         obf_K_e_3075.petBoxContainerUI.y = this.y - 10;
         if(obf_K_e_3075.petBoxContainerUI)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.petBoxContainerUI);
         }
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.obf_0_0_2_552();
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

