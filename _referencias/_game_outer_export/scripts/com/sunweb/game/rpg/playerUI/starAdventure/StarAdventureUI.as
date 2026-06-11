package com.sunweb.game.rpg.playerUI.starAdventure
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.rpg.starAdventure.StarAdventureManager;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextFormat;
   import playerUI.StarAdventureUIMC;
   
   public class StarAdventureUI extends StarAdventureUIMC implements IPlayerUI
   {
      
      private var obf_F_n_4581:int = 0;
      
      private var obf_1_N_826:int;
      
      private var maxStarsNum:int;
      
      private var showMessageList:Array = new Array();
      
      public function StarAdventureUI()
      {
         super();
         this.initDiversity();
         txtDeyTitle.mouseEnabled = false;
         titleBox.mouseEnabled = false;
         bgBox2.mouseEnabled = false;
         this.visible = false;
         this.onResize(null);
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.underline = true;
         txtExplain.setTextFormat(_loc1_);
         obf_9_h_1529.gotoAndStop(1);
         this.addListener();
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         txtAdventureExplain.addEventListener(TextEvent.LINK,this.onClickLink);
         cmdUp.addEventListener(MouseEvent.CLICK,this.obf_e_s_3253);
         cmdAdventure.addEventListener(MouseEvent.CLICK,this.obf_G_z_1773);
         obf_K_e_3075.addUIMouseToolTip(txtExplain,"txtStarAdventureUIExplain");
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         txtAdventureExplain.removeEventListener(TextEvent.LINK,this.onClickLink);
         cmdUp.removeEventListener(MouseEvent.CLICK,this.obf_e_s_3253);
         cmdAdventure.removeEventListener(MouseEvent.CLICK,this.obf_G_z_1773);
         obf_K_e_3075.removeUIMouseToolTip(txtExplain);
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
      
      private function onClickLink(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      private function obf_e_s_3253(param1:Event) : void
      {
         if(this.obf_F_n_4581 < 1)
         {
            return;
         }
         if(this.obf_1_N_826 < this.maxStarsNum)
         {
            WindowManager.showMessageBox(DiversityManager.getString("StarAdventureUI","warn_UpCond"));
            return;
         }
         StarAdventureManager.sendStarsUpReq();
      }
      
      private function obf_G_z_1773(param1:Event) : void
      {
         var _loc3_:String = null;
         if(this.obf_F_n_4581 < 1)
         {
            return;
         }
         if(!obf_K_e_3075.playerBagUI.haveEmptyBag(1))
         {
            WindowManager.showMessageBox(DiversityManager.getString("CommonPrompt","playerBagFull"));
            return;
         }
         var _loc2_:Object = StarAdventureManager.starAdventureItems;
         for(_loc3_ in _loc2_)
         {
            if(obf_K_e_3075.playerBagUI.getEqualItemCount(_loc3_) < _loc2_[_loc3_])
            {
               WindowManager.showMessageBox(DiversityManager.getString("StarAdventureUI","warn_NoMoreMaterial",[GameItemManager.getItemName(_loc3_),_loc2_[_loc3_]]));
               return;
            }
         }
         StarAdventureManager.sendStarsAdvReq();
      }
      
      public function getStarAdventureLevel() : int
      {
         return this.obf_F_n_4581;
      }
      
      public function showStarAdvInfo(param1:int, param2:int) : void
      {
         var _loc8_:* = undefined;
         var _loc9_:int = 0;
         this.obf_F_n_4581 = param1;
         txtStarName.text = "";
         txtStarCond.text = "";
         txtAttrsName.text = "";
         txtAttribute.text = "";
         var _loc3_:Array = StarAdventureManager.starChartLevels;
         if(param1 < 1 || param1 > _loc3_.length)
         {
            return;
         }
         this.obf_1_N_826 = param2;
         DiversityManager.setTextField(txtStar,"StarAdventureUI","txtStar",[param2]);
         var _loc4_:Object = _loc3_[param1 - 1];
         txtStarName.htmlText = _loc4_.name;
         if(param1 < _loc3_.length)
         {
            DiversityManager.setTextField(txtStarCond,"StarAdventureUI","txtStarCond",[_loc4_.upNeedStars]);
            this.maxStarsNum = _loc4_.upNeedStars;
            _loc9_ = param2 / this.maxStarsNum * 100;
            if(_loc9_ < 1)
            {
               _loc9_ = 1;
            }
            obf_9_h_1529.gotoAndStop(_loc9_);
         }
         else
         {
            obf_9_h_1529.gotoAndStop(100);
            cmdUp.enabled = false;
            DiversityManager.setTextField(txtStarCond,"StarAdventureUI","txtMaxStarCond");
         }
         var _loc5_:String = "";
         var _loc6_:String = "";
         var _loc7_:Object = _loc4_.attr;
         for(_loc8_ in _loc7_)
         {
            _loc5_ += RoleAttributesModifierEnum.getAttributesName(_loc8_) + "\n";
            _loc6_ += RoleAttributesModifierEnum.getAttributesValueString(_loc8_,_loc7_[_loc8_]) + "\n";
         }
         txtAttrsName.text += _loc5_;
         txtAttribute.text += _loc6_;
      }
      
      private function getMessage() : void
      {
         if(!GameContext.userConfig.sst)
         {
            GameContext.userConfig.sst = new Object();
            GameContext.saveConfigNow();
         }
         if(!GameContext.userConfig.sst.hasOwnProperty("starAdventure"))
         {
            GameContext.userConfig.sst.starAdventure = [];
            GameContext.saveConfigNow();
         }
         this.showMessageList = GameContext.userConfig.sst.starAdventure;
      }
      
      public function showMsg(param1:Object) : void
      {
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         this.getMessage();
         var _loc2_:Object = StarAdventureManager.starAdventure;
         for(_loc3_ in param1)
         {
            if(!obf_L_l_4100.isEmpty(_loc3_))
            {
               _loc5_ = "";
               _loc6_ = 1;
               while(_loc6_ < 7)
               {
                  _loc7_ = _loc2_["text_" + _loc6_];
                  _loc8_ = int(_loc7_.length);
                  _loc9_ = "";
                  _loc5_ += _loc7_[Math.floor(Math.random() * _loc8_)].text;
                  _loc5_ = _loc5_.replace("_%0_",obf_7_6_4416.getItemLinkA(_loc3_,"") + "x" + param1[_loc3_]);
                  _loc6_++;
               }
               break;
            }
         }
         this.showMessageList.push(_loc5_);
         if(this.showMessageList.length > 10)
         {
            this.showMessageList.shift();
         }
         txtAdventureExplain.htmlText = "";
         var _loc4_:int = 0;
         while(_loc4_ < this.showMessageList.length)
         {
            txtAdventureExplain.htmlText += "<font color=\'#00FF00\'>" + obf_K_e_3075.smallMapUI.serverDate + " " + obf_K_e_3075.smallMapUI.serverTime + "</font>" + ":" + GameContext.localPlayer.fullInfo.name + this.showMessageList[_loc4_] + "\n";
            _loc4_++;
         }
         txtAdventureExplain.scrollV = int.MAX_VALUE;
         obf_2_E_3095.update();
         GameContext.userConfig.sst.starAdventure = this.showMessageList;
         GameContext.saveConfigNow();
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
         DiversityManager.setTextField(txtDeyTitle,"StarAdventureUI","txtDeyTitle");
         DiversityManager.setTextField(txtAtrrs,"StarAdventureUI","txtAtrrs");
         DiversityManager.setTextField(txtAdventure,"StarAdventureUI","txtAdventure");
         txtExplain.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("StarAdventureUI","txtExplain") + "</a>";
         DiversityManager.setTextField(txtStar,"StarAdventureUI","txtStar",[0]);
         cmdUp.label = DiversityManager.getString("StarAdventureUI","cmdUp");
         cmdAdventure.label = DiversityManager.getString("StarAdventureUI","cmdAdventure");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.getMessage();
         txtAdventureExplain.htmlText = "";
         var _loc1_:int = 0;
         while(_loc1_ < this.showMessageList.length)
         {
            txtAdventureExplain.htmlText += "<font color=\'#00FF00\'>" + obf_K_e_3075.smallMapUI.serverDate + " " + obf_K_e_3075.smallMapUI.serverTime + "</font>" + ":" + GameContext.localPlayer.fullInfo.name + this.showMessageList[_loc1_] + "\n";
            _loc1_++;
         }
         txtAdventureExplain.scrollV = int.MAX_VALUE;
         obf_2_E_3095.update();
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

