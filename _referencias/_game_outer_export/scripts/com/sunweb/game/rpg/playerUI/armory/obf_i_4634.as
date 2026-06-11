package com.sunweb.game.rpg.playerUI.armory
{
   import com.sunweb.game.rpg.armory.ArmoryItemInfo;
   import com.sunweb.game.rpg.armory.obf_S_M_1257;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.equ.EquipmentKind;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.PlayerBagUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import playerUI.ArmoryUpgradeUIMC;
   
   public class obf_i_4634 extends ArmoryUpgradeUIMC implements IIconItemUI
   {
      
      private var itemBags:Array;
      
      public var _bagMaterial1:IconItemBag;
      
      public var _bagMaterial2:IconItemBag;
      
      private var obf_I_S_2412:Object;
      
      private var skillItemBags:Array;
      
      private var obf_p_p_3899:Array;
      
      private var specailItemBags:Array;
      
      private var bagKind:Object;
      
      private var time:TimeLimiter = new TimeLimiter(500);
      
      public function obf_i_4634()
      {
         super();
         this.itemBags = new Array();
         this.skillItemBags = new Array();
         this.obf_p_p_3899 = new Array();
         this.specailItemBags = new Array();
         this.obf_I_S_2412 = new Object();
         this.bagKind = new Object();
         this.txtArmoryName.mouseEnabled = false;
         this.txtArmoryName.text = "";
         expBar.gotoAndStop(1);
         this.initDiversity();
         this.initBags();
         this.addListener();
      }
      
      public function updateInfo() : void
      {
         this.upDataArmoryBase();
         this.expChange(obf_S_M_1257.obf_r_M_3661,obf_S_M_1257.getArmoryNeedMaxExp(obf_S_M_1257.obf_U_n_2740));
      }
      
      private function initBags() : void
      {
         var _loc1_:IconItemBag = null;
         var _loc2_:MovieClip = null;
         var _loc5_:Object = null;
         var _loc6_:Array = null;
         var _loc3_:Array = obf_S_M_1257.getEquipConfig();
         var _loc4_:Array = [["mbag0",EquipmentKind.obf_d_p_4239],["mbag1",EquipmentKind.obf_d_p_4239],["mbag2",EquipmentKind.obf_d_p_4239],["mbag3",EquipmentKind.obf_d_p_4239],["mbag4",EquipmentKind.obf_d_p_4239],["mbag5",EquipmentKind.obf_d_p_4239],["mbag6",EquipmentKind.obf_d_p_4239],["mbag7",EquipmentKind.obf_d_p_4239],["mbag8",EquipmentKind.obf_h_W_4446],["mbag9",EquipmentKind.obf_h_W_4446],["mbag10",EquipmentKind.obf_h_W_4446],["mbag11",EquipmentKind.obf_h_W_4446],["mbag12",EquipmentKind.obf_v_a_2182]];
         for each(_loc5_ in _loc3_)
         {
            if(this.hasOwnProperty(_loc5_.gridToMCName))
            {
               _loc2_ = this[_loc5_.gridToMCName];
               if(_loc2_)
               {
                  _loc1_ = new IconItemBag(_loc2_,this,0,_loc5_.gridToMCName);
                  _loc1_.isLocked = true;
                  _loc1_.addValidType(GameItemType.EQUIPMENT);
                  this.itemBags.push(_loc1_);
                  this.obf_I_S_2412[_loc5_.gridToMCName] = _loc1_;
                  _loc6_ = _loc5_.gridSubType as Array;
                  if(_loc6_)
                  {
                     if(_loc6_.indexOf(EquipmentKind.obf_d_p_4239) != -1)
                     {
                        this.obf_p_p_3899.push(_loc1_);
                     }
                     if(_loc6_.indexOf(EquipmentKind.obf_h_W_4446) != -1)
                     {
                        this.skillItemBags.push(_loc1_);
                     }
                     if(_loc6_.indexOf(EquipmentKind.obf_v_a_2182) != -1)
                     {
                        this.specailItemBags.push(_loc1_);
                     }
                     this.bagKind[_loc6_[0] + ""] = _loc1_;
                  }
               }
            }
         }
         this._bagMaterial1 = new IconItemBag(bagMaterial1,this,0);
         this._bagMaterial1.addValidType(GameItemType.ALL);
         this._bagMaterial1.lockDrag = true;
         this._bagMaterial2 = new IconItemBag(bagMaterial2,this,0);
         this._bagMaterial2.addValidType(GameItemType.ALL);
         this._bagMaterial2.lockDrag = true;
      }
      
      private function addListener() : void
      {
         this.btnUpgrade.addEventListener(MouseEvent.CLICK,this.btnUpgradeHandler);
         obf_K_e_3075.addUIMouseToolTip(tipButton,"armoryLvup");
      }
      
      private function removeListener() : void
      {
         this.btnUpgrade.removeEventListener(MouseEvent.CLICK,this.btnUpgradeHandler);
         obf_K_e_3075.removeUIMouseToolTip(tipButton);
      }
      
      public function getIconItemBags() : Array
      {
         return this.itemBags.concat(this._bagMaterial1).concat(this._bagMaterial2);
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
         obf_S_M_1257.sendArmoryRemove(param1.id,-1);
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         if(!param1)
         {
            return;
         }
         if(param3.parentIconUI == this)
         {
            return;
         }
         var _loc4_:Object = new Object();
         _loc4_.gridToMCName = param1.bagMC.name;
         var _loc5_:Object = GameItemManager.getItemConfig(param2.itemCode);
         if(!_loc5_ || !_loc5_.properties || !_loc5_.properties.kind)
         {
            return;
         }
         var _loc6_:Array = obf_S_M_1257.getEquipConfig() as Array;
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_.length)
         {
            if(_loc6_[_loc7_].gridToMCName == param1.bagMC.name)
            {
               if(!ConditionScript.checkCondition(_loc6_[_loc7_].gridTerm,null,true))
               {
                  return;
               }
               break;
            }
            _loc7_++;
         }
         if(this.skillItemBags.indexOf(param1) != -1)
         {
            if(_loc5_.properties.kind == EquipmentKind.obf_h_W_4446)
            {
               param3.useIconItem(_loc4_);
            }
            else
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ArmoryUI","canBut"));
            }
         }
         if(this.obf_p_p_3899.indexOf(param1) != -1)
         {
            if(_loc5_.properties.kind == EquipmentKind.obf_d_p_4239)
            {
               param3.useIconItem(_loc4_);
            }
            else
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ArmoryUI","canBut"));
            }
         }
         if(this.specailItemBags.indexOf(param1) != -1)
         {
            if(_loc5_.properties.kind == EquipmentKind.obf_v_a_2182)
            {
               param3.useIconItem(_loc4_);
            }
            else
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ArmoryUI","canBut"));
            }
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         if(!(param3 is PlayerBagUI || param3 == null))
         {
            return;
         }
         obf_S_M_1257.sendArmoryRemove(param1.id,param2 ? param2.itemIndex : -1);
      }
      
      public function pushTallyIconItem(param1:IconItemBag, param2:IconItem) : void
      {
         if(param1.haveIconItem)
         {
            param1.obf_o_g_3238();
            param1.dropIconItem();
         }
         param1.pushIconItem(param2);
      }
      
      public function showArmoryEquip(param1:Array) : void
      {
         var _loc2_:ArmoryItemInfo = null;
         var _loc3_:IconItemBag = null;
         var _loc4_:IconItem = null;
         for each(_loc2_ in param1)
         {
            _loc3_ = this.obf_I_S_2412[_loc2_.gridToMCName] as IconItemBag;
            if(_loc3_)
            {
               _loc3_.dropIconItem();
               if(_loc2_.equipment)
               {
                  _loc4_ = IconItemManager.getIconItemByCode(_loc2_.equipment.itemCode,"");
                  if(_loc4_)
                  {
                     this.pushTallyIconItem(_loc3_,_loc4_);
                  }
               }
            }
         }
         PlayerSkillManager.obf_y_m_873();
      }
      
      public function showArmoryUpgradeInfo() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Object = obf_S_M_1257.getUpGradeConfig(obf_S_M_1257.obf_U_n_2740);
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:Array = obf_S_M_1257.getNeedItems(_loc1_);
         while(_loc3_ < _loc2_.length)
         {
            if(this.hasOwnProperty("_bagMaterial" + (_loc3_ + 1)))
            {
               this["_bagMaterial" + (_loc3_ + 1)].pushIconItem(_loc2_[_loc3_]);
            }
            _loc3_++;
         }
         DiversityManager.setTextField(this.txtNeedMagicInt,"ArmoryUI","needMagic",[obf_S_M_1257.getNeedMaigicVal(_loc1_)]);
         moneyPoint.addChild(obf_a_f_2935.getGoldDisplay(JSONUtil.getInt(_loc1_,["armoryTerm","gold>="])));
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
      
      public function showUI() : void
      {
      }
      
      public function upDataArmoryBase() : void
      {
         this.obf_i_g_2474();
         this.openArmoryGrids(obf_S_M_1257.obf_h_D_2022);
         this.txtArmoryName.htmlText = obf_S_M_1257.getArmoryNameByLvl(obf_S_M_1257.obf_U_n_2740);
         this.showArmoryUpgradeInfo();
      }
      
      public function openArmoryGrids(param1:Array) : void
      {
         var _loc2_:String = null;
         var _loc3_:IconItemBag = null;
         for each(_loc2_ in param1)
         {
            if(this.obf_I_S_2412.hasOwnProperty(_loc2_))
            {
               _loc3_ = this.obf_I_S_2412[_loc2_] as IconItemBag;
               if(!_loc3_.haveIconItem)
               {
                  _loc3_.isLocked = false;
               }
            }
         }
      }
      
      private function btnUpgradeHandler(param1:MouseEvent) : void
      {
         if(this.time.checkTimeout())
         {
            if(obf_S_M_1257.obf_9_N_2822(obf_S_M_1257.getUpGradeConfig(obf_S_M_1257.obf_U_n_2740)))
            {
               obf_S_M_1257.sendArmoryUpgradeExp();
            }
         }
      }
      
      public function expChange(param1:int, param2:int) : void
      {
         DiversityManager.setTextField(this.txtExp,"ArmoryUI","upgradeExpValue",[param1,param2]);
         var _loc3_:int = 100 * Number(param1 / param2);
         if(_loc3_ < 2)
         {
            _loc3_ = 2;
         }
         expBar.gotoAndStop(_loc3_);
      }
      
      public function getEquipBindSkills() : Array
      {
         var _loc2_:String = null;
         var _loc3_:IconItemBag = null;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc1_:Array = new Array();
         for(_loc2_ in this.bagKind)
         {
            _loc3_ = this.bagKind[_loc2_];
            if(_loc3_.haveIconItem)
            {
               _loc4_ = GameItemManager.getItemConfig(_loc3_.haveIconItem.itemCode);
               if((Boolean(_loc4_)) && Boolean(_loc4_.properties.bindingSkills))
               {
                  for each(_loc5_ in _loc4_.properties.bindingSkills)
                  {
                     _loc1_.push(_loc5_);
                  }
               }
            }
         }
         return _loc1_;
      }
      
      private function obf_i_g_2474() : void
      {
         txtExp.text = "";
         DiversityManager.setTextField(this.txtNeedMagicInt,"ArmoryUI","needMagic",["0"]);
         this._bagMaterial1.obf_o_g_3238();
         this._bagMaterial1.dropIconItem();
         this._bagMaterial2.obf_o_g_3238();
         this._bagMaterial2.dropIconItem();
         while(moneyPoint.numChildren > 0)
         {
            moneyPoint.removeChildAt(0);
         }
      }
      
      public function closeUI() : void
      {
      }
      
      public function destroy() : void
      {
         this.obf_i_g_2474();
         this.removeListener();
         this.itemBags = new Array();
         this.obf_I_S_2412 = new Object();
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(this.txtNeedMagicInt,"ArmoryUI","needMagic",["0"]);
         DiversityManager.setTextField(this.txtNeedMoney,"ArmoryUI","needMoney");
         DiversityManager.setTextField(this.txtUpgradeExp,"ArmoryUI","upgradeExp");
         this.btnUpgrade.label = DiversityManager.getString("ArmoryUI","upgrade");
         tipButton.label = DiversityManager.getString("ArmoryUI","tipButton");
      }
   }
}

