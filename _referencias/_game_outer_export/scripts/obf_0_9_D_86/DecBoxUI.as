package obf_0_9_D_86
{
   import obf_x_O_4078.obf_A_V_935;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.DecBoxUIMC;
   
   public class DecBoxUI extends DecBoxUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      public function DecBoxUI()
      {
         var _loc2_:MovieClip = null;
         var _loc3_:IconItemBag = null;
         super();
         this.initDiversity();
         titleBox.mouseEnabled = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         this.bags = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = this["bag" + _loc1_];
            if(_loc2_)
            {
               _loc3_ = new IconItemBag(this["bag" + _loc1_],this,_loc1_);
               _loc3_.lockDrag = true;
               _loc3_.addValidType(GameItemType.ALL);
               this.bags.push(_loc3_);
            }
            _loc1_++;
         }
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"DecBoxUI","txtTitle");
         DiversityManager.setTextField(txtDeyPrompt,"DecBoxUI","txtPrompt");
         cmdDec.label = DiversityManager.getString("DecBoxUI","cmdDec");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdDec.addEventListener(MouseEvent.CLICK,this.obf_0_2_j_352);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdDec.removeEventListener(MouseEvent.CLICK,this.obf_0_2_j_352);
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
      
      private function obf_0_2_j_352(param1:Event) : void
      {
         var _loc3_:IconItemBag = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in this.bags)
         {
            if(Boolean(_loc3_.haveIconItem) && !obf_L_l_4100.isEmpty(_loc3_.haveIconItem.itemId))
            {
               _loc2_.push(_loc3_.haveIconItem.itemId);
            }
         }
         if(_loc2_.length == 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("DecBoxUI","prompt_NoItems"));
            return;
         }
         WindowManager.showConfirmBox(DiversityManager.getString("DecBoxUI","confirmDec"),this.confirmDec,_loc2_);
      }
      
      private function confirmDec(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_A_V_935.sendDecomposeItems(param1.par);
            obf_K_e_3075.closeUI(this);
         }
      }
      
      public function clearItems() : void
      {
         var _loc1_:IconItemBag = null;
         for each(_loc1_ in this.bags)
         {
            _loc1_.dropIconItem();
         }
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
         return this.bags;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.clearItems();
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
         var _loc5_:IconItemBag = null;
         if(param3.parentIconUI != obf_K_e_3075.playerBagUI)
         {
            return;
         }
         var _loc4_:Object = GameItemManager.getItemConfig(param2.itemCode);
         if(JSONUtil.getStr(_loc4_,["decDropRule"]) == "" || obf_L_l_4100.isEmpty(param2.itemId))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("DecBoxUI","prompt_ItemError"));
            return;
         }
         for each(_loc5_ in this.bags)
         {
            if(!_loc5_.haveIconItem)
            {
               param2.itemCount = 1;
               _loc5_.pushIconItem(param2);
               break;
            }
            if(_loc5_.haveIconItem.itemId == param2.itemId)
            {
               return;
            }
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         if(param3 != this)
         {
            param1.dropIconItem();
         }
      }
   }
}

