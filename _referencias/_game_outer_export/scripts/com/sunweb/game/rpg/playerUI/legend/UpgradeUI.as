package com.sunweb.game.rpg.playerUI.legend
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.legend.obf_P_8_3783;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import playerUI.UpgradeUIMC;
   
   public class UpgradeUI extends UpgradeUIMC implements IIconItemUI
   {
      
      private var mainGemBarBag:Array;
      
      private var obf_n_A_2739:Array;
      
      private var obf_m_t_2198:IconItemBag;
      
      private var obf_l_J_2325:int;
      
      private var currentCost:int;
      
      private var obf_u_F_4067:String;
      
      private var isMoney:Boolean;
      
      public function UpgradeUI()
      {
         var _loc3_:IconItemBag = null;
         super();
         this.visible = false;
         this.initDiversity();
         this.mainGemBarBag = new Array();
         this.obf_m_t_2198 = new IconItemBag(obf_T_o_3829,this,0);
         this.obf_m_t_2198.lockDrag = true;
         this.obf_m_t_2198.addValidType(GameItemType.COLLECTION);
         this.mainGemBarBag.push(this.obf_m_t_2198);
         this.obf_n_A_2739 = new Array();
         var _loc1_:int = 1;
         while(_loc1_ <= 12)
         {
            _loc3_ = new IconItemBag(this["iconBar" + _loc1_],this,_loc1_);
            _loc3_.lockDrag = true;
            _loc3_.addValidType(GameItemType.COLLECTION);
            this.obf_n_A_2739.push(_loc3_);
            _loc1_++;
         }
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.underline = true;
         txtDayAchieve.setTextFormat(_loc2_);
         this.addListener();
      }
      
      private function addListener() : void
      {
         godCheck.addEventListener(MouseEvent.CLICK,this.obf_P_G_3138);
         moneyCheck.addEventListener(MouseEvent.CLICK,this.obf_P_G_3138);
         cmdUp.addEventListener(MouseEvent.CLICK,this.onClickUpLv);
         obf_K_e_3075.addUIMouseToolTip(txtDayAchieve,"legendAchieve");
      }
      
      private function removeListener() : void
      {
         godCheck.removeEventListener(MouseEvent.CLICK,this.obf_P_G_3138);
         moneyCheck.removeEventListener(MouseEvent.CLICK,this.obf_P_G_3138);
         cmdUp.removeEventListener(MouseEvent.CLICK,this.onClickUpLv);
         obf_K_e_3075.removeUIMouseToolTip(txtDayAchieve);
      }
      
      private function onClickUpLv(param1:Event) : void
      {
         var _loc3_:IconItemBag = null;
         if(!this.obf_m_t_2198.haveIconItem)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("UpgradeUI","select"));
            return;
         }
         if(this.obf_l_J_2325 == 2 && this.currentCost > GameContext.localPlayer.fullInfo.gold)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("UpgradeUI","noGold"));
            return;
         }
         if(this.obf_l_J_2325 == 1 && this.currentCost > GameContext.localPlayer.fullInfo.money)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("UpgradeUI","noMoney"));
            return;
         }
         if(!obf_K_e_3075.playerBagUI.haveEmptyBag(1))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("UpgradeUI","playerBagFull"));
            return;
         }
         var _loc2_:Object = new Object();
         for each(_loc3_ in this.obf_n_A_2739)
         {
            if(_loc3_.haveIconItem)
            {
               if(_loc2_[_loc3_.haveIconItem.itemCode])
               {
                  _loc2_[_loc3_.haveIconItem.itemCode] += _loc3_.haveIconItem.itemCount;
               }
               else
               {
                  _loc2_[_loc3_.haveIconItem.itemCode] = _loc3_.haveIconItem.itemCount;
               }
            }
         }
         obf_P_8_3783.sendUpLevelRequest(this.obf_m_t_2198.haveIconItem.itemCode,_loc2_,this.isMoney);
         this.setConstType(this.obf_l_J_2325);
      }
      
      public function obf_v_g_1699() : void
      {
         txtLeavings.text = "";
         txtLeavings.text = DiversityManager.getString("UpgradeUI","txtLeavings",[obf_P_8_3783.goldUpLvNmu,obf_P_8_3783.num]);
      }
      
      private function obf_P_G_3138(param1:Event) : void
      {
         if(param1.target.name == "moneyCheck")
         {
            this.setConstType(1);
         }
         if(param1.target.name == "godCheck")
         {
            if(obf_P_8_3783.goldUpLvNmu < 1)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("UpgradeUI","noNum"));
               return;
            }
            this.setConstType(2);
         }
      }
      
      private function setConstType(param1:int) : void
      {
         var _loc2_:Object = null;
         this.obf_l_J_2325 = param1;
         while(mgPoint.numChildren > 0)
         {
            mgPoint.removeChildAt(0);
         }
         if(this.obf_l_J_2325 == 1)
         {
            moneyCheck.selected = true;
            godCheck.selected = false;
            if(this.obf_u_F_4067)
            {
               _loc2_ = GameItemManager.getItemConfig(this.obf_u_F_4067);
               if(!_loc2_)
               {
                  return;
               }
               if(obf_P_8_3783.getUpLevelConfig(_loc2_.itemLevel))
               {
                  this.currentCost = JSONUtil.getInt(obf_P_8_3783.getUpLevelConfig(_loc2_.itemLevel),["money"]);
               }
               mgPoint.addChild(obf_a_f_2935.getMoneyDisplay(this.currentCost));
            }
            this.isMoney = true;
         }
         else if(this.obf_l_J_2325 == 2)
         {
            godCheck.selected = true;
            moneyCheck.selected = false;
            if(this.obf_u_F_4067)
            {
               _loc2_ = GameItemManager.getItemConfig(this.obf_u_F_4067);
               if(!_loc2_)
               {
                  return;
               }
               if(obf_P_8_3783.getUpLevelConfig(_loc2_.itemLevel))
               {
                  this.currentCost = JSONUtil.getInt(obf_P_8_3783.getUpLevelConfig(_loc2_.itemLevel),["gold"]);
               }
               mgPoint.addChild(obf_a_f_2935.getGoldDisplay(this.currentCost));
            }
            this.isMoney = false;
         }
         if(!this.obf_m_t_2198.haveIconItem)
         {
            txtName.text = DiversityManager.getString("UpgradeUI","txtName");
         }
         txtLeavings.text = "";
         txtLeavings.text = DiversityManager.getString("UpgradeUI","txtLeavings",[obf_P_8_3783.goldUpLvNmu,obf_P_8_3783.num]);
      }
      
      private function obf_n_8_2968(param1:String) : void
      {
         this.clear();
         var _loc2_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc2_)
         {
            return;
         }
         txtName.text = _loc2_.name;
         txtDaySucceed.text = DiversityManager.getString("UpgradeUI","txtDaySucceed");
         txtLv.text = DiversityManager.getString("UpgradeUI","upToLv",[_loc2_.itemLevel + 1]);
         txtSucceed.text = DiversityManager.getString("UpgradeUI","txtSucceed",[0]);
      }
      
      private function obf_i_T_3027() : void
      {
         var _loc4_:int = 0;
         var _loc5_:IconItemBag = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Object = null;
         txtSucceed.text = "";
         var _loc1_:Object = GameItemManager.getItemConfig(this.obf_m_t_2198.haveIconItem.itemCode);
         var _loc2_:String = JSONUtil.getStr(_loc1_,["properties","toCode"]);
         var _loc3_:Object = GameItemManager.getItemConfig(_loc2_);
         if(!_loc1_ || !_loc3_)
         {
            return;
         }
         for each(_loc5_ in this.obf_n_A_2739)
         {
            if(_loc5_.haveIconItem)
            {
               _loc9_ = GameItemManager.getItemConfig(_loc5_.haveIconItem.itemCode);
               _loc4_ += JSONUtil.getInt(_loc9_,["properties","chance"]) * _loc5_.haveIconItem.itemCount;
            }
         }
         _loc6_ = JSONUtil.getInt(_loc3_,["properties","chance"]);
         _loc7_ = obf_P_8_3783.upMul;
         _loc8_ = int(_loc4_ / (_loc6_ * _loc7_) * 100);
         if(_loc8_ >= 100)
         {
            txtSucceed.text = DiversityManager.getString("UpgradeUI","txtSucceed",[100]);
         }
         else
         {
            txtSucceed.text = DiversityManager.getString("UpgradeUI","txtSucceed",[_loc8_]);
         }
      }
      
      public function clear() : void
      {
         txtName.text = "";
         txtDaySucceed.text = "";
         txtLv.text = "";
         txtSucceed.text = "";
      }
      
      public function getIconItemBags() : Array
      {
         return this.mainGemBarBag.concat(this.obf_n_A_2739);
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
         if(param1 == this.obf_m_t_2198)
         {
            this.clear();
            this.obf_J_7_2424(true);
         }
         else
         {
            param1.dropIconItem();
            this.obf_i_T_3027();
         }
         this.setConstType(this.obf_l_J_2325);
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:IconItemBag = null;
         if(!param1 || !param2)
         {
            return;
         }
         var _loc4_:Object = GameItemManager.getItemConfig(param2.itemCode);
         if(!_loc4_)
         {
            return;
         }
         if(!JSONUtil.getBoolean(_loc4_,["properties","isLegend"]))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("UpgradeUI","isLegend"));
            return;
         }
         if(param1 == this.obf_m_t_2198)
         {
            if(!JSONUtil.getStr(_loc4_,["properties","toCode"]))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("UpgradeUI","toCode"));
               return;
            }
            param2.itemCount = 1;
            param2.countTextVisible = false;
            this.obf_n_8_2968(param2.itemCode);
            this.obf_u_F_4067 = param2.itemCode;
         }
         else
         {
            if(!this.obf_m_t_2198.haveIconItem)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("UpgradeUI","txtName"));
               return;
            }
            param2.itemCount = 1;
            _loc5_ = param2.itemCount;
            _loc6_ = 0;
            if(param2.itemCode == this.obf_m_t_2198.haveIconItem.itemCode)
            {
               if(_loc5_ + 1 > obf_K_e_3075.playerBagUI.getItemCount(param2.itemCode))
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("UpgradeUI","sure"));
                  return;
               }
               if(_loc5_ + 1 < obf_K_e_3075.playerBagUI.getItemCount(param2.itemCode))
               {
                  for each(_loc7_ in this.obf_n_A_2739)
                  {
                     if(Boolean(_loc7_.haveIconItem) && _loc7_.haveIconItem.itemCode == param2.itemCode)
                     {
                        _loc6_ += _loc7_.haveIconItem.itemCount;
                     }
                  }
                  if(_loc6_ + _loc5_ + 1 > obf_K_e_3075.playerBagUI.getItemCount(param2.itemCode))
                  {
                     obf_K_e_3075.showTipInfo(DiversityManager.getString("UpgradeUI","sure"));
                     return;
                  }
               }
            }
            else
            {
               for each(_loc7_ in this.obf_n_A_2739)
               {
                  if(Boolean(_loc7_.haveIconItem) && _loc7_.haveIconItem.itemCode == param2.itemCode)
                  {
                     _loc6_ += _loc7_.haveIconItem.itemCount;
                  }
               }
               if(_loc6_ + _loc5_ > obf_K_e_3075.playerBagUI.getItemCount(param2.itemCode))
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("UpgradeUI","sure"));
                  return;
               }
            }
         }
         param2.countTextVisible = false;
         param1.dropIconItem();
         param1.pushIconItem(param2);
         this.setConstType(this.obf_l_J_2325);
         this.obf_i_T_3027();
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
         DiversityManager.setTextField(txtExpendable,"UpgradeUI","txtExpendable");
         DiversityManager.setTextField(txtName,"UpgradeUI","txtName");
         cmdUp.label = DiversityManager.getString("UpgradeUI","cmdUp");
         moneyCheck.label = DiversityManager.getString("UpgradeUI","moneyCheck");
         godCheck.label = DiversityManager.getString("UpgradeUI","godCheck");
         txtDayAchieve.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("UpgradeUI","txtDayAchieve") + "</a>";
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.setConstType(1);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.clear();
         this.obf_J_7_2424(true);
      }
      
      public function obf_J_7_2424(param1:Boolean = false) : void
      {
         var _loc2_:IconItemBag = null;
         for each(_loc2_ in this.obf_n_A_2739)
         {
            if(_loc2_.haveIconItem)
            {
               _loc2_.dropIconItem();
            }
         }
         txtSucceed.text = DiversityManager.getString("UpgradeUI","txtSucceed",[0]);
         if(param1)
         {
            this.obf_m_t_2198.dropIconItem();
            this.obf_u_F_4067 = "";
            txtSucceed.text = "";
            txtName.text = DiversityManager.getString("UpgradeUI","txtName");
         }
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

