package com.sunweb.game.rpg.playerUI.country
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.country.obf_S_x_1774;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.ui.WindowManager;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import playerUI.CountryUIMC;
   
   public class CountryUI extends CountryUIMC implements IPlayerUI
   {
      
      private static var landName:String;
      
      private static var landsLevel:Object;
      
      private static var wills:int;
      
      private static var creatures:Number;
      
      private static var origins:int;
      
      private static var countryGrade:int = 0;
      
      private static var mouseTipMapI:Dictionary = new Dictionary();
      
      private var mapButtonsArr:Array = new Array();
      
      private var landIndex:int = 0;
      
      public function CountryUI()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.onResize(null);
         titleBox.mouseEnabled = false;
         bgBox2.mouseEnabled = false;
         txtDeyTitle.mouseEnabled = false;
         this.init();
         this.addListener();
      }
      
      private static function obf_Z_l_1286(param1:MouseEvent) : void
      {
         var _loc6_:Object = null;
         var _loc9_:String = null;
         var _loc10_:* = undefined;
         var _loc2_:Array = obf_S_x_1774.countryLandList;
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:Object = _loc2_[mouseTipMapI[param1.currentTarget]];
         var _loc4_:String = "";
         var _loc5_:int = 0;
         var _loc7_:GameTipUI = new GameTipUI("MapButtonTip");
         var _loc8_:int = 200;
         for(_loc9_ in landsLevel)
         {
            if(_loc3_.name == _loc9_)
            {
               _loc5_ = int(landsLevel[_loc9_]);
               break;
            }
         }
         _loc7_.addTipInfo("<P align=\'center\'><FONT color=\'#00FF00\'>" + _loc3_.name + "</FONT></P>",_loc8_,_loc7_.maxRow + 1);
         _loc7_.addTipInfo("<P align=\'center\'><FONT color=\'#00FF00\'>" + DiversityManager.getString("CountryUI","txtLandLv",[_loc5_]) + "</FONT></P>",_loc8_,_loc7_.maxRow + 1);
         if(_loc5_ < _loc3_.levels.length)
         {
            _loc6_ = _loc3_.levels[_loc5_];
            _loc7_.addTipInfo(DiversityManager.getString("CountryUI","needCountryCond",[_loc6_.countryLevel]),_loc8_,_loc7_.maxRow + 1);
            _loc7_.addTipInfo(DiversityManager.getString("CountryUI","needPeople",[_loc6_.creatures]),_loc8_,_loc7_.maxRow + 1);
            _loc7_.addTipInfo(DiversityManager.getString("CountryUI","needWorldRoot",[_loc6_.origins]),_loc8_,_loc7_.maxRow + 1);
         }
         for(_loc10_ in _loc6_.attr)
         {
            _loc7_.addTipInfo("<FONT color=\'#00FF00\'>" + RoleAttributesModifierEnum.getAttributesName(_loc10_) + "</FONT>",_loc8_,_loc7_.maxRow + 1);
            _loc7_.addTipInfo("<P align=\'right\'><FONT color=\'#00FF00\'>" + RoleAttributesModifierEnum.getAttributesValueString(_loc10_,_loc6_.attr[_loc10_]) + "</FONT></P>",_loc8_,_loc7_.maxRow);
         }
         GameTipManager.showTip(_loc7_);
      }
      
      private static function obf_0_6_9_109(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("MapButtonTip");
      }
      
      private static function obf_c_x_3461(param1:MouseEvent) : void
      {
         var _loc2_:Object = obf_S_x_1774.countryLevelsObject(countryGrade);
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_.wills > wills)
         {
            WindowManager.showMessageBox(DiversityManager.getString("CountryUI","warn_UpCountryCond"));
            return;
         }
         if(!landsLevel)
         {
            return;
         }
         var _loc3_:Array = [];
         var _loc4_:Array = obf_S_x_1774.countryLandList;
         if(!_loc4_)
         {
            return;
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            if(landsLevel.hasOwnProperty(_loc4_[_loc5_].name))
            {
               _loc3_.push({
                  "name":_loc4_[_loc5_].name,
                  "level":landsLevel[_loc4_[_loc5_].name]
               });
            }
            else
            {
               _loc3_.push({
                  "name":_loc4_[_loc5_].name,
                  "level":0
               });
            }
            _loc5_++;
         }
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_.length)
         {
            if(_loc3_[_loc6_].level < _loc2_.landLevel)
            {
               WindowManager.showMessageBox(DiversityManager.getString("CountryUI","warn_UpCountryCond"));
               return;
            }
            _loc6_++;
         }
         obf_S_x_1774.sendUpCountryReq();
      }
      
      private static function obf_q_c_4044(param1:MouseEvent) : void
      {
         var _loc4_:String = null;
         var _loc2_:Array = obf_S_x_1774.countryLandList;
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(landName == _loc2_[_loc3_].name)
            {
               if(landsLevel.hasOwnProperty(landName))
               {
                  for(_loc4_ in landsLevel)
                  {
                     if(landName == _loc4_)
                     {
                        if(countryGrade < _loc2_[_loc3_].levels[landsLevel[_loc4_]].countryLevel || creatures < _loc2_[_loc3_].levels[landsLevel[_loc4_]].creatures || origins < _loc2_[_loc3_].levels[landsLevel[_loc4_]].origins)
                        {
                           WindowManager.showMessageBox(DiversityManager.getString("CountryUI","warn_UpLandCond"));
                           return;
                        }
                     }
                  }
               }
               else if(countryGrade < _loc2_[_loc3_].levels[0].countryLevel || creatures < _loc2_[_loc3_].levels[0].creatures || origins < _loc2_[_loc3_].levels[0].origins)
               {
                  WindowManager.showMessageBox(DiversityManager.getString("CountryUI","warn_UpLandCond"));
                  return;
               }
               break;
            }
            _loc3_++;
         }
         obf_S_x_1774.sendUpLandReq(landName);
      }
      
      private function init() : void
      {
         this.mapButtonsArr = [button1,button2,button3,button4,button5,button6,button7,button8,button9];
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         var _loc1_:int = 0;
         while(_loc1_ < this.mapButtonsArr.length)
         {
            this.mapButtonsArr[_loc1_].addEventListener(MouseEvent.CLICK,this.onMapButton);
            this.addUIMouseToolTip(this.mapButtonsArr[_loc1_],_loc1_);
            _loc1_++;
         }
         cmdCountry.addEventListener(MouseEvent.CLICK,obf_c_x_3461);
         cmdLand.addEventListener(MouseEvent.CLICK,obf_q_c_4044);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         var _loc1_:int = 0;
         while(_loc1_ < this.mapButtonsArr.length)
         {
            this.mapButtonsArr[_loc1_].removeEventListener(MouseEvent.CLICK,this.onMapButton);
            this.removeUIMouseToolTip(this.mapButtonsArr[_loc1_]);
            _loc1_++;
         }
         cmdCountry.removeEventListener(MouseEvent.CLICK,obf_c_x_3461);
         cmdLand.removeEventListener(MouseEvent.CLICK,obf_q_c_4044);
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
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth / 2 - 150;
         this.y = GameContext.gameStage.stageHeight / 2;
      }
      
      private function onMapButton(param1:MouseEvent) : void
      {
         this.landIndex = this.mapButtonsArr.indexOf(param1.currentTarget);
         this.showLandInfo(this.landIndex);
      }
      
      private function addUIMouseToolTip(param1:InteractiveObject, param2:int) : void
      {
         mouseTipMapI[param1] = param2;
         param1.addEventListener(MouseEvent.MOUSE_OVER,obf_Z_l_1286);
         param1.addEventListener(MouseEvent.MOUSE_OUT,obf_0_6_9_109);
      }
      
      private function removeUIMouseToolTip(param1:InteractiveObject) : void
      {
         var mouseTipObj:InteractiveObject = param1;
         delete mouseTipMapI[mouseTipObj];
         try
         {
            mouseTipObj.removeEventListener(MouseEvent.MOUSE_OVER,obf_Z_l_1286);
            mouseTipObj.removeEventListener(MouseEvent.MOUSE_OUT,obf_0_6_9_109);
         }
         catch(e:Error)
         {
         }
      }
      
      public function showCountryInfo(param1:int) : void
      {
         var _loc6_:* = undefined;
         mapPoint.gotoAndStop(param1 + 1);
         countryGrade = param1;
         txtCountryLv.text = "";
         txtCountryAttrName.text = "";
         txtCountryAttrs.text = "";
         var _loc2_:Object = obf_S_x_1774.countryLevelsObject(param1);
         if(!_loc2_)
         {
            return;
         }
         DiversityManager.setTextField(txtCountryLv,"CountryUI","txtCountryLv",[param1]);
         var _loc3_:String = "";
         var _loc4_:String = "";
         var _loc5_:Object = _loc2_.attr;
         for(_loc6_ in _loc5_)
         {
            _loc3_ += RoleAttributesModifierEnum.getAttributesName(_loc6_) + "\n";
            _loc4_ += RoleAttributesModifierEnum.getAttributesValueString(_loc6_,_loc5_[_loc6_]) + "\n";
         }
         txtCountryAttrName.text += _loc3_;
         txtCountryAttrs.text += _loc4_;
         if(param1 < obf_S_x_1774.countryMaxLevels())
         {
            DiversityManager.setTextField(txtUpCondition,"CountryUI","needUpCountryCond",[_loc2_.landLevel,_loc2_.wills]);
         }
         else
         {
            cmdCountry.visible = false;
         }
      }
      
      private function showLandInfo(param1:int) : void
      {
         var _loc5_:String = null;
         var _loc6_:Object = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:* = undefined;
         txtLandName.text = "";
         txtLandLv.text = "";
         txtLandAttrName.text = "";
         txtLandAttr.text = "";
         var _loc2_:int = 0;
         var _loc3_:Array = obf_S_x_1774.countryLandList;
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:Object = _loc3_[param1];
         for(_loc5_ in landsLevel)
         {
            if(_loc4_.name == _loc5_)
            {
               _loc2_ = int(landsLevel[_loc5_]);
               break;
            }
         }
         txtLandName.text = _loc4_.name;
         landName = _loc4_.name;
         DiversityManager.setTextField(txtLandLv,"CountryUI","txtLandLv",[_loc2_]);
         _loc7_ = "";
         _loc8_ = "";
         _loc6_ = _loc4_.levels[_loc2_];
         for(_loc9_ in _loc6_.attr)
         {
            _loc7_ += RoleAttributesModifierEnum.getAttributesName(_loc9_) + "\n";
            _loc8_ += RoleAttributesModifierEnum.getAttributesValueString(_loc9_,_loc6_.attr[_loc9_]) + "\n";
         }
         txtLandAttrName.text += _loc7_;
         txtLandAttr.text += _loc8_;
         if(_loc2_ >= _loc4_.levels.length)
         {
            cmdLand.visible = false;
         }
      }
      
      public function getLandObject(param1:Object) : void
      {
         landsLevel = param1;
         this.showLandInfo(this.landIndex);
      }
      
      public function showWills(param1:int) : void
      {
         wills = param1;
         DiversityManager.setTextField(txtWorldWit,"CountryUI","txtWorldWit",[param1]);
      }
      
      public function showCreatures(param1:Number) : void
      {
         creatures = param1;
         DiversityManager.setTextField(txtPeople,"CountryUI","txtPeople",[param1]);
      }
      
      public function showOrigins(param1:int) : void
      {
         origins = param1;
         DiversityManager.setTextField(txtWorldRoot,"CountryUI","txtWorldRoot",[param1]);
      }
      
      public function getCreatures() : Number
      {
         return creatures;
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return bgBox.getBounds(bgBox).contains(bgBox.mouseX,bgBox.mouseY);
         }
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"CountryUI","txtDeyTitle");
         DiversityManager.setTextField(txtCountryName,"CountryUI","txtCountryName");
         DiversityManager.setTextField(txtCountryLv,"CountryUI","txtCountryLv",[0]);
         DiversityManager.setTextField(txtPeople,"CountryUI","txtPeople",[0]);
         DiversityManager.setTextField(txtWorldRoot,"CountryUI","txtWorldRoot",[0]);
         DiversityManager.setTextField(txtWorldWit,"CountryUI","txtWorldWit",[0]);
         cmdCountry.label = DiversityManager.getString("CountryUI","cmdCountry");
         cmdLand.label = DiversityManager.getString("CountryUI","cmdLand");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.showLandInfo(this.landIndex);
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

