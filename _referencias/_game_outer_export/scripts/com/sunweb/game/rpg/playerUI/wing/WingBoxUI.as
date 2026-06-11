package com.sunweb.game.rpg.playerUI.wing
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.equ.EquipmentKind;
   import com.sunweb.game.rpg.equ.EquipmentManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.gameItem.obf_x_c_2855;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.netRole.obf_Y_E_3667;
   import com.sunweb.game.rpg.playerUI.obf_0_d_4341;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.obf_E_k_1445;
   import com.sunweb.game.rpg.role.action.obf_D_0_1300;
   import com.sunweb.game.rpg.role.action.obf_S_c_3330;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.rpg.sound.obf_q_6_3634;
   import com.sunweb.game.rpg.wingSpirit.obf_B_5_1274;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.worldZone.command.npc.NpcAssembleItemAnswer;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import fl.data.DataProvider;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import playerUI.WingBoxUIMC;
   
   public class WingBoxUI extends WingBoxUIMC implements IIconItemUI, obf_0_d_4341
   {
      
      private var allBags:Array;
      
      private var wingBag:IconItemBag;
      
      private var targetWingBag:IconItemBag;
      
      private var wingMaterialBag:IconItemBag;
      
      private var currentWingAssConfig:Object;
      
      private var _player:obf_Y_E_3667;
      
      private var _noviceSprite:Sprite;
      
      public function WingBoxUI()
      {
         super();
         this.initDiversity();
         this.y = GameContext.gameStage.stageHeight / 2;
         this.x = GameContext.gameStage.stageWidth - 300;
         this.visible = false;
         titleBox.mouseEnabled = false;
         obf_Q_0_1896.visible = false;
         cmdWingSpirit.visible = WorldConfig.getValue("functionSwitch","showWingSpirit");
         txtDeyChance.visible = false;
         txtChance.visible = false;
         this.allBags = new Array();
         this.wingBag = new IconItemBag(bagWing,this,0);
         this.wingBag.lockDrag = true;
         this.wingBag.addValidType(GameItemType.EQUIPMENT);
         this.allBags.push(this.wingBag);
         this.targetWingBag = new IconItemBag(bagTargetWing,this,0);
         this.targetWingBag.lockDrag = true;
         this.targetWingBag.addValidType(GameItemType.EQUIPMENT);
         this.allBags.push(this.targetWingBag);
         this.wingMaterialBag = new IconItemBag(bagMaterial,this,0);
         this.wingMaterialBag.lockDrag = true;
         this.wingMaterialBag.addValidType(GameItemType.ALL);
         this.allBags.push(this.wingMaterialBag);
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"WingBoxUI","txtTitle");
         DiversityManager.setTextField(txtDeyWingPrv,"WingBoxUI","txtWingPrv");
         DiversityManager.setTextField(txtDeyPrompt1,"WingBoxUI","txtPushWing");
         DiversityManager.setTextField(txtDeyMaterial,"WingBoxUI","txtWingMaterial");
         DiversityManager.setTextField(txtDeyChance,"WingBoxUI","txtWingChance");
         cmdAssWing.label = DiversityManager.getString("WingBoxUI","cmdAssWing");
         cmdWingSpirit.label = DiversityManager.getString("WingBoxUI","cmdWingSpirit");
      }
      
      public function set noviceSprite(param1:Sprite) : void
      {
         this._noviceSprite = param1;
      }
      
      public function get noviceSprite() : Sprite
      {
         return this._noviceSprite;
      }
      
      public function get novicePromptName() : String
      {
         return "WingBoxUI";
      }
      
      public function getTargetPoint(param1:String) : Point
      {
         var _loc2_:DisplayObject = this[param1];
         if(!_loc2_)
         {
            return null;
         }
         return new Point(_loc2_.x + _loc2_.width / 2,_loc2_.y + _loc2_.height / 2);
      }
      
      public function getHighLightDisplayObject(param1:String) : DisplayObject
      {
         return JSONUtil.getObject(this,[param1]) as DisplayObject;
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         listWing.addEventListener(Event.CHANGE,this.obf_0_6_p_230);
         cmdAssWing.addEventListener(MouseEvent.CLICK,this.obf_L_i_1157);
         cmdWingSpirit.addEventListener(MouseEvent.CLICK,this.obf_x_N_3059);
         obf_K_e_3075.addUIMouseToolTip(obf_Q_0_1896,"Luck_StarPrompt");
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         listWing.removeEventListener(Event.CHANGE,this.obf_0_6_p_230);
         cmdAssWing.removeEventListener(MouseEvent.CLICK,this.obf_L_i_1157);
         cmdWingSpirit.addEventListener(MouseEvent.CLICK,this.obf_x_N_3059);
         obf_K_e_3075.removeUIMouseToolTip(obf_Q_0_1896);
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
      
      private function obf_x_N_3059(param1:Event) : void
      {
         param1.stopPropagation();
         if(!ConditionScript.checkCondition(obf_B_5_1274.wingSpiritConfig.openCondition,null,true))
         {
            return;
         }
         if(!obf_K_e_3075.wingSpiritUI)
         {
            return;
         }
         if(obf_K_e_3075.wingSpiritUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.wingSpiritUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.wingSpiritUI);
         }
      }
      
      private function obf_0_6_p_230(param1:Event) : void
      {
         if(this.visible)
         {
            this.showWingPreview();
         }
      }
      
      private function obf_L_i_1157(param1:Event) : void
      {
         var _loc2_:String = null;
         if(!this.currentWingAssConfig)
         {
            return;
         }
         for(_loc2_ in this.currentWingAssConfig.baseItems)
         {
            if(_loc2_ != this.wingBag.haveIconItem.itemCode)
            {
               if(GameContext.bagItemManager.getHaveItemCount(_loc2_,true) < this.currentWingAssConfig.baseItems[_loc2_])
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("AssembleBoxUI","noMoreMaterial",[GameItemManager.getItemName(_loc2_)]));
                  return;
               }
            }
         }
         if(!ConditionScript.checkCondition(this.currentWingAssConfig.condition,null,true))
         {
            return;
         }
         var _loc3_:IconItemBag = obf_K_e_3075.playerFullInfoUI.getEquipBagByKind(EquipmentKind.WING);
         if(Boolean(this.wingBag.haveIconItem) && Boolean(_loc3_.haveIconItem) && this.wingBag.haveIconItem.itemId == _loc3_.haveIconItem.itemId)
         {
            EquipmentManager.sendRemoveEquip(EquipmentKind.WING,-1);
         }
         obf_x_c_2855.sendAssemble("",null,this.currentWingAssConfig.ruleIndex,null,true);
      }
      
      private function obf_d_x_2332() : void
      {
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:IconItem = null;
         this.obf_P_P_1580();
         if(!this.wingBag.haveIconItem)
         {
            return;
         }
         var _loc1_:Object = GameItemManager.getItemConfig(this.wingBag.haveIconItem.itemCode);
         if(!_loc1_)
         {
            return;
         }
         txtWingName.text = _loc1_.name;
         this.currentWingAssConfig = obf_x_c_2855.getConfigInMaterialMap(_loc1_.code,0);
         if(!this.currentWingAssConfig)
         {
            return;
         }
         var _loc2_:String = this.currentWingAssConfig.mainTargetItem;
         txtTargetWingName.text = GameItemManager.getItemName(_loc2_);
         var _loc3_:Object = GameItemManager.getItemConfig(_loc2_);
         if(!_loc3_)
         {
            return;
         }
         this.targetWingBag.dropIconItem();
         this.targetWingBag.pushIconItem(IconItemManager.getIconItemByCode(_loc2_,""));
         this.wingMaterialBag.dropIconItem();
         for(_loc4_ in this.currentWingAssConfig.baseItems)
         {
            if(_loc4_ != this.wingBag.haveIconItem.itemCode)
            {
               _loc8_ = IconItemManager.getIconItemByCode(_loc4_,"");
               if(_loc8_)
               {
                  _loc8_.itemCount = this.currentWingAssConfig.baseItems[_loc4_];
                  this.wingMaterialBag.pushIconItem(_loc8_);
                  break;
               }
            }
         }
         _loc5_ = new Array();
         _loc6_ = _loc2_;
         while(!obf_L_l_4100.isEmpty(_loc6_) && _loc7_ < 5)
         {
            _loc5_.push({
               "label":GameItemManager.getItemName(_loc6_),
               "data":_loc6_
            });
            _loc6_ = JSONUtil.getStr(obf_x_c_2855.getConfigInMaterialMap(_loc6_,0),["mainTargetItem"]);
            _loc7_++;
         }
         this._player = new obf_Y_E_3667(GameContext.localPlayer.fullInfo.jobCode,GameContext.localPlayer.fullInfo.sex,GameContext.localPlayer.fullInfo.hairStyleIndex);
         this._player.setEquipmentModels(GameContext.localPlayer.getEquipmentModels());
         this._player.moveToPixel(0,0);
         this._player.doAction(obf_S_c_3330.obf_h_4_3537,obf_D_0_1300.DOWN,true);
         pointImage.addChild(this._player);
         obf_x_c_2855.setLuckBox(obf_x_c_2855.getAssembleLuck(this.currentWingAssConfig.ruleIndex),obf_Q_0_1896);
         obf_Q_0_1896.visible = true;
         listWing.dataProvider = new DataProvider(_loc5_);
         listWing.selectedIndex = 0;
         this.showWingPreview();
      }
      
      private function showWingPreview() : void
      {
         var _loc3_:Object = null;
         if(!listWing.selectedItem || !this._player)
         {
            return;
         }
         var _loc1_:Object = GameItemManager.getItemConfig(listWing.selectedItem.data);
         if(!_loc1_)
         {
            return;
         }
         this._player.setUsingEquipmentModel(obf_E_k_1445.WING,JSONUtil.getStr(_loc1_,["properties","modelCode"]));
         this._player.obf_A_j_2560();
         var _loc2_:String = "";
         for each(_loc3_ in _loc1_.properties.extAttr)
         {
            _loc2_ += "   " + RoleAttributesModifierEnum.getAttributesName(_loc3_.attr) + "    ";
            _loc2_ += RoleAttributesModifierEnum.getAttributesValueString(_loc3_.attr,_loc3_.value) + "\n";
         }
         txtWingAttr.htmlText = _loc2_;
      }
      
      private function obf_P_P_1580() : void
      {
         if(this._player)
         {
            if(this._player.parent)
            {
               this._player.parent.removeChild(this._player);
            }
            this._player.destroy();
         }
         listWing.dataProvider = new DataProvider();
         txtWingName.text = "";
         txtTargetWingName.text = "";
         txtChance.text = "";
         txtWingAttr.htmlText = "";
         this.currentWingAssConfig = null;
         obf_Q_0_1896.visible = false;
      }
      
      private function obf_B_t_2901() : void
      {
         this.wingBag.dropIconItem();
         this.targetWingBag.dropIconItem();
         this.wingMaterialBag.dropIconItem();
      }
      
      public function obf_w_i_3412(param1:NpcAssembleItemAnswer) : void
      {
         var _loc2_:Object = null;
         var _loc3_:IconItemBag = null;
         if(Boolean(this.currentWingAssConfig) && this.currentWingAssConfig.ruleIndex == param1.assembleRuleIndex)
         {
            if(param1.isSucceeded)
            {
               WindowManager.showMessageBox(DiversityManager.getString("AssemblePrompt","assembleComplete"));
               obf_6_D_3816.print(DiversityManager.getString("AssemblePrompt","assembleComplete"));
               this.obf_B_t_2901();
               this.obf_P_P_1580();
               _loc2_ = obf_x_c_2855.getConfigById(param1.assembleRuleIndex + "");
               _loc3_ = obf_K_e_3075.playerBagUI.getIconItemBagByCode(_loc2_.mainTargetItem);
               if(Boolean(_loc3_) && Boolean(_loc3_.haveIconItem))
               {
                  this.wingBag.pushIconItem(_loc3_.haveIconItem.clone());
                  this.obf_d_x_2332();
               }
               obf_x_c_2855.setAssembleLuck(param1.assembleRuleIndex,0);
               obf_x_c_2855.setLuckBox(0,obf_Q_0_1896);
               obf_q_6_3634.obf_e_J_1876("dzhao@fs9",1);
            }
            else
            {
               obf_K_e_3075.showInfoOnUI(DiversityManager.getString("AssemblePrompt","assembleFail"),this,new Point(0,-100));
               obf_6_D_3816.print(DiversityManager.getString("AssemblePrompt","assembleFail"));
               obf_x_c_2855.setLuckBox(obf_x_c_2855.obf_0_2_6_666(param1.assembleRuleIndex),obf_Q_0_1896);
            }
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
         var _loc1_:IconItemBag = obf_K_e_3075.playerFullInfoUI.getEquipBagByKind(EquipmentKind.WING);
         if(Boolean(_loc1_) && Boolean(_loc1_.haveIconItem))
         {
            this.wingBag.dropIconItem();
            this.wingBag.pushIconItem(_loc1_.haveIconItem.clone());
            this.obf_d_x_2332();
         }
      }
      
      public function getIconItemBags() : Array
      {
         return this.allBags;
      }
      
      public function closeUI() : void
      {
         this.obf_P_P_1580();
         this.obf_B_t_2901();
         this.visible = false;
      }
      
      public function destroy() : void
      {
         var _loc1_:IconItemBag = null;
         this.removeListener();
         for each(_loc1_ in this.allBags)
         {
            _loc1_.destroy();
         }
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         if(this.visible && param1 == this.wingBag && param3.parentIconUI == obf_K_e_3075.playerBagUI)
         {
            this.wingBag.dropIconItem();
            this.wingBag.pushIconItem(param2);
            this.obf_d_x_2332();
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
   }
}

