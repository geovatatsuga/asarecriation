package obf_I_Q_4451
{
   import obf_x_O_4078.obf_A_V_935;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.equ.EquipmentKind;
   import com.sunweb.game.rpg.equ.EquipmentManager;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.SoulWeaponLevelUpUIMC;
   
   public class SoulWeaponLevelUpUI extends SoulWeaponLevelUpUIMC implements IIconItemUI
   {
      
      private var _bags:Array;
      
      private var obf_0_5_7_110:Array;
      
      private var obf_I_j_3665:IconItemBag;
      
      private var obf_Q_4_2390:GameItemFullInfo;
      
      private var buttonTimeInv:TimeLimiter;
      
      private var getInfoTimeInv:TimeLimiter;
      
      public function SoulWeaponLevelUpUI()
      {
         var _loc2_:MovieClip = null;
         var _loc3_:IconItemBag = null;
         this.getInfoTimeInv = new TimeLimiter(500);
         super();
         this.initDiversity();
         this.visible = false;
         barExp.gotoAndStop(1);
         this._bags = new Array();
         this.obf_0_5_7_110 = new Array();
         this.obf_I_j_3665 = new IconItemBag(bagCurrentSW,this,0);
         this.obf_I_j_3665.addValidType(GameItemType.EQUIPMENT);
         this._bags.push(this.obf_I_j_3665);
         var _loc1_:int = 0;
         while(_loc1_ <= 2)
         {
            _loc2_ = this["bagM" + _loc1_];
            if(_loc2_)
            {
               _loc3_ = new IconItemBag(_loc2_,this,_loc1_);
               _loc3_.addValidType(GameItemType.ALL);
               _loc3_.lockDrag = true;
               this.obf_0_5_7_110.push(_loc3_);
               this._bags.push(_loc3_);
            }
            _loc1_++;
         }
         this.addListener();
      }
      
      private function addListener() : void
      {
         cmdLevelUp.addEventListener(MouseEvent.CLICK,this.onClickLevelUp);
      }
      
      private function removeListener() : void
      {
         cmdLevelUp.removeEventListener(MouseEvent.CLICK,this.onClickLevelUp);
      }
      
      private function onClickLevelUp(param1:Event) : void
      {
         if(!this.obf_Q_4_2390 || this.obf_Q_4_2390.isEmpty)
         {
            return;
         }
         var _loc2_:Object = GameItemManager.getItemConfig(this.obf_Q_4_2390.itemCode);
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:Object = JSONUtil.getObject(_loc2_,["properties","equLevel",this.obf_Q_4_2390.equipmentInfo.equLevel,"upEquExpReqCond"]);
         if(!ConditionScript.checkCondition(_loc3_,null,true))
         {
            return;
         }
         var _loc4_:IconItemBag = obf_K_e_3075.playerFullInfoUI.getEquipBagByKind(EquipmentKind.obf_m_S_4609);
         if(Boolean(this.obf_I_j_3665.haveIconItem) && Boolean(_loc4_.haveIconItem) && this.obf_I_j_3665.haveIconItem.itemId == _loc4_.haveIconItem.itemId)
         {
            EquipmentManager.sendRemoveEquip(EquipmentKind.obf_m_S_4609,-1);
         }
         obf_A_V_935.sendEquipExpUp(this.obf_Q_4_2390.itemId);
         cmdLevelUp.enabled = false;
         this.buttonTimeInv = new TimeLimiter(3000);
      }
      
      public function obf_S_k_2067(param1:IconItem) : void
      {
         this.obf_q_D_1668();
         var _loc2_:Object = GameItemManager.getItemConfig(param1.itemCode);
         if(JSONUtil.getValue(_loc2_,"properties","kind") != EquipmentKind.obf_m_S_4609)
         {
            return;
         }
         this.obf_I_j_3665.pushIconItem(param1.clone());
      }
      
      private function showSoulContent() : void
      {
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc10_:IconItem = null;
         var _loc11_:IconItemBag = null;
         if(!this.obf_Q_4_2390 || this.obf_Q_4_2390.isEmpty || !this.obf_Q_4_2390.equipmentInfo)
         {
            return;
         }
         var _loc1_:Object = GameItemManager.getItemConfig(this.obf_Q_4_2390.itemCode);
         if(!_loc1_)
         {
            return;
         }
         if(this.obf_Q_4_2390.equipmentInfo.equLevel >= JSONUtil.getValue(_loc1_,"properties","equLevel","length"))
         {
            obf_K_e_3075.showInfoOnUI(DiversityManager.getString("SoulWeaponLevelUpUI","prompt_MaxLevel"),this);
            return;
         }
         var _loc2_:int = JSONUtil.getInt(_loc1_,["properties","equLevel",this.obf_Q_4_2390.equipmentInfo.equLevel,"reqEquExp"]);
         var _loc3_:int = JSONUtil.getInt(_loc1_,["properties","equLevel",this.obf_Q_4_2390.equipmentInfo.equLevel - 1,"reqEquExp"]);
         txtExp.text = this.obf_Q_4_2390.equipmentInfo.equExp + "/" + _loc2_;
         var _loc4_:int = (this.obf_Q_4_2390.equipmentInfo.equExp - _loc3_) / EquipmentManager.getEquipmentLevelUpExpAbs(this.obf_Q_4_2390.itemCode,this.obf_Q_4_2390.equipmentInfo.equLevel + 1) * 100;
         barExp.gotoAndStop(_loc4_);
         var _loc5_:Object = JSONUtil.getObject(_loc1_,["properties","equLevel",this.obf_Q_4_2390.equipmentInfo.equLevel,"upEquExpReqCond"]);
         var _loc6_:Object = JSONUtil.getObject(_loc5_,["equalItemsInBag"]);
         if(_loc6_)
         {
            _loc8_ = 0;
            for(_loc9_ in _loc6_)
            {
               if(_loc8_ >= this.obf_0_5_7_110.length)
               {
                  break;
               }
               _loc10_ = IconItemManager.getIconItemByCode(_loc9_,"");
               _loc10_.itemCount = _loc6_[_loc9_];
               _loc11_ = this.obf_0_5_7_110[_loc8_];
               _loc11_.pushIconItem(_loc10_);
               _loc8_++;
            }
         }
         if(JSONUtil.getInt(_loc5_,["sp>="]) > 0)
         {
            txtSp.text = JSONUtil.getInt(_loc5_,["sp>="]) + "";
         }
         txtCurrentAttr.htmlText = EquipmentManager.getEquipmentAttrHTML(this.obf_Q_4_2390.itemCode,this.obf_Q_4_2390);
         var _loc7_:GameItemFullInfo = new GameItemFullInfo();
         this.obf_Q_4_2390.obf_0_5_A_522(_loc7_);
         ++_loc7_.equipmentInfo.equLevel;
         txtLevelUpAttr.htmlText = EquipmentManager.getEquipmentAttrHTML(_loc7_.itemCode,_loc7_);
      }
      
      public function obf_q_D_1668() : void
      {
         var _loc1_:IconItemBag = null;
         this.obf_Q_4_2390 = null;
         cmdLevelUp.enabled = true;
         for each(_loc1_ in this.obf_0_5_7_110)
         {
            _loc1_.dropIconItem();
         }
         txtCurrentAttr.htmlText = "";
         txtLevelUpAttr.htmlText = "";
         txtSp.text = "";
         barExp.gotoAndStop(1);
         txtExp.text = "";
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(Boolean(this.obf_I_j_3665.haveIconItem) && Boolean(this.getInfoTimeInv.checkTimeout()) && !this.obf_Q_4_2390)
         {
            this.obf_Q_4_2390 = GameItemInfoManager.getItemInfo(this.obf_I_j_3665.haveIconItem.itemId);
            if(this.obf_Q_4_2390)
            {
               this.showSoulContent();
            }
            else
            {
               GameContext.bagItemManager.sendViewItem(this.obf_I_j_3665.haveIconItem.itemId);
            }
         }
         if(Boolean(this.buttonTimeInv) && this.buttonTimeInv.checkTimeout())
         {
            this.buttonTimeInv = null;
            cmdLevelUp.enabled = true;
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
         if(Boolean(param1) && Boolean(param2))
         {
            this.obf_S_k_2067(param2);
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         if(param1 == this.obf_I_j_3665)
         {
            this.obf_q_D_1668();
            this.obf_I_j_3665.dropIconItem();
         }
      }
      
      public function get mouseOn() : Boolean
      {
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyCurrentLevel,"SoulWeaponLevelUpUI","txtCurrentSoul");
         DiversityManager.setTextField(txtDeyCurrentAttr,"SoulWeaponLevelUpUI","txtCurrentAttr");
         DiversityManager.setTextField(txtDeyLevelUpAttr,"SoulWeaponLevelUpUI","txtNextAttr");
         DiversityManager.setTextField(txtDeyLevelUpMaterial,"SoulWeaponLevelUpUI","txtLevelMaterial");
         DiversityManager.setTextField(txtDeySp,"SoulWeaponLevelUpUI","txtSp");
         DiversityManager.setTextField(txtDeyLevelUpExp,"SoulWeaponLevelUpUI","txtExp");
         cmdLevelUp.label = DiversityManager.getString("SoulWeaponLevelUpUI","cmdLevelUp");
      }
      
      public function showUI() : void
      {
         var _loc1_:IconItemBag = null;
         if(obf_K_e_3075.playerFullInfoUI)
         {
            _loc1_ = obf_K_e_3075.playerFullInfoUI.getEquipBagByKind(EquipmentKind.obf_m_S_4609);
            if(Boolean(_loc1_) && Boolean(_loc1_.haveIconItem))
            {
               this.obf_S_k_2067(_loc1_.haveIconItem);
            }
         }
         this.visible = true;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.obf_q_D_1668();
         this.obf_I_j_3665.dropIconItem();
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

