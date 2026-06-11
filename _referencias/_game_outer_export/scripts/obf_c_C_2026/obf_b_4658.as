package obf_c_C_2026
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import playerUI.BoothItemUIMC;
   
   public class obf_b_4658 extends BoothItemUIMC implements IIconItemUI
   {
      
      private var iconBag:IconItemBag;
      
      private var isAmend:Boolean = false;
      
      private var obf_U_q_2671:obf_0_9_P_664;
      
      public function obf_b_4658()
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         this.iconBag = new IconItemBag(iconBar,this,0);
         this.iconBag.addValidType(GameItemType.COLLECTION | GameItemType.EXPENDABLE);
         this.iconBag.lockDrag = true;
         this.addListener();
      }
      
      private function addListener() : void
      {
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         inputDiamond.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputDiamond.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputSilver.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputSilver.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputGold.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputGold.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputCopper.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputCopper.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputName.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputName.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputNum.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputNum.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputNum.addEventListener(Event.CHANGE,this.onInputValue);
         cmdValidate.addEventListener(MouseEvent.CLICK,this.obf_v_s_2597);
         cmdOk.addEventListener(MouseEvent.CLICK,this.onOk);
         cmdCancel.addEventListener(MouseEvent.CLICK,this.obf_0_4_h_132);
      }
      
      private function removerListener() : void
      {
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         inputDiamond.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputDiamond.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputSilver.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputSilver.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputGold.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputGold.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputCopper.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputCopper.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputName.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputName.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputNum.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputNum.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputNum.removeEventListener(Event.CHANGE,this.onInputValue);
         cmdValidate.removeEventListener(MouseEvent.CLICK,this.obf_v_s_2597);
         cmdOk.removeEventListener(MouseEvent.CLICK,this.onOk);
         cmdCancel.removeEventListener(MouseEvent.CLICK,this.obf_0_4_h_132);
      }
      
      private function obf_m_I_3657(param1:Event) : void
      {
         param1.stopPropagation();
      }
      
      private function onStartDrag(param1:MouseEvent) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      private function obf_v_s_2597(param1:MouseEvent) : void
      {
         if(obf_L_l_4100.isEmpty(inputName.text))
         {
            return;
         }
         this.iconBag.dropIconItem();
         var _loc2_:String = GameItemManager.getItemCode(inputName.text);
         if(obf_L_l_4100.isEmpty(_loc2_))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("BoothUI","promptBfmError_NoItem"));
            return;
         }
         if(!GameItemManager.itemCanTrade(_loc2_))
         {
            return;
         }
         if(GameItemManager.isEquip(_loc2_))
         {
            return;
         }
         var _loc3_:IconItem = IconItemManager.getIconItemByCode(_loc2_,"");
         if(!_loc3_)
         {
            return;
         }
         this.iconBag.pushIconItem(_loc3_);
         var _loc4_:int = GameItemManager.getStackSize(_loc2_);
         if(int(inputNum.text) > _loc4_)
         {
            inputNum.text = _loc4_ + "";
         }
      }
      
      private function onOk(param1:MouseEvent) : void
      {
         if(obf_L_l_4100.isEmpty(inputName.text) || obf_L_l_4100.isEmpty(inputNum.text))
         {
            return;
         }
         var _loc2_:String = GameItemManager.getItemCode(inputName.text);
         if(obf_L_l_4100.isEmpty(_loc2_))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("BoothUI","promptBfmError_NoItem"));
            return;
         }
         if(!GameItemManager.itemCanTrade(_loc2_))
         {
            return;
         }
         if(GameItemManager.isEquip(_loc2_))
         {
            return;
         }
         var _loc3_:int = int(inputDiamond.text) * 1000000 + int(inputGold.text) * 10000 + int(inputSilver.text) * 100 + int(inputCopper.text);
         if(_loc3_ <= 0)
         {
            _loc3_ = 1;
         }
         if(GameContext.localPlayer.fullInfo.gold < _loc3_ * int(inputNum.text) + obf_K_e_3075.boothBfmUI.allBfmGold)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("BoothUI","promptBfmError_CantBfm"));
            return;
         }
         var _loc4_:int = GameItemManager.getStackSize(_loc2_);
         if(int(inputNum.text) > _loc4_)
         {
            inputNum.text = _loc4_ + "";
         }
         if(this.isAmend)
         {
            obf_K_e_3075.boothBfmUI.bfmAmend(this.obf_U_q_2671,_loc3_,int(inputNum.text));
         }
         else
         {
            obf_K_e_3075.boothBfmUI.addBfmItem(_loc3_,_loc2_,"",int(inputNum.text));
         }
         obf_K_e_3075.closeUI(this);
      }
      
      private function obf_0_4_h_132(param1:MouseEvent) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function onInputValue(param1:Event) : void
      {
         var _loc2_:String = GameItemManager.getItemCode(inputName.text);
         var _loc3_:int = int(inputNum.text);
         var _loc4_:int = GameItemManager.getStackSize(_loc2_);
         if(_loc3_ < 1)
         {
            _loc3_ = 1;
         }
         else if(_loc3_ > _loc4_)
         {
            _loc3_ = _loc4_;
         }
         inputNum.text = _loc3_ + "";
      }
      
      public function setItem(param1:String, param2:String = "") : void
      {
         if(obf_L_l_4100.isEmpty(param1))
         {
            return;
         }
         this.obf_E_j_2700();
         if(!GameItemManager.itemCanTrade(param1))
         {
            return;
         }
         if(GameItemManager.isEquip(param1))
         {
            return;
         }
         var _loc3_:IconItem = IconItemManager.getIconItemByCode(param1,param2);
         if(!_loc3_)
         {
            return;
         }
         this.iconBag.pushIconItem(_loc3_);
         inputName.text = GameItemManager.getItemName(param1);
      }
      
      public function setAmendItem(param1:obf_0_9_P_664, param2:Number) : void
      {
         if(!param1)
         {
            return;
         }
         this.isAmend = true;
         this.obf_U_q_2671 = param1;
         inputName.enabled = false;
         cmdValidate.enabled = false;
         inputName.text = GameItemManager.getItemName(param1.iconBag.haveIconItem.itemCode);
         inputNum.text = param1.iconBag.haveIconItem.itemCount + "";
         var _loc3_:Array = obf_a_f_2935.getGoldRank(param2);
         inputDiamond.text = _loc3_[0] + "";
         inputGold.text = _loc3_[1] + "";
         inputSilver.text = _loc3_[2] + "";
         inputCopper.text = _loc3_[3] + "";
         var _loc4_:IconItem = param1.iconBag.haveIconItem.clone();
         if(_loc4_)
         {
            _loc4_.itemCount = 1;
            this.iconBag.pushIconItem(_loc4_);
         }
      }
      
      public function obf_E_j_2700() : void
      {
         this.iconBag.dropIconItem();
         inputName.text = "";
         inputNum.text = "1";
         inputDiamond.text = "";
         inputGold.text = "";
         inputSilver.text = "";
         inputCopper.text = "";
         this.isAmend = false;
         inputName.enabled = true;
         cmdValidate.enabled = true;
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
         DiversityManager.setTextField(txtName,"BoothUI","txtName");
         DiversityManager.setTextField(txtNub,"BoothUI","txtNub");
         DiversityManager.setTextField(txtPrice,"BoothUI","txtPrice");
         cmdValidate.label = DiversityManager.getString("BoothUI","cmdValidate");
         cmdOk.label = DiversityManager.getString("BoothUI","cmdOk");
         cmdCancel.label = DiversityManager.getString("BoothUI","cmdCancel");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.obf_E_j_2700();
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removerListener();
      }
   }
}

