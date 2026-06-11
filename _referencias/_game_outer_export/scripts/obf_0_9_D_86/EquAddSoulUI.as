package obf_0_9_D_86
{
   import obf_x_O_4078.obf_1_t_884;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemCollection;
   import com.sunweb.game.rpg.iconItem.IconItemEquip;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import playerUI.EquAddSoulUIMC;
   
   public class EquAddSoulUI extends EquAddSoulUIMC implements IPlayerUI, IIconItemUI
   {
      
      private var _bags:Array;
      
      private var _equipBag:IconItemBag;
      
      private var obf_0_5_7_110:Array;
      
      public var equipInfo:GameItemFullInfo;
      
      private var obf_a_k_2370:Array;
      
      private var obf_Q_S_4113:Object;
      
      private var equipSoulLevel:int;
      
      private var soulLevelConfig:Object;
      
      private var refineCost:int;
      
      private var obf_u_7_2336:Number;
      
      private var maxMaterialNumber:int = 3;
      
      private var timeInv:TimeLimiter;
      
      private var buttonInv:TimeLimiter;
      
      public function EquAddSoulUI()
      {
         var _loc3_:IconItemBag = null;
         this.timeInv = new TimeLimiter(300);
         this.buttonInv = new TimeLimiter(500);
         super();
         this.visible = false;
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         titleBox.mouseEnabled = false;
         this._bags = new Array();
         this._equipBag = new IconItemBag(obf_8_3_3181,this,0);
         this._equipBag.addValidType(GameItemType.EQUIPMENT);
         this._equipBag.isLocked = false;
         this._bags.push(this._equipBag);
         this.obf_0_5_7_110 = new Array();
         var _loc1_:int = 1;
         while(_loc1_ <= this.maxMaterialNumber)
         {
            _loc3_ = new IconItemBag(this["iconBar" + _loc1_],this,_loc1_);
            _loc3_.addValidType(GameItemType.COLLECTION);
            _loc3_.isLocked = true;
            _loc3_.lockDrag = false;
            this.obf_0_5_7_110.push(_loc3_);
            this._bags.push(_loc3_);
            _loc1_++;
         }
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.underline = true;
         txtRemark.setTextFormat(_loc2_);
         this.addListener();
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdSoul.addEventListener(MouseEvent.CLICK,this.onSoul);
         cmdDevolve.addEventListener(MouseEvent.CLICK,this.obf_s_S_793);
         obf_K_e_3075.addUIMouseToolTip(txtRemark,"equAddSoul");
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdSoul.removeEventListener(MouseEvent.CLICK,this.onSoul);
         cmdDevolve.removeEventListener(MouseEvent.CLICK,this.obf_s_S_793);
         obf_K_e_3075.removeUIMouseToolTip(txtRemark);
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
         if(obf_K_e_3075.playerBagUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.playerBagUI);
         }
      }
      
      private function onSoul(param1:Event) : void
      {
         var _loc2_:String = null;
         if(!this._equipBag.haveIconItem)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("EquAddSoulUI","pushEqu"));
            return;
         }
         if(this.equipSoulLevel >= JSONUtil.getInt(obf_1_t_884.getAddSoulConfig()[obf_1_t_884.getAddSoulConfig().length - 1],["maxLv"]))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("EquAddSoulUI","maxLv"));
            return;
         }
         if(this.refineCost > GameContext.localPlayer.fullInfo.gold)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("EquAddSoulUI","noGold"));
            return;
         }
         for(_loc2_ in this.obf_Q_S_4113)
         {
            if(this.obf_Q_S_4113[_loc2_] > obf_K_e_3075.playerBagUI.getItemCount(_loc2_))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("EquAddSoulUI","noStuff"));
               return;
            }
         }
         obf_1_t_884.sendArtifactSoulRequest(this._equipBag.haveIconItem.itemId);
         cmdSoul.enabled = false;
      }
      
      private function obf_s_S_793(param1:Event) : void
      {
         if(!obf_K_e_3075.devolveUI.visible)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.devolveUI);
            obf_K_e_3075.closeUI(this);
         }
         param1.stopPropagation();
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.buttonInv.checkTimeout() && !cmdSoul.enabled)
         {
            cmdSoul.enabled = true;
         }
         if(Boolean(!this.equipInfo) && Boolean(this._equipBag.haveIconItem) && this.timeInv.checkTimeout())
         {
            this.obf_l_n_3275();
         }
      }
      
      private function obf_l_n_3275() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:Object = null;
         var _loc11_:Number = NaN;
         var _loc12_:String = null;
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
            this.equipSoulLevel = this.equipInfo.equipmentInfo.addSoulLevel;
            this.obf_a_k_2370 = obf_1_t_884.getAddSoulConfig();
            this.obf_a_k_2370.sortOn("maxLv",Array.NUMERIC);
            for each(_loc3_ in this.obf_a_k_2370)
            {
               if(this.equipSoulLevel <= _loc3_["maxLv"])
               {
                  _loc2_ = _loc3_;
                  break;
               }
            }
            this.soulLevelConfig = _loc2_;
            this.obf_Q_S_4113 = JSONUtil.getObject(this.soulLevelConfig,["items"]);
            this.obf_u_7_2336 = JSONUtil.getNumber(this.soulLevelConfig,["chance"]);
            txtChance.text = "";
            txtChance.text = this.obf_u_7_2336 * 100 + "%";
            while(pointCost.numChildren > 0)
            {
               pointCost.removeChildAt(0);
            }
            while(pointSoulIcon.numChildren > 0)
            {
               pointSoulIcon.removeChildAt(0);
            }
            pointSoulIcon.addChild(obf_1_t_884.getSoulLevelDisplay(this.equipSoulLevel));
            this.refineCost = JSONUtil.getNumber(this.soulLevelConfig,["gold"]);
            pointCost.addChild(obf_a_f_2935.getGoldDisplay(this.refineCost));
            if(Boolean(_loc1_.properties.baseAttr) && _loc1_.properties.baseAttr.length > 0)
            {
               _loc4_ = 0;
               if(this.equipInfo.equipmentInfo.isRandomQuality)
               {
                  _loc4_ = this.equipInfo.equipmentInfo.quality;
               }
               else
               {
                  _loc4_ = JSONUtil.getInt(_loc1_,["properties","quality"]);
               }
               _loc5_ = obf_1_t_884.getSoulAttr();
               _loc6_ = "";
               _loc7_ = "";
               _loc8_ = "";
               _loc9_ = "";
               for each(_loc10_ in _loc1_.properties.baseAttr)
               {
                  _loc11_ = GameItemManager.getItemQualityValue(_loc10_.value,_loc4_);
                  _loc12_ = "";
                  if(this.equipSoulLevel > 0)
                  {
                     _loc12_ = "<font color=\'#00FF00\'>(" + Math.round(_loc11_ * _loc5_ * this.equipSoulLevel) + ")</font>";
                  }
                  _loc6_ += RoleAttributesModifierEnum.getAttributesName(_loc10_.attr) + "\n";
                  _loc7_ += RoleAttributesModifierEnum.getAttributesValueString(_loc10_.attr,_loc11_) + " " + _loc12_ + "\n";
                  if(this.equipSoulLevel + 1 <= this.obf_a_k_2370[this.obf_a_k_2370.length - 1]["maxLv"])
                  {
                     _loc8_ += RoleAttributesModifierEnum.getAttributesName(_loc10_.attr) + "\n";
                     _loc9_ += RoleAttributesModifierEnum.getAttributesValueString(_loc10_.attr,_loc11_) + "<font color=\'#00FF00\'> (" + Math.round(_loc11_ * _loc5_ * (this.equipSoulLevel + 1)) + ")</font>\n";
                  }
               }
               txtBeforeAttr.htmlText = _loc6_;
               txtBeforeAttrValue.htmlText = _loc7_;
               txtAfterAttr.htmlText = _loc8_;
               txtAfterAttrValue.htmlText = _loc9_;
            }
            this.obf_A_U_3684();
         }
         else
         {
            GameContext.bagItemManager.sendViewItem(this._equipBag.haveIconItem.itemId);
         }
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
         if(!JSONUtil.getBoolean(_loc2_,["properties","canRefine"]))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("EquAddSoulUI","prompt_CantRefine"));
            return;
         }
         this.clearContent();
         this.obf_k_K_3759();
         this._equipBag.pushIconItem(param1);
      }
      
      private function obf_k_K_3759() : void
      {
         var _loc1_:IconItemCollection = null;
         var _loc3_:IconItemBag = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.maxMaterialNumber)
         {
            _loc3_ = JSONUtil.getObject(this.obf_0_5_7_110,[_loc2_]) as IconItemBag;
            if(!_loc3_)
            {
               return;
            }
            _loc1_ = IconItemCollection.getNewIconItem(obf_1_t_884.getItemCode(),"");
            if(!_loc1_)
            {
               return;
            }
            _loc3_.isLocked = false;
            _loc3_.dropIconItem();
            _loc3_.pushIconItem(_loc1_);
            _loc2_++;
         }
      }
      
      private function obf_A_U_3684() : void
      {
         var _loc3_:IconItemBag = null;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.maxMaterialNumber)
         {
            _loc3_ = JSONUtil.getObject(this.obf_0_5_7_110,[_loc2_]) as IconItemBag;
            if(!_loc3_)
            {
               return;
            }
            _loc3_.haveIconItem.itemCount = this.obf_Q_S_4113[obf_1_t_884.getItemCode()] / 3;
            _loc1_++;
            _loc4_ = this.obf_Q_S_4113[obf_1_t_884.getItemCode()] / 3 * _loc1_;
            if(_loc4_ <= obf_K_e_3075.playerBagUI.getItemCount(obf_1_t_884.getItemCode()))
            {
               _loc3_.haveIconItem.countTextColor = 16777215;
            }
            else
            {
               _loc3_.haveIconItem.countTextColor = 16711680;
            }
            _loc2_++;
         }
      }
      
      public function showRefineEffect(param1:Boolean) : void
      {
         soulBg.gotoAndPlay(param1 ? "complete" : "fail");
      }
      
      private function clearContent() : void
      {
         var _loc1_:IconItemBag = null;
         for each(_loc1_ in this._bags)
         {
            _loc1_.dropIconItem();
         }
         for each(_loc1_ in this.obf_0_5_7_110)
         {
            _loc1_.isLocked = true;
         }
         this.equipInfo = null;
         this.soulLevelConfig = null;
         this.equipSoulLevel = 0;
         this.refineCost = 0;
         txtChance.text = "";
         txtBeforeAttr.text = "";
         txtBeforeAttrValue.text = "";
         txtAfterAttr.text = "";
         txtAfterAttrValue.text = "";
         while(pointCost.numChildren > 0)
         {
            pointCost.removeChildAt(0);
         }
         while(pointSoulIcon.numChildren > 0)
         {
            pointSoulIcon.removeChildAt(0);
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
         DiversityManager.setTextField(txtDeyTitle,"EquAddSoulUI","txtTitle");
         DiversityManager.setTextField(txtDeyBeforeSoul,"EquAddSoulUI","txtDeyBeforeSoul");
         DiversityManager.setTextField(txtDeyAfterSoul,"EquAddSoulUI","txtDeyAfterSoul");
         DiversityManager.setTextField(txtDeyChance,"EquAddSoulUI","txtDeyChance");
         DiversityManager.setTextField(txtDeyCost,"EquAddSoulUI","txtDeyCost");
         txtRemark.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("EquAddSoulUI","txtRemark") + "</a>";
         cmdSoul.label = DiversityManager.getString("EquAddSoulUI","cmdSoul");
         cmdDevolve.label = DiversityManager.getString("EquAddSoulUI","cmdDevolve");
      }
      
      public function showUI() : void
      {
         cmdSoul.enabled = true;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.visible = true;
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
      
      public function getIconItemBags() : Array
      {
         return this._bags;
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
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         if(param1 == this._equipBag)
         {
            this.clearContent();
         }
      }
   }
}

