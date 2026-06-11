package com.sunweb.game.rpg.playerUI.equ.kindGrow
{
   import obf_Q_c_4394.obf_Z_j_930;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.equ.EquipmentKind;
   import com.sunweb.game.rpg.equipKindGrow.EquipKindGrowInfo;
   import com.sunweb.game.rpg.equipKindGrow.EquipKindGrowManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import playerUI.equipKindGrowTemperUIMC;
   
   public class obf_0_1_e_423 extends equipKindGrowTemperUIMC implements IPlayerUI
   {
      
      private var _kind:int;
      
      private var obf_p_3145:Array;
      
      public function obf_0_1_e_423()
      {
         super();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            this["lock" + _loc1_].gotoAndStop(1);
            _loc1_++;
         }
         this.initDiversity();
         this.addListener();
      }
      
      public function setParam(param1:int, param2:Array) : void
      {
         this._kind = param1;
         this.obf_p_3145 = param2;
         this.obf_p_3145.sortOn("attr",Array.NUMERIC);
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtTitle,"equipKindGrowTemperUI","txtTitle");
         DiversityManager.setTextField(txtAttrTitle0,"equipKindGrowTemperUI","txtAttrTitle0");
         DiversityManager.setTextField(txtAttrTitle1,"equipKindGrowTemperUI","txtAttrTitle1");
         DiversityManager.setTextField(txtAttrTitle2,"equipKindGrowTemperUI","txtAttrTitle2");
         cmdTemper.label = DiversityManager.getString("equipKindGrowTemperUI","cmdTemper");
         cmdSave.label = DiversityManager.getString("equipKindGrowTemperUI","cmdSave");
      }
      
      public function addListener() : void
      {
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            this["lock" + _loc1_].addEventListener(MouseEvent.CLICK,this.obf_G_A_2176);
            _loc1_++;
         }
         cmdTemper.addEventListener(MouseEvent.CLICK,this.onTemper);
         cmdSave.addEventListener(MouseEvent.CLICK,this.obf_t_N_1581);
         txtMaterial.addEventListener(TextEvent.LINK,this.onInfoLink);
         txtLock.addEventListener(TextEvent.LINK,this.onInfoLink);
      }
      
      public function removeListener() : void
      {
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            this["lock" + _loc1_].removeEventListener(MouseEvent.CLICK,this.obf_G_A_2176);
            _loc1_++;
         }
         cmdTemper.removeEventListener(MouseEvent.CLICK,this.onTemper);
         cmdSave.removeEventListener(MouseEvent.CLICK,this.obf_t_N_1581);
         txtMaterial.removeEventListener(TextEvent.LINK,this.onInfoLink);
         txtLock.removeEventListener(TextEvent.LINK,this.onInfoLink);
      }
      
      private function onInfoLink(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      public function obf_t_N_1581(param1:MouseEvent) : void
      {
         var _loc2_:obf_D_r_3256 = obf_K_e_3075.equipKindGrowUI;
         var _loc3_:EquipKindGrowInfo = _loc2_.kindInfoMap[this._kind];
         if(!_loc3_)
         {
            _loc3_ = new EquipKindGrowInfo();
            _loc3_.init(this._kind);
         }
         if(!_loc3_.newTemper)
         {
            return;
         }
         EquipKindGrowManager.onKindGrowTemperSaveRequest(this._kind);
      }
      
      public function onTemper(param1:MouseEvent) : void
      {
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < 4)
         {
            if(this.obf_p_3145[_loc3_])
            {
               _loc8_ = int(this.obf_p_3145[_loc3_].attr);
               if(this["lock" + _loc3_].currentFrame == 2)
               {
                  _loc2_.push(_loc8_);
               }
            }
            _loc3_++;
         }
         var _loc4_:String = null;
         for(_loc5_ in EquipKindGrowManager.temperItemCode)
         {
            _loc4_ = _loc5_;
         }
         _loc6_ = int(EquipKindGrowManager.temperItemCode[_loc4_]);
         if(obf_K_e_3075.playerBagUI.getItemCount(_loc4_) < _loc6_)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","notHaveItemInBag"));
            return;
         }
         var _loc7_:int = int(EquipKindGrowManager.lockNeedNum[_loc2_.length]);
         if(obf_K_e_3075.playerBagUI.getItemCount(EquipKindGrowManager.temperLockCode) < _loc7_)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","notHaveItemInBag"));
            return;
         }
         EquipKindGrowManager.onKindGrowTemperRequest(this._kind,_loc2_);
      }
      
      public function obf_G_A_2176(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(!_loc2_.visible)
         {
            return;
         }
         if(_loc2_.currentFrame == 1)
         {
            _loc2_.gotoAndStop(2);
         }
         else if(_loc2_.currentFrame == 2)
         {
            _loc2_.gotoAndStop(1);
         }
         this.obf_V_i_4058();
      }
      
      public function obf_V_i_4058() : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         DiversityManager.setTextField(txtTip,"equipKindGrowTemperUI","txtTip",[EquipmentKind.getKindName(this._kind)]);
         var _loc1_:String = null;
         for(_loc2_ in EquipKindGrowManager.temperItemCode)
         {
            _loc1_ = _loc2_;
         }
         _loc3_ = int(EquipKindGrowManager.temperItemCode[_loc1_]);
         _loc4_ = GameItemManager.getItemName(_loc1_);
         _loc5_ = obf_Z_j_930.getItemLinkCode(_loc4_,_loc1_) + " x " + _loc3_;
         DiversityManager.setTextField(txtMaterial,"equipKindGrowTemperUI","txtMaterial",[_loc5_],true);
         _loc6_ = 0;
         _loc7_ = 0;
         while(_loc7_ < 4)
         {
            if(this["lock" + _loc7_].currentFrame == 2)
            {
               _loc6_++;
            }
            _loc7_++;
         }
         var _loc8_:int = int(EquipKindGrowManager.lockNeedNum[_loc6_]);
         var _loc9_:String = GameItemManager.getItemName(EquipKindGrowManager.temperLockCode);
         var _loc10_:String = obf_Z_j_930.getItemLinkCode(_loc9_,EquipKindGrowManager.temperLockCode) + "x" + _loc8_;
         DiversityManager.setTextField(txtLock,"equipKindGrowTemperUI","txtLock",[_loc10_],true);
      }
      
      public function refresh() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc1_:obf_D_r_3256 = obf_K_e_3075.equipKindGrowUI;
         var _loc2_:EquipKindGrowInfo = _loc1_.kindInfoMap[this._kind];
         if(!_loc2_)
         {
            _loc2_ = new EquipKindGrowInfo();
            _loc2_.init(this._kind);
         }
         var _loc3_:int = 0;
         while(_loc3_ < 4)
         {
            if(!this.obf_p_3145[_loc3_])
            {
               this.setVisible(_loc3_,false);
            }
            else
            {
               _loc4_ = int(this.obf_p_3145[_loc3_].attr);
               this.setVisible(_loc3_,true);
               this["txtAttr" + _loc3_].htmlText = RoleAttributesModifierEnum.getAttributesName(_loc4_);
               _loc5_ = 0;
               if(_loc2_.temper)
               {
                  _loc7_ = _loc2_.temper[_loc4_] == null ? 0 : Number(_loc2_.temper[_loc4_]);
                  _loc5_ = Math.round(_loc7_ * 100);
               }
               this["txtAttrThis" + _loc3_].htmlText = "+" + _loc5_ + "%";
               _loc6_ = 0;
               if(_loc2_.newTemper)
               {
                  _loc8_ = _loc2_.newTemper[_loc4_] == null ? 0 : Number(_loc2_.newTemper[_loc4_]);
                  _loc6_ = Math.round(_loc8_ * 100);
               }
               if(_loc6_ > _loc5_)
               {
                  this["txtAttrNew" + _loc3_].htmlText = "<font color=\'#00FF00\'>+" + _loc6_ + "%↑</font>";
               }
               else if(_loc6_ < _loc5_)
               {
                  this["txtAttrNew" + _loc3_].htmlText = "<font color=\'#FF0000\'>+" + _loc6_ + "%↓</font>";
               }
               else
               {
                  this["txtAttrNew" + _loc3_].htmlText = "+" + _loc6_ + "%";
               }
               this["txtAttrMax" + _loc3_].htmlText = "<font color=\'#FF9900\'>+100%</font>";
            }
            _loc3_++;
         }
      }
      
      public function setVisible(param1:int, param2:Boolean) : void
      {
         if(param1 < 0 || param1 > 3)
         {
            return;
         }
         this["bgAttr" + param1].visible = param2;
         this["lock" + param1].visible = param2;
         this["txtAttr" + param1].visible = param2;
         this["txtAttrThis" + param1].visible = param2;
         this["txtAttrNew" + param1].visible = param2;
         this["txtAttrMax" + param1].visible = param2;
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
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return bg.getBounds(bg).contains(bg.mouseX,bg.mouseY);
         }
         return false;
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
         this.removeListener();
      }
   }
}

