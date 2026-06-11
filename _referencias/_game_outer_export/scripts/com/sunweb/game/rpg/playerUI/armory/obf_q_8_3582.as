package com.sunweb.game.rpg.playerUI.armory
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemSubtype;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.gameItem.obf_x_c_2855;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.ItemShowBoxUI;
   import com.sunweb.game.rpg.playerUI.PlayerBagUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.worldZone.command.npc.NpcAssembleItemAnswer;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import fl.data.DataProvider;
   import fl.events.ScrollEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import playerUI.ArmoryComposeUIMC;
   
   public class obf_q_8_3582 extends ArmoryComposeUIMC implements IIconItemUI
   {
      
      private var itemsBag:Array;
      
      private var materialsBags:Array;
      
      private var obf_a_1_1812:IconItemBag;
      
      private var _bagMaterial:IconItemBag;
      
      private var obf_g_L_4409:IconItemBag;
      
      private var obf_t_G_2524:IconItemBag;
      
      private var obf_0_4_e_131:IconItemBag;
      
      private var obf_0_5_1_561:IconItemBag;
      
      private var obf_Q_d_1861:Array;
      
      private var selectType:String;
      
      private var selectTallyItem:ItemShowBoxUI;
      
      private var obf_N_V_2726:TimeLimiter;
      
      private var tallyUpConfig:Object;
      
      private var obf_O_G_1308:Array;
      
      private var readyRuleIndex:uint;
      
      private var obf_0_0_N_146:String;
      
      private var isClickLVup:int;
      
      private var assembleTimeLimit:TimeLimiter;
      
      private var obf_u_4667:String;
      
      public function obf_q_8_3582()
      {
         super();
         this.itemsBag = new Array();
         this.materialsBags = new Array();
         this.initDiversity();
         this.initBags();
         this.btnTallyUpdate.enabled = false;
         this.btnProductCompose.enabled = false;
         assembleBar.gotoAndStop(1);
         assembleBar.visible = false;
         this.addListener();
         var _loc1_:Array = WorldConfig.getObjectSetting("armoryAssembleTypeList") as Array;
         if(_loc1_)
         {
            this.obf_0_0_N_146 = _loc1_[0];
         }
      }
      
      private function addListener() : void
      {
         this.listType.addEventListener(Event.CHANGE,this.typeChangeHandler);
         this.scrolltallyList.addEventListener(ScrollEvent.SCROLL,this.obf_r_p_1917);
         this.btnTallyUpdate.addEventListener(MouseEvent.CLICK,this.btnTallyUpdateHandler);
         this.btnProductCompose.addEventListener(MouseEvent.CLICK,this.btnProductComposeHandler);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         obf_K_e_3075.addUIMouseToolTip(txttallylevelInfo,"armoryCompose");
      }
      
      private function removeListener() : void
      {
         this.listType.removeEventListener(Event.CHANGE,this.typeChangeHandler);
         this.scrolltallyList.removeEventListener(ScrollEvent.SCROLL,this.obf_r_p_1917);
         this.btnTallyUpdate.removeEventListener(MouseEvent.CLICK,this.btnTallyUpdateHandler);
         this.btnProductCompose.removeEventListener(MouseEvent.CLICK,this.btnProductComposeHandler);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         obf_K_e_3075.removeUIMouseToolTip(txttallylevelInfo);
      }
      
      public function obf_w_i_3412(param1:NpcAssembleItemAnswer) : void
      {
         var _loc2_:IconItemBag = null;
         var _loc3_:IconItem = null;
         if(!this.tallyUpConfig)
         {
            return;
         }
         if(param1.assembleRuleIndex == this.tallyUpConfig.ruleIndex)
         {
            this.obf_0_0_L_145();
            if(!param1.isSucceeded)
            {
               return;
            }
            _loc2_ = obf_K_e_3075.playerBagUI.getIconItemBagByCode(obf_x_c_2855.getMainTargetItemCodeById(param1.assembleRuleIndex + ""));
            if(Boolean(_loc2_) && Boolean(_loc2_.haveIconItem))
            {
               _loc3_ = IconItemManager.getIconItemByCode(_loc2_.haveIconItem.itemCode,_loc2_.haveIconItem.itemId);
               if(_loc3_)
               {
                  this.obf_7_d_3129(_loc3_);
               }
            }
         }
      }
      
      private function initBags() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:IconItemBag = null;
         this.obf_a_1_1812 = new IconItemBag(bagTally,this,0);
         this.obf_a_1_1812.addValidType(GameItemType.COLLECTION);
         this.itemsBag.push(this.obf_a_1_1812);
         this._bagMaterial = new IconItemBag(bagMaterial,this,0);
         this._bagMaterial.addValidType(GameItemType.ALL);
         this._bagMaterial.lockDrag = true;
         this.itemsBag.push(this._bagMaterial);
         this.obf_g_L_4409 = new IconItemBag(this.bagSuccess,this,0);
         this.obf_g_L_4409.addValidType(GameItemType.ALL);
         this.obf_g_L_4409.lockDrag = true;
         this.itemsBag.push(this.obf_g_L_4409);
         this.obf_t_G_2524 = new IconItemBag(this.bagFailed,this,0);
         this.obf_t_G_2524.addValidType(GameItemType.ALL);
         this.obf_t_G_2524.lockDrag = true;
         this.itemsBag.push(this.obf_t_G_2524);
         this.obf_0_4_e_131 = new IconItemBag(this.bagProduct,this,0);
         this.obf_0_4_e_131.addValidType(GameItemType.ALL);
         this.obf_0_4_e_131.lockDrag = true;
         this.itemsBag.push(this.obf_0_4_e_131);
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            _loc2_ = this["mbag" + _loc1_];
            if(_loc2_)
            {
               _loc3_ = new IconItemBag(_loc2_,this,0);
               _loc3_.lockDrag = true;
               _loc3_.addValidType(GameItemType.ALL);
               this.materialsBags.push(_loc3_);
            }
            _loc1_++;
         }
         this.obf_0_5_1_561 = new IconItemBag(bagSafe,this,0);
         this.obf_0_5_1_561.addValidType(GameItemType.ALL);
         this.itemsBag.push(this.obf_0_5_1_561);
      }
      
      private function obf_p_V_1905(param1:IconItem, param2:Boolean = false) : void
      {
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc6_:Object = null;
         var _loc7_:String = null;
         var _loc8_:Object = null;
         var _loc9_:String = null;
         var _loc10_:IconItem = null;
         if(!param1)
         {
            return;
         }
         this.obf_O_G_1308 = obf_x_c_2855.getMaterialAssembleList(this.obf_a_1_1812.haveIconItem.itemCode);
         var _loc5_:int = 0;
         while(_loc5_ < this.obf_O_G_1308.length)
         {
            _loc6_ = JSONUtil.getObject(obf_x_c_2855.getConfigById(this.obf_O_G_1308[_loc5_]).protectionItems,null);
            if(_loc6_)
            {
               for(_loc7_ in _loc6_)
               {
                  _loc4_ = GameItemManager.getItemEqual(_loc7_);
                  if(_loc7_ == param1.itemCode || _loc4_ == param1.itemCode)
                  {
                     param1.itemCount = _loc6_[_loc7_];
                     if(param1.itemCount > obf_K_e_3075.playerBagUI.getEqualItemCount(_loc7_))
                     {
                        if(param2)
                        {
                           obf_K_e_3075.showTipInfo(DiversityManager.getString("ArmoryUI","showtip",[param1.itemCount]));
                        }
                        return;
                     }
                     this.obf_0_5_1_561.dropIconItem();
                     this.obf_0_5_1_561.pushIconItem(param1);
                     _loc3_ = obf_x_c_2855.getConfigById(this.obf_O_G_1308[_loc5_]);
                     break;
                  }
               }
            }
            _loc5_++;
         }
         if(!_loc3_ || !_loc3_.protectionItems)
         {
            return;
         }
         this.tallyUpConfig = _loc3_;
         if(Boolean(this.obf_0_5_1_561.haveIconItem) && Boolean(this.tallyUpConfig.gainItemsWhenProtectionFailed))
         {
            _loc8_ = JSONUtil.getObject(this.tallyUpConfig.gainItemsWhenProtectionFailed,null);
            for(_loc9_ in _loc8_)
            {
               _loc10_ = IconItemManager.getIconItemByCode(_loc9_,"");
               if(_loc10_)
               {
                  this.pushIconItem(this.obf_t_G_2524,_loc10_,_loc8_[_loc9_]);
               }
            }
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(this.visible && Boolean(this.assembleTimeLimit))
         {
            _loc2_ = this.assembleTimeLimit.totalTimeInMS / this.assembleTimeLimit.timelimit * 100;
            assembleBar.gotoAndStop(_loc2_);
            if(this.assembleTimeLimit.checkTimeout())
            {
               obf_x_c_2855.sendAssemble("",null,this.readyRuleIndex,null,false,null,this.obf_u_4667);
               this.assembleTimeLimit = null;
               assembleBar.visible = false;
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
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.obf_0_0_L_145();
         var _loc1_:Array = obf_x_c_2855.getSubtypeList(this.obf_0_0_N_146);
         if(!_loc1_)
         {
            return;
         }
         listType.dataProvider = new DataProvider(_loc1_);
         this.showTallyList(obf_x_c_2855.getConfigsByType(this.obf_0_0_N_146,_loc1_[0]));
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.assembleTimeLimit = null;
         assembleBar.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this.selectType = "";
         this.obf_Q_d_1861 = new Array();
         this.selectTallyItem = null;
         this.obf_r_j_4183();
         this.clearTallyList();
         this.obf_0_0_L_145();
      }
      
      public function getIconItemBags() : Array
      {
         return this.itemsBag.concat(this.materialsBags).concat(this.obf_Q_d_1861);
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
         if(Boolean(param1.haveIconItem) && this.obf_0_5_1_561 == param1)
         {
            this.obf_0_5_1_561.dropIconItem();
            this.obf_t_G_2524.dropIconItem();
         }
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         var _loc4_:Object = null;
         if(!param1)
         {
            return;
         }
         if(param1 == this.obf_a_1_1812)
         {
            _loc4_ = GameItemManager.getItemConfig(param2.itemCode);
            if(!_loc4_)
            {
               return;
            }
            if(_loc4_.subtype == GameItemSubtype.obf_L_j_4553)
            {
               this.obf_7_d_3129(param2);
            }
         }
         if(Boolean(!this.obf_0_5_1_561.isLocked && this.tallyUpConfig) && Boolean(this.obf_a_1_1812.haveIconItem) && param1 == this.obf_0_5_1_561)
         {
            this.obf_p_V_1905(param2,true);
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         if(param1 == this.obf_a_1_1812)
         {
            this.obf_0_0_L_145();
         }
         if((param3 == null || param3 is PlayerBagUI) && Boolean(param1.haveIconItem))
         {
            this.obf_0_5_1_561.dropIconItem();
            this.obf_t_G_2524.dropIconItem();
         }
      }
      
      private function typeChangeHandler(param1:Event = null) : void
      {
         this.showTallyList(obf_x_c_2855.getConfigsByType(this.obf_0_0_N_146,listType.selectedItem.data));
      }
      
      public function obf_7_d_3129(param1:IconItem) : void
      {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         var _loc4_:IconItem = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:IconItem = null;
         var _loc8_:Object = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:IconItem = null;
         this.obf_0_0_L_145();
         this.tallyUpConfig = obf_x_c_2855.getConfigInMaterialMap(param1.itemCode,0);
         if(this.tallyUpConfig)
         {
            _loc2_ = JSONUtil.getStr(this.tallyUpConfig,["mainTargetItem"]);
            _loc3_ = GameItemManager.getItemConfig(_loc2_);
            if(!_loc3_)
            {
               return;
            }
            if(_loc3_.subtype != GameItemSubtype.obf_L_j_4553)
            {
               return;
            }
            _loc4_ = IconItemManager.getIconItemByCode(_loc2_,"");
            if(_loc4_)
            {
               this.pushIconItem(this.obf_g_L_4409,_loc4_);
            }
            for(_loc5_ in this.tallyUpConfig.baseItems)
            {
               if(_loc5_ == param1.itemCode)
               {
                  this.pushIconItem(this.obf_a_1_1812,param1,this.tallyUpConfig.baseItems[_loc5_]);
               }
               else
               {
                  _loc7_ = IconItemManager.getIconItemByCode(_loc5_,"");
                  if(_loc7_)
                  {
                     this.pushIconItem(this._bagMaterial,_loc7_,this.tallyUpConfig.baseItems[_loc5_]);
                  }
               }
            }
            _loc6_ = int(this.tallyUpConfig.baseChance * 100) + "";
            DiversityManager.setTextField(this.txtSuccessRate,"ArmoryUI","tallyUpRate",[_loc6_]);
            if(Boolean(!this.obf_0_5_1_561.isLocked) && Boolean(this.obf_a_1_1812.haveIconItem) && Boolean(this.tallyUpConfig.protectionItems))
            {
               _loc8_ = JSONUtil.getObject(this.tallyUpConfig,["protectionItems"]);
               for(_loc9_ in _loc8_)
               {
                  if(obf_K_e_3075.playerBagUI.getItemCount(_loc9_) > 0)
                  {
                     _loc10_ = _loc9_;
                  }
                  else
                  {
                     _loc10_ = GameItemManager.getItemEqual(_loc9_);
                  }
                  _loc11_ = IconItemManager.getIconItemByCode(_loc10_,"");
                  if(_loc11_)
                  {
                     this.obf_p_V_1905(_loc11_);
                  }
               }
            }
            this.btnTallyUpdate.enabled = true;
         }
      }
      
      private function pushIconItem(param1:IconItemBag, param2:IconItem, param3:uint = 1) : void
      {
         param1.dropIconItem();
         if(param2)
         {
            param2.itemCount = param3;
            param1.pushIconItem(param2);
         }
      }
      
      private function obf_r_p_1917(param1:ScrollEvent) : void
      {
         this.typeListPoint.scrollRect = new Rectangle(0,param1.position,scrolltallyList.x - typeListPoint.x,scrolltallyList.height);
      }
      
      private function btnTallyUpdateHandler(param1:MouseEvent) : void
      {
         if(this.tallyUpConfig)
         {
            this.isClickLVup = 1;
            this.doTallyCompose(this.tallyUpConfig);
         }
      }
      
      private function btnProductComposeHandler(param1:MouseEvent) : void
      {
         if(this.selectTallyItem)
         {
            this.isClickLVup = 2;
            this.doTallyCompose(this.selectTallyItem.composeConfig);
         }
      }
      
      private function doTallyCompose(param1:Object) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(this.assembleTimeLimit)
         {
            return;
         }
         if(!obf_K_e_3075.playerBagUI || !GameContext.currentMap)
         {
            return;
         }
         if(!param1)
         {
            return;
         }
         var _loc2_:int = 0;
         for(_loc3_ in param1.targetItems)
         {
            _loc2_++;
         }
         if(!obf_K_e_3075.playerBagUI.haveEmptyBag(_loc2_))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","nomoreEmptyBag"));
            return;
         }
         if(this.isClickLVup == 1 && Boolean(this.obf_0_5_1_561.haveIconItem))
         {
            for(_loc4_ in param1.protectionItems)
            {
               if(GameContext.bagItemManager.getHaveItemCount(_loc4_,true) < param1.protectionItems[_loc4_])
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("AssembleBoxUI","noMoreMaterial",[GameItemManager.getItemName(_loc4_)]));
                  return;
               }
            }
         }
         if(!obf_x_c_2855.obf_C_e_1742(param1))
         {
            return;
         }
         this.readyRuleIndex = param1.ruleIndex;
         this.obf_u_4667 = "";
         if(Boolean(this.obf_0_5_1_561.haveIconItem) && this.isClickLVup == 1)
         {
            this.obf_u_4667 = this.obf_0_5_1_561.haveIconItem.itemCode;
         }
         this.assembleTimeLimit = new TimeLimiter(JSONUtil.getInt(param1,["costTimeInSec"],1) * 1000);
         assembleBar.visible = true;
      }
      
      public function showTallyList(param1:Array) : void
      {
         var _loc5_:Object = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:ItemShowBoxUI = null;
         var _loc9_:String = null;
         if(!param1)
         {
            return;
         }
         this.obf_Q_d_1861 = new Array();
         this.clearTallyList();
         this.obf_r_j_4183();
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = -1;
         for each(_loc5_ in param1)
         {
            _loc4_++;
            if(JSONUtil.getStr(_loc5_,["mainTargetItem"]) != "")
            {
               _loc6_ = _loc5_.mainTargetItem;
            }
            else
            {
               var _loc12_:int = 0;
               var _loc13_:* = _loc5_.targetItems;
               for(_loc9_ in _loc13_)
               {
                  _loc6_ = _loc9_;
               }
            }
            _loc7_ = int(_loc5_.targetItems[_loc6_]);
            _loc8_ = new ItemShowBoxUI(_loc6_,_loc7_);
            _loc8_.dockParentUI(this,this.obf_Q_d_1861);
            _loc8_.addEventListener(MouseEvent.CLICK,this.obf_g_K_4255);
            _loc8_.composeConfig = _loc5_;
            _loc8_.x = (_loc4_ + 2) % 2 * _loc8_.width;
            _loc8_.y = _loc2_;
            _loc3_ = _loc8_.height;
            this.typeListPoint.addChild(_loc8_);
            if((_loc4_ + 2) % 2 == 1)
            {
               _loc2_ += _loc8_.height;
            }
         }
         _loc2_ += _loc3_;
         this.scrolltallyList.minScrollPosition = 1;
         this.scrolltallyList.maxScrollPosition = 1;
         this.typeListPoint.scrollRect = new Rectangle(0,0,this.scrolltallyList.x - this.typeListPoint.x,this.scrolltallyList.height);
         if(_loc2_ > scrolltallyList.height)
         {
            scrolltallyList.pageSize = scrolltallyList.height;
            scrolltallyList.minScrollPosition = 1;
            scrolltallyList.maxScrollPosition = _loc2_ - scrolltallyList.height;
         }
         scrolltallyList.visible = scrolltallyList.enabled;
      }
      
      private function obf_g_K_4255(param1:MouseEvent) : void
      {
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc7_:IconItemBag = null;
         var _loc8_:IconItem = null;
         var _loc9_:IconItem = null;
         if(this.selectTallyItem)
         {
            this.selectTallyItem.selected = false;
         }
         this.selectTallyItem = param1.currentTarget as ItemShowBoxUI;
         this.selectTallyItem.selected = true;
         var _loc2_:Object = this.selectTallyItem.composeConfig;
         if(!_loc2_)
         {
            return;
         }
         this.obf_r_j_4183();
         var _loc3_:Array = new Array();
         for(_loc4_ in _loc2_.baseItems)
         {
            _loc3_.push({
               "itemCode":_loc4_,
               "itemCount":_loc2_.baseItems[_loc4_]
            });
         }
         _loc3_.sortOn("itemCode");
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            if(_loc5_ >= this.materialsBags.length)
            {
               break;
            }
            _loc7_ = this.materialsBags[_loc5_];
            _loc8_ = IconItemManager.getIconItemByCode(_loc3_[_loc5_].itemCode,"");
            _loc8_.itemCount = _loc3_[_loc5_].itemCount;
            if(obf_K_e_3075.playerBagUI.getItemCount(_loc8_.itemCode) < _loc8_.itemCount)
            {
               _loc8_.countTextColor = 16711680;
            }
            _loc7_.pushIconItem(_loc8_);
            _loc5_++;
         }
         var _loc6_:String = _loc2_.mainTargetItem as String;
         if(_loc6_)
         {
            _loc9_ = IconItemManager.getIconItemByCode(_loc6_,"");
            this.obf_0_4_e_131.pushIconItem(_loc9_);
         }
         DiversityManager.setTextField(this.txtProductRate,"ArmoryUI","productRate",[_loc2_.baseChance * 100]);
         this.btnProductCompose.enabled = true;
      }
      
      private function clearTallyList() : void
      {
         var _loc1_:ItemShowBoxUI = null;
         this.selectTallyItem = null;
         while(typeListPoint.numChildren > 0)
         {
            _loc1_ = typeListPoint.getChildAt(0) as ItemShowBoxUI;
            if(_loc1_)
            {
               _loc1_.removeEventListener(MouseEvent.CLICK,this.obf_g_K_4255);
               _loc1_.destroy();
            }
            typeListPoint.removeChildAt(0);
         }
      }
      
      private function obf_r_j_4183() : void
      {
         var _loc1_:IconItemBag = null;
         for each(_loc1_ in this.materialsBags)
         {
            _loc1_.dropIconItem();
         }
         this.obf_0_4_e_131.dropIconItem();
         DiversityManager.setTextField(this.txtProductRate,"ArmoryUI","productRate",[0]);
         this.btnProductCompose.enabled = false;
      }
      
      private function obf_0_0_L_145() : void
      {
         this.tallyUpConfig = null;
         this.obf_a_1_1812.dropIconItem();
         this._bagMaterial.dropIconItem();
         this.obf_t_G_2524.dropIconItem();
         this.obf_g_L_4409.dropIconItem();
         this.obf_0_5_1_561.dropIconItem();
         this.obf_0_5_1_561.isLocked = false;
         this.btnTallyUpdate.enabled = false;
         DiversityManager.setTextField(this.txtSuccessRate,"ArmoryUI","tallyUpRate",[0]);
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(this.txtDeyType,"ArmoryUI","tallyType");
         DiversityManager.setTextField(this.txtFailed,"ArmoryUI","failed");
         DiversityManager.setTextField(this.txtSuccess,"ArmoryUI","success");
         DiversityManager.setTextField(this.txtMainMaterial,"ArmoryUI","mainMaterial");
         DiversityManager.setTextField(this.txtMaterial,"ArmoryUI","needMaterial");
         DiversityManager.setTextField(this.txtTally,"ArmoryUI","armoryTally");
         DiversityManager.setTextField(this.txtSafe,"ArmoryUI","armorySafe");
         DiversityManager.setTextField(this.txtProduct,"ArmoryUI","product");
         DiversityManager.setTextField(this.txtProductRate,"ArmoryUI","productRate",[0]);
         DiversityManager.setTextField(this.txtSuccessRate,"ArmoryUI","tallyUpRate",[0]);
         DiversityManager.setTextField(txttallylevelInfo,"ArmoryUI","tallylevelInfo",null,true);
         this.btnProductCompose.label = DiversityManager.getString("ArmoryUI","compose");
         this.btnTallyUpdate.label = DiversityManager.getString("ArmoryUI","compose");
      }
   }
}

