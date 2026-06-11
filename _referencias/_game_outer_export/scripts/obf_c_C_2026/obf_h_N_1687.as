package obf_c_C_2026
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.netRole.obf_Y_E_3667;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.obf_z_A_3653;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.util.TimeLimiter;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import playerUI.BoothViewUIMC;
   
   public class obf_h_N_1687 extends BoothViewUIMC implements IIconItemUI, obf_z_A_3653
   {
      
      private var obf_5_F_4317:Array;
      
      public var playerName:String;
      
      private var obf_0_5_I_285:Dictionary;
      
      private var timeInv:TimeLimiter = new TimeLimiter(500);
      
      public function obf_h_N_1687()
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         titleBox.mouseEnabled = false;
         this.obf_5_F_4317 = new Array();
         this.obf_0_5_I_285 = new Dictionary();
         this.obf_0_5_I_285[saleTab] = obf_K_e_3075.boothSellViewUI;
         this.obf_0_5_I_285[bfmTab] = obf_K_e_3075.boothBfmViewUI;
         obf_K_e_3075.showChildUI(this,this.obf_0_5_I_285[saleTab]);
         this.refreshTableButton();
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
            _loc1_.addEventListener(MouseEvent.CLICK,this.onClickTableButton);
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
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onClickTableButton);
         }
      }
      
      private function refreshTableButton() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in this.obf_0_5_I_285)
         {
            if(_loc1_)
            {
               _loc1_.gotoAndStop(this.obf_5_F_4317.indexOf(this.obf_0_5_I_285[_loc1_]) > -1 ? 2 : 1);
            }
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
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
         if(obf_K_e_3075.boothBfmWim)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.boothBfmWim);
         }
      }
      
      private function onClickTableButton(param1:MouseEvent) : void
      {
         obf_K_e_3075.closeAllChildUI(this);
         var _loc2_:IPlayerUI = this.obf_0_5_I_285[param1.currentTarget] as IPlayerUI;
         if(_loc2_)
         {
            obf_K_e_3075.showChildUI(this,_loc2_);
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:obf_Y_E_3667 = null;
         if(this.timeInv.checkTimeout())
         {
            _loc2_ = GameContext.currentMap.remotePlayerSet.getObject(this.playerName) as obf_Y_E_3667;
            if(!_loc2_ || GameContext.localPlayer.getLineDistance(_loc2_) > WorldConfig.getValue("booth","visitDistance"))
            {
               this.onClose(null);
            }
         }
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
         return _loc1_;
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
         DiversityManager.setTextField(txtDeyTitle,"BoothUI","txtTitle");
         DiversityManager.setTextField(saleTab.txtLabel,"BoothUI","saleTab");
         DiversityManager.setTextField(bfmTab.txtLabel,"BoothUI","bfmTab");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.playerName = "";
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
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
         return pointUI;
      }
      
      public function obf_7_h_998(param1:IPlayerUI) : void
      {
         this.refreshTableButton();
      }
      
      public function removeChildPlayerUI(param1:IPlayerUI) : void
      {
         this.refreshTableButton();
      }
   }
}

