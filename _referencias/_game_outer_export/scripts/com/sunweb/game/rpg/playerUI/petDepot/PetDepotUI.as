package com.sunweb.game.rpg.playerUI.petDepot
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.petDepot.PetDepotItemInfo;
   import com.sunweb.game.rpg.petDepot.obf_0_1_a_376;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.rpg.worldZone.command.petDepot.PetDepotUpLevelAnswer;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import playerUI.PetDepotUIMC;
   
   public class PetDepotUI extends PetDepotUIMC implements IIconItemUI
   {
      
      public var bags:Array;
      
      public var allBags:Array;
      
      private var pageButtons:Array;
      
      private var bagsPage:Array;
      
      private var bagsBox:Array;
      
      private var bagPageSize:int = 50;
      
      private var petDepotConfig:Object;
      
      private var currentLv:int;
      
      public function PetDepotUI()
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:IconItemBag = null;
         this.bags = new Array();
         this.allBags = new Array();
         this.bagsPage = new Array();
         this.bagsBox = new Array();
         super();
         this.visible = false;
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         titleBox.mouseEnabled = false;
         this.pageButtons = [this.cmdPage1,this.cmdPage2,this.cmdPage3,this.cmdPage4];
         var _loc1_:int = 1;
         while(_loc1_ <= this.pageButtons.length)
         {
            _loc3_ = new Array();
            (this["page" + _loc1_] as MovieClip).doubleClickEnabled = true;
            this.bagsBox.push(this["page" + _loc1_]);
            _loc4_ = 0;
            while(_loc4_ < this.bagPageSize)
            {
               _loc5_ = this["page" + _loc1_]["bag" + _loc4_];
               if(_loc5_ != null)
               {
                  _loc6_ = new IconItemBag(_loc5_,this,(_loc1_ - 1) * this.bagPageSize + _loc4_);
                  _loc6_.isLocked = true;
                  _loc6_.lockDrag = true;
                  _loc6_.addValidType(GameItemType.PET);
                  _loc3_.push(_loc6_);
                  this.allBags.push(_loc6_);
               }
               _loc4_++;
            }
            this.bagsPage.push(_loc3_);
            _loc1_++;
         }
         this.petDepotConfig = obf_0_1_a_376.getPetDepotConfig();
         this.setBagsPage(1);
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.underline = true;
         txtRemark2.setTextFormat(_loc2_);
         this.obf_x_v_2806();
      }
      
      private function obf_x_v_2806() : void
      {
         var _loc1_:MovieClip = null;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         closeButton.addEventListener(MouseEvent.CLICK,this.onClose);
         for each(_loc1_ in this.pageButtons)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.obf_k_X_2379);
         }
         cmdUpLv.addEventListener(MouseEvent.CLICK,this.onUpLv);
         cmdUpLv.addEventListener(MouseEvent.MOUSE_OVER,this.obf_G_k_3294);
         cmdUpLv.addEventListener(MouseEvent.MOUSE_OUT,this.obf_6_b_2643);
         obf_K_e_3075.addUIMouseToolTip(txtRemark2,"remarkPetWardrobe");
      }
      
      private function removerLsiten() : void
      {
         var _loc1_:MovieClip = null;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         closeButton.removeEventListener(MouseEvent.CLICK,this.onClose);
         for each(_loc1_ in this.pageButtons)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.obf_k_X_2379);
         }
         cmdUpLv.removeEventListener(MouseEvent.CLICK,this.onUpLv);
         cmdUpLv.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_G_k_3294);
         cmdUpLv.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_6_b_2643);
         obf_K_e_3075.removeUIMouseToolTip(txtRemark2);
      }
      
      private function onStartDrag(param1:MouseEvent) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      private function onClose(param1:MouseEvent) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function onUpLv(param1:Event) : void
      {
         var _loc4_:String = null;
         if(!this.petDepotConfig)
         {
            return;
         }
         var _loc2_:int = (JSONUtil.getInt(this.petDepotConfig,["max"]) - JSONUtil.getInt(this.petDepotConfig,["init"])) / 2;
         if(this.currentLv >= _loc2_ + 1)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("PetDepotUI","maxLv"));
            return;
         }
         var _loc3_:Object = JSONUtil.getValue(this.petDepotConfig,"upLevelItem");
         for(_loc4_ in _loc3_)
         {
            if(_loc3_[_loc4_] > obf_K_e_3075.playerBagUI.getItemCount(_loc4_))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("PetDepotUI","noStuf"));
               return;
            }
         }
         obf_0_1_a_376.sendPetDepotUpLevelRequest();
      }
      
      private function obf_G_k_3294(param1:MouseEvent) : void
      {
         var _loc6_:String = null;
         var _loc7_:Object = null;
         var _loc2_:Object = JSONUtil.getValue(this.petDepotConfig,"upLevelItem");
         var _loc3_:GameTipUI = new GameTipUI("PetDepotUITip");
         var _loc4_:int = 150;
         var _loc5_:int = 0;
         for(_loc6_ in _loc2_)
         {
            _loc5_++;
            _loc7_ = GameItemManager.getItemConfig(_loc6_);
            _loc3_.addTipInfo(DiversityManager.getString("PetDepotUI","upLvCost",[_loc7_.name,_loc2_[_loc6_]]),_loc4_,_loc5_);
         }
         GameTipManager.showTip(_loc3_);
      }
      
      private function obf_6_b_2643(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("PetDepotUITip");
      }
      
      private function obf_k_X_2379(param1:Event) : void
      {
         this.setBagsPage(this.pageButtons.indexOf(param1.currentTarget) + 1);
      }
      
      public function setBagsPage(param1:int) : void
      {
         var bagBox:MovieClip = null;
         var page:int = param1;
         page = Math.max(1,Math.min(this.pageButtons.length,page));
         var i:int = 0;
         while(i < this.pageButtons.length)
         {
            (this.pageButtons[i] as MovieClip).gotoAndStop(i + 1 == page ? 2 : 1);
            i++;
         }
         for each(bagBox in this.bagsBox)
         {
            try
            {
               this.removeChild(bagBox);
            }
            catch(e:Error)
            {
            }
         }
         this.addChild(this.bagsBox[page - 1]);
         this.bags = this.bagsPage[page - 1];
      }
      
      public function obf_J_5_1993(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:IconItemBag = null;
         if(Boolean(this.allBags) && this.allBags.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this.allBags.length)
            {
               _loc3_ = this.allBags[_loc2_];
               if(_loc2_ < param1)
               {
                  _loc3_.isLocked = false;
               }
               else
               {
                  _loc3_.isLocked = true;
               }
               _loc2_++;
            }
         }
      }
      
      public function obf_R_2_4129(param1:Object) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:String = "";
         for(_loc3_ in param1)
         {
            _loc2_ += RoleAttributesModifierEnum.getAttributesName(_loc3_) + ": " + RoleAttributesModifierEnum.getAttributesValueString(int(_loc3_),param1[_loc3_]) + "\r";
         }
         txtArr.text = _loc2_;
      }
      
      public function obf_k_T_4034(param1:PetDepotUpLevelAnswer) : void
      {
         txtIconBarNum.text = "";
         txtLv.text = "";
         this.currentLv = param1.currentLv;
         txtIconBarNum.text = DiversityManager.getString("PetDepotUI","txtIconBarNum",[param1.currentCount]);
         txtLv.text = DiversityManager.getString("PetDepotUI","txtLv",[param1.currentLv]);
      }
      
      public function onBagCheck(param1:Array) : void
      {
         var _loc2_:IconItemBag = null;
         var _loc3_:PetDepotItemInfo = null;
         var _loc4_:IconItemBag = null;
         var _loc5_:IconItem = null;
         if(this.allBags != null && this.allBags.length > 0)
         {
            for each(_loc2_ in this.allBags)
            {
               if(_loc2_.haveIconItem)
               {
                  _loc2_.dropIconItem();
               }
            }
            for each(_loc3_ in param1)
            {
               if(_loc3_.index < this.allBags.length)
               {
                  _loc4_ = this.allBags[_loc3_.index];
               }
               if(_loc4_)
               {
                  _loc4_.dropIconItem();
                  _loc5_ = null;
                  if(_loc3_.item)
                  {
                     _loc5_ = IconItemManager.getIconItemByCode(_loc3_.item.itemCode,_loc3_.item.itemId);
                  }
                  if(_loc5_ != null)
                  {
                     _loc5_.itemCount = _loc3_.item.itemCount;
                     _loc5_.itemId = _loc3_.item.itemId;
                     _loc4_.pushIconItem(_loc5_);
                  }
               }
            }
         }
         txtEquNum.text = "";
         txtEquNum.text = param1.length + "";
      }
      
      public function getAllBags() : Array
      {
         return this.allBags;
      }
      
      public function haveEmptyBag(param1:int) : Boolean
      {
         var _loc3_:IconItemBag = null;
         var _loc2_:int = 0;
         for each(_loc3_ in this.allBags)
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
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
         if(Boolean(param1) && param1.isLocked)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("PetDepotUI","upLv"));
            return;
         }
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
         if(!param1.haveIconItem)
         {
            return;
         }
         if(obf_K_e_3075.petBoxUI.getEnptyBag() <= 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("PetDepotUI","petPrompt_BagIsFull"));
            return;
         }
         var _loc2_:int = this.allBags.indexOf(param1);
         obf_0_1_a_376.sendPetDepotRemoveRequest(_loc2_,param1.haveIconItem.itemId);
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         var _loc5_:IconItemBag = null;
         if(!param1)
         {
            return;
         }
         if(!param1 || param3.parentIconUI != obf_K_e_3075.petBoxUI)
         {
            return;
         }
         if(!this.haveEmptyBag(1))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("PetDepotUI","bagFull"));
            return;
         }
         var _loc4_:Object = GameItemManager.getItemConfig(param2.itemCode);
         if(!_loc4_)
         {
            return;
         }
         if(param2.itemId == obf_K_e_3075.petBoxUI.sommunPetId)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("PetDepotUI","sommun"));
            return;
         }
         if(_loc4_.rank == GameItemRank.NOMAL)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("PetDepotUI","NOMAL"));
            return;
         }
         if(GameItemManager.haveValidTime(param2.itemCode))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("RideBoxUI","term"));
            return;
         }
         for each(_loc5_ in this.allBags)
         {
            if(Boolean(_loc5_.haveIconItem) && _loc5_.haveIconItem.itemCode == param2.itemCode)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("PetDepotUI","be"));
               return;
            }
         }
         obf_0_1_a_376.sendPetDepotAddRequest(param2.itemId);
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
         DiversityManager.setTextField(cmdPage1.txtLabel,"PetDepotUI","cmdPage1",null,true);
         DiversityManager.setTextField(cmdPage2.txtLabel,"PetDepotUI","cmdPage2",null,true);
         DiversityManager.setTextField(cmdPage3.txtLabel,"PetDepotUI","cmdPage3",null,true);
         DiversityManager.setTextField(cmdPage4.txtLabel,"PetDepotUI","cmdPage4",null,true);
         DiversityManager.setTextField(txtDeyTitle,"PetDepotUI","txtDeyTitle");
         DiversityManager.setTextField(txtDayEquNum,"PetDepotUI","txtDayEquNum");
         DiversityManager.setTextField(txtRemark1,"PetDepotUI","txtRemark1");
         txtRemark2.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("PetDepotUI","txtRemark2") + "</a>";
         DiversityManager.setTextField(txtDayArr,"PetDepotUI","txtDayArr");
         cmdUpLv.label = DiversityManager.getString("PetDepotUI","cmdUpLv");
      }
      
      public function showUI() : void
      {
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         var _loc1_:IconItemBag = null;
         this.removerLsiten();
         for each(_loc1_ in this.allBags)
         {
            _loc1_.destroy();
            if(this.contains(_loc1_))
            {
               this.removeChild(_loc1_);
            }
         }
         this.bags = null;
         this.allBags = null;
      }
   }
}

