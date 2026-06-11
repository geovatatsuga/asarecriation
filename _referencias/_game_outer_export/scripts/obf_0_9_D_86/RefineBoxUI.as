package obf_0_9_D_86
{
   import obf_x_O_4078.obf_1_t_884;
   import obf_x_O_4078.obf_A_V_935;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemCollection;
   import com.sunweb.game.rpg.iconItem.IconItemEquip;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.obf_0_d_4341;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.rpg.shop.ShopManager;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import playerUI.RefineBoxUIMC;
   
   public class RefineBoxUI extends RefineBoxUIMC implements IIconItemUI, obf_0_d_4341
   {
      
      private var _bags:Array;
      
      private var _equipBag:IconItemBag;
      
      private var obf_0_5_7_110:Array;
      
      private var equipInfo:GameItemFullInfo;
      
      private var equipRefineValue:Number;
      
      private var materialValue:Number;
      
      private var equipRefineLevel:int;
      
      private var refineLevelConfig:Object;
      
      private var refineCost:int;
      
      private var maxMaterialNumber:int = 4;
      
      private var _noviceSprite:Sprite;
      
      private var timeInv:TimeLimiter;
      
      private var isWaitBestMaterial:Boolean;
      
      public function RefineBoxUI()
      {
         var _loc2_:IconItemBag = null;
         this.timeInv = new TimeLimiter(300);
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth - 300;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         titleBox.mouseEnabled = false;
         this._bags = new Array();
         this._equipBag = new IconItemBag(bagEquip,this,0);
         this._equipBag.addValidType(GameItemType.EQUIPMENT);
         this._equipBag.isLocked = false;
         this._bags.push(this._equipBag);
         this.obf_0_5_7_110 = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < this.maxMaterialNumber)
         {
            _loc2_ = new IconItemBag(this["bagMaterial" + _loc1_],this,_loc1_);
            _loc2_.addValidType(GameItemType.COLLECTION);
            _loc2_.isLocked = false;
            this.obf_0_5_7_110.push(_loc2_);
            this._bags.push(_loc2_);
            _loc1_++;
         }
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"RefineBoxUI","txtTitle");
         DiversityManager.setTextField(txtDeyBeforeRefine,"RefineBoxUI","txtBeforeRefine");
         DiversityManager.setTextField(txtDeyAfterRefine,"RefineBoxUI","txtAfterRefine");
         DiversityManager.setTextField(txtDeyEquip,"RefineBoxUI","txtEquip");
         DiversityManager.setTextField(txtDeyChance,"RefineBoxUI","txtChance");
         DiversityManager.setTextField(txtDeyCost,"RefineBoxUI","txtCost");
         cmdAuto.label = DiversityManager.getString("RefineBoxUI","cmdAuto");
         cmdBest.label = DiversityManager.getString("RefineBoxUI","cmdBest");
         cmdRefine.label = DiversityManager.getString("RefineBoxUI","cmdRefine");
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
         return "RefineUI";
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
      
      public function get equipBag() : IconItemBag
      {
         return this._equipBag;
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdRefine.addEventListener(MouseEvent.CLICK,this.obf_S_v_1347);
         cmdAuto.addEventListener(MouseEvent.CLICK,this.obf_E_n_3115);
         cmdBest.addEventListener(MouseEvent.CLICK,this.obf_R_m_4365);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdRefine.removeEventListener(MouseEvent.CLICK,this.obf_S_v_1347);
         cmdAuto.removeEventListener(MouseEvent.CLICK,this.obf_E_n_3115);
         cmdBest.removeEventListener(MouseEvent.CLICK,this.obf_R_m_4365);
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
      
      private function onEnterFrame(param1:Event) : void
      {
         if(Boolean(!this.equipInfo) && Boolean(this._equipBag.haveIconItem) && this.timeInv.checkTimeout())
         {
            this.obf_l_n_3275();
         }
      }
      
      private function obf_S_v_1347(param1:Event) : void
      {
         var _loc4_:IconItemBag = null;
         var _loc5_:String = null;
         if(!this.equipInfo || !this._equipBag.haveIconItem)
         {
            return;
         }
         if(this.materialValue <= 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("RefineBoxUI","prompt_NoMaterial"));
            return;
         }
         if(!ConditionScript.checkCondition(JSONUtil.getObject(this.refineLevelConfig,["reqCond"]),null,true))
         {
            return;
         }
         var _loc2_:Object = new Object();
         var _loc3_:Array = new Array();
         for each(_loc4_ in this.obf_0_5_7_110)
         {
            if(_loc4_.haveIconItem)
            {
               _loc3_.push(_loc4_.haveIconItem.itemCode);
               if(!_loc2_[_loc4_.haveIconItem.itemCode])
               {
                  _loc2_[_loc4_.haveIconItem.itemCode] = 0;
               }
               ++_loc2_[_loc4_.haveIconItem.itemCode];
            }
         }
         for(_loc5_ in _loc2_)
         {
            if(obf_K_e_3075.playerBagUI.getItemCount(_loc5_) < _loc2_[_loc5_])
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("RefineBoxUI","prompt_NoMoreMaterial",[GameItemManager.getItemName(_loc5_)]));
               return;
            }
         }
         if(GameContext.localPlayer.fullInfo.gold < this.refineCost)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMoreGold"));
            return;
         }
         obf_A_V_935.sendRefine(this._equipBag.haveIconItem.itemId,this.equipRefineLevel,_loc3_);
      }
      
      private function obf_E_n_3115(param1:Event) : void
      {
         this.autoMaterial();
      }
      
      private function obf_R_m_4365(param1:Event) : void
      {
         this.bestMaterial();
      }
      
      public function autoMaterial() : void
      {
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(!this.equipInfo || !this._equipBag.haveIconItem)
         {
            return;
         }
         var _loc1_:Object = GameItemManager.getItemConfig(this._equipBag.haveIconItem.itemCode);
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:Array = obf_1_t_884.getAllMaterialInPlayerBag();
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:Array = new Array();
         for each(_loc4_ in _loc2_)
         {
            if(obf_1_t_884.itemCanUseOnEquip(_loc4_,this._equipBag.haveIconItem.itemCode))
            {
               _loc3_.push(_loc4_);
            }
         }
         _loc5_ = this.getBestMaterialInList(this.equipRefineValue,_loc3_);
         _loc6_ = this.maxMaterialNumber - 1;
         _loc7_ = 0;
         while(_loc6_ >= 0 && _loc7_ < _loc5_.length)
         {
            _loc8_ = Math.min(obf_K_e_3075.playerBagUI.getItemCount(_loc5_[_loc7_]),this.maxMaterialNumber);
            if(_loc8_ > 0)
            {
               _loc9_ = 1;
               while(_loc9_ <= _loc8_)
               {
                  this.obf_k_K_3759(_loc6_ - _loc9_ + 1,_loc5_[_loc7_]);
                  _loc9_++;
               }
            }
            _loc6_ -= _loc8_;
            _loc7_++;
         }
      }
      
      public function bestMaterial() : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc7_:DisplayObject = null;
         var _loc8_:int = 0;
         if(!this.equipInfo || !this._equipBag.haveIconItem)
         {
            return;
         }
         var _loc1_:Array = this.getBestMaterialInList(this.equipRefineValue,obf_1_t_884.getMaterialListInStore());
         var _loc2_:Array = new Array();
         for each(_loc3_ in _loc1_)
         {
            if(obf_1_t_884.itemCanUseOnEquip(_loc3_,this._equipBag.haveIconItem.itemCode))
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc4_ = "";
         if(Boolean(_loc2_) && _loc2_.length > 0)
         {
            _loc4_ = _loc2_[0];
         }
         if(obf_L_l_4100.isEmpty(_loc4_))
         {
            return;
         }
         var _loc5_:int = obf_K_e_3075.playerBagUI.getItemCount(_loc4_);
         var _loc6_:int = Math.max(this.maxMaterialNumber - _loc5_,0);
         if(_loc6_ > 0)
         {
            _loc7_ = GameItemManager.getItemIcon(_loc4_);
            if(_loc7_)
            {
               _loc7_.x = -(_loc7_.width / 2);
               _loc7_.y = -(_loc7_.height / 2);
            }
            _loc8_ = GameItemManager.getItemMoneyBuy(_loc4_) * _loc6_;
            WindowManager.showConfirmBox(DiversityManager.getString("RefineBoxUI","prompt_ConfirmBuyBestMaterial",[obf_7_6_4416.getItemLinkA(_loc4_,""),_loc5_,_loc6_,obf_a_f_2935.getMoneyString(_loc8_)]),this.confirmBuyBestMaterial,{
               "itemCode":_loc4_,
               "count":_loc6_
            },[_loc7_]);
         }
         else
         {
            this.autoMaterial();
         }
      }
      
      private function confirmBuyBestMaterial(param1:Object) : void
      {
         if(!param1.confirm)
         {
            return;
         }
         var _loc2_:int = GameItemManager.getItemMoneyBuy(param1.par.itemCode) * param1.par.count;
         if(GameContext.localPlayer.fullInfo.money < _loc2_)
         {
            obf_K_e_3075.showShortOfMoney();
            return;
         }
         ShopManager.sendStoreBuyItem(param1.par.itemCode,ShopManager.obf_B_9_2165,"",param1.par.count);
         this.isWaitBestMaterial = true;
      }
      
      public function obf_I_n_2839() : void
      {
         if(this.isWaitBestMaterial)
         {
            this.autoMaterial();
            this.isWaitBestMaterial = false;
         }
      }
      
      public function getBestMaterialInList(param1:Number, param2:Array) : Array
      {
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:Object = null;
         var _loc3_:Array = new Array();
         var _loc4_:Number = param1 / this.maxMaterialNumber;
         for each(_loc5_ in param2)
         {
            _loc3_.push({
               "itemCode":_loc5_,
               "value":Math.abs(_loc4_ - obf_1_t_884.getRefineMaterialValue(_loc5_))
            });
         }
         _loc3_.sortOn("value",Array.NUMERIC);
         _loc6_ = new Array();
         for each(_loc7_ in _loc3_)
         {
            _loc6_.push(_loc7_.itemCode);
         }
         return _loc6_;
      }
      
      private function obf_l_n_3275() : void
      {
         var _loc1_:Object = null;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Object = null;
         var _loc8_:Number = NaN;
         var _loc9_:String = null;
         if(!this._equipBag.haveIconItem)
         {
            return;
         }
         this.equipInfo = GameItemInfoManager.getItemInfo(this._equipBag.haveIconItem.itemId);
         if(this.equipInfo)
         {
            if(this.equipInfo.isEmpty)
            {
               return;
            }
            _loc1_ = GameItemManager.getItemConfig(this._equipBag.haveIconItem.itemCode);
            this.equipRefineLevel = this.equipInfo.equipmentInfo.refineLevel;
            this.refineLevelConfig = obf_1_t_884.getRefineLevelConfig(this.equipRefineLevel);
            this.equipRefineValue = JSONUtil.getNumber(this.refineLevelConfig,["reqRefineValueMul"]) * (obf_1_t_884.refineValueAdded + JSONUtil.getNumber(_loc1_,["properties","extAttrPoint"]));
            txtEquipName.htmlText = "<font color=\'#" + GameItemRank.getRankColor(_loc1_.rank).toString(16) + "\'>" + _loc1_.name + (this.equipRefineLevel > 0 ? " +" + this.equipRefineLevel : "") + "</font>";
            pointRefineIcon.addChild(obf_1_t_884.getRefineLevelDisplay(this.equipRefineLevel,true));
            this.refineCost = JSONUtil.getNumber(_loc1_,["properties","extAttrPoint"]) * JSONUtil.getNumber(this.refineLevelConfig,["costGoldMul"]);
            pointCost.addChild(obf_a_f_2935.getGoldDisplay(this.refineCost));
            if(Boolean(_loc1_.properties.baseAttr) && _loc1_.properties.baseAttr.length > 0)
            {
               _loc2_ = 0;
               if(this.equipInfo.equipmentInfo.isRandomQuality)
               {
                  _loc2_ = this.equipInfo.equipmentInfo.quality;
               }
               else
               {
                  _loc2_ = JSONUtil.getInt(_loc1_,["properties","quality"]);
               }
               _loc3_ = "";
               _loc4_ = "";
               _loc5_ = "";
               _loc6_ = "";
               for each(_loc7_ in _loc1_.properties.baseAttr)
               {
                  _loc8_ = GameItemManager.getItemQualityValue(_loc7_.value,_loc2_);
                  _loc9_ = "";
                  if(this.equipRefineLevel > 0)
                  {
                     _loc9_ = "<font color=\'#00FF00\'>(+" + Math.round(obf_1_t_884.getValueRefine(_loc8_,this.equipRefineLevel)) + ")</font>";
                  }
                  _loc3_ += RoleAttributesModifierEnum.getAttributesName(_loc7_.attr) + "\n";
                  _loc4_ += RoleAttributesModifierEnum.getAttributesValueString(_loc7_.attr,_loc8_) + _loc9_ + "\n";
                  if(this.equipRefineLevel + 1 <= obf_1_t_884.maxRefineLevel)
                  {
                     _loc5_ += RoleAttributesModifierEnum.getAttributesName(_loc7_.attr) + "\n";
                     _loc6_ += RoleAttributesModifierEnum.getAttributesValueString(_loc7_.attr,_loc8_) + "<font color=\'#00FF00\'>(+" + Math.round(obf_1_t_884.getValueRefine(_loc8_,this.equipRefineLevel + 1)) + ")</font>\n";
                  }
               }
               txtBeforeAttr.htmlText = _loc3_;
               txtBeforeAttrValue.htmlText = _loc4_;
               txtAfterAttr.htmlText = _loc5_;
               txtAfterAttrValue.htmlText = _loc6_;
            }
            this.obf_j_H_3519();
         }
         else
         {
            GameContext.bagItemManager.sendViewItem(this._equipBag.haveIconItem.itemId);
         }
      }
      
      public function pushEquipIn(param1:IconItemEquip) : void
      {
         if(!param1)
         {
            return;
         }
         if(!GameItemManager.itemCanRefine(param1.itemCode))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("RefineBoxUI","prompt_CantRefine"));
            return;
         }
         this.clearContent();
         this._equipBag.pushIconItem(param1);
      }
      
      public function obf_k_K_3759(param1:int, param2:String) : void
      {
         if(!this._equipBag.haveIconItem || !obf_1_t_884.itemIsRefineMaterial(param2))
         {
            return;
         }
         if(!obf_1_t_884.itemCanUseOnEquip(param2,this._equipBag.haveIconItem.itemCode))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("RefineBoxUI","prompt_CantUseMaterialInEquip"));
            return;
         }
         var _loc3_:IconItemBag = JSONUtil.getObject(this.obf_0_5_7_110,[param1]) as IconItemBag;
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:IconItemCollection = IconItemCollection.getNewIconItem(param2,"");
         if(!_loc4_)
         {
            return;
         }
         _loc3_.dropIconItem();
         _loc3_.pushIconItem(_loc4_);
         this.obf_j_H_3519();
      }
      
      public function obf_j_H_3519() : void
      {
         var _loc1_:IconItemBag = null;
         if(!this.equipInfo || !this._equipBag.haveIconItem)
         {
            return;
         }
         this.materialValue = 0;
         for each(_loc1_ in this.obf_0_5_7_110)
         {
            if(!(!_loc1_.haveIconItem || !obf_1_t_884.itemIsRefineMaterial(_loc1_.haveIconItem.itemCode)))
            {
               this.materialValue += obf_1_t_884.getRefineMaterialValue(_loc1_.haveIconItem.itemCode);
            }
         }
         txtChance.text = Math.min(this.materialValue / this.equipRefineValue * 100,100).toFixed(2) + "%";
      }
      
      public function clearContent() : void
      {
         var _loc1_:IconItemBag = null;
         for each(_loc1_ in this._bags)
         {
            _loc1_.dropIconItem();
         }
         this.equipInfo = null;
         this.refineLevelConfig = null;
         this.isWaitBestMaterial = false;
         this.equipRefineValue = 0;
         this.equipRefineLevel = 0;
         this.materialValue = 0;
         this.refineCost = 0;
         txtChance.text = "";
         txtBeforeAttr.text = "";
         txtBeforeAttrValue.text = "";
         txtAfterAttr.text = "";
         txtAfterAttrValue.text = "";
         txtEquipName.htmlText = "";
         while(pointCost.numChildren > 0)
         {
            pointCost.removeChildAt(0);
         }
         while(pointRefineIcon.numChildren > 0)
         {
            pointRefineIcon.removeChildAt(0);
         }
      }
      
      public function obf_0_7_0_691() : void
      {
         var _loc5_:IconItemBag = null;
         if(!this._equipBag.haveIconItem)
         {
            return;
         }
         var _loc1_:IconItemEquip = this._equipBag.haveIconItem.clone() as IconItemEquip;
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < this.obf_0_5_7_110.length)
         {
            _loc5_ = this.obf_0_5_7_110[_loc3_] as IconItemBag;
            _loc2_.push(JSONUtil.getStr(_loc5_,["haveIconItem","itemCode"]));
            _loc3_++;
         }
         this.clearContent();
         this.pushEquipIn(_loc1_);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            this.obf_k_K_3759(_loc4_,_loc2_[_loc4_]);
            _loc4_++;
         }
      }
      
      public function showRefineEffect(param1:Boolean) : void
      {
         refineBG.gotoAndPlay(param1 ? "complete" : "fail");
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
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function getIconItemBags() : Array
      {
         return this._bags;
      }
      
      public function closeUI() : void
      {
         this.clearContent();
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.visible = false;
      }
      
      public function destroy() : void
      {
         var _loc1_:IconItemBag = null;
         this.removeListener();
         for each(_loc1_ in this._bags)
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
         if(!param1 || param3.parentIconUI != obf_K_e_3075.playerBagUI)
         {
            return;
         }
         if(param1 == this._equipBag && param2 is IconItemEquip)
         {
            this.pushEquipIn(param2 as IconItemEquip);
         }
         if(param1 != this._equipBag && param2 is IconItemCollection)
         {
            this.obf_k_K_3759(param1.itemIndex,param2.itemCode);
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         if(param1 == this._equipBag)
         {
            this.clearContent();
         }
         else
         {
            param1.dropIconItem();
            this.obf_j_H_3519();
         }
      }
   }
}

