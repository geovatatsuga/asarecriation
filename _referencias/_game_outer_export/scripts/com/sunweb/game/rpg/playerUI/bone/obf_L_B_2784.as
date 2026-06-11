package com.sunweb.game.rpg.playerUI.bone
{
   import obf_b_2_1718.obf_0_8_D_73;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.gameItem.obf_x_c_2855;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.RoleAttributesInfo;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.rpg.worldZone.command.player.bone.BoneRefineAnswer;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_9_V_1635;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import gs.TweenLite;
   import gs.easing.obf_V_f_3046;
   import img.BoneOff;
   import img.BoneOn;
   import playerUI.BoneUIMC;
   
   public class obf_L_B_2784 extends BoneUIMC implements IIconItemUI
   {
      
      private static var mouseTipMap:Dictionary = new Dictionary();
      
      private static var mouseTipMapI:Dictionary = new Dictionary();
      
      private var bags:Array;
      
      private var equipBags:Array;
      
      private var materialBags:Array;
      
      private var obf_a_4651:Array;
      
      private var maskArr:Array;
      
      private var lvBox:Array;
      
      private var mList:Array;
      
      private var materialObject:Object;
      
      public var buttonType:int = 1;
      
      private var iconWidth:int = 27;
      
      private var obf_c_M_1170:int = 10;
      
      private var nowBtnIndex:int;
      
      private var btnWidth:Number;
      
      private var obf_c_p_4012:Number;
      
      private var obf_1_3_2857:Array;
      
      private var currentBoneIndex:int = 0;
      
      public function obf_L_B_2784()
      {
         var _loc7_:int = 0;
         var _loc8_:MovieClip = null;
         var _loc9_:IconItemBag = null;
         var _loc10_:IconItemBag = null;
         var _loc11_:BoneOff = null;
         this.lvBox = new Array();
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2 + 150;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         titleBox.mouseEnabled = false;
         this.obf_a_4651 = [this.btnList.btn1,this.btnList.btn2,this.btnList.btn3,this.btnList.btn4,this.btnList.btn5,this.btnList.btn6,this.btnList.btn7,this.btnList.btn8];
         this.obf_1_3_2857 = [];
         var _loc1_:int = 1;
         while(_loc1_ <= this.obf_a_4651.length)
         {
            (this["lv" + _loc1_] as MovieClip).doubleClickEnabled = true;
            this.lvBox.push(this["lv" + _loc1_]);
            _loc7_ = 1;
            while(_loc7_ <= this.obf_c_M_1170)
            {
               _loc8_ = this["lv" + _loc1_]["b" + _loc7_];
               _loc8_.gotoAndStop("hide");
               _loc7_++;
            }
            _loc1_++;
         }
         this.obf_c_p_4012 = btnList.x;
         this.btnWidth = btnList.btn2.x - btnList.btn1.x;
         var _loc2_:int = 4;
         while(_loc2_ < this.obf_a_4651.length)
         {
            this.obf_a_4651[_loc2_].visible = false;
            _loc2_++;
         }
         this.bags = new Array();
         this.equipBags = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < 3)
         {
            _loc9_ = new IconItemBag(this["equipBag" + _loc3_],this,_loc3_);
            _loc9_.addValidType(GameItemType.EQUIPMENT);
            _loc9_.isLocked = false;
            this.equipBags.push(_loc9_);
            this.bags.push(_loc9_);
            _loc3_++;
         }
         this.materialBags = new Array();
         var _loc4_:int = 0;
         while(_loc4_ < 2)
         {
            _loc10_ = new IconItemBag(this["material" + _loc4_],this,_loc4_);
            _loc10_.addValidType(GameItemType.ALL);
            _loc10_.isLocked = false;
            this.materialBags.push(_loc10_);
            this.bags.push(_loc10_);
            _loc4_++;
         }
         var _loc5_:Sprite = new Sprite();
         var _loc6_:int = 1;
         while(_loc6_ <= obf_0_8_D_73.getBoneClearNum())
         {
            _loc11_ = new BoneOff();
            _loc11_.x = (_loc6_ - 1) * this.iconWidth;
            _loc5_.addChild(_loc11_);
            _loc6_++;
         }
         pointRefineIcon1.addChild(_loc5_);
         this.addListener();
      }
      
      private function addListener() : void
      {
         var _loc1_:MovieClip = null;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdRefine.addEventListener(MouseEvent.CLICK,this.obf_S_v_1347);
         cmdClean.addEventListener(MouseEvent.CLICK,this.obf_O_B_2245);
         cmdBone.addEventListener(MouseEvent.CLICK,this.obf_U_k_3621);
         cmdLeft.addEventListener(MouseEvent.CLICK,this.listLeft);
         cmdRight.addEventListener(MouseEvent.CLICK,this.listRight);
         for each(_loc1_ in this.obf_a_4651)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.obf_0_4_n_348);
         }
         obf_K_e_3075.addUIMouseToolTip(txtBoneLevelPoint,"TxtBoneLevelPoint");
      }
      
      private function removeListener() : void
      {
         var _loc1_:MovieClip = null;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdRefine.removeEventListener(MouseEvent.CLICK,this.obf_S_v_1347);
         cmdClean.removeEventListener(MouseEvent.CLICK,this.obf_O_B_2245);
         cmdBone.removeEventListener(MouseEvent.CLICK,this.obf_U_k_3621);
         for each(_loc1_ in this.obf_a_4651)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.obf_0_4_n_348);
         }
         cmdLeft.removeEventListener(MouseEvent.CLICK,this.listLeft);
         cmdRight.removeEventListener(MouseEvent.CLICK,this.listRight);
         obf_K_e_3075.removeUIMouseToolTip(txtBoneLevelPoint);
      }
      
      private function obf_Z_l_1286(param1:MouseEvent) : void
      {
         var _loc4_:Array = null;
         var _loc5_:Object = null;
         var _loc6_:Number = NaN;
         var _loc2_:GameTipUI = new GameTipUI("BoneMouseTip");
         var _loc3_:int = 200;
         _loc3_ = 150;
         _loc4_ = obf_0_8_D_73.getAttributesInfo(mouseTipMapI[param1.currentTarget]);
         if((Boolean(_loc4_)) && _loc4_.length > 0)
         {
            _loc2_.addTipInfo("<P align=\'center\'><FONT color=\'#FFFF00\'>" + obf_0_8_D_73.getAttributesName() + "</FONT>",_loc3_,_loc2_.maxRow + 1);
            for each(_loc5_ in _loc4_)
            {
               _loc6_ = GameItemManager.getItemQualityValue(_loc5_.value,0);
               _loc2_.addTipInfo("<FONT color=\'#00FF00\'>" + RoleAttributesModifierEnum.getAttributesName(_loc5_.attr) + "</FONT>",_loc3_,_loc2_.maxRow + 1);
               _loc2_.addTipInfo("<P align=\'right\'><FONT color=\'#00FF00\'>" + RoleAttributesModifierEnum.getAttributesValueString(_loc5_.attr,_loc6_) + "</FONT></P>",_loc3_,_loc2_.maxRow);
            }
            GameTipManager.showTip(_loc2_);
            return;
         }
      }
      
      private function obf_0_6_9_109(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("BoneMouseTip");
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
      
      private function addUIMouseToolTip(param1:InteractiveObject, param2:int, param3:int) : void
      {
         mouseTipMap[param1] = param2;
         mouseTipMapI[param1] = param3;
         param1.addEventListener(MouseEvent.MOUSE_OVER,this.obf_Z_l_1286);
         param1.addEventListener(MouseEvent.MOUSE_OUT,this.obf_0_6_9_109);
      }
      
      private function removeUIMouseToolTip(param1:InteractiveObject) : void
      {
         var mouseTipObj:InteractiveObject = param1;
         delete mouseTipMap[mouseTipObj];
         delete mouseTipMapI[mouseTipObj];
         try
         {
            mouseTipObj.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_Z_l_1286);
            mouseTipObj.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_0_6_9_109);
         }
         catch(e:Error)
         {
         }
      }
      
      private function obf_0_4_n_348(param1:Event) : void
      {
         if(this.obf_a_4651.indexOf(param1.currentTarget) + 1 > GameContext.localPlayer.fullInfo.boneLevel)
         {
            return;
         }
         this.setBoneBtn(this.obf_a_4651.indexOf(param1.currentTarget) + 1);
         obf_0_8_D_73.sendBoneLevelAttr(this.buttonType);
      }
      
      public function get getButtonType() : int
      {
         return this.buttonType;
      }
      
      public function setBoneBtn(param1:int) : void
      {
         var i:int;
         var lv:MovieClip = null;
         var index:int = param1;
         this.buttonType = index;
         i = 0;
         while(i < this.obf_a_4651.length)
         {
            (this.obf_a_4651[i] as MovieClip).gotoAndStop(i + 1 == index ? 2 : 1);
            i++;
         }
         for each(lv in this.lvBox)
         {
            try
            {
               this.removeChild(lv);
            }
            catch(e:Error)
            {
            }
         }
         this.addChild(this.lvBox[index - 1]);
         if(index < GameContext.localPlayer.fullInfo.boneLevel)
         {
            this.obf_0_8_p_357(index,this.obf_c_M_1170);
         }
         else if(GameContext.localPlayer.fullInfo.lightLevel == this.obf_c_M_1170)
         {
            this.obf_0_8_p_357(index,this.obf_c_M_1170);
         }
         else
         {
            this.obf_0_5_H_253(index,GameContext.localPlayer.fullInfo.lightLevel);
            this.obf_U_L_3755();
         }
      }
      
      private function obf_0_8_p_357(param1:int, param2:int) : void
      {
         this.obf_0_5_H_253(param1,param2);
         this.obf_P_K_1551();
      }
      
      private function obf_S_v_1347(param1:Event) : void
      {
         var _loc4_:IconItemBag = null;
         var _loc2_:Object = new Object();
         var _loc3_:Array = new Array();
         for each(_loc4_ in this.equipBags)
         {
            if(Boolean(_loc4_.haveIconItem) && !obf_L_l_4100.isEmpty(_loc4_.haveIconItem.itemId))
            {
               _loc2_[_loc4_.haveIconItem.itemId] = _loc4_.haveIconItem.itemCode;
               _loc3_.push(_loc2_);
            }
         }
         if(_loc3_.length == 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("boneUI","prompt_NoItems"));
            return;
         }
         obf_0_8_D_73.sendRefineItems(_loc2_);
      }
      
      private function confirmRefine(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_0_8_D_73.sendRefineItems(param1.par);
         }
      }
      
      private function obf_O_B_2245(param1:Event) : void
      {
         if(!ConditionScript.checkCondition({"equalItemsInBag":this.materialObject},null,true))
         {
            return;
         }
         if(GameContext.localPlayer.fullInfo.refineLevel > obf_0_8_D_73.getBoneClearNum())
         {
            return;
         }
         obf_0_8_D_73.sendRefineBone();
      }
      
      private function obf_U_k_3621(param1:Event) : void
      {
         if(GameContext.localPlayer.fullInfo.refineLevel != obf_0_8_D_73.getBoneClearNum())
         {
            return;
         }
         var _loc2_:Object = JSONUtil.getObject(obf_0_8_D_73.BoneGradeList[GameContext.localPlayer.fullInfo.boneLevel - 1],["openCon"]);
         if(!ConditionScript.checkCondition(_loc2_,null,true))
         {
            return;
         }
         obf_0_8_D_73.sendBoneUpLevel();
      }
      
      private function obf_5_E_2528() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.obf_a_4651.length)
         {
            this.obf_a_4651[_loc1_].visible = false;
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ <= 2)
         {
            this.obf_a_4651[this.nowBtnIndex + _loc2_].visible = true;
            _loc2_++;
         }
      }
      
      private function listLeft(param1:MouseEvent) : void
      {
         if(this.nowBtnIndex <= 0)
         {
            return;
         }
         --this.nowBtnIndex;
         this.moveList();
      }
      
      private function listRight(param1:MouseEvent) : void
      {
         if(this.nowBtnIndex >= 5)
         {
            return;
         }
         ++this.nowBtnIndex;
         this.moveList();
      }
      
      private function moveList() : void
      {
         this.obf_5_E_2528();
         TweenLite.to(btnList,0.5,{
            "x":this.obf_c_p_4012 - this.nowBtnIndex * this.btnWidth,
            "ease":obf_V_f_3046.easeOut
         });
      }
      
      public function clearItems() : void
      {
         var _loc1_:IconItemBag = null;
         for each(_loc1_ in this.equipBags)
         {
            if(_loc1_.haveIconItem)
            {
               _loc1_.dropIconItem();
            }
         }
      }
      
      public function obf_6_Z_2251() : void
      {
         this.obf_0_5_H_253(GameContext.localPlayer.fullInfo.boneLevel,GameContext.localPlayer.fullInfo.lightLevel);
         var _loc1_:int = obf_0_8_D_73.getBoneCurrentLightAll(GameContext.localPlayer.fullInfo.boneLevel,GameContext.localPlayer.fullInfo.lightLevel);
         var _loc2_:int = _loc1_ / obf_0_8_D_73.getBoneAllNum() * 100;
         if(_loc2_ == 0)
         {
            _loc2_ = 1;
         }
         barBoneLevelPoint.gotoAndStop(_loc2_);
         DiversityManager.setTextField(txtBoneLevelPoint,"boneUI","txtBonePoint",[_loc1_,obf_0_8_D_73.getBoneAllNum()],true);
      }
      
      public function obf_0_5_H_253(param1:int, param2:int) : void
      {
         var _loc5_:MovieClip = null;
         if(param1 > this.obf_a_4651.length)
         {
            return;
         }
         var _loc3_:int = 1;
         while(_loc3_ <= param2)
         {
            _loc5_ = this["lv" + param1]["b" + _loc3_];
            if(_loc5_)
            {
               _loc5_.gotoAndStop("none");
            }
            else
            {
               _loc5_.gotoAndStop("hide");
            }
            _loc3_++;
         }
         var _loc4_:int = 1;
         while(_loc4_ <= this.obf_c_M_1170)
         {
            this.addUIMouseToolTip(this["lv" + param1]["b" + _loc4_],0,_loc4_);
            _loc4_++;
         }
      }
      
      public function obf_U_L_3755() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         var _loc3_:IconItemBag = null;
         var _loc4_:IconItem = null;
         while(pointRefineIcon2.numChildren > 0)
         {
            pointRefineIcon2.removeChildAt(0);
         }
         if(GameContext.localPlayer.fullInfo.boneLevel == 8 && GameContext.localPlayer.fullInfo.lightLevel == this.obf_c_M_1170)
         {
            cmdClean.visible = false;
            cmdBone.visible = false;
         }
         else if(GameContext.localPlayer.fullInfo.refineLevel < obf_0_8_D_73.getBoneClearNum())
         {
            cmdBone.visible = false;
            cmdClean.visible = true;
         }
         else
         {
            cmdClean.visible = false;
            cmdBone.visible = true;
         }
         pointRefineIcon2.addChild(this.getBoneUpLevelDisplay(GameContext.localPlayer.fullInfo.refineLevel,true));
         obf_x_c_2855.setLuckBox(obf_x_c_2855.getAssembleLuck(obf_0_8_D_73.getRefineRule()),obf_Q_0_1896,false);
         obf_Q_0_1896.visible = true;
         this.materialObject = obf_0_8_D_73.getRefineMaterial();
         this.mList = new Array();
         for(_loc1_ in this.materialObject)
         {
            this.mList.push({
               "itemCode":_loc1_,
               "itemCount":this.materialObject[_loc1_]
            });
         }
         this.mList.sortOn("itemCode");
         _loc2_ = 0;
         while(_loc2_ < this.mList.length)
         {
            if(_loc2_ >= this.materialBags.length)
            {
               break;
            }
            _loc3_ = this.materialBags[_loc2_];
            _loc4_ = IconItemManager.getIconItemByCode(this.mList[_loc2_].itemCode,"");
            if(Boolean(_loc3_) && Boolean(_loc4_))
            {
               _loc4_.itemCount = this.mList[_loc2_].itemCount;
               _loc3_.dropIconItem();
               _loc3_.pushIconItem(_loc4_);
            }
            _loc2_++;
         }
      }
      
      public function exchangeAttr() : void
      {
         if(obf_K_e_3075.boneUI.visible)
         {
            this.setBoneBtn(GameContext.localPlayer.fullInfo.boneLevel);
            obf_0_8_D_73.sendBoneLevelAttr(GameContext.localPlayer.fullInfo.boneLevel);
            this.obf_0_5_H_253(GameContext.localPlayer.fullInfo.boneLevel,GameContext.localPlayer.fullInfo.lightLevel);
         }
      }
      
      public function obf_E_P_1839() : void
      {
         var _loc1_:IconItemBag = null;
         cmdClean.visible = false;
         cmdBone.visible = false;
         for each(_loc1_ in this.materialBags)
         {
            if(_loc1_.haveIconItem)
            {
               _loc1_.dropIconItem();
            }
         }
         obf_x_c_2855.setLuckBox(0,obf_Q_0_1896,false);
         while(pointRefineIcon2.numChildren > 0)
         {
            pointRefineIcon2.removeChildAt(0);
         }
      }
      
      public function obf_P_K_1551() : void
      {
         if(this.buttonType < GameContext.localPlayer.fullInfo.boneLevel)
         {
            this.obf_E_P_1839();
         }
         else if(GameContext.localPlayer.fullInfo.lightLevel < this.obf_c_M_1170)
         {
            cmdClean.visible = true;
            cmdBone.visible = false;
            while(pointRefineIcon2.numChildren > 0)
            {
               pointRefineIcon2.removeChildAt(0);
            }
         }
      }
      
      public function showTabState() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.obf_a_4651.length)
         {
            if(_loc1_ >= GameContext.localPlayer.fullInfo.boneLevel)
            {
               (this.obf_a_4651[_loc1_] as MovieClip).filters = [obf_9_V_1635.getGrayFilter()];
            }
            else
            {
               (this.obf_a_4651[_loc1_] as MovieClip).filters = null;
            }
            _loc1_++;
         }
      }
      
      public function clearContent() : void
      {
         var _loc1_:IconItemBag = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         for each(_loc1_ in this.bags)
         {
            _loc1_.dropIconItem();
         }
         _loc2_ = 1;
         while(_loc2_ <= this.obf_a_4651.length)
         {
            _loc3_ = 1;
            while(_loc3_ <= this.obf_c_M_1170)
            {
               this.removeUIMouseToolTip(this["lv" + _loc2_]["b" + _loc3_]);
               _loc3_++;
            }
            _loc2_++;
         }
         txtCritDefense.text = "";
         txtPhysicalAttack.text = "";
         txtMagicAttack.text = "";
         txtPhysicalDefense.text = "";
         txtMagicDefense.text = "";
         txtPierceAttack.text = "";
         txtCritDamage.text = "";
         while(pointRefineIcon2.numChildren > 0)
         {
            pointRefineIcon2.removeChildAt(0);
         }
      }
      
      public function getBoneUpLevelDisplay(param1:int, param2:Boolean = false) : DisplayObject
      {
         var _loc5_:BoneOn = null;
         var _loc3_:Sprite = new Sprite();
         var _loc4_:int = 1;
         while(_loc4_ <= obf_0_8_D_73.getBoneClearNum())
         {
            if(_loc4_ > param1)
            {
               break;
            }
            _loc5_ = new BoneOn();
            _loc5_.x = (_loc4_ - 1) * this.iconWidth;
            _loc3_.addChild(_loc5_);
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function showBoneAttr(param1:RoleAttributesInfo) : void
      {
         txtCritDefense.text = param1.toughValue + "";
         txtPhysicalAttack.text = param1.physicalAttack + "";
         txtMagicAttack.text = param1.magicAttack + "";
         txtPhysicalDefense.text = param1.physicalDefense + "";
         txtMagicDefense.text = param1.magicDefense + "";
         txtPierceAttack.text = param1.pierceAttack + "";
         txtCritDamage.text = int(Math.round(param1.critDamageMul * 100)) + "%";
      }
      
      public function obf_k_N_2236(param1:BoneRefineAnswer) : void
      {
         GameContext.localPlayer.fullInfo.refineLevel = param1.refineLevel;
         if(param1.isSucceeded)
         {
            WindowManager.showMessageBox(DiversityManager.getString("boneUI","cleanComplete"));
            obf_6_D_3816.print(DiversityManager.getString("boneUI","cleanComplete"));
            this.obf_U_L_3755();
            obf_x_c_2855.setAssembleLuck(param1.assembleRuleIndex,0);
            obf_x_c_2855.setLuckBox(0,obf_Q_0_1896);
         }
         else
         {
            obf_K_e_3075.showInfoOnUI(DiversityManager.getString("boneUI","cleanFail"),this,new Point(0,-100));
            obf_6_D_3816.print(DiversityManager.getString("boneUI","cleanFail"));
            obf_x_c_2855.setLuckBox(obf_x_c_2855.obf_0_2_6_666(param1.assembleRuleIndex),obf_Q_0_1896);
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
         var _loc5_:IconItemBag = null;
         if(param3.parentIconUI != obf_K_e_3075.playerBagUI)
         {
            return;
         }
         var _loc4_:Object = GameItemManager.getItemConfig(param2.itemCode);
         if(!_loc4_)
         {
            return;
         }
         if(JSONUtil.getStr(_loc4_,["decDropRule"]) == "" || obf_L_l_4100.isEmpty(param2.itemId))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("boneUI","prompt_UnItems"));
            return;
         }
         if(obf_0_8_D_73.itemIsRefineEquip(param2.itemCode))
         {
            for each(_loc5_ in this.equipBags)
            {
               if(!_loc5_.haveIconItem)
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("boneUI","prompt_ClearItems"));
                  _loc5_.dropIconItem();
                  param2.itemCount = 1;
                  _loc5_.pushIconItem(param2);
                  break;
               }
               if(_loc5_.haveIconItem.itemId == param2.itemId)
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("boneUI","prompt_HasItems"));
                  return;
               }
            }
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
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
         DiversityManager.setTextField(txtDeyPhysicalAttack,"boneUI","txtPhysicalAttack");
         DiversityManager.setTextField(txtDeyPhysicalDefense,"boneUI","txtPhysicalDefense");
         DiversityManager.setTextField(txtDeyMagicAttack,"boneUI","txtMagicAttack");
         DiversityManager.setTextField(txtDeyMagicDefense,"boneUI","txtPhysicalDefense");
         DiversityManager.setTextField(txtDeyPierceAttack,"boneUI","txtPierceAttack");
         DiversityManager.setTextField(txtDeyCritDamage,"boneUI","txtCritDamage");
         DiversityManager.setTextField(txtDeyCritDefense,"boneUI","txtCritDefense");
         DiversityManager.setTextField(txtPrompt,"boneUI","txtPrompt");
         DiversityManager.setTextField(txtL,"boneUI","cmdLeft");
         DiversityManager.setTextField(txtR,"boneUI","cmdRight");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.setBoneBtn(1);
         this.buttonType = 1;
         this.obf_6_Z_2251();
         obf_0_8_D_73.sendBoneLevelAttr(1);
         this.showTabState();
      }
      
      public function closeUI() : void
      {
         this.clearContent();
         this.clearItems();
         this.visible = false;
      }
      
      public function destroy() : void
      {
         var _loc1_:IconItemBag = null;
         this.removeListener();
         for each(_loc1_ in this.bags)
         {
            _loc1_.destroy();
         }
         this.bags = null;
      }
   }
}

