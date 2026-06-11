package obf_A_z_3492
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.bless.BlessSellInfo;
   import com.sunweb.game.rpg.bless.obf_G_4_4620;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemSkill;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.skill.SkillManager;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.BlessBoothViewUIMC;
   
   public class obf_F_k_1994 extends BlessBoothViewUIMC implements IIconItemUI
   {
      
      private var obf_9_i_1208:IconItemBag;
      
      private var obf_C_v_1189:BlessSellInfo;
      
      private var obf_a_i_1176:String;
      
      public function obf_F_k_1994()
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
      
      public function get playerName() : String
      {
         return this.obf_a_i_1176;
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdBuy.addEventListener(MouseEvent.CLICK,this.onClickBuy);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdBuy.removeEventListener(MouseEvent.CLICK,this.onClickBuy);
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
      
      private function onClickBuy(param1:Event) : void
      {
         if(!this.obf_C_v_1189 || obf_L_l_4100.isEmpty(this.obf_a_i_1176))
         {
            return;
         }
         if(GameContext.localPlayer.fullInfo.charmInt < this.obf_C_v_1189.blessPrice)
         {
            obf_K_e_3075.showInfoOnUI(DiversityManager.getString("BlessUI","prompt_NeedMoreCharmInt"),this);
            return;
         }
         obf_G_4_4620.sendBuyBless(this.obf_C_v_1189.blessCode,this.obf_C_v_1189.blessLevel,this.obf_C_v_1189.blessPrice,this.obf_a_i_1176);
         obf_K_e_3075.closeUI(this);
      }
      
      public function showBlessBooth(param1:BlessSellInfo, param2:String) : void
      {
         if(!param1 || obf_L_l_4100.isEmpty(param2))
         {
            return;
         }
         var _loc3_:IconItemSkill = IconItemSkill.getNewIconItem(param1.blessCode,param1.blessLevel);
         if(!_loc3_)
         {
            return;
         }
         this.obf_9_i_1208.dropIconItem();
         this.obf_9_i_1208.pushIconItem(_loc3_);
         txtBlessName.text = SkillManager.getSkillName(param1.blessCode) + " Lv" + param1.blessLevel;
         txtPrice.text = param1.blessPrice + "";
         txtMyCharmInt.text = GameContext.localPlayer.fullInfo.charmInt + "";
         txtTransacCount.text = DiversityManager.getString("BlessUI","txtTracatNum",[param1.buyNum]);
         this.obf_C_v_1189 = param1;
         this.obf_a_i_1176 = param2;
         obf_K_e_3075.showUI(this);
      }
      
      public function obf_0_4_K_719() : void
      {
         this.obf_C_v_1189 = null;
         this.obf_a_i_1176 = "";
         this.obf_9_i_1208.dropIconItem();
         txtBlessName.text = "";
         txtPrice.text = "";
         txtMyCharmInt.text = "";
         txtTransacCount.text = "";
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
         DiversityManager.setTextField(txtDeyMyCharmInt,"BlessUI","txtMyCharmInt");
         DiversityManager.setTextField(txtDeyTransacCount,"BlessUI","txtTransacCount");
         cmdBuy.label = DiversityManager.getString("BlessUI","cmdBuyBless");
      }
      
      public function showUI() : void
      {
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.obf_0_4_K_719();
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

