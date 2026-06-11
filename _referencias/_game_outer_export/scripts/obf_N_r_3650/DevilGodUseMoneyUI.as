package obf_N_r_3650
{
   import obf_S_0_4540.DevilGodManager;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import playerUI.DevilGodUseMoneyUIMC;
   
   public class DevilGodUseMoneyUI extends DevilGodUseMoneyUIMC implements IIconItemUI
   {
      
      private var moneyCount:int;
      
      private var countUpTimeInv:TimeLimiter;
      
      private var countDownTimeInv:TimeLimiter;
      
      private var countMin:int = 0;
      
      private var countMax:int;
      
      private var countValue:int;
      
      public function DevilGodUseMoneyUI()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         txtCount.text = 0 + "";
         this.addListener();
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdLeft.addEventListener(MouseEvent.CLICK,this.obf_4_n_4240);
         cmdRight.addEventListener(MouseEvent.CLICK,this.obf_0_h_2163);
         cmdLeft.addEventListener(MouseEvent.CLICK,this.obf_4_n_4240);
         cmdRight.addEventListener(MouseEvent.CLICK,this.obf_0_h_2163);
         cmdLeft.addEventListener(MouseEvent.MOUSE_DOWN,this.obf_g_V_1348);
         cmdRight.addEventListener(MouseEvent.MOUSE_DOWN,this.obf_g_V_1348);
         cmdSure.addEventListener(MouseEvent.CLICK,this.obf_0_9_726);
         txtCount.addEventListener(Event.CHANGE,this.onInputValue);
         txtCount.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         txtCount.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdLeft.removeEventListener(MouseEvent.CLICK,this.obf_4_n_4240);
         cmdRight.removeEventListener(MouseEvent.CLICK,this.obf_0_h_2163);
         cmdLeft.removeEventListener(MouseEvent.MOUSE_DOWN,this.obf_g_V_1348);
         cmdRight.removeEventListener(MouseEvent.MOUSE_DOWN,this.obf_g_V_1348);
         cmdSure.removeEventListener(MouseEvent.CLICK,this.obf_0_9_726);
         txtCount.removeEventListener(Event.CHANGE,this.onInputValue);
         txtCount.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         txtCount.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
         this.countUpTimeInv = null;
         this.countDownTimeInv = null;
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function onInputValue(param1:Event) : void
      {
         this.checkInputValue(int(txtCount.text));
      }
      
      private function obf_m_I_3657(param1:Event) : void
      {
         param1.stopPropagation();
      }
      
      private function checkInputValue(param1:int) : void
      {
         if(param1 < this.countMin)
         {
            param1 = this.countMin;
         }
         else if(param1 > GameContext.localPlayer.fullInfo.money)
         {
            param1 = GameContext.localPlayer.fullInfo.money;
         }
         this.moneyCount = param1;
         txtCount.text = param1 + "";
      }
      
      private function obf_4_n_4240(param1:Event) : void
      {
         --this.moneyCount;
         if(this.moneyCount < 1)
         {
            this.moneyCount = 0;
         }
         txtCount.text = this.moneyCount + "";
      }
      
      private function obf_0_h_2163(param1:Event) : void
      {
         ++this.moneyCount;
         if(this.moneyCount > GameContext.localPlayer.fullInfo.money)
         {
            this.moneyCount = GameContext.localPlayer.fullInfo.money;
         }
         txtCount.text = this.moneyCount + "";
      }
      
      private function obf_g_V_1348(param1:Event) : void
      {
         if(param1.currentTarget == cmdRight)
         {
            this.countUpTimeInv = new TimeLimiter(500);
         }
         else if(param1.currentTarget == cmdLeft)
         {
            this.countDownTimeInv = new TimeLimiter(500);
         }
      }
      
      private function obf_0_9_726(param1:Event) : void
      {
         if(this.moneyCount < 1)
         {
            return;
         }
         var _loc2_:Array = DevilGodManager.devilGodDevilGodInfo;
         if(!_loc2_ || _loc2_.length == 0)
         {
            return;
         }
         var _loc3_:int = obf_K_e_3075.devilGodUI.devilGodLevel;
         if(_loc3_ < 1)
         {
            return;
         }
         if(this.moneyCount * DevilGodManager.devilGodGrowByMoney > _loc2_[_loc3_ - 1].upGrow || this.moneyCount * DevilGodManager.devilGodGrowByMoney + obf_K_e_3075.devilGodUI.devilGodGrow > _loc2_[_loc3_ - 1].upGrow)
         {
            WindowManager.showMessageBox(DiversityManager.getString("DevilGodUseMoneyUI","maxMoneyGrow"));
            this.obf_J_m_1486();
            return;
         }
         DevilGodManager.sendDevilGodUseMoneyReq(this.moneyCount);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.visible)
         {
            if(Boolean(this.countUpTimeInv) && this.countUpTimeInv.checkTimeout(true))
            {
               ++this.moneyCount;
               this.moneyCount = Math.min(this.moneyCount,GameContext.localPlayer.fullInfo.money);
               txtCount.text = this.moneyCount + "";
            }
            if(Boolean(this.countDownTimeInv) && this.countDownTimeInv.checkTimeout(true))
            {
               --this.moneyCount;
               this.moneyCount = Math.max(0,this.moneyCount);
               txtCount.text = this.moneyCount + "";
            }
         }
      }
      
      public function obf_J_m_1486() : void
      {
         this.moneyCount = 0;
         txtCount.text = this.moneyCount + "";
      }
      
      public function getIconItemBags() : Array
      {
         return null;
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
         DiversityManager.setTextField(txtExplain,"DevilGodUseMoneyUI","txtExplain",[DevilGodManager.devilGodGrowByMoney]);
         DiversityManager.setTextField(txtNum,"DevilGodUseMoneyUI","txtNum");
         cmdSure.label = DiversityManager.getString("DevilGodUseMoneyUI","cmdSure");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.obf_J_m_1486();
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this.countUpTimeInv = null;
         this.countDownTimeInv = null;
      }
   }
}

