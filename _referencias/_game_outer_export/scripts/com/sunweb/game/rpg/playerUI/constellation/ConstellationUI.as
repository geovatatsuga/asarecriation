package com.sunweb.game.rpg.playerUI.constellation
{
   import obf_a_F_1055.obf_b_p_3604;
   import obf_g_A_3629.ChatDecoder;
   import obf_g_A_3629.obf_g_u_3212;
   import com.sunweb.game.res.obf_0_P_4381;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.constellation.obf_H_B_2569;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.equ.EquipmentKind;
   import com.sunweb.game.rpg.equ.EquipmentManager;
   import com.sunweb.game.rpg.equ.EquippedItemInfo;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemEquip;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.ItemShowBoxUI;
   import com.sunweb.game.rpg.playerUI.PlayerBagUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.script.MacroScript;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.TaskManager;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.rpg.world.map.WorldMapManager;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import fl.data.DataProvider;
   import fl.events.ScrollEvent;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import playerUI.ConstellationUIMC;
   
   public class ConstellationUI extends ConstellationUIMC implements IIconItemUI
   {
      
      private static var mouseTipMap:Dictionary = new Dictionary();
      
      private var bagKind:Object;
      
      private var obf_0_3_d_665:Array;
      
      private var taskObj:Object;
      
      private var obf_g_q_4337:String;
      
      private var constellationEquipBags:Array;
      
      private var constellationEquipMap:Object;
      
      private const obf_g_c_1273:String = "$pray";
      
      private const obf_3_4672:String = "$luck";
      
      private var obf_0_8_H_476:Array = new Array();
      
      private var monthData:Array = new Array();
      
      private var dayData:Array = new Array();
      
      private var refreshTaskShowTime:TimeLimiter = new TimeLimiter(2000);
      
      public function ConstellationUI()
      {
         super();
         this.initDiversity();
         this.visible = false;
         cmdAssociate.visible = false;
         cmdReceive.enabled = false;
         cmdComplete.enabled = false;
         this.onResize(null);
         this.initBags();
         this.addListener();
      }
      
      public static function addUIMouseToolTip(param1:InteractiveObject, param2:String) : void
      {
         mouseTipMap[param1] = param2;
         param1.addEventListener(MouseEvent.MOUSE_OVER,obf_Z_l_1286);
         param1.addEventListener(MouseEvent.MOUSE_OUT,obf_0_6_9_109);
      }
      
      public static function removeUIMouseToolTip(param1:InteractiveObject) : void
      {
         var mouseTipObj:InteractiveObject = param1;
         delete mouseTipMap[mouseTipObj];
         try
         {
            mouseTipObj.removeEventListener(MouseEvent.MOUSE_OVER,obf_Z_l_1286);
            mouseTipObj.removeEventListener(MouseEvent.MOUSE_OUT,obf_0_6_9_109);
         }
         catch(e:Error)
         {
         }
      }
      
      public static function obf_Z_l_1286(param1:Event) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("UIMouseTip");
         _loc2_.addTipInfo("<P align=\'center\'><FONT color=\'#FFFF00\'>" + mouseTipMap[param1.currentTarget] + "</FONT>",100,0);
         GameTipManager.showTip(_loc2_);
      }
      
      public static function obf_0_6_9_109(param1:Event) : void
      {
         GameTipManager.closeTip("UIMouseTip");
      }
      
      private function initBags() : void
      {
         var _loc2_:IconItemBag = null;
         this.constellationEquipBags = new Array();
         this.bagKind = new Object();
         var _loc1_:Array = [[bagClothes,EquipmentKind.obf_A_8_4141],[bagWeapon,EquipmentKind.obf_6_F_1556],[bagTally,EquipmentKind.obf_u_r_1074],[bagShield,EquipmentKind.obf_a_H_4017]];
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = new IconItemBag(_loc1_[_loc3_][0],this,_loc3_,_loc1_[_loc3_][1] + "");
            _loc2_.addValidType(GameItemType.EQUIPMENT);
            this.constellationEquipBags.push(_loc2_);
            this.bagKind[_loc1_[_loc3_][1] + ""] = _loc2_;
            _loc3_++;
         }
         var _loc4_:int = new Date().fullYear;
         var _loc5_:int = 1900;
         while(_loc5_ <= _loc4_)
         {
            this.obf_0_8_H_476.push(_loc5_);
            _loc5_++;
         }
         var _loc6_:int = 1;
         while(_loc6_ <= 12)
         {
            this.monthData.push(_loc6_);
            _loc6_++;
         }
         var _loc7_:int = 1;
         while(_loc7_ <= 31)
         {
            this.dayData.push(_loc7_);
            _loc7_++;
         }
         inputYear.dataProvider = new DataProvider(this.obf_0_8_H_476);
         inputMonth.dataProvider = new DataProvider(this.monthData);
         inputDay.dataProvider = new DataProvider(this.dayData);
         pointLuck.addChild(obf_H_B_2569.getConstellationLuckDisplay(0,true));
         pointConstellationUp.addChild(obf_H_B_2569.getConstellationHartDisplay(0,true));
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         cmdBless.addEventListener(MouseEvent.CLICK,this.obf_K_t_1144);
         cmdReceive.addEventListener(MouseEvent.CLICK,this.obf_L_R_1398);
         cmdAbandon.addEventListener(MouseEvent.CLICK,this.obf_W_r_4160);
         cmdComplete.addEventListener(MouseEvent.CLICK,this.onComplete);
         cmdChange.addEventListener(MouseEvent.CLICK,this.obf_0_7_c_329);
         cmdAccept.addEventListener(MouseEvent.CLICK,this.obf_0_5_t_419);
         cmdUp.addEventListener(MouseEvent.CLICK,this.obf_e_s_3253);
         cmdCompose.addEventListener(MouseEvent.CLICK,this.onCompose);
         cmdRouse.addEventListener(MouseEvent.CLICK,this.onRouse);
         cmdConfirm.addEventListener(MouseEvent.CLICK,this.onConfirm);
         taskShow.addEventListener(TextEvent.LINK,this.onClickLink);
         scrollTaskAward.addEventListener(ScrollEvent.SCROLL,this.onScrollAward);
         obf_K_e_3075.addUIMouseToolTip(cmdChange,"txtCmdChange");
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         cmdBless.removeEventListener(MouseEvent.CLICK,this.obf_K_t_1144);
         cmdReceive.removeEventListener(MouseEvent.CLICK,this.obf_L_R_1398);
         cmdAbandon.removeEventListener(MouseEvent.CLICK,this.obf_W_r_4160);
         cmdComplete.removeEventListener(MouseEvent.CLICK,this.onComplete);
         cmdChange.removeEventListener(MouseEvent.CLICK,this.obf_0_7_c_329);
         cmdAccept.removeEventListener(MouseEvent.CLICK,this.obf_0_5_t_419);
         cmdUp.removeEventListener(MouseEvent.CLICK,this.obf_e_s_3253);
         cmdCompose.removeEventListener(MouseEvent.CLICK,this.onCompose);
         cmdRouse.removeEventListener(MouseEvent.CLICK,this.onRouse);
         cmdConfirm.removeEventListener(MouseEvent.CLICK,this.onConfirm);
         taskShow.removeEventListener(TextEvent.LINK,this.onClickLink);
         scrollTaskAward.removeEventListener(ScrollEvent.SCROLL,this.onScrollAward);
         obf_K_e_3075.removeUIMouseToolTip(cmdChange);
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
      
      private function onEnterFrame(param1:Event) : void
      {
         if(!this.taskObj)
         {
            cmdReceive.enabled = false;
            cmdAbandon.enabled = false;
            cmdComplete.enabled = false;
         }
         if(Boolean(this.refreshTaskShowTime && this.visible) && Boolean(this.taskObj) && this.refreshTaskShowTime.checkTimeout())
         {
            this.refreshTask(GameContext.localPlayer.fullInfo.constellationTaskId);
            cmdReceive.enabled = true;
            if(TaskManager.doingTasks.indexOf(GameContext.localPlayer.fullInfo.constellationTaskId) > -1)
            {
               cmdReceive.enabled = false;
               cmdComplete.enabled = true;
            }
            else
            {
               cmdComplete.enabled = false;
            }
         }
      }
      
      private function obf_y_t_2104(param1:Event) : void
      {
      }
      
      private function obf_K_t_1144(param1:Event) : void
      {
         var _loc2_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter(this.obf_g_c_1273);
         if(JSONUtil.getInt(_loc2_,["numOfDay"]) > 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("ConstellationUI","alreadyDraw"));
            return;
         }
         obf_H_B_2569.sendGetBless();
      }
      
      private function obf_L_R_1398(param1:Event) : void
      {
         if(!this.taskObj)
         {
            return;
         }
         obf_H_B_2569.sendReceiveTask(GameContext.localPlayer.fullInfo.constellationTaskId);
      }
      
      private function obf_W_r_4160(param1:Event) : void
      {
         if(!this.taskObj)
         {
            return;
         }
         if(TaskManager.doingTasks.indexOf(GameContext.localPlayer.fullInfo.constellationTaskId) == -1)
         {
            return;
         }
         if(Boolean(this.taskObj.abortRule) && Boolean(this.taskObj.abortRule.cannotAbort))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("TaskUI","promptContAbortTask"));
         }
         else
         {
            WindowManager.showConfirmBox(DiversityManager.getString("TaskUI","promptConfirmAbortTask"),this.confirmAbortTask,this.taskObj.taskId);
         }
      }
      
      private function confirmAbortTask(param1:Object) : void
      {
         if(param1.confirm)
         {
            TaskManager.sendAbortTask(param1.par);
         }
      }
      
      private function onComplete(param1:Event) : void
      {
         if(!this.taskObj)
         {
            return;
         }
         obf_H_B_2569.sendFinishTask(GameContext.localPlayer.fullInfo.constellationTaskId);
      }
      
      private function obf_0_7_c_329(param1:Event) : void
      {
         if(GameContext.localPlayer.fullInfo.money < obf_H_B_2569.getChangeLuckByMoney())
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("ConstellationUI","not_EnoughMoney"));
            return;
         }
         if(GameContext.localPlayer.fullInfo.constellationLevel < 1)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("ConstellationUI","not_constellation"));
            return;
         }
         obf_H_B_2569.sendChangLuck();
      }
      
      private function obf_0_5_t_419(param1:Event) : void
      {
         cmdAccept.enabled = false;
         var _loc2_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter(this.obf_3_4672);
         if(JSONUtil.getInt(_loc2_,["numOfDay"]) > 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("ConstellationUI","alreadyDraw"));
            return;
         }
         if(GameContext.localPlayer.fullInfo.constellationLevel < 1 || GameContext.localPlayer.fullInfo.luckLevel < 1)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("ConstellationUI","not_Draw"));
            return;
         }
         obf_H_B_2569.sendGetLuck(GameContext.localPlayer.fullInfo.luckLevel);
      }
      
      private function obf_e_s_3253(param1:Event) : void
      {
         if(GameContext.localPlayer.fullInfo.hartLevel == obf_H_B_2569.getMaxHartLevel && GameContext.localPlayer.fullInfo.constellationLevel < obf_H_B_2569.getConstellationLevel(GameContext.localPlayer.fullInfo.constellation))
         {
            obf_H_B_2569.sendUp();
            return;
         }
         obf_K_e_3075.showTipInfo(DiversityManager.getString("ConstellationUI","not_up"));
      }
      
      private function onCompose(param1:Event) : void
      {
         obf_K_e_3075.assembleBoxUI.show("","",null,obf_H_B_2569.getConstellationComposeList());
         obf_K_e_3075.closeUI(this);
      }
      
      private function onRouse(param1:Event) : void
      {
         obf_K_e_3075.assembleBoxUI.show("","",null,obf_H_B_2569.getConstellationRouseList());
         obf_K_e_3075.closeUI(this);
      }
      
      private function onConfirm(param1:Event) : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = int(inputYear.selectedLabel);
         var _loc3_:int = int(inputMonth.selectedLabel);
         var _loc4_:int = int(inputDay.selectedLabel);
         switch(_loc3_)
         {
            case 1:
            case 3:
            case 5:
            case 7:
            case 8:
            case 10:
            case 12:
               _loc5_ = 31;
               break;
            case 2:
               if(_loc2_ % 400 == 0 || _loc2_ % 4 == 0 && _loc2_ % 100 != 0)
               {
                  _loc5_ = 29;
               }
               else
               {
                  _loc5_ = 28;
               }
               break;
            default:
               _loc5_ = 30;
         }
         if(_loc5_ < _loc4_)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("ConstellationUI","errorDay"));
            return;
         }
         var _loc6_:String = "";
         var _loc7_:String = "";
         if(_loc3_ < 10)
         {
            _loc6_ = "0" + _loc3_;
         }
         else
         {
            _loc6_ = _loc3_ + "";
         }
         if(_loc4_ < 10)
         {
            _loc7_ = "0" + _loc4_;
         }
         else
         {
            _loc7_ = _loc4_ + "";
         }
         var _loc8_:String = _loc6_ + "-" + _loc7_;
         obf_H_B_2569.sendBirthday(_loc8_);
      }
      
      private function onClickLink(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      private function onScrollAward(param1:ScrollEvent) : void
      {
         taskAwardContent.scrollRect = new Rectangle(0,param1.position,scrollTaskAward.x - taskAwardContent.x,scrollTaskAward.height);
      }
      
      public function refreshTask(param1:int) : void
      {
         var _loc5_:String = null;
         var _loc8_:String = null;
         var _loc11_:String = null;
         var _loc12_:Array = null;
         var _loc13_:Array = null;
         this.clearTaskContent();
         this.taskObj = TaskManager.getTaskObjById(int(param1));
         if(!this.taskObj)
         {
            return;
         }
         var _loc2_:String = obf_K_e_3075.getSwitchString(this.taskObj.detail);
         var _loc3_:String = "";
         var _loc4_:String = "";
         for each(_loc5_ in this.taskObj.receiveRule.atAnyNpc)
         {
            _loc12_ = _loc5_.split("@");
            if(Boolean(GameContext.currentMap) && WorldMapManager.getMapInLandCode(_loc12_[1]) == WorldMapManager.getMapInLandCode(GameContext.currentMap.mapId))
            {
               _loc3_ += ChatDecoder.decode(obf_g_u_3212.getNpcLinkCode(obf_b_p_3604.getNpcFullBriefName(_loc5_),_loc12_[1],_loc12_[0]));
            }
            _loc4_ += obf_g_u_3212.getNpcLinkCode(obf_b_p_3604.getNpcBriefName(_loc5_) + "-" + WorldMapManager.getMapName(_loc12_[1]),_loc12_[1],_loc12_[0]);
         }
         if(obf_L_l_4100.isEmpty(_loc3_))
         {
            _loc3_ = _loc4_;
         }
         _loc3_ = DiversityManager.getString("TaskUI","recevieNPC") + _loc3_;
         var _loc6_:String = "";
         var _loc7_:String = "";
         for each(_loc8_ in this.taskObj.finishRule.atAnyNpc)
         {
            _loc13_ = _loc8_.split("@");
            if(Boolean(GameContext.currentMap) && WorldMapManager.getMapInLandCode(_loc13_[1]) == WorldMapManager.getMapInLandCode(GameContext.currentMap.mapId))
            {
               _loc6_ += ChatDecoder.decode(obf_g_u_3212.getNpcLinkCode(obf_b_p_3604.getNpcBriefName(_loc8_) + "-" + WorldMapManager.getMapName(_loc13_[1]),_loc13_[1],_loc13_[0]));
            }
            _loc7_ += obf_g_u_3212.getNpcLinkCode(obf_b_p_3604.getNpcBriefName(_loc8_) + "-" + WorldMapManager.getMapName(_loc13_[1]),_loc13_[1],_loc13_[0]);
         }
         if(obf_L_l_4100.isEmpty(_loc6_))
         {
            _loc6_ = _loc7_;
         }
         _loc6_ = "\n" + DiversityManager.getString("TaskUI","finishNPC") + _loc6_;
         taskShow.htmlText = ChatDecoder.decode(_loc2_ + "\n");
         var _loc9_:Object = this.taskObj.finishRule.condition;
         if(!_loc9_)
         {
            return;
         }
         var _loc10_:String = "";
         for(_loc11_ in _loc9_)
         {
            taskShow.htmlText += ConditionScript.getConditionHTML(_loc11_,_loc9_[_loc11_]);
         }
         taskScrollBar.update();
         this.setTaskAward(this.taskObj.finishRule.onFinished);
      }
      
      private function setTaskAward(param1:Object) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:DisplayObject = null;
         if(!param1)
         {
            return;
         }
         this.obf_0_3_d_665 = new Array();
         while(taskAwardContent.numChildren > 0)
         {
            if(taskAwardContent.getChildAt(0) is ItemShowBoxUI)
            {
               ItemShowBoxUI(taskAwardContent.getChildAt(0)).destroy();
            }
            taskAwardContent.removeChildAt(0);
         }
         var _loc2_:Array = new Array();
         for(_loc3_ in param1)
         {
            _loc2_.push(_loc3_);
         }
         _loc2_.sort();
         _loc5_ = 0;
         for each(_loc6_ in _loc2_)
         {
            _loc7_ = MacroScript.getMacroDisplay(_loc6_,param1[_loc6_]);
            _loc8_ = 0;
            while(_loc8_ < _loc7_.length)
            {
               _loc9_ = _loc7_[_loc8_];
               if(_loc9_)
               {
                  if(_loc9_ is ItemShowBoxUI)
                  {
                     ItemShowBoxUI(_loc9_).dockParentUI(this,this.obf_0_3_d_665);
                  }
                  _loc9_.x = _loc8_ % 1 * 40;
                  _loc9_.y = _loc4_;
                  _loc5_ = Math.max(_loc5_,_loc9_.height);
                  if(_loc8_ % 1 == 0 && _loc8_ > 0)
                  {
                     _loc4_ += _loc5_;
                     _loc9_.y = _loc4_;
                  }
                  if(_loc8_ == _loc7_.length - 1)
                  {
                     _loc4_ += _loc5_;
                  }
                  taskAwardContent.addChild(_loc9_);
               }
               _loc8_++;
            }
         }
         if(_loc4_ > scrollTaskAward.height)
         {
            scrollTaskAward.maxScrollPosition = _loc4_ - scrollTaskAward.height;
            scrollTaskAward.visible = true;
         }
         else
         {
            scrollTaskAward.scrollPosition = 0;
            scrollTaskAward.maxScrollPosition = 1;
            scrollTaskAward.visible = false;
         }
         taskAwardContent.scrollRect = new Rectangle(0,scrollTaskAward.scrollPosition,scrollTaskAward.x - taskAwardContent.x,scrollTaskAward.height);
      }
      
      public function clearTaskContent() : void
      {
         taskShow.htmlText = "";
         while(taskAwardContent.numChildren > 0)
         {
            if(taskAwardContent.getChildAt(0) is ItemShowBoxUI)
            {
               ItemShowBoxUI(taskAwardContent.getChildAt(0)).destroy();
            }
            taskAwardContent.removeChildAt(0);
         }
         scrollTaskAward.visible = false;
      }
      
      private function showLuckContent() : void
      {
         var _loc3_:Object = null;
         var _loc1_:String = "";
         var _loc2_:int = 0;
         while(_loc2_ < obf_H_B_2569.getLuckLevelArr.length)
         {
            _loc3_ = obf_H_B_2569.getLuckLevelArr[_loc2_];
            _loc1_ += _loc3_.luckExplain + "\n";
            _loc2_++;
         }
         luckShow.htmlText = _loc1_;
         luckScrollBar.update();
      }
      
      public function updateChangLuckButton() : void
      {
         if(GameContext.localPlayer.fullInfo.constellationLevel < 1)
         {
            cmdChange.enabled = false;
         }
         else
         {
            cmdChange.enabled = true;
         }
      }
      
      public function updateReceiveLuckButton() : void
      {
         var _loc1_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter(this.obf_3_4672);
         if(JSONUtil.getInt(_loc1_,["numOfDay"]) > 0)
         {
            cmdAccept.enabled = false;
         }
         else
         {
            cmdAccept.enabled = true;
         }
      }
      
      public function updateBlessButton() : void
      {
         var _loc1_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter(this.obf_g_c_1273);
         if(JSONUtil.getInt(_loc1_,["numOfDay"]) > 0)
         {
            cmdBless.enabled = false;
         }
         else
         {
            cmdBless.enabled = true;
         }
      }
      
      public function getConstellationAttrInfo() : void
      {
         var _loc8_:Object = null;
         var _loc9_:String = null;
         var _loc10_:* = undefined;
         var _loc1_:int = GameContext.localPlayer.fullInfo.constellation;
         var _loc2_:int = GameContext.localPlayer.fullInfo.constellationLevel;
         if(_loc2_ <= 0)
         {
            return;
         }
         var _loc3_:Array = JSONUtil.getObject(obf_H_B_2569.getConstellationObject(_loc1_),["addAttrList"]) as Array;
         var _loc4_:String = JSONUtil.getStr(obf_H_B_2569.getConstellationObject(_loc1_),["icon"]);
         obf_0_P_4381.obf_m_X_1194(_loc4_,pointIcon);
         var _loc5_:String = "";
         var _loc6_:String = "";
         if(!_loc3_)
         {
            return;
         }
         var _loc7_:int = 1;
         while(_loc7_ <= _loc3_.length)
         {
            if(_loc7_ == _loc2_)
            {
               _loc8_ = JSONUtil.getObject(_loc3_[_loc7_ - 1],["attr"]);
               _loc9_ = JSONUtil.getStr(_loc3_[_loc7_ - 1],["prayExplain"]);
               for(_loc10_ in _loc8_)
               {
                  _loc5_ += RoleAttributesModifierEnum.getAttributesName(_loc10_) + "    " + _loc8_[_loc10_].toString() + "\n";
               }
            }
            _loc7_++;
         }
         attrShow.htmlText += _loc5_;
         attrScrollBar.update();
         blessShow.htmlText += _loc9_;
      }
      
      public function obf_b_z_1599() : void
      {
         txtName.text = "";
         txtDay.text = "";
         attrShow.text = "";
         blessShow.text = "";
         while(pointIcon.numChildren > 0)
         {
            pointIcon.removeChildAt(0);
         }
         if(GameContext.localPlayer.fullInfo.constellationLevel > 0)
         {
            txtName.text = obf_H_B_2569.getGodTypeName(GameContext.localPlayer.fullInfo.constellation) + "  " + GameContext.localPlayer.fullInfo.constellationLevel;
            txtDay.text = obf_H_B_2569.initializeConstellationDay(GameContext.localPlayer.fullInfo.constellation);
            this.getConstellationAttrInfo();
         }
      }
      
      public function resetBirthday() : void
      {
         if(GameContext.localPlayer.fullInfo.constellationLevel < 1)
         {
            cmdConfirm.enabled = true;
            inputYear.enabled = true;
            inputMonth.enabled = true;
            inputDay.enabled = true;
         }
         else
         {
            cmdConfirm.enabled = false;
            inputYear.enabled = false;
            inputMonth.enabled = false;
            inputDay.enabled = false;
         }
      }
      
      public function obf_k_I_2192(param1:int) : void
      {
         while(pointLuck1.numChildren > 0)
         {
            pointLuck1.removeChildAt(0);
         }
         pointLuck1.addChild(obf_H_B_2569.getConstellationLuckDisplay(param1,true));
      }
      
      public function obf_U_v_2683(param1:int) : void
      {
         while(pointConstellationUp1.numChildren > 0)
         {
            pointConstellationUp1.removeChildAt(0);
         }
         if(GameContext.localPlayer.fullInfo.constellationLevel < obf_H_B_2569.getConstellationLevel(GameContext.localPlayer.fullInfo.constellation))
         {
            pointConstellationUp1.addChild(obf_H_B_2569.getConstellationHartDisplay(param1,true));
         }
         else
         {
            cmdUp.enabled = false;
         }
      }
      
      public function obf_R_E_3490() : void
      {
         this.obf_b_z_1599();
         this.refreshTask(GameContext.localPlayer.fullInfo.constellationTaskId);
         this.obf_k_I_2192(GameContext.localPlayer.fullInfo.luckLevel);
         this.obf_U_v_2683(GameContext.localPlayer.fullInfo.hartLevel);
         this.resetBirthday();
         this.showLuckContent();
         this.updateAllButton();
      }
      
      public function obf_E_P_1839() : void
      {
         while(pointLuck1.numChildren > 0)
         {
            pointLuck1.removeChildAt(0);
         }
         while(pointConstellationUp1.numChildren > 0)
         {
            pointConstellationUp1.removeChildAt(0);
         }
         this.obf_b_z_1599();
         this.clearTaskContent();
      }
      
      public function updateAllButton() : void
      {
         if(GameContext.localPlayer.fullInfo.constellationLevel < 1)
         {
            cmdBless.enabled = false;
            cmdReceive.enabled = false;
            cmdAbandon.enabled = false;
            cmdComplete.enabled = false;
            cmdChange.enabled = false;
            cmdAccept.enabled = false;
            cmdUp.enabled = false;
            cmdCompose.enabled = false;
         }
         else
         {
            this.updateBlessButton();
            this.updateReceiveLuckButton();
            cmdReceive.enabled = true;
            cmdAbandon.enabled = true;
            cmdComplete.enabled = true;
            cmdChange.enabled = true;
            cmdUp.enabled = true;
            cmdCompose.enabled = true;
            if(GameContext.localPlayer.fullInfo.constellationLevel >= obf_H_B_2569.getConstellationLevel(GameContext.localPlayer.fullInfo.constellation))
            {
               cmdUp.enabled = false;
            }
         }
      }
      
      public function hideTaskButton() : void
      {
         cmdReceive.enabled = false;
         cmdAbandon.enabled = false;
         cmdComplete.enabled = false;
      }
      
      public function setEquip(param1:EquippedItemInfo) : void
      {
         var _loc3_:Object = null;
         var _loc4_:IconItemEquip = null;
         if(!param1 || !GameContext.localPlayer)
         {
            return;
         }
         var _loc2_:IconItemBag = this.bagKind[param1.equipmentKind + ""];
         if(!_loc2_)
         {
            return;
         }
         _loc2_.dropIconItem();
         _loc2_.bagMC.alpha = 0.5;
         if(param1.equipment)
         {
            _loc3_ = GameItemManager.getItemConfig(param1.equipment.itemCode);
            _loc4_ = IconItemEquip.getNewIconItem(param1.equipment.itemCode,param1.equipment.itemId);
            _loc2_.pushIconItem(_loc4_);
            _loc2_.bagMC.alpha = 1;
         }
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
      
      public function getIconItemBags() : Array
      {
         return this.constellationEquipBags.concat(this.obf_0_3_d_665);
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
         if(Boolean(param1.haveIconItem) && param1.haveIconItem.itemType == GameItemType.EQUIPMENT)
         {
            EquipmentManager.sendRemoveEquip(IconItemEquip(param1.haveIconItem).kind,-1);
         }
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         if(!param1)
         {
            return;
         }
         if(!(param3.parentIconUI is PlayerBagUI) || !GameItemType.contrastType(GameItemType.EQUIPMENT,param2.itemType))
         {
            param2.destroy();
            return;
         }
         param3.useIconItem();
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         if(!(param3 is PlayerBagUI))
         {
            return;
         }
         EquipmentManager.sendRemoveEquip(IconItemEquip(param1.haveIconItem).kind,param2 ? param2.itemIndex : -1);
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
         txtCompose.htmlText = DiversityManager.getString("ConstellationUI","txtCompose");
         composeScrolBar.update();
         DiversityManager.setTextField(txtClothes,"ConstellationUI","txtClothes");
         DiversityManager.setTextField(txtWeapon,"ConstellationUI","txtWeapon");
         DiversityManager.setTextField(txtTally,"ConstellationUI","txtTally");
         DiversityManager.setTextField(txtShield,"ConstellationUI","txtShield");
         cmdBless.label = DiversityManager.getString("ConstellationUI","cmdBless");
         cmdReceive.label = DiversityManager.getString("ConstellationUI","cmdReceive");
         cmdAbandon.label = DiversityManager.getString("ConstellationUI","cmdAbandon");
         cmdComplete.label = DiversityManager.getString("ConstellationUI","cmdComplete");
         cmdChange.label = DiversityManager.getString("ConstellationUI","cmdChange");
         cmdAccept.label = DiversityManager.getString("ConstellationUI","cmdAccept");
         cmdUp.label = DiversityManager.getString("ConstellationUI","cmdUp");
         cmdCompose.label = DiversityManager.getString("ConstellationUI","cmdCompose");
         cmdRouse.label = DiversityManager.getString("ConstellationUI","cmdRouse");
         cmdConfirm.label = DiversityManager.getString("ConstellationUI","cmdConfirm");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.obf_R_E_3490();
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.obf_E_P_1839();
      }
      
      public function destroy() : void
      {
         var _loc1_:IconItemBag = null;
         this.removeListener();
         for each(_loc1_ in this.constellationEquipBags)
         {
            _loc1_.destroy();
         }
         this.constellationEquipBags = null;
         this.obf_E_P_1839();
         this.refreshTaskShowTime = null;
      }
   }
}

