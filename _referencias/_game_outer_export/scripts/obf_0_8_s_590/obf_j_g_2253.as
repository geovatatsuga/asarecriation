package obf_0_8_s_590
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.obf_z_A_3653;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import playerUI.FundBgBoxUIMC;
   
   public class obf_j_g_2253 extends FundBgBoxUIMC implements IIconItemUI, obf_z_A_3653
   {
      
      private var obf_0_5_I_285:Dictionary;
      
      private var obf_5_F_4317:Array;
      
      private var allBags:Array;
      
      public function obf_j_g_2253()
      {
         super();
         this.visible = false;
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth >> 1;
         this.y = GameContext.gameStage.stageHeight >> 1;
         this.obf_5_F_4317 = new Array();
         txtDeyTitle.mouseEnabled = false;
         titleBox.mouseEnabled = false;
         this.allBags = new Array();
         this.obf_0_5_I_285 = new Dictionary();
         this.obf_0_5_I_285[FundBtn] = obf_K_e_3075.fundUI;
         this.obf_0_5_I_285[tuFundBtn] = obf_K_e_3075.localTyrantFundUI;
         this.obf_0_5_I_285[boonBtn] = obf_K_e_3075.allOfPeopleBoonUI;
         this.obf_0_5_I_285[monthCardBtn] = obf_K_e_3075.monthCardUI;
         this.addListener();
      }
      
      private function addListener() : void
      {
         var _loc1_:* = undefined;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         for(_loc1_ in this.obf_0_5_I_285)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.onClick);
         }
      }
      
      private function removeListener() : void
      {
         var _loc1_:* = undefined;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         for(_loc1_ in this.obf_0_5_I_285)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onClick);
         }
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function onClick(param1:Event) : void
      {
         obf_K_e_3075.closeAllChildUI(this);
         var _loc2_:IPlayerUI = this.obf_0_5_I_285[param1.currentTarget] as IPlayerUI;
         if(_loc2_)
         {
            obf_K_e_3075.showChildUI(this,_loc2_);
         }
      }
      
      public function showOther(param1:int) : void
      {
         obf_K_e_3075.closeAllChildUI(this);
         if(param1 == 1)
         {
            obf_K_e_3075.showChildUI(this,this.obf_0_5_I_285[FundBtn]);
         }
         else
         {
            obf_K_e_3075.showChildUI(this,this.obf_0_5_I_285[tuFundBtn]);
         }
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      public function getIconItemBags() : Array
      {
         var _loc2_:IPlayerUI = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in this.obf_5_F_4317)
         {
            if(Boolean(_loc2_) && _loc2_ is IIconItemUI)
            {
               _loc1_ = _loc1_.concat((_loc2_ as IIconItemUI).getIconItemBags());
            }
         }
         return this.allBags.concat(_loc1_);
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
         DiversityManager.setTextField(txtDeyTitle,"fundBgBoxUI","txtDeyTitle");
         FundBtn.label = DiversityManager.getString("fundBgBoxUI","FundBtn");
         tuFundBtn.label = DiversityManager.getString("fundBgBoxUI","tuFundBtn");
         boonBtn.label = DiversityManager.getString("fundBgBoxUI","boonBtn");
         monthCardBtn.label = DiversityManager.getString("fundBgBoxUI","monthCardBtn");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         obf_K_e_3075.closeAllChildUI(this);
         obf_K_e_3075.showChildUI(this,this.obf_0_5_I_285[FundBtn]);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
      
      public function get obf_l_v_2495() : Array
      {
         return this.obf_5_F_4317;
      }
      
      public function get obf_R_4_1122() : DisplayObjectContainer
      {
         return childUIPoint;
      }
      
      public function obf_7_h_998(param1:IPlayerUI) : void
      {
      }
      
      public function removeChildPlayerUI(param1:IPlayerUI) : void
      {
      }
   }
}

