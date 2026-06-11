package obf_8_d_4188
{
   import obf_T_4_4162.obf_0_4_3_717;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.ui.WindowManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.ForgeGodUIMC;
   
   public class obf_q_s_2314 extends ForgeGodUIMC implements IPlayerUI, IIconItemUI
   {
      
      public var level:int;
      
      public var value:int;
      
      private var itemBag1:IconItemBag;
      
      private var itemBag2:IconItemBag;
      
      public function obf_q_s_2314()
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         var _loc3_:IconItem = null;
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         this.itemBag1 = new IconItemBag(icon1,this,0);
         this.itemBag1.addValidType(GameItemType.ALL);
         this.itemBag1.lockDrag = true;
         this.itemBag2 = new IconItemBag(icon2,this,0);
         this.itemBag2.addValidType(GameItemType.ALL);
         this.itemBag2.lockDrag = true;
         this.expBar.gotoAndStop(1);
         for(_loc1_ in obf_0_4_3_717.toMapCost)
         {
            _loc2_ = int(obf_0_4_3_717.toMapCost[_loc1_]);
            _loc3_ = IconItemManager.getIconItemByCode(_loc1_,null);
            _loc3_.itemCount = _loc2_;
            this.itemBag1.pushIconItem(_loc3_);
         }
         this.addListener();
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtTitle,"forgeGodUI","txtTitle");
         DiversityManager.setTextField(txtPower,"forgeGodUI","txtPower");
         DiversityManager.setTextField(txtForgeGod,"forgeGodUI","txtForgeGod");
         txtInfo.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("forgeGodUI","txtInfo") + "</a>";
         cmdToMap.label = DiversityManager.getString("forgeGodUI","cmdToMap");
         cmdForgeGod.label = DiversityManager.getString("forgeGodUI","cmdForgeGod");
      }
      
      private function addListener() : void
      {
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdToMap.addEventListener(MouseEvent.CLICK,this.obf_X_O_3513);
         cmdForgeGod.addEventListener(MouseEvent.CLICK,this.obf_0_0_d_337);
         obf_K_e_3075.addUIMouseToolTip(txtInfo,"forgeGodInfo");
      }
      
      private function removeListener() : void
      {
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdToMap.removeEventListener(MouseEvent.CLICK,this.obf_X_O_3513);
         cmdForgeGod.removeEventListener(MouseEvent.CLICK,this.obf_0_0_d_337);
         obf_K_e_3075.removeUIMouseToolTip(txtInfo);
      }
      
      public function obf_X_O_3513(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         param1.stopPropagation();
         if(!ConditionScript.checkCondition(obf_0_4_3_717.openCon,null,true))
         {
            return;
         }
         var _loc2_:String = GameContext.currentMap.mapId;
         if(obf_0_4_3_717.getNoChallgeMapIdList().indexOf(_loc2_) >= 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("forgeGodUI","noChallge"));
            return;
         }
         if(obf_0_4_3_717.getCanChallgeMapIdList().length > 0 && obf_0_4_3_717.getCanChallgeMapIdList().indexOf(_loc2_) == -1)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("forgeGodUI","noChallge"));
            return;
         }
         for(_loc3_ in obf_0_4_3_717.toMapCost)
         {
            _loc4_ = int(obf_0_4_3_717.toMapCost[_loc3_]);
            if(obf_K_e_3075.playerBagUI.getItemCount(_loc3_) < _loc4_)
            {
               WindowManager.showMessageBox(DiversityManager.getString("forgeGodUI","noItem"));
               return;
            }
         }
         obf_0_4_3_717.obf_X_O_3513();
      }
      
      public function obf_0_0_d_337(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         param1.stopPropagation();
         if(!ConditionScript.checkCondition(obf_0_4_3_717.openCon,null,true))
         {
            return;
         }
         if(this.level >= obf_0_4_3_717.maxLevel)
         {
            return;
         }
         var _loc2_:Object = obf_0_4_3_717.getLevelConfig(this.level);
         if(!_loc2_)
         {
            return;
         }
         if(this.value < _loc2_.costValue)
         {
            WindowManager.showMessageBox(DiversityManager.getString("forgeGodUI","noValue"));
            return;
         }
         if(_loc2_.costItems)
         {
            for(_loc3_ in _loc2_.costItems)
            {
               _loc4_ = int(_loc2_.costItems[_loc3_]);
               if(obf_K_e_3075.playerBagUI.getItemCount(_loc3_) < _loc4_)
               {
                  WindowManager.showMessageBox(DiversityManager.getString("forgeGodUI","noItem"));
                  return;
               }
            }
         }
         obf_0_4_3_717.obf_0_0_d_337();
      }
      
      public function refresh() : void
      {
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc10_:IconItem = null;
         txtPowerValue.text = this.value + "";
         txtForgeGodValue.text = this.level + "";
         var _loc1_:Object = obf_0_4_3_717.getLevelConfig(this.level);
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:int = int(_loc1_.costValue);
         var _loc3_:int = Math.round(this.value * 100 / _loc2_);
         if(_loc3_ < 1)
         {
            _loc3_ = 1;
         }
         else if(_loc3_ > 100)
         {
            _loc3_ = 100;
         }
         expBar.gotoAndStop(_loc3_);
         if(_loc1_.attr)
         {
            _loc4_ = 0;
            for(_loc5_ in _loc1_.attr)
            {
               _loc6_ = int(_loc5_);
               _loc7_ = int(_loc1_.attr[_loc5_]);
               this["txtAttr" + _loc4_].text = RoleAttributesModifierEnum.getAttributesName(_loc6_) + ":";
               this["txtAttrValue" + _loc4_].text = "+" + _loc7_;
               if(++_loc4_ >= 15)
               {
                  break;
               }
            }
         }
         this.itemBag2.dropIconItem();
         if(_loc1_.costItems)
         {
            for(_loc8_ in _loc1_.costItems)
            {
               _loc9_ = int(_loc1_.costItems[_loc8_]);
               _loc10_ = IconItemManager.getIconItemByCode(_loc8_,null);
               _loc10_.itemCount = _loc9_;
               this.itemBag2.pushIconItem(_loc10_);
            }
         }
      }
      
      public function obf_9_5_4194() : void
      {
         txtPowerValue.text = this.value + "";
         var _loc1_:Object = obf_0_4_3_717.getLevelConfig(this.level);
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:int = int(_loc1_.costValue);
         var _loc3_:int = Math.round(this.value * 100 / _loc2_);
         if(_loc3_ < 1)
         {
            _loc3_ = 1;
         }
         else if(_loc3_ > 100)
         {
            _loc3_ = 100;
         }
         expBar.gotoAndStop(_loc3_);
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
         this.itemBag2.destroy();
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
      
      public function getIconItemBags() : Array
      {
         return [this.itemBag1,this.itemBag2];
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

