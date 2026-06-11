package obf_a_2_2914
{
   import obf_R_R_2172.obf_1_Y_1502;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemEquip;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import playerUI.DivineUIMC;
   
   public class DivineUI extends DivineUIMC implements IIconItemUI
   {
      
      public var bags:Array;
      
      private var equipIconBag:IconItemBag;
      
      public var divineValue:int;
      
      private var time:TimeLimiter = new TimeLimiter(500);
      
      public function DivineUI()
      {
         super();
         this.cacheAsBitmap = true;
         this.initDiversity();
         this.visible = false;
         this.onResize(null);
         this.bags = new Array();
         this.equipIconBag = new IconItemBag(equipIcon,this,0);
         this.equipIconBag.addValidType(GameItemType.EQUIPMENT);
         this.bags.push(this.equipIconBag);
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.underline = true;
         _loc1_.bold = true;
         txtExplain.setTextFormat(_loc1_);
         this.divineValue = -1;
         this.addListener();
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         cmdDivine.addEventListener(MouseEvent.CLICK,this.obf_J_e_3448);
         cmdUp.addEventListener(MouseEvent.CLICK,this.obf_s_l_1008);
         cmdGain.addEventListener(MouseEvent.CLICK,this.obf_8_B_3049);
         obf_K_e_3075.addUIMouseToolTip(txtExplain,"txtDivineExplain");
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         cmdDivine.removeEventListener(MouseEvent.CLICK,this.obf_J_e_3448);
         cmdUp.removeEventListener(MouseEvent.CLICK,this.obf_s_l_1008);
         cmdGain.removeEventListener(MouseEvent.CLICK,this.obf_8_B_3049);
         obf_K_e_3075.removeUIMouseToolTip(txtExplain);
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
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.time.checkTimeout())
         {
            txtNum.text = obf_1_Y_1502.dayTimes + "/" + obf_1_Y_1502.obf_S_O_3216();
         }
      }
      
      private function obf_J_e_3448(param1:Event) : void
      {
         if(!this.equipIconBag.haveIconItem)
         {
            WindowManager.showMessageBox(DiversityManager.getString("DivineUI","pushDivineEquip"));
            return;
         }
         var _loc2_:Object = obf_1_Y_1502.divineLeveAttrsConfig(obf_1_Y_1502.divineLevel);
         var _loc3_:int = int(_loc2_.addNeedValue);
         if(int(txtValue.text) < _loc3_)
         {
            WindowManager.showMessageBox(DiversityManager.getString("DivineUI","needDivineNum",[_loc3_]));
            return;
         }
         var _loc4_:String = obf_1_Y_1502.getConfigValue("equipmentKind");
         var _loc5_:Object = GameItemManager.getItemConfig(this.equipIconBag.haveIconItem.itemCode);
         if(_loc4_.indexOf(_loc5_.properties.kind) == -1)
         {
            WindowManager.showMessageBox(DiversityManager.getString("DivineUI","NotDivineEquip"));
            return;
         }
         obf_1_Y_1502.sendEquipmentDivine(this.equipIconBag.haveIconItem.itemId);
      }
      
      private function obf_s_l_1008(param1:Event) : void
      {
         var _loc2_:Object = obf_1_Y_1502.divineLeveAttrsConfig(obf_1_Y_1502.divineLevel);
         var _loc3_:int = int(_loc2_.upValue);
         var _loc4_:Array = obf_1_Y_1502.divineLeveConfig();
         if(obf_1_Y_1502.divineLevel < _loc4_.length)
         {
            if(int(txtValue.text) < _loc3_)
            {
               WindowManager.showMessageBox(DiversityManager.getString("DivineUI","needDivineNum",[_loc3_]));
               return;
            }
            obf_1_Y_1502.sendDivineUpLevel();
            return;
         }
         WindowManager.showMessageBox(DiversityManager.getString("DivineUI","maxLv"));
      }
      
      private function obf_8_B_3049(param1:Event) : void
      {
         if(obf_1_Y_1502.obf_S_O_3216() - obf_1_Y_1502.dayTimes <= 0)
         {
            return;
         }
         if(!ConditionScript.checkCondition(obf_1_Y_1502.getConfigValue("itemCondition"),null,true))
         {
            return;
         }
         if(obf_K_e_3075.playerBagUI.getEqualItemCount(obf_1_Y_1502.obf_X_W_3534()) > 0)
         {
            return;
         }
         if(!obf_K_e_3075.playerBagUI.haveEmptyBag(1))
         {
            return;
         }
         obf_1_Y_1502.sendGetFreeItem();
      }
      
      public function obf_p_R_2702(param1:int) : void
      {
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc15_:String = null;
         var _loc16_:String = null;
         var _loc17_:String = null;
         var _loc2_:Array = obf_1_Y_1502.divineLeveConfig();
         var _loc3_:String = "";
         var _loc4_:String = "";
         if(!_loc2_)
         {
            return;
         }
         if(param1 < 1)
         {
            return;
         }
         var _loc5_:Object = _loc2_[param1 - 1];
         txtDivineName.htmlText = _loc5_.name;
         var _loc6_:Array = _loc5_.addAttrs;
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_.length)
         {
            _loc12_ = RoleAttributesModifierEnum.getAttributesName(_loc6_[_loc7_].type);
            _loc13_ = RoleAttributesModifierEnum.getAttributesValueString(_loc6_[_loc7_].type,_loc6_[_loc7_].min,false,true);
            _loc14_ = RoleAttributesModifierEnum.getAttributesValueString(_loc6_[_loc7_].type,_loc6_[_loc7_].max,false,true);
            _loc3_ += _loc12_ + "\n";
            _loc4_ += _loc13_ + " - " + _loc14_ + "\n";
            _loc7_++;
         }
         txtDayCurrentAttr.htmlText = _loc3_;
         txtCurrentAtts.htmlText = _loc4_;
         var _loc8_:String = "";
         var _loc9_:String = "";
         if(param1 >= obf_1_Y_1502.divineLeveConfig().length)
         {
            txtDayCurrentAttr2.htmlText = _loc8_;
            txtNextAtts.htmlText = _loc9_;
            return;
         }
         var _loc10_:Array = _loc2_[param1].addAttrs;
         var _loc11_:int = 0;
         while(_loc11_ < _loc10_.length)
         {
            _loc15_ = RoleAttributesModifierEnum.getAttributesName(_loc10_[_loc11_].type);
            _loc16_ = RoleAttributesModifierEnum.getAttributesValueString(_loc10_[_loc11_].type,_loc10_[_loc11_].min,false,true);
            _loc17_ = RoleAttributesModifierEnum.getAttributesValueString(_loc10_[_loc11_].type,_loc10_[_loc11_].max,false,true);
            _loc8_ += _loc15_ + "\n";
            _loc9_ += _loc16_ + " - " + _loc17_ + "\n";
            _loc11_++;
         }
         txtDayCurrentAttr2.htmlText = _loc8_;
         txtNextAtts.htmlText = _loc9_;
      }
      
      public function obf_D_s_3771(param1:int) : void
      {
         this.divineValue = param1;
         txtValue.text = param1 + "";
      }
      
      private function pushEquipIn(param1:IconItemEquip) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:Object = GameItemManager.getItemConfig(param1.itemCode);
         if(!_loc2_)
         {
            return;
         }
         this.equipIconBag.dropIconItem();
         this.equipIconBag.pushIconItem(param1);
      }
      
      public function clear() : void
      {
         this.equipIconBag.dropIconItem();
         this.equipIconBag.bagMC.alpha = 0.5;
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
         if(param3.parentIconUI == obf_K_e_3075.playerBagUI)
         {
            if(param1 == this.equipIconBag && param2 is IconItemEquip)
            {
               this.clear();
               this.equipIconBag.pushIconItem(param2);
               this.equipIconBag.bagMC.alpha = 1;
            }
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         if(param1 == this.equipIconBag)
         {
            this.clear();
         }
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return bgBox.getBounds(bgBox).contains(bgBox.mouseX,bgBox.mouseY);
         }
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"DivineUI","txtDeyTitle");
         DiversityManager.setTextField(txtCurrentAttrExplain,"DivineUI","txtCurrentAttrExplain");
         DiversityManager.setTextField(txtNextAttrExplain,"DivineUI","txtNextAttrExplain");
         DiversityManager.setTextField(txtDivineValue,"DivineUI","txtDivineValue");
         DiversityManager.setTextField(txtEquip,"DivineUI","txtEquip");
         txtExplain.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("DivineUI","txtExplain") + "</a>";
         cmdDivine.label = DiversityManager.getString("DivineUI","cmdDivine");
         cmdUp.label = DiversityManager.getString("DivineUI","cmdUp");
         cmdGain.label = DiversityManager.getString("DivineUI","cmdGain");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.clear();
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

