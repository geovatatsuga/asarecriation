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
   import playerUI.LockTowerUpUIMC;
   
   public class obf_y_A_3392 extends LockTowerUpUIMC implements IIconItemUI, IPlayerUI
   {
      
      private var obf_g_y_3934:int;
      
      private var _monsterCode:String;
      
      private var iconBag:IconItemBag;
      
      public function obf_y_A_3392()
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
      
      public function setFloorInfo(param1:int, param2:String) : void
      {
         this.obf_g_y_3934 = param1;
         this._monsterCode = param2;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtTitle,"lockTowerUpUI","txtTitle");
         DiversityManager.setTextField(txtTip1,"lockTowerUpUI","txtTip1");
         DiversityManager.setTextField(txtTip2,"lockTowerUpUI","txtTip2");
         cmdB1.label = DiversityManager.getString("lockTowerUpUI","cmdB1");
         cmdB2.label = DiversityManager.getString("lockTowerUpUI","cmdB2");
         cmdB3.label = DiversityManager.getString("lockTowerUpUI","cmdB3");
      }
      
      public function addListener() : void
      {
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdB1.addEventListener(MouseEvent.CLICK,this.obf_w_a_3696);
         cmdB2.addEventListener(MouseEvent.CLICK,this.obf_w_a_3696);
         cmdB3.addEventListener(MouseEvent.CLICK,this.obf_w_a_3696);
      }
      
      public function removeListener() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdB1.removeEventListener(MouseEvent.CLICK,this.obf_w_a_3696);
         cmdB2.removeEventListener(MouseEvent.CLICK,this.obf_w_a_3696);
         cmdB3.removeEventListener(MouseEvent.CLICK,this.obf_w_a_3696);
      }
      
      public function obf_w_a_3696(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:int = 0;
         if(param1.target == cmdB1)
         {
            _loc2_ = 1;
         }
         else if(param1.target == cmdB2)
         {
            _loc2_ = 10;
         }
         else if(param1.target == cmdB3)
         {
            _loc2_ = 100;
         }
         if(_loc2_ <= 0)
         {
            return;
         }
         if(!this.iconBag.haveIconItem)
         {
            return;
         }
         if(obf_N_9_4230.itemCode() != this.iconBag.haveIconItem.itemCode)
         {
            _loc3_ = obf_N_9_4230.obf_L_A_4035(this.iconBag.haveIconItem.itemCode);
            if(!_loc3_ || _loc3_ != this._monsterCode)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("lockTowerUpUI","error"));
               return;
            }
         }
         if(obf_K_e_3075.playerBagUI.getItemCount(this.iconBag.haveIconItem.itemCode) < _loc2_)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("lockTowerUpUI","noItems"));
            return;
         }
         obf_N_9_4230.obf_X_U_2834(this.obf_g_y_3934,this.iconBag.haveIconItem.itemCode,_loc2_);
      }
      
      private function obf_E_j_2700() : void
      {
         this.iconBag.dropIconItem();
         this.obf_g_y_3934 = 0;
         this._monsterCode = null;
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
         if(!this._monsterCode)
         {
            return;
         }
         if(param3.parentIconUI == obf_K_e_3075.playerBagUI)
         {
            param2.itemCount = 1;
            if(param2.itemCode == obf_N_9_4230.itemCode())
            {
               this.iconBag.dropIconItem();
               this.iconBag.pushIconItem(param2);
            }
            else
            {
               _loc4_ = obf_N_9_4230.obf_L_A_4035(param2.itemCode);
               if((Boolean(_loc4_)) && this._monsterCode == _loc4_)
               {
                  this.iconBag.dropIconItem();
                  this.iconBag.pushIconItem(param2);
               }
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

