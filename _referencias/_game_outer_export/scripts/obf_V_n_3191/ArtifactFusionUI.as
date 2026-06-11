package obf_V_n_3191
{
   import obf_x_O_4078.obf_A_V_935;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.equ.EquipmentKind;
   import com.sunweb.game.rpg.equ.EquipmentManager;
   import com.sunweb.game.rpg.equ.obf_0_4_X_546;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.obf_0_d_4341;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import playerUI.ArtifactFusionUIMC;
   
   public class ArtifactFusionUI extends ArtifactFusionUIMC implements IIconItemUI, obf_0_d_4341
   {
      
      private var bags:Array;
      
      private var obf_E_G_4000:IconItemBag;
      
      private var obf_g_U_4456:Array;
      
      private var obf_c_t_3251:IconItemBag;
      
      private var obf_W_Y_2983:IconItemBag;
      
      private var obf_D_J_917:IconItemBag;
      
      private var obf_A_Q_2415:GameItemFullInfo;
      
      private var obf_K_j_2939:GameItemFullInfo;
      
      private var obf_C_Y_4167:GameItemFullInfo;
      
      private var _noviceSprite:Sprite;
      
      private var timeInv:TimeLimiter;
      
      private var obf_f_J_4627:TimeLimiter;
      
      public function ArtifactFusionUI()
      {
         var _loc2_:MovieClip = null;
         var _loc3_:IconItemBag = null;
         this.timeInv = new TimeLimiter(500);
         super();
         this.initDiversity();
         barWashProgress.gotoAndStop(1);
         this.bags = new Array();
         this.obf_E_G_4000 = new IconItemBag(bagWashArtifact,this,0);
         this.obf_E_G_4000.addValidType(GameItemType.EQUIPMENT);
         this.bags.push(this.obf_E_G_4000);
         this.obf_g_U_4456 = new Array();
         var _loc1_:int = 0;
         while(_loc1_ <= 1)
         {
            _loc2_ = this["bagWashMaterial" + _loc1_];
            if(_loc2_)
            {
               _loc3_ = new IconItemBag(_loc2_,this,_loc1_);
               _loc3_.addValidType(GameItemType.ALL);
               _loc3_.lockDrag = true;
               this.obf_g_U_4456.push(_loc3_);
               this.bags.push(_loc3_);
            }
            _loc1_++;
         }
         this.obf_c_t_3251 = new IconItemBag(bagFusionArtifact,this,0);
         this.obf_c_t_3251.addValidType(GameItemType.EQUIPMENT);
         this.bags.push(this.obf_c_t_3251);
         this.obf_W_Y_2983 = new IconItemBag(bagFusionWeapon,this,0);
         this.obf_W_Y_2983.addValidType(GameItemType.EQUIPMENT);
         this.bags.push(this.obf_W_Y_2983);
         this.obf_D_J_917 = new IconItemBag(bagFusionMaterial,this,0);
         this.obf_D_J_917.addValidType(GameItemType.ALL);
         this.obf_D_J_917.lockDrag = true;
         this.bags.push(this.obf_D_J_917);
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyPushWash,"ArtifactFusionUI","txtPushWash");
         DiversityManager.setTextField(txtDeyPushWashMaterial,"ArtifactFusionUI","txtPushWashMaterial");
         DiversityManager.setTextField(txtDeyWashProgress,"ArtifactFusionUI","txtWashProgress");
         DiversityManager.setTextField(txtDeyWashRemark,"ArtifactFusionUI","txtWashRemark");
         DiversityManager.setTextField(txtDeyPushFusion,"ArtifactFusionUI","txtPushFusion");
         DiversityManager.setTextField(txtDeyPushWeapon,"ArtifactFusionUI","txtPushWeapon");
         DiversityManager.setTextField(txtDeyFusionMaterial,"ArtifactFusionUI","txtFusionMaterial");
         DiversityManager.setTextField(txtDeyAddFusionAttr,"ArtifactFusionUI","txtAddFusionAttr");
         DiversityManager.setTextField(txtFusionRemark,"ArtifactFusionUI","txtFusionRemark");
         cmdWashArtifact.label = DiversityManager.getString("ArtifactFusionUI","cmdWashArtifact");
         cmdFusionArtifact.label = DiversityManager.getString("ArtifactFusionUI","cmdFusionArtifact");
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
         return "ArtifactFusionUI";
      }
      
      public function getTargetPoint(param1:String) : Point
      {
         var _loc2_:DisplayObject = this.getChildByName(param1);
         if(!_loc2_)
         {
            return null;
         }
         return this.globalToLocal(_loc2_.localToGlobal(new Point(16,16)));
      }
      
      public function getHighLightDisplayObject(param1:String) : DisplayObject
      {
         return this.getChildByName(param1);
      }
      
      private function addListener() : void
      {
         cmdFusionArtifact.addEventListener(MouseEvent.CLICK,this.obf_U_m_3354);
         cmdWashArtifact.addEventListener(MouseEvent.CLICK,this.obf_0_r_2109);
      }
      
      private function removeListener() : void
      {
         cmdFusionArtifact.removeEventListener(MouseEvent.CLICK,this.obf_U_m_3354);
         cmdWashArtifact.removeEventListener(MouseEvent.CLICK,this.obf_0_r_2109);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.timeInv.checkTimeout())
         {
            if(!this.obf_A_Q_2415 && Boolean(this.obf_E_G_4000.haveIconItem))
            {
               this.obf_w_b_3239();
            }
            if(!this.obf_K_j_2939 && Boolean(this.obf_c_t_3251.haveIconItem))
            {
               this.obf_0_6_k_200();
            }
            if(!this.obf_C_Y_4167 && Boolean(this.obf_W_Y_2983.haveIconItem))
            {
               this.obf_0___H_304();
            }
         }
         if(Boolean(this.obf_f_J_4627) && this.obf_f_J_4627.checkTimeout())
         {
            cmdWashArtifact.enabled = true;
            cmdFusionArtifact.enabled = true;
            this.obf_f_J_4627 = null;
         }
      }
      
      private function obf_0_r_2109(param1:Event) : void
      {
         if(!this.obf_E_G_4000.haveIconItem || !this.obf_A_Q_2415)
         {
            return;
         }
         var _loc2_:Object = GameItemManager.getItemConfig(this.obf_E_G_4000.haveIconItem.itemCode);
         var _loc3_:Object = obf_0_4_X_546.getFusionConfig(JSONUtil.getInt(_loc2_,["properties","fusionId"]));
         if(!_loc3_)
         {
            return;
         }
         if(!ConditionScript.checkCondition(_loc3_.washCondition,null,true))
         {
            return;
         }
         var _loc4_:IconItemBag = obf_K_e_3075.playerFullInfoUI.getEquipBagByKind(EquipmentKind.WEAPON);
         if(Boolean(_loc4_.haveIconItem) && this.obf_E_G_4000.haveIconItem.itemId == _loc4_.haveIconItem.itemId)
         {
            EquipmentManager.sendRemoveEquip(EquipmentKind.WEAPON,-1);
         }
         obf_A_V_935.sendEquipmentWash(this.obf_E_G_4000.haveIconItem.itemId);
         this.obf_f_J_4627 = new TimeLimiter(1000);
         cmdWashArtifact.enabled = false;
      }
      
      private function obf_U_m_3354(param1:Event) : void
      {
         if(!this.obf_c_t_3251.haveIconItem || !this.obf_K_j_2939)
         {
            return;
         }
         if(!this.obf_W_Y_2983.haveIconItem)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("EquipmentFusionUI","prompt_NeedStuff"));
            return;
         }
         var _loc2_:Object = GameItemManager.getItemConfig(this.obf_c_t_3251.haveIconItem.itemCode);
         var _loc3_:Object = obf_0_4_X_546.getFusionConfig(JSONUtil.getInt(_loc2_,["properties","fusionId"]));
         if(!_loc3_)
         {
            return;
         }
         if(this.obf_K_j_2939.equipmentInfo.washRate < 1)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("EquipmentFusionUI","prompt_NeedWashPoint100"));
            return;
         }
         if(!ConditionScript.checkCondition(_loc3_.condition,null,true))
         {
            return;
         }
         var _loc4_:IconItemBag = obf_K_e_3075.playerFullInfoUI.getEquipBagByKind(EquipmentKind.WEAPON);
         if(Boolean(_loc4_.haveIconItem) && this.obf_c_t_3251.haveIconItem.itemId == _loc4_.haveIconItem.itemId)
         {
            EquipmentManager.sendRemoveEquip(EquipmentKind.WEAPON,-1);
         }
         obf_A_V_935.sendEquipmentFusion(this.obf_c_t_3251.haveIconItem.itemId,this.obf_W_Y_2983.haveIconItem.itemId);
         this.obf_f_J_4627 = new TimeLimiter(1000);
         cmdFusionArtifact.enabled = false;
      }
      
      public function obf_w_b_3239() : void
      {
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:IconItemBag = null;
         var _loc8_:IconItem = null;
         if(!this.obf_E_G_4000.haveIconItem)
         {
            return;
         }
         this.obf_w_W_3244(true);
         this.obf_A_Q_2415 = GameItemInfoManager.getItemInfo(this.obf_E_G_4000.haveIconItem.itemId);
         if(!this.obf_A_Q_2415)
         {
            GameContext.bagItemManager.sendViewItem(this.obf_E_G_4000.haveIconItem.itemId);
            return;
         }
         var _loc1_:Object = GameItemManager.getItemConfig(this.obf_E_G_4000.haveIconItem.itemCode);
         var _loc2_:Object = obf_0_4_X_546.getFusionConfig(JSONUtil.getInt(_loc1_,["properties","fusionId"]));
         if(!_loc2_)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("EquipmentFusionUI","prompt_ItemCantFusion"));
            this.obf_w_W_3244();
            return;
         }
         var _loc3_:int = this.obf_A_Q_2415.equipmentInfo.washRate * 100;
         barWashProgress.gotoAndStop(_loc3_);
         txtWashProgress.text = Number(this.obf_A_Q_2415.equipmentInfo.washRate * 100).toFixed(1) + "%";
         var _loc4_:Object = JSONUtil.getObject(_loc2_,["washCondition","equalItemsInBag"]);
         if(_loc4_)
         {
            _loc5_ = 0;
            for(_loc6_ in _loc4_)
            {
               if(_loc5_ >= this.obf_g_U_4456.length)
               {
                  break;
               }
               _loc7_ = this.obf_g_U_4456[_loc5_];
               _loc8_ = IconItemManager.getIconItemByCode(_loc6_,"");
               _loc8_.itemCount = _loc4_[_loc6_];
               _loc7_.pushIconItem(_loc8_);
               _loc5_++;
            }
         }
      }
      
      public function obf_w_W_3244(param1:Boolean = false) : void
      {
         var _loc2_:IconItemBag = null;
         for each(_loc2_ in this.obf_g_U_4456)
         {
            _loc2_.dropIconItem();
         }
         if(!param1)
         {
            this.obf_E_G_4000.dropIconItem();
         }
         txtWashProgress.text = "";
         barWashProgress.gotoAndStop(1);
         this.obf_A_Q_2415 = null;
      }
      
      public function obf_0_6_k_200() : void
      {
         var _loc4_:String = null;
         var _loc5_:IconItem = null;
         if(!this.obf_c_t_3251.haveIconItem)
         {
            return;
         }
         this.obf_W_Z_2731(true);
         this.obf_K_j_2939 = GameItemInfoManager.getItemInfo(this.obf_c_t_3251.haveIconItem.itemId);
         if(!this.obf_K_j_2939)
         {
            GameContext.bagItemManager.sendViewItem(this.obf_c_t_3251.haveIconItem.itemId);
            return;
         }
         var _loc1_:Object = GameItemManager.getItemConfig(this.obf_c_t_3251.haveIconItem.itemCode);
         var _loc2_:Object = obf_0_4_X_546.getFusionConfig(JSONUtil.getInt(_loc1_,["properties","fusionId"]));
         if(!_loc2_)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("EquipmentFusionUI","prompt_ItemCantFusion"));
            this.obf_W_Z_2731();
            return;
         }
         var _loc3_:Object = JSONUtil.getObject(_loc2_,["condition","equalItemsInBag"]);
         if(_loc3_)
         {
            for(_loc4_ in _loc3_)
            {
               _loc5_ = IconItemManager.getIconItemByCode(_loc4_,"");
               if(_loc5_)
               {
                  _loc5_.itemCount = _loc3_[_loc4_];
                  this.obf_D_J_917.pushIconItem(_loc5_);
                  break;
               }
            }
         }
      }
      
      public function obf_0___H_304() : void
      {
         var _loc6_:Object = null;
         var _loc7_:Number = NaN;
         if(!this.obf_W_Y_2983.haveIconItem || !this.obf_c_t_3251.haveIconItem)
         {
            return;
         }
         this.obf_0_5_D_515(true);
         this.obf_C_Y_4167 = GameItemInfoManager.getItemInfo(this.obf_W_Y_2983.haveIconItem.itemId);
         if(!this.obf_C_Y_4167)
         {
            GameContext.bagItemManager.sendViewItem(this.obf_W_Y_2983.haveIconItem.itemId);
            return;
         }
         var _loc1_:Object = GameItemManager.getItemConfig(this.obf_c_t_3251.haveIconItem.itemCode);
         var _loc2_:Object = GameItemManager.getItemConfig(this.obf_W_Y_2983.haveIconItem.itemCode);
         if(!_loc1_ || !_loc2_)
         {
            return;
         }
         if(!GameItemManager.obf_D_n_3089(this.obf_W_Y_2983.haveIconItem.itemCode))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("EquipmentFusionUI","prompt_StuffMustCanUse"));
            this.obf_W_Y_2983.dropIconItem();
            return;
         }
         if(JSONUtil.getInt(_loc1_,["properties","kind"]) != JSONUtil.getInt(_loc2_,["properties","kind"]))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("EquipmentFusionUI","prompt_FusionMustSameKind"));
            this.obf_W_Y_2983.dropIconItem();
            return;
         }
         if(!JSONUtil.getBoolean(_loc2_,["properties","isFusionItem"],true))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("EquipmentFusionUI","prompt_StuffCantFusion"));
            this.obf_W_Y_2983.dropIconItem();
            return;
         }
         var _loc3_:int = 0;
         if(this.obf_C_Y_4167.equipmentInfo.isRandomQuality)
         {
            _loc3_ = this.obf_C_Y_4167.equipmentInfo.quality;
         }
         else
         {
            _loc3_ = JSONUtil.getInt(_loc2_,["properties","quality"]);
         }
         var _loc4_:Array = JSONUtil.getObject(_loc2_,["properties","baseAttr"]) as Array;
         var _loc5_:String = "";
         for each(_loc6_ in _loc4_)
         {
            _loc7_ = GameItemManager.getItemQualityValue(_loc6_.value,_loc3_);
            _loc5_ += RoleAttributesModifierEnum.getAttributesName(_loc6_.attr);
            _loc5_ = _loc5_ + RoleAttributesModifierEnum.getAttributesValueString(_loc6_.attr,_loc7_);
            _loc5_ = _loc5_ + "\n";
         }
         txtAddFusionAttr.htmlText = _loc5_;
      }
      
      public function obf_0_5_D_515(param1:Boolean = false) : void
      {
         txtAddFusionAttr.htmlText = "";
         this.obf_C_Y_4167 = null;
         if(!param1)
         {
            this.obf_W_Y_2983.dropIconItem();
         }
      }
      
      public function obf_W_Z_2731(param1:Boolean = false) : void
      {
         this.obf_0_5_D_515();
         this.obf_K_j_2939 = null;
         if(!param1)
         {
            this.obf_c_t_3251.dropIconItem();
         }
         this.obf_W_Y_2983.dropIconItem();
         this.obf_D_J_917.dropIconItem();
      }
      
      public function get mouseOn() : Boolean
      {
         return false;
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.obf_W_Z_2731();
         this.obf_w_W_3244();
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         if(param1 == this.obf_c_t_3251 || param1 == this.obf_E_G_4000)
         {
            this.obf_c_t_3251.dropIconItem();
            this.obf_c_t_3251.pushIconItem(param2.clone());
            this.obf_0_6_k_200();
            this.obf_E_G_4000.dropIconItem();
            this.obf_E_G_4000.pushIconItem(param2.clone());
            this.obf_w_b_3239();
         }
         if(param1 == this.obf_W_Y_2983)
         {
            this.obf_0_5_D_515();
            this.obf_W_Y_2983.pushIconItem(param2);
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         if(param1 == this.obf_c_t_3251 || param1 == this.obf_E_G_4000)
         {
            this.obf_W_Z_2731();
            this.obf_w_W_3244();
         }
         if(param1 == this.obf_W_Y_2983)
         {
            this.obf_0_5_D_515();
         }
      }
   }
}

