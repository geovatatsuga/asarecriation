package obf_p_w_3235
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.lockTower.obf_N_9_4230;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import flash.events.MouseEvent;
   import playerUI.LockTowerEatUIMC;
   
   public class obf_T_7_2588 extends LockTowerEatUIMC implements IIconItemUI, IPlayerUI
   {
      
      private var obf_g_y_3934:int;
      
      private var iconBag:IconItemBag;
      
      public function obf_T_7_2588()
      {
         super();
         this.visible = false;
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.iconBag = new IconItemBag(icon,this,0);
         this.iconBag.addValidType(GameItemType.ALL);
         this.iconBag.lockDrag = true;
         this.addListener();
      }
      
      public function setFloor(param1:int) : void
      {
         this.obf_g_y_3934 = param1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtTitle,"lockTowerEatUI","txtTitle");
         DiversityManager.setTextField(txtTip,"lockTowerEatUI","txtTip");
         cmdSure.label = DiversityManager.getString("lockTowerEatUI","cmdSure");
      }
      
      public function addListener() : void
      {
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdSure.addEventListener(MouseEvent.CLICK,this.obf_H_Z_3613);
      }
      
      public function removeListener() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdSure.removeEventListener(MouseEvent.CLICK,this.obf_H_Z_3613);
      }
      
      public function obf_H_Z_3613(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!this.iconBag.haveIconItem)
         {
            return;
         }
         if(this.iconBag.haveIconItem.itemCode != obf_N_9_4230.itemCode())
         {
            _loc2_ = obf_N_9_4230.obf_L_A_4035(this.iconBag.haveIconItem.itemCode);
            if(!_loc2_)
            {
               return;
            }
         }
         obf_N_9_4230.obf_E_a_1328(this.obf_g_y_3934,this.iconBag.haveIconItem.itemCode);
         obf_K_e_3075.closeUI(this);
      }
      
      private function obf_E_j_2700() : void
      {
         this.iconBag.dropIconItem();
         this.obf_g_y_3934 = 0;
      }
      
      private function onStopDrag(param1:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      private function onStartDrag(param1:MouseEvent) : void
      {
         this.startDrag();
      }
      
      private function onClose(param1:MouseEvent) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      public function getIconItemBags() : Array
      {
         return [this.iconBag];
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         var _loc4_:String = null;
         if(param3.parentIconUI == obf_K_e_3075.playerBagUI)
         {
            if(param2.itemCode == obf_N_9_4230.itemCode())
            {
               this.iconBag.dropIconItem();
               this.iconBag.pushIconItem(param2);
            }
            else
            {
               _loc4_ = obf_N_9_4230.obf_L_A_4035(param2.itemCode);
               if(!_loc4_)
               {
                  return;
               }
               this.iconBag.dropIconItem();
               this.iconBag.pushIconItem(param2);
            }
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         this.iconBag.dropIconItem();
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
      
      public function showUI() : void
      {
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.obf_E_j_2700();
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

