package obf_0_5_Z_663
{
   import obf_0_7_V_532.*;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.utils.obf_L_l_4100;
   import fl.controls.Button;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.GenieMagicSummonUIMC;
   
   public class obf_0_9_N_71 extends GenieMagicSummonUIMC implements IPlayerUI, IIconItemUI
   {
      
      private var bags:Array;
      
      private var buttonArr:Array;
      
      private var _itemConfig:Object;
      
      public function obf_0_9_N_71()
      {
         var _loc2_:IconItemBag = null;
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         txtDeyTitle.mouseEnabled = false;
         this.bags = new Array();
         this.buttonArr = new Array();
         var _loc1_:int = 1;
         while(_loc1_ < 8)
         {
            _loc2_ = new IconItemBag(this["summonIcon" + _loc1_],this,_loc1_);
            _loc2_.addValidType(GameItemType.ALL);
            _loc2_.isLocked = false;
            this.bags.push(_loc2_);
            _loc1_++;
         }
         this.buttonArr = [this.cmdSummon1,this.cmdSummon2,this.cmdSummon3,this.cmdSummon4,this.cmdSummon5,this.cmdSummon6,this.cmdSummon7];
         this.addListener();
      }
      
      public function get itemConfig() : Object
      {
         return this._itemConfig;
      }
      
      public function set itemConfig(param1:Object) : void
      {
         this._itemConfig = param1;
      }
      
      private function showGenieMagicSummon(param1:Object) : void
      {
         var _loc2_:IconItemBag = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:IconItemBag = null;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:Object = null;
         var _loc10_:IconItem = null;
         for each(_loc2_ in this.bags)
         {
            _loc2_.dropIconItem();
         }
         _loc3_ = obf_N_o_3647.getGenieMagicElementConfig().skillConfig as Array;
         _loc4_ = 0;
         for(_loc5_ in param1)
         {
            if(_loc4_ >= this.bags.length)
            {
               break;
            }
            _loc6_ = this.bags[_loc4_];
            _loc7_ = 0;
            while(_loc7_ < _loc3_.length)
            {
               if(_loc3_[_loc7_].id == _loc5_ && _loc3_[_loc7_].GenieMagicSkillTypeEnum == GenieMagicSkillTypeEnum.obf_K_z_1029)
               {
                  _loc8_ = _loc3_[_loc7_].callCodes[param1[_loc5_] - 1];
                  _loc9_ = GameItemManager.getItemConfig(_loc8_);
                  if((Boolean(_loc9_)) && _loc9_.type == GameItemType.PET)
                  {
                     _loc10_ = IconItemManager.getIconItemByCode(_loc8_,"");
                     _loc6_.pushIconItem(_loc10_);
                     this.buttonArr[_loc4_].id = _loc5_;
                     this.buttonArr[_loc4_].remark = _loc4_;
                     this.buttonArr[_loc4_].icon = _loc10_;
                     _loc4_++;
                     break;
                  }
               }
               _loc7_++;
            }
         }
      }
      
      private function addListener() : void
      {
         var _loc1_:Button = null;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         titleBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         for each(_loc1_ in this.buttonArr)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.onClickButton);
         }
      }
      
      private function removeListener() : void
      {
         var _loc1_:Button = null;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         titleBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         for each(_loc1_ in this.buttonArr)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onClickButton);
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
      }
      
      private function onClickButton(param1:Event) : void
      {
         if(obf_L_l_4100.isEmpty(param1.currentTarget.id))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("GenieMagicBoxUI","ErrorWork"));
            return;
         }
         if(!obf_L_l_4100.isEmpty(param1.currentTarget.id))
         {
            obf_N_o_3647.sendGenieMagicUseSkill(param1.currentTarget.id);
            obf_K_e_3075.genieMagicSkillUI.cmdElemSum.id = param1.currentTarget.id;
            obf_K_e_3075.genieMagicSkillUI.cmdElemSum.bindIcon = param1.currentTarget.icon;
            obf_K_e_3075.genieMagicSkillUI.cmdElemSum.enabled = false;
            obf_K_e_3075.genieMagicSkillUI.elementBag.dropIconItem();
            obf_K_e_3075.genieMagicSkillUI.elementBag.pushIconItem(param1.currentTarget.icon);
            this.closeUI();
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
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"GenieMagicBoxUI","txtGenieSumTitle");
         DiversityManager.setTextField(txtDeyExplain,"GenieMagicBoxUI","txtGenieSumExplain");
         cmdSummon1.label = DiversityManager.getString("GenieMagicBoxUI","cmdSummon");
         cmdSummon2.label = DiversityManager.getString("GenieMagicBoxUI","cmdSummon");
         cmdSummon3.label = DiversityManager.getString("GenieMagicBoxUI","cmdSummon");
         cmdSummon4.label = DiversityManager.getString("GenieMagicBoxUI","cmdSummon");
         cmdSummon5.label = DiversityManager.getString("GenieMagicBoxUI","cmdSummon");
         cmdSummon6.label = DiversityManager.getString("GenieMagicBoxUI","cmdSummon");
         cmdSummon7.label = DiversityManager.getString("GenieMagicBoxUI","cmdSummon");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.showGenieMagicSummon(obf_N_o_3647.magicSkills);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
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
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
   }
}

