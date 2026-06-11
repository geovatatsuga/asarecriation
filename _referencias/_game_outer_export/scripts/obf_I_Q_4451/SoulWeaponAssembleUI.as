package obf_I_Q_4451
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.equ.EquipmentKind;
   import com.sunweb.game.rpg.equ.EquipmentManager;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemSubtype;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.gameItem.obf_x_c_2855;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.worldZone.command.npc.NpcAssembleItemAnswer;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.SoulWeaponAssembleUIMC;
   
   public class SoulWeaponAssembleUI extends SoulWeaponAssembleUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      private var obf_s_T_3528:IconItemBag;
      
      private var obf_T_8_3721:IconItemBag;
      
      private var obf_0_5_7_110:Array;
      
      private var obf_Q_4_2390:GameItemFullInfo;
      
      private var obf_W_w_1676:String;
      
      private var obf_5_j_1206:String;
      
      private var _currentAssembleConfig:Object;
      
      private var getInfoTimeInv:TimeLimiter;
      
      public function SoulWeaponAssembleUI()
      {
         var _loc2_:MovieClip = null;
         var _loc3_:IconItemBag = null;
         this.getInfoTimeInv = new TimeLimiter(1000);
         super();
         this.initDiversity();
         this.visible = false;
         this.bags = new Array();
         this.obf_s_T_3528 = new IconItemBag(bagSoul,this,0);
         this.obf_s_T_3528.addValidType(GameItemType.EQUIPMENT);
         this.bags.push(this.obf_s_T_3528);
         this.obf_T_8_3721 = new IconItemBag(bagAssembleSoul,this,0);
         this.obf_T_8_3721.addValidType(GameItemType.EQUIPMENT);
         this.obf_T_8_3721.lockDrag = true;
         this.bags.push(this.obf_T_8_3721);
         this.obf_0_5_7_110 = new Array();
         var _loc1_:int = 0;
         while(_loc1_ <= 4)
         {
            _loc2_ = this["bagMaterial" + _loc1_] as MovieClip;
            if(_loc2_)
            {
               _loc3_ = new IconItemBag(_loc2_,this,_loc1_);
               _loc3_.addValidType(GameItemType.ALL);
               _loc3_.lockDrag = true;
               this.obf_0_5_7_110.push(_loc3_);
               this.bags.push(_loc3_);
            }
            _loc1_++;
         }
         this.addListener();
      }
      
      private function addListener() : void
      {
         cmdSoulWeaponAssemble.addEventListener(MouseEvent.CLICK,this.obf_W_j_2205);
      }
      
      private function removeListener() : void
      {
         cmdSoulWeaponAssemble.removeEventListener(MouseEvent.CLICK,this.obf_W_j_2205);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(Boolean(this.obf_s_T_3528.haveIconItem) && Boolean(!this.obf_Q_4_2390) && this.getInfoTimeInv.checkTimeout())
         {
            this.obf_Q_4_2390 = GameItemInfoManager.getItemInfo(this.obf_s_T_3528.haveIconItem.itemId);
            if(!this.obf_Q_4_2390)
            {
               GameContext.bagItemManager.sendViewItem(this.obf_s_T_3528.haveIconItem.itemId);
            }
            else
            {
               cmdSoulWeaponAssemble.enabled = true;
            }
         }
      }
      
      private function obf_W_j_2205(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc4_:int = 0;
         if(obf_L_l_4100.isEmpty(this.obf_W_w_1676) || !this._currentAssembleConfig || !this.obf_Q_4_2390)
         {
            return;
         }
         for(_loc2_ in this._currentAssembleConfig.baseItems)
         {
            if(_loc2_ != this.obf_s_T_3528.haveIconItem.itemCode)
            {
               if(GameContext.bagItemManager.getHaveItemCount(_loc2_,true) < this._currentAssembleConfig.baseItems[_loc2_])
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("AssembleBoxUI","noMoreMaterial",[GameItemManager.getItemName(_loc2_)]));
                  return;
               }
            }
         }
         if(GameContext.localPlayer.fullInfo.gold < this._currentAssembleConfig.costGold)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("AssembleBoxUI","promptAssemberError_NoMoreGold"));
            return;
         }
         if(!ConditionScript.checkCondition(this._currentAssembleConfig.condition,null,true))
         {
            return;
         }
         if(JSONUtil.getInt(this._currentAssembleConfig,["reqEquLevel"]) != 0)
         {
            _loc4_ = int(this._currentAssembleConfig.reqEquLevel);
            if(_loc4_ < 0)
            {
               _loc4_ = EquipmentManager.getEquipmentMaxLevel(this.obf_W_w_1676);
            }
            if(this.obf_Q_4_2390.isEmpty || !this.obf_Q_4_2390.equipmentInfo || this.obf_Q_4_2390.equipmentInfo.equLevel < _loc4_)
            {
               obf_K_e_3075.showInfoOnUI(DiversityManager.getString("AssembleBoxUI","promptAssemberError_EquipLevel",[GameItemManager.getItemName(this.obf_W_w_1676),_loc4_]),this);
               return;
            }
         }
         var _loc3_:IconItemBag = obf_K_e_3075.playerFullInfoUI.getEquipBagByKind(EquipmentKind.obf_m_S_4609);
         if(Boolean(this.obf_s_T_3528.haveIconItem) && Boolean(_loc3_.haveIconItem) && this.obf_s_T_3528.haveIconItem.itemCode == _loc3_.haveIconItem.itemCode)
         {
            EquipmentManager.sendRemoveEquip(EquipmentKind.obf_m_S_4609,-1);
         }
         obf_x_c_2855.sendAssemble("",null,this._currentAssembleConfig.ruleIndex,null,true,[this.obf_5_j_1206]);
      }
      
      public function showAssembleSoul(param1:String, param2:String) : void
      {
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         var _loc8_:IconItemBag = null;
         var _loc9_:IconItem = null;
         this.clearAssembleSoul();
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc3_)
         {
            return;
         }
         if(_loc3_.subtype != GameItemSubtype.obf_s_2_3291)
         {
            return;
         }
         var _loc4_:Object = obf_x_c_2855.getConfigInMaterialMap(param1,0);
         if(!_loc4_)
         {
            return;
         }
         this._currentAssembleConfig = _loc4_;
         this.obf_W_w_1676 = param1;
         this.obf_5_j_1206 = param2;
         this.obf_s_T_3528.pushIconItem(IconItemManager.getIconItemByCode(param1,param2));
         this.obf_T_8_3721.pushIconItem(IconItemManager.getIconItemByCode(_loc4_.mainTargetItem,""));
         txtSoulAttr.htmlText = EquipmentManager.getEquipmentAttrHTML(param1);
         txtAssembleSoulAttr.htmlText = EquipmentManager.getEquipmentAttrHTML(_loc4_.mainTargetItem);
         if(this._currentAssembleConfig.costGold > 0)
         {
            pointGold.addChild(obf_a_f_2935.getGoldDisplay(this._currentAssembleConfig.costGold));
         }
         var _loc5_:Array = obf_x_c_2855.getAssembleBaseMaterial(this._currentAssembleConfig.ruleIndex);
         if((Boolean(_loc5_)) && _loc5_.length > 0)
         {
            _loc6_ = 0;
            for each(_loc7_ in _loc5_)
            {
               if(_loc7_.itemCode != this.obf_W_w_1676)
               {
                  if(_loc6_ >= this.obf_0_5_7_110.length)
                  {
                     break;
                  }
                  _loc8_ = this.obf_0_5_7_110[_loc6_];
                  _loc9_ = IconItemManager.getIconItemByCode(_loc7_.itemCode,"");
                  if(_loc9_)
                  {
                     _loc9_.itemCount = _loc7_.itemCount;
                     _loc8_.pushIconItem(_loc9_);
                     _loc6_++;
                  }
               }
            }
         }
      }
      
      public function clearAssembleSoul() : void
      {
         var _loc1_:IconItemBag = null;
         this._currentAssembleConfig = null;
         this.obf_W_w_1676 = "";
         this.obf_5_j_1206 = "";
         this.obf_Q_4_2390 = null;
         for each(_loc1_ in this.bags)
         {
            if(_loc1_)
            {
               _loc1_.dropIconItem();
            }
         }
         txtSoulAttr.htmlText = "";
         txtAssembleSoulAttr.htmlText = "";
         while(pointGold.numChildren > 0)
         {
            pointGold.removeChildAt(0);
         }
         cmdSoulWeaponAssemble.enabled = false;
      }
      
      public function obf_w_i_3412(param1:NpcAssembleItemAnswer) : void
      {
         var _loc2_:IconItemBag = null;
         if(!this._currentAssembleConfig)
         {
            return;
         }
         if(param1.assembleRuleIndex == this._currentAssembleConfig.ruleIndex)
         {
            this.clearAssembleSoul();
            _loc2_ = obf_K_e_3075.playerBagUI.getIconItemBagByCode(obf_x_c_2855.getMainTargetItemCodeById(param1.assembleRuleIndex + ""));
            if(Boolean(_loc2_) && Boolean(_loc2_.haveIconItem))
            {
               this.showAssembleSoul(_loc2_.haveIconItem.itemCode,_loc2_.haveIconItem.itemId);
            }
         }
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
         if(Boolean(param2) && param1 == this.obf_s_T_3528)
         {
            this.showAssembleSoul(param2.itemCode,param2.itemId);
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
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
         DiversityManager.setTextField(txtDeyAssembleMaterial,"SoulWeaponAssembleUI","txtAssembleCondition");
         DiversityManager.setTextField(txtDeyGold,"SoulWeaponAssembleUI","txtGold");
         cmdSoulWeaponAssemble.label = DiversityManager.getString("SoulWeaponAssembleUI","cmdAssemble");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         var _loc1_:IconItemBag = obf_K_e_3075.playerFullInfoUI.getEquipBagByKind(EquipmentKind.obf_m_S_4609);
         if(Boolean(_loc1_) && Boolean(_loc1_.haveIconItem))
         {
            this.showAssembleSoul(_loc1_.haveIconItem.itemCode,_loc1_.haveIconItem.itemId);
         }
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.clearAssembleSoul();
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function destroy() : void
      {
         var _loc1_:IconItemBag = null;
         this.removeListener();
         for each(_loc1_ in this.bags)
         {
            _loc1_.destroy();
         }
      }
   }
}

