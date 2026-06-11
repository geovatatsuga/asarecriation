package obf_A_z_3492
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.bless.obf_G_4_4620;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemSkill;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.rpg.skill.SkillManager;
   import com.sunweb.game.rpg.skill.obf_M_F_3694;
   import com.sunweb.game.ui.WindowManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import playerUI.BlessBoothUIMC;
   
   public class BlessBoothUI extends BlessBoothUIMC implements IIconItemUI
   {
      
      private var obf_9_i_1208:IconItemBag;
      
      private var obf_0_4_o_271:String;
      
      public function BlessBoothUI()
      {
         super();
         this.initDiversity();
         titleBox.mouseEnabled = false;
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.obf_9_i_1208 = new IconItemBag(bagBlessSkill,this,0);
         this.obf_9_i_1208.addValidType(GameItemType.SKILL);
         this.obf_9_i_1208.lockDrag = true;
         this.addListener();
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdBless.addEventListener(MouseEvent.CLICK,this.obf_r_D_1563);
         inputPrice.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdBless.removeEventListener(MouseEvent.CLICK,this.obf_r_D_1563);
         inputPrice.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
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
      
      private function obf_m_I_3657(param1:Event) : void
      {
         param1.stopImmediatePropagation();
      }
      
      private function obf_r_D_1563(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(GameContext.localPlayer.isBlessing)
         {
            obf_G_4_4620.sendStopBless();
         }
         else
         {
            if(SkillManager.getSkillType(this.obf_0_4_o_271) != obf_M_F_3694.obf_0_7_O_353)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("BlessUI","prompt_SellBlessError"));
               return;
            }
            _loc2_ = int(inputPrice.text);
            _loc3_ = obf_G_4_4620.getBlessLevelLowPrice(this.obf_0_4_o_271,PlayerSkillManager.getSkillLevel(this.obf_0_4_o_271));
            if(_loc2_ < _loc3_)
            {
               WindowManager.showMessageBox(DiversityManager.getString("BlessUI","prompt_PriceTooLow",[_loc3_]));
               return;
            }
            obf_G_4_4620.sendStartBless(this.obf_0_4_o_271,_loc2_);
         }
      }
      
      public function setBless(param1:Boolean) : void
      {
         inputPrice.editable = !param1;
         cmdBless.label = DiversityManager.getString("BlessUI",param1 ? "cmdStopBless" : "cmdStartBless");
      }
      
      public function showBless(param1:String) : void
      {
         var _loc3_:IconItemSkill = null;
         var _loc2_:int = PlayerSkillManager.getSkillLevel(param1);
         if(_loc2_ <= 0)
         {
            return;
         }
         _loc3_ = IconItemSkill.getNewIconItem(param1,_loc2_);
         if(!_loc3_)
         {
            return;
         }
         txtBlessName.text = SkillManager.getSkillName(param1) + " Lv" + _loc2_;
         this.obf_0_4_o_271 = param1;
         this.obf_9_i_1208.dropIconItem();
         this.obf_9_i_1208.pushIconItem(_loc3_);
         obf_K_e_3075.showUI(this);
      }
      
      public function obf_q_y_4041() : void
      {
         this.obf_0_4_o_271 = "";
         this.obf_9_i_1208.dropIconItem();
      }
      
      public function getIconItemBags() : Array
      {
         return [this.obf_9_i_1208];
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
         DiversityManager.setTextField(txtDeyTitle,"BlessUI","txtBless");
         DiversityManager.setTextField(txtDeyBlessSkill,"BlessUI","txtBlessSkill");
         DiversityManager.setTextField(txtDeyPrice,"BlessUI","txtSellCharmInt");
         cmdBless.label = DiversityManager.getString("BlessUI","cmdStartBless");
      }
      
      public function showUI() : void
      {
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

