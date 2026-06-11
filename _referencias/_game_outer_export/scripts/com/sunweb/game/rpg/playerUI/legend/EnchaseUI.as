package com.sunweb.game.rpg.playerUI.legend
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemSubtype;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.legend.LegendAttrKind;
   import com.sunweb.game.rpg.legend.obf_P_8_3783;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.EnchaseUIMC;
   
   public class EnchaseUI extends EnchaseUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      private var obf_M_q_1929:Array;
      
      private var itemBag1:IconItemBag;
      
      private var itemBag2:IconItemBag;
      
      private var equipInfo:GameItemFullInfo;
      
      private var timeInv:TimeLimiter = new TimeLimiter(100);
      
      private var obf_s_H_3873:IconItemBag;
      
      public function EnchaseUI()
      {
         super();
         this.visible = false;
         this.initDiversity();
         this.bags = new Array();
         this.itemBag1 = new IconItemBag(obf_8_3_3181,this,0);
         this.itemBag1.lockDrag = true;
         this.itemBag1.addValidType(GameItemType.EQUIPMENT);
         this.bags.push(this.itemBag1);
         this.obf_M_q_1929 = new Array();
         this.itemBag2 = new IconItemBag(obf_T_o_3829,this,1);
         this.itemBag2.lockDrag = true;
         this.itemBag2.addValidType(GameItemType.COLLECTION);
         this.obf_M_q_1929.push(this.itemBag2);
         this.bags.push(this.itemBag2);
         this.addListener();
      }
      
      private function addListener() : void
      {
         cmdEnchase.addEventListener(MouseEvent.CLICK,this.onEnchase);
      }
      
      private function removeListener() : void
      {
         cmdEnchase.removeEventListener(MouseEvent.CLICK,this.onEnchase);
      }
      
      private function onEnchase(param1:Event) : void
      {
         if(!obf_K_e_3075.playerBagUI.getIconItemBagByID(this.itemBag1.haveIconItem.itemId))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("EnchaseUI","notHaveItemInBag"));
            return;
         }
         if(obf_P_8_3783.costMoney > GameContext.localPlayer.fullInfo.gold)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("EnchaseUI","noGold"));
            return;
         }
         if(!obf_K_e_3075.playerBagUI.haveEmptyBag(1))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("EnchaseUI","playerBagFull"));
            return;
         }
         obf_P_8_3783.sendRemoveRequest(this.itemBag1.haveIconItem.itemId,this.obf_s_H_3873.itemIndex);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.timeInv.checkTimeout() && !this.equipInfo)
         {
            this.obf_l_n_3275();
         }
      }
      
      private function obf_l_n_3275() : void
      {
         if(!this.itemBag1.haveIconItem)
         {
            return;
         }
         this.equipInfo = GameItemInfoManager.getItemInfo(this.itemBag1.haveIconItem.itemId);
         if(this.equipInfo)
         {
            this.setGemBags(this.equipInfo);
         }
         else
         {
            GameContext.bagItemManager.sendViewItem(this.itemBag1.haveIconItem.itemId);
         }
      }
      
      private function setGemBags(param1:GameItemFullInfo) : void
      {
         var _loc4_:IconItemBag = null;
         var _loc5_:IconItem = null;
         if(!param1 || !param1.equipmentInfo || !this.equipInfo)
         {
            return;
         }
         var _loc2_:Object = GameItemManager.getItemConfig(param1.itemCode);
         var _loc3_:int = 0;
         while(_loc3_ < this.obf_M_q_1929.length)
         {
            _loc4_ = this.obf_M_q_1929[_loc3_];
            _loc4_.dropIconItem();
            _loc4_.isLocked = _loc3_ >= param1.equipmentInfo.legendHole;
            if(param1.equipmentInfo.legends[_loc3_ + 1])
            {
               _loc5_ = IconItemManager.getIconItemByCode(param1.equipmentInfo.legends[_loc3_ + 1],"");
               if(_loc5_)
               {
                  _loc4_.pushIconItem(_loc5_);
               }
            }
            _loc3_++;
         }
      }
      
      private function selectHole(param1:int) : void
      {
         var _loc2_:Object = obf_P_8_3783.getHoleConfig(param1);
         if(!_loc2_)
         {
            return;
         }
         if(!obf_K_e_3075.playerBagUI.getIconItemBagByID(this.itemBag1.haveIconItem.itemId))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("EnchaseUI","notHaveItemInBag"));
            return;
         }
         WindowManager.showConfirmBox(DiversityManager.getString("EnchaseUI","confirm_Hole",[obf_7_6_4416.getItemLinkA(_loc2_.itemCode,""),_loc2_.itemNum]),this.confirmHole,{
            "code":_loc2_.itemCode,
            "num":_loc2_.itemNum
         });
      }
      
      private function confirmHole(param1:Object) : void
      {
         if(!param1.confirm)
         {
            return;
         }
         if(param1.par.num > obf_K_e_3075.playerBagUI.getItemCount(param1.par.code))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("EnchaseUI","noStuf"));
            return;
         }
         obf_P_8_3783.sendHoleReques(this.itemBag1.haveIconItem.itemId);
      }
      
      private function selectDisembed(param1:IconItemBag) : void
      {
         if(!this.equipInfo || !this.itemBag1.haveIconItem)
         {
            return;
         }
         while(mgPoint.numChildren > 0)
         {
            mgPoint.removeChildAt(0);
         }
         this.obf_s_H_3873 = param1;
         mgPoint.addChild(obf_a_f_2935.getGoldDisplay(obf_P_8_3783.costMoney));
         txtExpendable.text = DiversityManager.getString("EnchaseUI","txtExpendable");
         cmdEnchase.visible = true;
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
         if(param1 != this.itemBag1)
         {
            if(param1.isLocked)
            {
               this.selectHole(param1.itemIndex);
            }
            else if(param1.haveIconItem)
            {
               this.selectDisembed(param1);
            }
         }
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
         if(param1 == this.itemBag1)
         {
            if(param1.haveIconItem)
            {
               param1.dropIconItem();
               txtGemType.text = "";
            }
            this.clearContent(true);
         }
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:IconItemBag = null;
         if(!param1)
         {
            return;
         }
         if(param1 == this.itemBag1)
         {
            _loc4_ = GameItemManager.getItemConfig(param2.itemCode);
            if(!_loc4_)
            {
               return;
            }
            if(_loc4_.subtype != GameItemSubtype.EQUIPMENT_WEAPON && _loc4_.subtype != GameItemSubtype.EQUIPMENT_SHIELD && _loc4_.subtype != GameItemSubtype.EQUIPMENT_CLOTHES && _loc4_.subtype != GameItemSubtype.EQUIPMENT_HAT && _loc4_.subtype != GameItemSubtype.EQUIPMENT_SHOES && _loc4_.subtype != GameItemSubtype.EQUIPMENT_GLOVE && _loc4_.subtype != GameItemSubtype.EQUIPMENT_RING && _loc4_.subtype != GameItemSubtype.EQUIPMENT_AMULET)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("EnchaseUI","cantPush"));
               return;
            }
            this.pushEquipIn(param2.itemCode);
            param1.dropIconItem();
            param1.pushIconItem(param2);
         }
         if(param1 == this.itemBag2)
         {
            if(!this.itemBag1.haveIconItem)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("EnchaseUI","txtName"));
               return;
            }
            if(!obf_K_e_3075.playerBagUI.getIconItemBagByID(this.itemBag1.haveIconItem.itemId))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("EnchaseUI","notHaveItemInBag"));
               return;
            }
            _loc5_ = GameItemManager.getItemConfig(this.itemBag1.haveIconItem.itemCode);
            _loc6_ = GameItemManager.getItemConfig(param2.itemCode);
            if(!_loc6_ || !_loc5_)
            {
               return;
            }
            if(!JSONUtil.getBoolean(_loc6_,["properties","isLegend"]))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("EnchaseUI","isLegend"));
               return;
            }
            _loc7_ = JSONUtil.getValue(_loc6_,"properties","equipKinds") as Array;
            _loc8_ = JSONUtil.getInt(_loc5_,["properties","kind"]);
            if(_loc7_.indexOf(_loc8_) < 0)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("EnchaseUI","noEnchase"));
               return;
            }
            _loc9_ = 0;
            for each(_loc10_ in this.obf_M_q_1929)
            {
               if(!_loc10_.isLocked && !_loc10_.haveIconItem)
               {
                  _loc9_++;
               }
            }
            if(_loc9_ < 1)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("EnchaseUI","noHole"));
               return;
            }
            WindowManager.showConfirmBox(DiversityManager.getString("EnchaseUI","confirm_Embed"),this.confirmEmbed,{
               "gemIndex":param1.itemIndex,
               "itemIndex":param3.itemIndex
            });
         }
         param2.itemCount = 1;
         param2.countTextVisible = false;
      }
      
      private function confirmEmbed(param1:Object) : void
      {
         if(!param1.confirm)
         {
            return;
         }
         obf_P_8_3783.sendEmbedRequest(this.itemBag1.haveIconItem.itemId,param1.par.gemIndex,param1.par.itemIndex);
      }
      
      public function pushEquipIn(param1:String) : void
      {
         var _loc6_:int = 0;
         var _loc2_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:Object = obf_P_8_3783.getGemTypeConfg();
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:String = "";
         var _loc5_:int = JSONUtil.getInt(_loc2_,["properties","kind"]);
         for each(_loc6_ in _loc3_[_loc5_])
         {
            _loc4_ += LegendAttrKind.getTypeString(_loc6_) + "\n";
         }
         txtGemType.text = _loc4_;
         this.clearContent();
         this.equipInfo = null;
      }
      
      public function haveEmptyBag(param1:int) : Boolean
      {
         var _loc3_:IconItemBag = null;
         var _loc2_:int = 0;
         for each(_loc3_ in this.obf_M_q_1929)
         {
            if(!_loc3_.isLocked)
            {
               if(_loc3_.haveIconItem == null)
               {
                  if(++_loc2_ >= param1)
                  {
                     return true;
                  }
               }
            }
         }
         return _loc2_ >= param1;
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
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
         cmdEnchase.label = DiversityManager.getString("EnchaseUI","cmdEnchase");
         DiversityManager.setTextField(txtName,"EnchaseUI","txtName");
         DiversityManager.setTextField(txtDeyGemType,"EnchaseUI","txtDeyGemType");
         DiversityManager.setTextField(txtDeyPrompt,"EnchaseUI","txtDeyPrompt");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         cmdEnchase.visible = false;
         if(this.itemBag1.haveIconItem)
         {
         }
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function closeUI() : void
      {
         this.clearContent();
         this.itemBag1.dropIconItem();
         txtGemType.text = "";
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function clearContent(param1:Boolean = false) : void
      {
         var _loc2_:IconItemBag = null;
         for each(_loc2_ in this.obf_M_q_1929)
         {
            _loc2_.visible = true;
            _loc2_.dropIconItem();
            _loc2_.isLocked = false;
         }
         if(param1)
         {
            this.equipInfo = null;
         }
         while(mgPoint.numChildren > 0)
         {
            mgPoint.removeChildAt(0);
         }
         txtExpendable.text = "";
         cmdEnchase.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

