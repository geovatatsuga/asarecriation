package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.farm.FarmManager;
   import com.sunweb.game.rpg.farm.FarmTempletManager;
   import com.sunweb.game.rpg.farm.LocalPlayerFarmInfo;
   import com.sunweb.game.rpg.farm.obf_0_1_N_478;
   import com.sunweb.game.rpg.farm.obf_F_R_1745;
   import com.sunweb.game.rpg.farm.obf_n_v_1693;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import com.sunweb.game.utils.obf_L_l_4100;
   import fl.controls.List;
   import fl.data.DataProvider;
   import fl.events.ListEvent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import playerUI.FarmManagerUIMC;
   
   public class PlayerFarmManagerUI extends FarmManagerUIMC implements IPlayerUI, obf_0_d_4341
   {
      
      private var _farmId:String;
      
      private var _farmLevel:int;
      
      private var _mapId:String;
      
      private var _oldName:String;
      
      private var _noviceSprite:Sprite;
      
      public function PlayerFarmManagerUI()
      {
         super();
         this.initDiversity();
         this.visible = false;
         List(managerLayer.listStyle).labelFunction = this.styleListLabel;
         List(managerLayer.listStyle).iconFunction = this.styleListIcon;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"FarmManagerUI","txtTitle");
         DiversityManager.setTextField(managerLayer.txtDeyFarmName,"FarmManagerUI","txtFarmName");
         DiversityManager.setTextField(managerLayer.txtDeyFarmLevel,"FarmManagerUI","txtFarmLevel");
         DiversityManager.setTextField(managerLayer.txtDeyLeveUp,"FarmManagerUI","txtFarmLevelUp");
         DiversityManager.setTextField(managerLayer.txtDeyFarmStyle,"FarmManagerUI","txtFarmStyle");
         managerLayer.cmdRename.label = DiversityManager.getString("FarmManagerUI","cmdRename");
         managerLayer.cmdLevelUp.label = DiversityManager.getString("FarmManagerUI","cmdLevelUp");
         managerLayer.cmdUseStyle.label = DiversityManager.getString("FarmManagerUI","cmdUseStyle");
         managerLayer.cmdBuyStyle.label = DiversityManager.getString("FarmManagerUI","cmdBuyStyle");
         buyLayer.cmdBuyFarm.label = DiversityManager.getString("FarmManagerUI","cmdBuyFarm");
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
         return "FarmManagerUI";
      }
      
      public function getTargetPoint(param1:String) : Point
      {
         return null;
      }
      
      public function getHighLightDisplayObject(param1:String) : DisplayObject
      {
         return this[param1];
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onDragStart);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onDragStop);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClickClose);
         managerLayer.inputFarmName.addEventListener(KeyboardEvent.KEY_DOWN,this.onBreakKey);
         managerLayer.inputFarmName.addEventListener(KeyboardEvent.KEY_UP,this.onBreakKey);
         buyLayer.cmdBuyFarm.addEventListener(MouseEvent.CLICK,this.onClickBuy);
         managerLayer.cmdRename.addEventListener(MouseEvent.CLICK,this.onClickRename);
         managerLayer.cmdLevelUp.addEventListener(MouseEvent.CLICK,this.onClickLevelUp);
         managerLayer.cmdUseStyle.addEventListener(MouseEvent.CLICK,this.onClickUseStyle);
         managerLayer.cmdBuyStyle.addEventListener(MouseEvent.CLICK,this.onClickBuyStyle);
         managerLayer.listStyle.addEventListener(ListEvent.ITEM_CLICK,this.onClickStyle);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onDragStart);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onDragStop);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClickClose);
         managerLayer.inputFarmName.removeEventListener(KeyboardEvent.KEY_DOWN,this.onBreakKey);
         managerLayer.inputFarmName.removeEventListener(KeyboardEvent.KEY_UP,this.onBreakKey);
         buyLayer.cmdBuyFarm.removeEventListener(MouseEvent.CLICK,this.onClickBuy);
         managerLayer.cmdRename.removeEventListener(MouseEvent.CLICK,this.onClickRename);
         managerLayer.cmdLevelUp.removeEventListener(MouseEvent.CLICK,this.onClickLevelUp);
         managerLayer.cmdUseStyle.removeEventListener(MouseEvent.CLICK,this.onClickUseStyle);
         managerLayer.cmdBuyStyle.removeEventListener(MouseEvent.CLICK,this.onClickBuyStyle);
         managerLayer.listStyle.removeEventListener(ListEvent.ITEM_CLICK,this.onClickStyle);
      }
      
      private function onBreakKey(param1:KeyboardEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function onDragStart(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onDragStop(param1:Event) : void
      {
         this.stopDrag();
      }
      
      public function openManager(param1:obf_0_1_N_478) : void
      {
         var _loc2_:LocalPlayerFarmInfo = null;
         var _loc3_:obf_n_v_1693 = null;
         var _loc4_:Boolean = false;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(!param1)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmManagerUI","promptOpenError_IntoFarm"));
            return;
         }
         if(param1.ownerId == GameContext.localPlayer.id)
         {
            _loc2_ = GameContext.localPlayer.fullInfo.getFarmInfoByFullID(param1.id + "@" + param1.getMap().mapId);
            if(!_loc2_)
            {
               obf_x_0_1295.obf_r_w_3556("obf___________23未在LocalPlayer对象中找到农场(" + param1.id + ")obf_________51");
               return;
            }
            this._farmId = param1.id;
            this._mapId = param1.getMap().mapId;
            this._farmLevel = param1.currentLevel;
            managerLayer.inputFarmName.text = param1.farmName;
            this._oldName = param1.farmName;
            while(managerLayer.levelUpGold.numChildren > 0)
            {
               managerLayer.levelUpGold.removeChildAt(0);
            }
            managerLayer.txtLevel.text = _loc2_.currentLevel;
            _loc3_ = FarmTempletManager.getFarmTemplet(_loc2_.templetCode);
            _loc4_ = _loc2_.currentLevel <= _loc3_.levelInfo.length;
            if(_loc4_)
            {
               _loc5_ = _loc3_.levelInfo[_loc2_.currentLevel - 1];
               managerLayer.levelUpGold.addChild(obf_a_f_2935.getGoldDisplay(_loc5_.goldCost));
               _loc6_ = FarmManager.getFarmTempletLevelMaxExp(_loc2_.templetCode,_loc2_.currentLevel);
               managerLayer.txtExp.text = _loc2_.farmExp + "/" + _loc6_;
               _loc7_ = 100 * Number(_loc2_.farmExp / _loc6_);
               if(_loc7_ < 2)
               {
                  _loc7_ = 2;
               }
               managerLayer.expBar.gotoAndStop(_loc7_);
            }
            managerLayer.cmdLevelUp.enabled = _loc4_;
            List(managerLayer.listStyle).dataProvider = new DataProvider(obf_F_R_1745.getValidFarmStyle(_loc2_.templetCode));
            List(managerLayer.listStyle).dataProvider.sortOn("farmLevel");
            managerLayer.visible = true;
            buyLayer.visible = false;
         }
         else
         {
            if(!obf_L_l_4100.isEmpty(param1.ownerId))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmManagerUI","promptOpenError_OnlyMyFarm"));
               return;
            }
            managerLayer.visible = false;
            buyLayer.visible = true;
         }
         this.visible = true;
      }
      
      public function closeManager() : void
      {
         var _loc2_:obf_n_v_1693 = null;
         var _loc1_:obf_0_1_N_478 = GameContext.currentMap.obf_v_P_2126.getFarm(this._farmId);
         if(_loc1_)
         {
            if(GameContext.localPlayer.fullInfo.getFarmInfoByFullID(this._farmId + "@" + this._mapId).styleCode != "")
            {
               _loc1_.obf_v_t_1412(obf_F_R_1745.getFarmStyleRes(GameContext.localPlayer.fullInfo.getFarmInfoByFullID(this._farmId + "@" + this._mapId).styleCode));
            }
            else
            {
               _loc2_ = FarmTempletManager.getFarmTemplet(GameContext.localPlayer.fullInfo.getFarmInfoByFullID(this._farmId + "@" + this._mapId).templetCode);
               if(_loc2_)
               {
                  _loc1_.obf_v_t_1412(_loc2_.res);
               }
            }
         }
         this.visible = false;
      }
      
      private function onClickClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function onClickBuy(param1:Event) : void
      {
      }
      
      private function onClickRename(param1:Event) : void
      {
         var _loc2_:String = null;
         if(managerLayer.inputFarmName.text == "")
         {
            return;
         }
         if(this._oldName != managerLayer.inputFarmName.text)
         {
            _loc2_ = obf_L_l_4100.obf_I_C_3435(managerLayer.inputFarmName.text);
            if(_loc2_.length > WorldConfig.obf_0_z_1933)
            {
               WindowManager.showMessageBox(DiversityManager.getString("FarmManagerUI","promptRenameError_TooLong"));
               return;
            }
            if(!obf_L_l_4100.checkNameString(_loc2_))
            {
               WindowManager.showMessageBox(DiversityManager.getString("FarmManagerUI","promptRenameError_InvalidChar"));
               return;
            }
            FarmManager.sendFarmRename(this._mapId,this._farmId,_loc2_);
         }
      }
      
      private function onClickLevelUp(param1:Event) : void
      {
         var _loc4_:Object = null;
         var _loc2_:LocalPlayerFarmInfo = GameContext.localPlayer.fullInfo.getFarmInfoByFullID(this._farmId + "@" + this._mapId);
         if(!_loc2_)
         {
            obf_x_0_1295.obf_r_w_3556("obf________________8(" + this._farmId + "@" + this._mapId + ")obf____4853！");
            return;
         }
         var _loc3_:obf_n_v_1693 = FarmTempletManager.getFarmTemplet(_loc2_.templetCode);
         if(_loc3_)
         {
            if(_loc2_.currentLevel >= _loc3_.levelInfo.length)
            {
               WindowManager.showMessageBox(DiversityManager.getString("FarmManagerUI","promptLevelUpError_IsMax"));
               return;
            }
            _loc4_ = _loc3_.levelInfo[_loc2_.currentLevel - 1];
            if(GameContext.localPlayer.fullInfo.gold < _loc4_.goldCost)
            {
               WindowManager.showMessageBox(DiversityManager.getString("FarmManagerUI","promptLevelUpError_NoMoreGold"));
               return;
            }
            if(_loc2_.farmExp < _loc4_.expCost)
            {
               WindowManager.showMessageBox(DiversityManager.getString("FarmManagerUI","promptLevelUpError_NoMoreExp"));
               return;
            }
            FarmManager.sendFarmLevelUp(this._farmId,this._mapId);
            this.closeManager();
         }
         else
         {
            obf_x_0_1295.obf_r_w_3556("obf________________4(" + _loc2_.templetCode + ")");
         }
      }
      
      private function onClickUseStyle(param1:Event) : void
      {
         var _loc2_:obf_0_1_N_478 = null;
         if(managerLayer.listStyle.selectedItem)
         {
            _loc2_ = GameContext.currentMap.obf_v_P_2126.getFarm(this._farmId);
            if(_loc2_)
            {
               _loc2_.obf_v_t_1412(obf_F_R_1745.getFarmStyleRes(managerLayer.listStyle.selectedItem.styleCode));
            }
         }
         else
         {
            WindowManager.showMessageBox(DiversityManager.getString("FarmManagerUI","promptStyleError_NoStyle"));
         }
      }
      
      private function onClickBuyStyle(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:obf_0_1_N_478 = null;
         var _loc7_:Boolean = false;
         if(managerLayer.listStyle.selectedItem)
         {
            _loc2_ = managerLayer.listStyle.selectedItem.styleCode;
            _loc3_ = int(managerLayer.listStyle.selectedItem.goldPrice);
            _loc4_ = int(managerLayer.listStyle.selectedItem.moneyPrice);
            _loc5_ = int(managerLayer.listStyle.selectedItem.farmLevel);
            _loc6_ = GameContext.currentMap.obf_v_P_2126.getFarm(this._farmId);
            if((Boolean(_loc6_)) && _loc6_.currentLevel < _loc5_)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("FarmManagerUI","promptStyleError_NeedFarmLevel",[_loc5_]));
               return;
            }
            if(_loc4_ > 0 && GameContext.localPlayer.fullInfo.money < _loc4_)
            {
               WindowManager.showMessageBox(DiversityManager.getString("FarmManagerUI","promptStyleError_NoMoreMoney",[obf_a_f_2935.RMB_NAME]));
               return;
            }
            if(_loc3_ > 0 && GameContext.localPlayer.fullInfo.gold < _loc3_)
            {
               WindowManager.showMessageBox(DiversityManager.getString("FarmManagerUI","promptStyleError_NoMoreGold"));
               return;
            }
            if(_loc4_ > 0)
            {
               _loc7_ = true;
            }
            this.closeManager();
            FarmManager.sendBuyFarmStyle(this._mapId,this._farmId,_loc2_,_loc7_);
         }
         else
         {
            WindowManager.showMessageBox(DiversityManager.getString("FarmManagerUI","promptStyleError_NoStyle"));
         }
      }
      
      private function onClickStyle(param1:Event) : void
      {
      }
      
      private function styleListLabel(param1:Object) : String
      {
         return "Lv:" + param1.farmLevel + " " + param1.styleName;
      }
      
      private function styleListIcon(param1:Object) : DisplayObject
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:Sprite = new Sprite();
         if(Boolean(param1.moneyPrice) && param1.moneyPrice > 0)
         {
            _loc3_ = obf_a_f_2935.getMoneyDisplay(param1.moneyPrice);
            _loc3_.x = _loc2_.width + 5;
            _loc2_.addChild(_loc3_);
         }
         else if(Boolean(param1.goldPrice) && param1.goldPrice > 0)
         {
            _loc2_.addChild(obf_a_f_2935.getGoldDisplay(param1.goldPrice));
         }
         _loc2_.graphics.drawCircle(70,0,0);
         _loc2_.graphics.endFill();
         return _loc2_;
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         if(GameContext.localPlayer)
         {
         }
         this.openManager(GameContext.localPlayer.getFarm());
      }
      
      public function closeUI() : void
      {
         this.closeManager();
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

