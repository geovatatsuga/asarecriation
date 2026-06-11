package com.sunweb.game.rpg.playerUI.ride
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.iconItem.IconItemRide;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.ride.obf_0___z_209;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.RideFusionUIMC;
   
   public class RideFusionUI extends RideFusionUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      private var mainRideBag:IconItemBag;
      
      private var obf_l_d_3623:IconItemBag;
      
      private var obf_o_E_2418:IconItemBag;
      
      private var fusionMaterialBag:IconItemBag;
      
      private var mainRideInfo:GameItemFullInfo;
      
      private var mainRideConfig:Object;
      
      private var obf_j_b_1806:GameItemFullInfo;
      
      private var subRideConfig:Object;
      
      private var fusionValue:int;
      
      private var timeInv:TimeLimiter = new TimeLimiter(500);
      
      public function RideFusionUI()
      {
         super();
         this.initDiversity();
         this.onResize(null);
         titleBox.mouseEnabled = false;
         this.visible = false;
         this.bags = new Array();
         this.mainRideBag = new IconItemBag(bagMainRide,this,0);
         this.mainRideBag.addValidType(GameItemType.RIDE);
         this.mainRideBag.lockDrag = true;
         this.bags.push(this.mainRideBag);
         this.obf_l_d_3623 = new IconItemBag(bagSubRide,this,1);
         this.obf_l_d_3623.addValidType(GameItemType.RIDE);
         this.bags.push(this.obf_l_d_3623);
         this.obf_o_E_2418 = new IconItemBag(bagInvertMaterial,this,2);
         this.obf_o_E_2418.addValidType(GameItemType.ALL);
         this.obf_o_E_2418.lockDrag = true;
         this.bags.push(this.obf_o_E_2418);
         this.fusionMaterialBag = new IconItemBag(bagFusionMaterial,this,3);
         this.fusionMaterialBag.addValidType(GameItemType.ALL);
         this.fusionMaterialBag.lockDrag = true;
         this.bags.push(this.fusionMaterialBag);
         this.obf_2_B_4604();
         this.addListener();
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdFusion.addEventListener(MouseEvent.CLICK,this.obf_c_Z_1811);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdFusion.removeEventListener(MouseEvent.CLICK,this.obf_c_Z_1811);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function obf_c_Z_1811(param1:Event) : void
      {
         if(!this.mainRideInfo || !this.obf_j_b_1806)
         {
            return;
         }
         this.obf_s_x_1694();
         var _loc2_:Object = new Object();
         if(this.fusionMaterialBag.haveIconItem)
         {
            if(obf_K_e_3075.playerBagUI.getItemCount(this.fusionMaterialBag.haveIconItem.itemCode) < JSONUtil.getInt(obf_0___z_209.rideFusionConfig,["fusionItemCount"]))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("RideFusionUI","error_NoMoreFusionItem",[GameItemManager.getItemName(this.fusionMaterialBag.haveIconItem.itemCode)]));
               return;
            }
            _loc2_[this.fusionMaterialBag.haveIconItem.itemCode] = this.fusionMaterialBag.haveIconItem.itemCount;
            var _loc3_:Object = new Object();
            if(this.obf_o_E_2418.haveIconItem)
            {
               if(obf_K_e_3075.playerBagUI.getItemCount(this.obf_o_E_2418.haveIconItem.itemCode) < JSONUtil.getInt(obf_0___z_209.rideFusionConfig,["fusionChangeItemCount"]))
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("RideFusionUI","error_NoMoreInvert",[GameItemManager.getItemName(this.obf_o_E_2418.haveIconItem.itemCode)]));
                  return;
               }
               _loc3_[this.obf_o_E_2418.haveIconItem.itemCode] = this.obf_o_E_2418.haveIconItem.itemCount;
               obf_0___z_209.sendRideFusion(this.mainRideInfo.itemId,this.obf_j_b_1806.itemId,_loc3_,_loc2_);
               return;
            }
            obf_K_e_3075.showTipInfo(DiversityManager.getString("RideFusionUI","pushIvert"));
            return;
         }
         obf_K_e_3075.showTipInfo(DiversityManager.getString("RideFusionUI","pushFusionItem"));
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         var _loc4_:IconItem = null;
         var _loc5_:IconItem = null;
         if(this.timeInv.checkTimeout())
         {
            if(Boolean(this.mainRideBag.haveIconItem) && this.mainRideInfo == null)
            {
               this.mainRideInfo = GameItemInfoManager.getItemInfo(this.mainRideBag.haveIconItem.itemId);
               if(!this.mainRideInfo)
               {
                  GameContext.bagItemManager.sendViewItem(this.mainRideBag.haveIconItem.itemId);
               }
               this.showMainRideInfo();
               this.obf_s_x_1694();
            }
            if(Boolean(this.obf_l_d_3623.haveIconItem) && this.obf_j_b_1806 == null)
            {
               this.obf_j_b_1806 = GameItemInfoManager.getItemInfo(this.obf_l_d_3623.haveIconItem.itemId);
               if(!this.obf_j_b_1806)
               {
                  GameContext.bagItemManager.sendViewItem(this.obf_l_d_3623.haveIconItem.itemId);
               }
               this.showSubRideInfo();
               this.obf_s_x_1694();
            }
            _loc2_ = JSONUtil.getObject(obf_0___z_209.rideFusionConfig,["fusionChangeItems"]);
            for(_loc3_ in _loc2_)
            {
               if(_loc3_)
               {
                  _loc5_ = IconItemManager.getIconItemByCode(_loc3_,"");
                  if(_loc5_)
                  {
                     _loc5_.itemCount = JSONUtil.getInt(obf_0___z_209.rideFusionConfig,["fusionChangeItemCount"]);
                     this.obf_o_E_2418.dropIconItem();
                     txtChance.text = "";
                     if(obf_K_e_3075.playerBagUI.getEqualItemCount(_loc5_.itemCode) < _loc5_.itemCount)
                     {
                        _loc5_.countTextColor = 16711680;
                     }
                     this.obf_o_E_2418.pushIconItem(_loc5_);
                     txtChance.text = _loc2_[_loc3_] + "%";
                  }
               }
            }
            _loc4_ = IconItemManager.getIconItemByCode(JSONUtil.getStr(obf_0___z_209.rideFusionConfig,["fusionItem"]),"");
            if(_loc4_)
            {
               _loc4_.itemCount = JSONUtil.getInt(obf_0___z_209.rideFusionConfig,["fusionItemCount"]);
               this.fusionMaterialBag.dropIconItem();
               if(obf_K_e_3075.playerBagUI.getEqualItemCount(_loc4_.itemCode) < _loc4_.itemCount)
               {
                  _loc4_.countTextColor = 16711680;
               }
               this.fusionMaterialBag.pushIconItem(_loc4_);
               this.obf_s_x_1694();
            }
         }
      }
      
      public function obf_v_m_991(param1:String, param2:String) : void
      {
         this.obf_X_5_2917();
         this.obf_Z_6_2502();
         var _loc3_:IconItemRide = IconItemManager.getIconItemByCode(param1,param2) as IconItemRide;
         if(!_loc3_)
         {
            return;
         }
         if(GameItemManager.haveValidTime(param1))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("RideBoxUI","noFusion"));
            return;
         }
         this.obf_2_B_4604();
         this.mainRideBag.pushIconItem(_loc3_);
      }
      
      public function obf_c_O_828(param1:String, param2:String) : void
      {
         this.obf_Z_6_2502();
         if(!this.mainRideInfo)
         {
            return;
         }
         var _loc3_:IconItemRide = IconItemManager.getIconItemByCode(param1,param2) as IconItemRide;
         if(!_loc3_)
         {
            return;
         }
         if(GameItemManager.haveValidTime(param1))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("RideBoxUI","noFusion"));
            return;
         }
         this.obf_l_d_3623.pushIconItem(_loc3_);
      }
      
      public function showMainRideInfo() : void
      {
         if(!this.mainRideInfo || this.mainRideInfo.isEmpty)
         {
            return;
         }
         this.mainRideConfig = GameItemManager.getItemConfig(this.mainRideInfo.itemCode);
         var _loc1_:int = JSONUtil.getInt(obf_0___z_209.rideFusionConfig,["fusion","mainRideLevel"]);
         if(this.mainRideInfo.rideInfo.level < _loc1_)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("RideFusionUI","error_MainRideLevel",[_loc1_]));
            this.obf_X_5_2917();
            this.obf_2_B_4604();
            return;
         }
         txtQuality.text = JSONUtil.getInt(this.mainRideConfig,["properties","qualityPoint"]) + "";
         txtLevel.text = this.mainRideInfo.rideInfo.level + "";
         txtLifeApt.text = obf_0___z_209.getAptValueAtLevel(this.mainRideInfo.itemCode,this.mainRideInfo.rideInfo.level,obf_0___z_209.obf_C_W_1491,this.mainRideInfo.rideInfo.lifeAptAdded) + "";
         txtDefenseApt.text = obf_0___z_209.getAptValueAtLevel(this.mainRideInfo.itemCode,this.mainRideInfo.rideInfo.level,obf_0___z_209.obf_A_C_2113,this.mainRideInfo.rideInfo.defenseAptAdded) + "";
         txtAttackApt.text = obf_0___z_209.getAptValueAtLevel(this.mainRideInfo.itemCode,this.mainRideInfo.rideInfo.level,obf_0___z_209.ATTACK_APT,this.mainRideInfo.rideInfo.attackAptAdded) + "";
         txtCureApt.text = obf_0___z_209.getAptValueAtLevel(this.mainRideInfo.itemCode,this.mainRideInfo.rideInfo.level,obf_0___z_209.obf_n_w_1135,this.mainRideInfo.rideInfo.cureAptAdded) + "";
         txtSpeed.text = this.mainRideInfo.rideInfo.rideSpeed + "";
      }
      
      public function showSubRideInfo() : void
      {
         if(!this.obf_j_b_1806 || this.obf_j_b_1806.isEmpty)
         {
            return;
         }
         this.subRideConfig = GameItemManager.getItemConfig(this.obf_j_b_1806.itemCode);
         var _loc1_:int = JSONUtil.getInt(obf_0___z_209.rideFusionConfig,["fusion","minorPetLevel"]);
         if(this.obf_j_b_1806.rideInfo.level < _loc1_)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("RideFusionUI","error_SubRideLevel",[_loc1_]));
            this.obf_Z_6_2502();
            this.obf_2_B_4604();
            return;
         }
         txtQuality2.text = JSONUtil.getInt(this.subRideConfig,["properties","qualityPoint"]) + "";
         txtLevel2.text = this.obf_j_b_1806.rideInfo.level + "";
         txtLifeApt2.text = obf_0___z_209.getAptValueAtLevel(this.obf_j_b_1806.itemCode,this.obf_j_b_1806.rideInfo.level,obf_0___z_209.obf_C_W_1491,this.obf_j_b_1806.rideInfo.lifeAptAdded) + "";
         txtDefenseApt2.text = obf_0___z_209.getAptValueAtLevel(this.obf_j_b_1806.itemCode,this.obf_j_b_1806.rideInfo.level,obf_0___z_209.obf_A_C_2113,this.obf_j_b_1806.rideInfo.defenseAptAdded) + "";
         txtAttackApt2.text = obf_0___z_209.getAptValueAtLevel(this.obf_j_b_1806.itemCode,this.obf_j_b_1806.rideInfo.level,obf_0___z_209.ATTACK_APT,this.obf_j_b_1806.rideInfo.attackAptAdded) + "";
         txtCureApt2.text = obf_0___z_209.getAptValueAtLevel(this.obf_j_b_1806.itemCode,this.obf_j_b_1806.rideInfo.level,obf_0___z_209.obf_n_w_1135,this.obf_j_b_1806.rideInfo.cureAptAdded) + "";
         txtSpeed2.text = this.obf_j_b_1806.rideInfo.rideSpeed + "";
      }
      
      public function obf_X_5_2917() : void
      {
         this.mainRideInfo = null;
         this.mainRideConfig = null;
         this.mainRideBag.dropIconItem();
         txtQuality.text = "";
         txtLevel.text = "";
         txtLifeApt.text = "";
         txtDefenseApt.text = "";
         txtAttackApt.text = "";
         txtCureApt.text = "";
         txtSpeed.text = "";
      }
      
      public function obf_Z_6_2502() : void
      {
         this.obf_j_b_1806 = null;
         this.subRideConfig = null;
         this.obf_l_d_3623.dropIconItem();
         txtQuality2.text = "";
         txtLevel2.text = "";
         txtLifeApt2.text = "";
         txtDefenseApt2.text = "";
         txtAttackApt2.text = "";
         txtCureApt2.text = "";
         txtSpeed2.text = "";
      }
      
      public function obf_2_B_4604() : void
      {
         txtChance.text = "";
         this.obf_o_E_2418.dropIconItem();
         this.fusionMaterialBag.dropIconItem();
      }
      
      public function obf_s_x_1694() : void
      {
         if(!this.mainRideInfo || !this.obf_j_b_1806)
         {
            return;
         }
         if(this.mainRideInfo.rideInfo.generation >= JSONUtil.getInt(obf_0___z_209.rideFusionConfig,["maxFusion"]))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("RideFusionUI","error_MaxGeneration"));
            return;
         }
         if(this.mainRideInfo.rideInfo.generation != this.obf_j_b_1806.rideInfo.generation)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("RideFusionUI","error_Generation"));
            this.obf_Z_6_2502();
            return;
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
         if(!param1)
         {
            return;
         }
         if(param1 == this.mainRideBag)
         {
            if(Boolean(this.obf_j_b_1806) && param2.itemId == this.obf_j_b_1806.itemId)
            {
               return;
            }
            this.obf_v_m_991(param2.itemCode,param2.itemId);
         }
         if(param1 == this.obf_l_d_3623)
         {
            if(param2.itemId == this.mainRideInfo.itemId)
            {
               return;
            }
            this.obf_c_O_828(param2.itemCode,param2.itemId);
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         if(param1 == this.obf_l_d_3623)
         {
            this.obf_Z_6_2502();
            this.obf_2_B_4604();
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
         DiversityManager.setTextField(txtDeyTitle,"RideFusionUI","txtTitle");
         DiversityManager.setTextField(txtDeyMainRide,"RideFusionUI","txtMainRide");
         DiversityManager.setTextField(txtDeySubRide,"RideFusionUI","txtSubRide");
         DiversityManager.setTextField(txtDeyQuality,"RideFusionUI","txtRideQuality");
         DiversityManager.setTextField(txtDeyQuality2,"RideFusionUI","txtRideQuality");
         DiversityManager.setTextField(txtDeyLevel,"RideFusionUI","txtRideLevel");
         DiversityManager.setTextField(txtDeyLevel2,"RideFusionUI","txtRideLevel");
         DiversityManager.setTextField(txtDeyLifeApt,"RideFusionUI","txtRideLifeApt");
         DiversityManager.setTextField(txtDeyLifeApt2,"RideFusionUI","txtRideLifeApt");
         DiversityManager.setTextField(txtDeyDefenseApt,"RideFusionUI","txtRideDefApt");
         DiversityManager.setTextField(txtDeyDefenseApt2,"RideFusionUI","txtRideDefApt");
         DiversityManager.setTextField(txtDeyAttackApt,"RideFusionUI","txtRideAttApt");
         DiversityManager.setTextField(txtDeyAttackApt2,"RideFusionUI","txtRideAttApt");
         DiversityManager.setTextField(txtDeyCureApt,"RideFusionUI","txtRideCureApt");
         DiversityManager.setTextField(txtDeyCureApt2,"RideFusionUI","txtRideCureApt");
         DiversityManager.setTextField(txtDeySpeed,"RideFusionUI","txtRideSpeed");
         DiversityManager.setTextField(txtDeySpeed2,"RideFusionUI","txtRideSpeed");
         DiversityManager.setTextField(txtDeyInvertMaterial,"RideFusionUI","txtInvertMaterial");
         DiversityManager.setTextField(txtDeyFusionMaterial,"RideFusionUI","txtFusionMaterial");
         DiversityManager.setTextField(txtDeyConvert,"RideFusionUI","txtConvert");
         txtDeyPrompt.htmlText = DiversityManager.getString("RideFusionUI","txtPrompt");
         cmdFusion.label = DiversityManager.getString("RideFusionUI","cmdFusion");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         txtScrollBar.update();
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.obf_X_5_2917();
         this.obf_Z_6_2502();
         this.obf_2_B_4604();
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

