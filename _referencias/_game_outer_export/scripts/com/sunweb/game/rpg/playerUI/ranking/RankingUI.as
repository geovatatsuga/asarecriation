package com.sunweb.game.rpg.playerUI.ranking
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.ranking.RankingInfo;
   import com.sunweb.game.rpg.ranking.RankingListType;
   import com.sunweb.game.rpg.ranking.RankingManager;
   import com.sunweb.game.rpg.settingConfig.NumberConfig;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.map.WorldMapManager;
   import com.sunweb.game.rpg.worldZone.command.map.clear.MapClearResultInfo;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_l_y_733;
   import fl.data.DataProvider;
   import fl.events.ScrollEvent;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import playerUI.RankingUIMC;
   
   public class RankingUI extends RankingUIMC implements IPlayerUI
   {
      
      private var _npcId:String;
      
      private var _npcMenuIndex:Array;
      
      private var tableCmdList:Array;
      
      private var currentRankingTypeIndex:int = -1;
      
      private var map_ArmyRank:Array;
      
      private var map_HonorArr:Array;
      
      private var map_ChallengeArr:Array;
      
      private var map_ChallengeRank:Array;
      
      private var otherPlayerRank:Object;
      
      private var obf_z_b_3034:int = 0;
      
      public function RankingUI()
      {
         var _loc1_:int = 0;
         var _loc2_:TableButton = null;
         super();
         this.initDiversity();
         this.otherPlayerRank = new Object();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         txtDeyTitle.mouseEnabled = false;
         titleBox.mouseEnabled = false;
         obf_k_v_1843.pageSize = obf_k_v_1843.height;
         this.map_HonorArr = new Array();
         this.tableCmdList = new Array();
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            if(_loc1_ != 2)
            {
               _loc2_ = new TableButton();
               _loc2_.name = RankingListType.getTankingBigKind(_loc1_);
               _loc2_.txtLabel.text = _loc2_.name;
               _loc2_.width = 180;
               _loc2_.type = _loc1_;
               _loc2_.gotoAndStop(1);
               _loc2_.x = pointType.width;
               pointType.addChild(_loc2_);
               this.tableCmdList.push(_loc2_);
            }
            _loc1_++;
         }
         this.map_HonorArr = WorldConfig.getObjectSetting("mapHonorRankingList") as Array;
         this.addListener();
         this.map_ArmyRank = new Array();
         this.getMapRank();
         RankingListType.getRankingMapArr(this.map_ArmyRank);
         this.map_ChallengeArr = WorldConfig.getObjectSetting("mapChallengeList") as Array;
         this.map_ChallengeRank = new Array();
         this.getMapChallengeArr();
         RankingListType.getChallengeArr(this.map_ChallengeRank);
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"RankingUI","txtTitle");
         DiversityManager.setTextField(txtDeyPlayerName,"RankingUI","txtPlayerName");
      }
      
      private function addListener() : void
      {
         var _loc1_:TableButton = null;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         obf_k_v_1843.addEventListener(ScrollEvent.SCROLL,this.onScrollList);
         for each(_loc1_ in this.tableCmdList)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.obf_N_A_1730);
         }
         list.addEventListener(Event.CHANGE,this.obf_d_5_3632);
      }
      
      private function removeListener() : void
      {
         var _loc1_:TableButton = null;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         obf_k_v_1843.removeEventListener(ScrollEvent.SCROLL,this.onScrollList);
         for each(_loc1_ in this.tableCmdList)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.obf_N_A_1730);
         }
         list.removeEventListener(Event.CHANGE,this.obf_d_5_3632);
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
      
      private function onClickLink(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      private function onScrollList(param1:Event) : void
      {
         pointList.scrollRect = new Rectangle(0,obf_k_v_1843.scrollPosition,obf_k_v_1843.x - pointList.x,obf_k_v_1843.height);
      }
      
      private function obf_N_A_1730(param1:Event) : void
      {
         if(!(param1.currentTarget is TableButton))
         {
            return;
         }
         this.selectRankingType(param1.currentTarget.name);
      }
      
      private function getMapRank() : void
      {
         if(!this.map_HonorArr)
         {
            return;
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.map_HonorArr.length)
         {
            this.map_ArmyRank.push({
               "id":RankingListType.obf_g_g_3050 + _loc1_,
               "label":WorldMapManager.getMapName(this.map_HonorArr[_loc1_])
            });
            _loc1_++;
         }
         this.map_ArmyRank.push({
            "id":RankingListType.obf_J_I_1570,
            "label":RankingListType.getRankingTypeName(RankingListType.obf_J_I_1570)
         });
      }
      
      private function getMapChallengeArr() : void
      {
         if(!this.map_ChallengeArr)
         {
            return;
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.map_ChallengeArr.length)
         {
            this.map_ChallengeRank.push({
               "id":RankingListType.obf_B_4646 + _loc1_,
               "label":this.map_ChallengeArr[_loc1_].tabName
            });
            _loc1_++;
         }
      }
      
      private function obf_d_5_3632(param1:Event) : void
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         this.clearList();
         this.obf_A_9_4591();
         txtInfoName.text = "";
         var _loc2_:Object = list.selectedItem;
         if(_loc2_)
         {
            if(_loc2_.id < 99)
            {
               DiversityManager.setTextField(txtDeyJobName,"RankingUI","txtJobName");
               this.setRankingList(_loc2_.id);
               this.showLocalArena(_loc2_.id);
            }
            else if(_loc2_.id >= 99 && _loc2_.id < 1000)
            {
               DiversityManager.setTextField(txtDeyJobName,"RankingUI","txtHonorName");
               this.setRankingList(_loc2_.id);
               this.showLocalArmy(_loc2_.id,_loc2_.label);
            }
            else if(_loc2_.id >= 1000)
            {
               txtDeyJobName.text = "";
               _loc3_ = this.map_ChallengeArr[list.selectedIndex].mapId;
               if(!_loc3_)
               {
                  return;
               }
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  RankingManager.sendCommand(_loc3_[_loc4_],1);
                  _loc4_++;
               }
            }
         }
      }
      
      private function selectRankingType(param1:String) : void
      {
         var _loc2_:TableButton = null;
         var _loc3_:Array = null;
         this.clearList();
         txtInfoName.text = "";
         if(param1 == null)
         {
            param1 = "";
         }
         for each(_loc2_ in this.tableCmdList)
         {
            _loc2_.gotoAndStop(_loc2_.name == param1 ? 2 : 1);
         }
         _loc3_ = RankingListType.getfinallyRanking(param1);
         list.dataProvider = new DataProvider(_loc3_);
         if(!_loc3_ || _loc3_.length <= 0)
         {
            return;
         }
         list.selectedIndex = 0;
         this.obf_d_5_3632(null);
      }
      
      public function showRanking(param1:String, param2:Array) : void
      {
         this._npcId = param1;
         this._npcMenuIndex = param2;
         obf_K_e_3075.showUI(this);
      }
      
      public function getLocalTier(param1:int) : int
      {
         var _loc4_:RankingInfo = null;
         var _loc2_:Array = this.otherPlayerRank[param1] as Array;
         var _loc3_:int = 1;
         for each(_loc4_ in _loc2_)
         {
            if(GameContext.localPlayer.id == _loc4_.name)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return 99999;
      }
      
      public function getRankList(param1:int, param2:Array) : void
      {
         this.otherPlayerRank[param1] = param2;
      }
      
      private function setRankingList(param1:int) : void
      {
         var _loc5_:RankingInfo = null;
         var _loc6_:RankingItem = null;
         var _loc7_:DisplayObject = null;
         var _loc8_:DisplayObject = null;
         DiversityManager.setTextField(txtDeyRank,"RankingUI","txtRanking");
         if(param1 < 99)
         {
            txtInfoName.text = RankingListType.getRankingTypeName(param1);
         }
         if(param1 > 99)
         {
            txtInfoName.text = DiversityManager.getString("RankingUI","armyLv");
         }
         if(param1 == RankingListType.obf_J_I_1570)
         {
            txtInfoName.text = RankingListType.getRankingTypeName(param1);
         }
         var _loc2_:Array = this.otherPlayerRank[param1] as Array;
         pointList.scrollRect = new Rectangle(0,0,obf_k_v_1843.x - pointList.x,obf_k_v_1843.height);
         var _loc3_:int = 0;
         var _loc4_:int = 1;
         for each(_loc5_ in _loc2_)
         {
            _loc6_ = new RankingItem();
            _loc6_.txtRank.text = _loc4_ + "";
            _loc6_.txtPlayerName.htmlText = obf_7_6_4416.getRoleLinkA(_loc5_.name);
            if(param1 >= 99)
            {
               _loc6_.txtJobName.text = _loc5_.value + "";
               if(_loc4_ == 1)
               {
                  _loc6_.txtJobName.textColor = 16319700;
               }
               else if(_loc4_ == 2)
               {
                  _loc6_.txtJobName.textColor = 2875923;
               }
               else if(_loc4_ == 3)
               {
                  _loc6_.txtJobName.textColor = 11005;
               }
               else
               {
                  _loc6_.txtJobName.textColor = 16777215;
               }
               _loc7_ = this.getInfoDisplay(param1,_loc5_,_loc4_);
               if(_loc7_)
               {
                  _loc6_.pointInfo.addChild(_loc7_);
               }
            }
            else if(param1 < 99)
            {
               _loc8_ = this.getInfoDisplay(param1,_loc5_,_loc4_);
               if(_loc8_)
               {
                  _loc6_.pointInfo.addChild(_loc8_);
               }
            }
            _loc6_.y = _loc3_;
            pointList.addChild(_loc6_);
            _loc3_ += _loc6_.height;
            _loc4_++;
         }
         obf_k_v_1843.maxScrollPosition = 0;
         if(_loc3_ > obf_k_v_1843.height)
         {
            obf_k_v_1843.maxScrollPosition = _loc3_ - obf_k_v_1843.height;
         }
      }
      
      public function showChallengeRanking(param1:String, param2:Array) : void
      {
         var _loc3_:MapClearResultInfo = null;
         var _loc4_:RankingItem = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:DisplayObject = null;
         DiversityManager.setTextField(txtDeyRank,"RankingUI","txtRankMap");
         txtDeyJobName.text = "";
         DiversityManager.setTextField(txtInfoName,"RankingUI","type_time");
         pointList.scrollRect = new Rectangle(0,0,obf_k_v_1843.x - pointList.x,obf_k_v_1843.height);
         for each(_loc3_ in param2)
         {
            _loc4_ = new RankingItem();
            _loc4_.txtRank.text = WorldMapManager.getMapName(param1);
            _loc5_ = _loc3_.players.split(",");
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length)
            {
               _loc4_.txtPlayerName.htmlText = obf_7_6_4416.getRoleLinkA(_loc5_[_loc6_]);
               _loc6_++;
            }
            _loc7_ = this.getNewText();
            (_loc7_ as TextField).text = obf_l_y_733.getTimeStringHHMMSS(_loc3_.clearTimeInSec * 1000);
            if(_loc7_)
            {
               _loc4_.pointInfo.addChild(_loc7_);
            }
            _loc4_.y = this.obf_z_b_3034;
            pointList.addChild(_loc4_);
            this.obf_z_b_3034 += _loc4_.height;
         }
         if(this.obf_z_b_3034 > obf_k_v_1843.height)
         {
            obf_k_v_1843.maxScrollPosition = this.obf_z_b_3034 - obf_k_v_1843.height;
         }
      }
      
      private function showLocalArena(param1:int) : void
      {
         if(!GameContext.localPlayer || !GameContext.localPlayer.fullInfo || param1 != RankingListType.obf_k_Z_3393)
         {
            return;
         }
         DiversityManager.setTextField(obf_0_1_n_363.txtRank,"RankingUI","type_local");
         obf_0_1_n_363.txtPlayerName.htmlText = obf_7_6_4416.getRoleLinkA(GameContext.localPlayer.id);
         var _loc2_:DisplayObject = this.getNewText();
         DiversityManager.setTextField(_loc2_ as TextField,"ValuePrompt","chon",[GameContext.localPlayer.fullInfo.arenaIntegral],true);
         obf_0_1_n_363.pointInfo.addChild(_loc2_);
      }
      
      private function showLocalArmy(param1:int, param2:String) : void
      {
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:TextField = null;
         var _loc10_:String = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:Array = null;
         var _loc15_:int = 0;
         var _loc16_:TextField = null;
         var _loc17_:String = null;
         var _loc18_:int = 0;
         if(!GameContext.localPlayer.fullInfo.mapHonorValues)
         {
            return;
         }
         DiversityManager.setTextField(obf_0_1_n_363.txtRank,"RankingUI","type_local");
         obf_0_1_n_363.txtPlayerName.htmlText = obf_7_6_4416.getRoleLinkA(GameContext.localPlayer.id);
         if(param2 == RankingListType.getRankingTypeName(RankingListType.obf_J_I_1570))
         {
            _loc3_ = GameContext.localPlayer.fullInfo.mapHonorValues;
            if(!_loc3_)
            {
               return;
            }
            for each(_loc5_ in _loc3_)
            {
               _loc4_ += int(_loc5_);
            }
            obf_0_1_n_363.txtJobName.text = _loc4_ + "";
            _loc7_ = NumberConfig.getSettingObject("armyTitleValues") as Array;
            _loc8_ = 0;
            while(_loc8_ < _loc7_.length)
            {
               if(_loc7_[_loc8_] <= _loc4_)
               {
                  _loc6_ = _loc8_;
               }
               _loc8_++;
            }
            _loc9_ = this.getNewText();
            if(_loc6_ >= _loc7_.length - 1)
            {
               obf_0_1_n_363.txtJobName.textColor = 16319700;
               _loc9_.htmlText = "<FONT COLOR=\'#f904d4\'>" + JSONUtil.getStr(NumberConfig.getSettingObject("armyTitleNames"),[_loc6_]) + "</FONT>" + "(" + DiversityManager.getString("RankingUI","maxLv") + ")";
            }
            else
            {
               _loc10_ = JSONUtil.getStr(NumberConfig.getSettingObject("armyTitleNames"),[_loc6_ + 1]);
               _loc11_ = _loc7_[_loc6_ + 1] - _loc4_;
               obf_0_1_n_363.txtJobName.textColor = 2875923;
               _loc9_.htmlText = "<FONT COLOR=\'#2be213\'>" + JSONUtil.getStr(NumberConfig.getSettingObject("armyTitleNames"),[_loc6_]) + "</FONT>" + "(" + DiversityManager.getString("RankingUI","explain",[_loc10_,_loc11_]) + ")";
            }
            obf_0_1_n_363.pointInfo.addChild(_loc9_);
         }
         else
         {
            _loc12_ = int(GameContext.localPlayer.fullInfo.mapHonorValues[WorldMapManager.getMapId(param2)]);
            obf_0_1_n_363.txtJobName.text = _loc12_ + "";
            _loc14_ = NumberConfig.getSettingObject("mapHonorLevelValues") as Array;
            _loc15_ = 0;
            while(_loc15_ < _loc14_.length)
            {
               if(_loc14_[_loc15_] <= _loc12_)
               {
                  _loc13_ = _loc15_;
               }
               _loc15_++;
            }
            _loc16_ = this.getNewText();
            if(_loc13_ >= _loc14_.length - 1)
            {
               obf_0_1_n_363.txtJobName.textColor = 16319700;
               _loc16_.htmlText = "<FONT COLOR=\'#f904d4\'>" + JSONUtil.getStr(NumberConfig.getSettingObject("mapHonorLevelNames"),[_loc13_]) + "</FONT>" + "(" + DiversityManager.getString("RankingUI","maxLv") + ")";
            }
            else
            {
               _loc17_ = JSONUtil.getStr(NumberConfig.getSettingObject("mapHonorLevelNames"),[_loc13_ + 1]);
               _loc18_ = _loc14_[_loc13_ + 1] - _loc12_;
               obf_0_1_n_363.txtJobName.textColor = 2875923;
               _loc16_.htmlText = "<FONT COLOR=\'#2be213\'>" + JSONUtil.getStr(NumberConfig.getSettingObject("mapHonorLevelNames"),[_loc13_]) + "</FONT>" + "(" + DiversityManager.getString("RankingUI","explain",[_loc17_,_loc18_]) + ")";
            }
            obf_0_1_n_363.pointInfo.addChild(_loc16_);
         }
      }
      
      private function getInfoDisplay(param1:int, param2:RankingInfo, param3:int) : DisplayObject
      {
         var _loc4_:DisplayObject = null;
         var _loc5_:int = 0;
         if(param1 == RankingListType.ROLE_LEVEL)
         {
            _loc4_ = this.getNewText();
            DiversityManager.setTextField(_loc4_ as TextField,"ValuePrompt","playerLevel",[param2.value],true);
         }
         else if(param1 == RankingListType.PK_VALUE)
         {
            _loc4_ = this.getNewText();
            DiversityManager.setTextField(_loc4_ as TextField,"ValuePrompt","pkValue",[param2.value],true);
         }
         else if(param1 == RankingListType.GOLD)
         {
            _loc4_ = obf_a_f_2935.getGoldNotCopperDisplay(param2.value);
         }
         else if(param1 == RankingListType.obf_p_n_4458)
         {
            _loc4_ = this.getNewText();
            (_loc4_ as TextField).text = JSONUtil.getStr(NumberConfig.getSettingObject("honorLevelNames"),[param2.value]);
         }
         else if(param1 == RankingListType.obf_1_s_2043)
         {
            _loc4_ = this.getNewText();
            (_loc4_ as TextField).text = DiversityManager.getString("ValuePrompt","ladder",[param2.value]) + "-" + obf_l_y_733.getTimeStringSec(param2.value2);
         }
         else if(param1 == RankingListType.obf_k_Z_3393)
         {
            _loc4_ = this.getNewText();
            DiversityManager.setTextField(_loc4_ as TextField,"ValuePrompt","chon",[param2.value],true);
         }
         else if(param1 == RankingListType.obf_J_I_1570)
         {
            _loc4_ = this.getNewText(param3);
            (_loc4_ as TextField).text = JSONUtil.getStr(NumberConfig.getSettingObject("armyTitleNames"),[param2.value2]);
         }
         else if(param1 > 99)
         {
            _loc5_ = 0;
            while(_loc5_ < this.map_ArmyRank.length)
            {
               if(param1 == this.map_ArmyRank[_loc5_].id)
               {
                  _loc4_ = this.getNewText(param3);
                  (_loc4_ as TextField).text = JSONUtil.getStr(NumberConfig.getSettingObject("mapHonorLevelNames"),[param2.value2]);
                  break;
               }
               _loc5_++;
            }
         }
         return _loc4_;
      }
      
      private function getNewText(param1:int = 0) : TextField
      {
         var _loc2_:TextField = new TextField();
         if(param1 == 1)
         {
            _loc2_.textColor = 16319700;
         }
         else if(param1 == 2)
         {
            _loc2_.textColor = 2875923;
         }
         else if(param1 == 3)
         {
            _loc2_.textColor = 11005;
         }
         else
         {
            _loc2_.textColor = 16777215;
         }
         _loc2_.selectable = false;
         _loc2_.autoSize = TextFieldAutoSize.LEFT;
         _loc2_.mouseEnabled = false;
         _loc2_.width = txtInfoName.width;
         return _loc2_;
      }
      
      private function clearList() : void
      {
         var _loc1_:RankingItem = null;
         while(pointList.numChildren > 0)
         {
            _loc1_ = pointList.getChildAt(0) as RankingItem;
            pointList.removeChildAt(0);
            if(_loc1_)
            {
               _loc1_.destroy();
            }
         }
      }
      
      private function obf_A_9_4591() : void
      {
         if(obf_0_1_n_363.pointInfo.numChildren > 0)
         {
            obf_0_1_n_363.pointInfo.removeChildAt(0);
         }
         obf_0_1_n_363.txtRank.text = "";
         obf_0_1_n_363.txtPlayerName.text = "";
         obf_0_1_n_363.txtJobName.text = "";
         this.obf_z_b_3034 = 0;
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
         this.visible = true;
         if(this.tableCmdList.length > 0)
         {
            this.selectRankingType(this.tableCmdList[0].name);
         }
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this._npcId = "";
         this._npcMenuIndex = null;
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this.clearList();
      }
   }
}

