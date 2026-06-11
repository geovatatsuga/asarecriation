package com.sunweb.game.rpg.playerUI.tower
{
   import obf_5_S_2387.obf_H_c_1383;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.netRole.obf_9_c_4534;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.action.obf_S_c_3330;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import gs.TweenLite;
   import gs.easing.Circ;
   import playerUI.ImageBice;
   import playerUI.ImageBlue;
   import playerUI.ImagePurple;
   import playerUI.ImageRed;
   import playerUI.ImageWhite;
   import playerUI.ImageYellow;
   import playerUI.TowerBoxUIMC;
   
   public class obf_9_y_2827 extends TowerBoxUIMC implements IPlayerUI
   {
      
      private var obf_i_F_838:obf_9_c_4534;
      
      private var obf_I_9_3338:Dictionary;
      
      private var obf_0_5_R_137:Dictionary;
      
      private var pearlRankObject:Dictionary;
      
      private var cmdObject:Dictionary;
      
      private var txtLvObject:Dictionary;
      
      private var obf_0_3_600:Dictionary;
      
      private var mouseTipMap:Dictionary;
      
      private var lvObject:Object;
      
      private var time:TimeLimiter;
      
      public function obf_9_y_2827()
      {
         var _loc1_:* = undefined;
         this.obf_0_3_600 = new Dictionary();
         this.mouseTipMap = new Dictionary();
         this.time = new TimeLimiter(500);
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         titleBox.mouseEnabled = false;
         barMC.gotoAndStop(1);
         this.obf_I_9_3338 = new Dictionary();
         this.obf_I_9_3338[cmdPearl0] = GameItemRank.NOMAL;
         this.obf_I_9_3338[cmdPearl1] = GameItemRank.MAGIC;
         this.obf_I_9_3338[cmdPearl2] = GameItemRank.FANTASY;
         this.obf_I_9_3338[cmdPearl3] = GameItemRank.LEGEND;
         this.obf_I_9_3338[cmdPearl4] = GameItemRank.EPIC;
         this.obf_I_9_3338[cmdPearl5] = GameItemRank.obf_f_l_943;
         this.obf_0_5_R_137 = new Dictionary();
         this.obf_0_5_R_137[GameItemRank.NOMAL] = cmdPearl0;
         this.obf_0_5_R_137[GameItemRank.MAGIC] = cmdPearl1;
         this.obf_0_5_R_137[GameItemRank.FANTASY] = cmdPearl2;
         this.obf_0_5_R_137[GameItemRank.LEGEND] = cmdPearl3;
         this.obf_0_5_R_137[GameItemRank.EPIC] = cmdPearl4;
         this.obf_0_5_R_137[GameItemRank.obf_f_l_943] = cmdPearl5;
         this.pearlRankObject = new Dictionary();
         this.pearlRankObject[GameItemRank.NOMAL] = new ImageWhite();
         this.pearlRankObject[GameItemRank.MAGIC] = new ImageBice();
         this.pearlRankObject[GameItemRank.FANTASY] = new ImageBlue();
         this.pearlRankObject[GameItemRank.LEGEND] = new ImageYellow();
         this.pearlRankObject[GameItemRank.EPIC] = new ImagePurple();
         this.pearlRankObject[GameItemRank.obf_f_l_943] = new ImageRed();
         this.cmdObject = new Dictionary();
         this.cmdObject[cmd1] = GameItemRank.NOMAL;
         this.cmdObject[cmd2] = GameItemRank.MAGIC;
         this.cmdObject[cmd3] = GameItemRank.FANTASY;
         this.cmdObject[cmd4] = GameItemRank.LEGEND;
         this.cmdObject[cmd5] = GameItemRank.EPIC;
         this.cmdObject[cmd6] = GameItemRank.obf_f_l_943;
         this.txtLvObject = new Dictionary();
         this.txtLvObject[GameItemRank.NOMAL] = txt1;
         this.txtLvObject[GameItemRank.MAGIC] = txt2;
         this.txtLvObject[GameItemRank.FANTASY] = txt3;
         this.txtLvObject[GameItemRank.LEGEND] = txt4;
         this.txtLvObject[GameItemRank.EPIC] = txt5;
         this.txtLvObject[GameItemRank.obf_f_l_943] = txt6;
         for(_loc1_ in this.obf_I_9_3338)
         {
            this.obf_0_3_600[_loc1_] = false;
         }
         this.obf_x_v_2806();
         txtAdvertScrollBar.update();
         txtAdvertScrollBar.visible = txtAdvertScrollBar.enabled;
      }
      
      private function obf_x_v_2806() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdEnter.addEventListener(MouseEvent.CLICK,this.obf_w_9_2494);
         for(_loc1_ in this.obf_I_9_3338)
         {
            this.addUIMouseToolTip(_loc1_,this.obf_I_9_3338[_loc1_]);
         }
         cmdEnter.addEventListener(MouseEvent.MOUSE_OVER,this.obf_G_k_3294);
         cmdEnter.addEventListener(MouseEvent.MOUSE_OUT,this.obf_6_b_2643);
         for(_loc2_ in this.cmdObject)
         {
            _loc2_.addEventListener(MouseEvent.CLICK,this.onClick);
         }
      }
      
      private function removerLsiten() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdEnter.removeEventListener(MouseEvent.CLICK,this.obf_w_9_2494);
         for(_loc1_ in this.obf_I_9_3338)
         {
            this.removeUIMouseToolTip(_loc1_);
         }
         cmdEnter.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_G_k_3294);
         cmdEnter.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_6_b_2643);
         for(_loc2_ in this.cmdObject)
         {
            _loc2_.removeEventListener(MouseEvent.CLICK,this.onClick);
         }
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
      
      private function onClick(param1:Event) : void
      {
         var _loc2_:int = int(this.cmdObject[param1.target]);
         if(GameContext.localPlayer.fullInfo.pearlNumMap[_loc2_ + ""] >= JSONUtil.getInt(obf_H_c_1383.getPearlObject(_loc2_),["maxLv"]))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("towerBoxUI","maxPearl"));
            return;
         }
         var _loc3_:Object = JSONUtil.getObject(obf_H_c_1383.getPearlObject(_loc2_),["items"]);
         if(!ConditionScript.checkCondition({"equalItemsInBag":_loc3_},null,true))
         {
            return;
         }
         obf_H_c_1383.sendTowerLvUp(_loc2_);
      }
      
      private function addUIMouseToolTip(param1:InteractiveObject, param2:int) : void
      {
         this.mouseTipMap[param1] = param2;
         param1.addEventListener(MouseEvent.MOUSE_OVER,this.obf_Z_l_1286);
         param1.addEventListener(MouseEvent.MOUSE_OUT,this.obf_0_6_9_109);
      }
      
      private function removeUIMouseToolTip(param1:InteractiveObject) : void
      {
         var mouseTipObj:InteractiveObject = param1;
         delete this.mouseTipMap[mouseTipObj];
         try
         {
            mouseTipObj.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_Z_l_1286);
            mouseTipObj.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_0_6_9_109);
         }
         catch(e:Error)
         {
         }
      }
      
      private function obf_Z_l_1286(param1:MouseEvent) : void
      {
         var _loc6_:String = null;
         var _loc2_:GameTipUI = new GameTipUI("TowerMouseTip");
         var _loc3_:int = 200;
         var _loc4_:String = "";
         var _loc5_:Object = JSONUtil.getObject(obf_H_c_1383.getPearlObject(this.mouseTipMap[param1.currentTarget]),["items"]);
         for(_loc6_ in _loc5_)
         {
            _loc4_ += GameItemManager.getItemName(_loc6_) + "x" + _loc5_[_loc6_] + "\n";
         }
         _loc2_.addTipInfo(DiversityManager.getString("towerBoxUI","mouseTip",[GameItemRank.getRankName(this.mouseTipMap[param1.currentTarget],true),JSONUtil.getInt(obf_H_c_1383.getPearlObject(this.mouseTipMap[param1.currentTarget]),["exp"]),GameContext.localPlayer.fullInfo.pearlNumMap[this.mouseTipMap[param1.currentTarget] + ""],JSONUtil.getInt(obf_H_c_1383.getPearlObject(this.mouseTipMap[param1.currentTarget]),["maxLv"]),_loc4_]),_loc3_,1);
         GameTipManager.showTip(_loc2_);
         this.obf_0_3_600[this.mouseTipMap[param1.currentTarget]] = true;
      }
      
      private function obf_0_6_9_109(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("TowerMouseTip");
         this.obf_0_3_600[this.mouseTipMap[param1.currentTarget]] = false;
      }
      
      private function obf_w_9_2494(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(!ConditionScript.checkCondition(obf_H_c_1383.obf_0___o_297,null,true))
         {
            return;
         }
         if(obf_H_c_1383.freeDayTimes < 1)
         {
            if(obf_H_c_1383.chargeDayTimes < 1)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("towerBoxUI","noTimes"));
               return;
            }
            _loc2_ = "";
            for(_loc3_ in obf_H_c_1383.chargeItems)
            {
               _loc4_ = "";
               if(obf_K_e_3075.playerBagUI.getEqualItemCount(_loc3_) > 0)
               {
                  _loc4_ = "00ff00";
               }
               else
               {
                  _loc4_ = "ff0000";
               }
               _loc2_ += "<font color=\'#" + _loc4_ + "\'>" + GameItemManager.getItemName(_loc3_) + "x" + obf_H_c_1383.chargeItems[_loc3_] + "</font>\n";
            }
            WindowManager.showConfirmBox(DiversityManager.getString("towerBoxUI","haveItems",[_loc2_]),this.obf_i_k_2402);
         }
         else
         {
            obf_H_c_1383.sendEnterTower();
            this.onClose(null);
         }
      }
      
      private function obf_G_k_3294(param1:MouseEvent) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("TowerTip");
         var _loc3_:int = 200;
         _loc2_.addTipInfo(DiversityManager.getString("towerBoxUI","enterTimes",[obf_H_c_1383.freeDayTimes,obf_H_c_1383.chargeDayTimes]),_loc3_,1);
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_6_b_2643(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("TowerTip");
      }
      
      private function obf_i_k_2402(param1:Object) : void
      {
         var _loc2_:String = null;
         if(param1.confirm)
         {
            for(_loc2_ in obf_H_c_1383.chargeItems)
            {
               if(obf_K_e_3075.playerBagUI.getEqualItemCount(_loc2_) < obf_H_c_1383.chargeItems[_loc2_])
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("towerBoxUI","noItems",[GameItemManager.getItemName(_loc2_)]));
                  return;
               }
            }
            obf_H_c_1383.sendEnterTower();
            this.onClose(null);
         }
      }
      
      public function showData(param1:int) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:* = undefined;
         var _loc9_:int = 0;
         this.obf_E_j_2700();
         var _loc2_:Object = obf_H_c_1383.getTowerObject(param1);
         if(!_loc2_)
         {
            return;
         }
         txtName.text = _loc2_.name;
         txtLv.text = _loc2_.level;
         this.obf_i_F_838 = new obf_9_c_4534(_loc2_.visualize);
         if(this.obf_i_F_838)
         {
            this.obf_i_F_838.x = 0;
            pointMC.addChild(this.obf_i_F_838);
            this.obf_i_F_838.doAction(obf_S_c_3330.obf_r_q_3113,0,true);
         }
         var _loc3_:String = "";
         for(_loc4_ in _loc2_.baseAttr)
         {
            _loc3_ += RoleAttributesModifierEnum.getAttributesName(int(_loc4_)) + ":\r";
         }
         txtAttr.text = _loc3_;
         _loc5_ = "";
         for(_loc6_ in _loc2_.baseAttr)
         {
            _loc5_ += "+" + _loc2_.baseAttr[_loc6_] + "\r";
         }
         txtAttrNum.text = _loc5_;
         obf_q_w_1805.text = param1 + "/" + obf_H_c_1383.allExp;
         _loc7_ = 100 * Number(param1 / obf_H_c_1383.allExp);
         if(_loc7_ < 1)
         {
            _loc7_ = 1;
         }
         barMC.gotoAndStop(_loc7_);
         this.lvObject = new Object();
         for(_loc8_ in this.txtLvObject)
         {
            _loc9_ = int(GameContext.localPlayer.fullInfo.pearlNumMap[_loc8_]);
            this.txtLvObject[_loc8_].text = DiversityManager.getString("towerBoxUI","pearlLv",[_loc9_]);
            this.lvObject[_loc8_] = _loc9_;
         }
      }
      
      public function get getTxtLvObject() : Object
      {
         return this.lvObject;
      }
      
      public function showEffect(param1:int, param2:int) : void
      {
         var _loc3_:MovieClip = this.pearlRankObject[param2] as MovieClip;
         if(!_loc3_)
         {
            return;
         }
         _loc3_.scaleX = 1;
         _loc3_.scaleY = 1;
         _loc3_.x = this.obf_0_5_R_137[param2].x;
         _loc3_.y = this.obf_0_5_R_137[param2].y;
         this.addChild(_loc3_);
         TweenLite.to(_loc3_,1,{
            "x":pointMC.x,
            "y":(pointMC.y - pointMC.height) / 2,
            "onComplete":this.obf_0_3_y_696,
            "onCompleteParams":[_loc3_],
            "ease":Circ.easeInOut,
            "scaleX":0.2,
            "scaleY":0.2
         });
      }
      
      private function obf_0_3_y_696(param1:MovieClip) : void
      {
         if(Boolean(param1) && this.contains(param1))
         {
            this.removeChild(param1);
            param1 = null;
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.time.checkTimeout() && Boolean(this.obf_i_F_838))
         {
            this.obf_i_F_838.onUpdate();
         }
      }
      
      private function obf_E_j_2700() : void
      {
         txtName.text = "";
         txtLv.text = "";
         txtAttr.text = "";
         obf_q_w_1805.text = "";
         while(pointMC.numChildren > 0)
         {
            pointMC.removeChildAt(0);
         }
         if(this.obf_i_F_838)
         {
            this.obf_i_F_838.destroy();
         }
         this.obf_i_F_838 = null;
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
         DiversityManager.setTextField(txtDeyTitle,"towerBoxUI","txtDeyTitle");
         DiversityManager.setTextField(txtDeyName,"towerBoxUI","txtDeyName");
         DiversityManager.setTextField(txtDeyLv,"towerBoxUI","txtDeyLv");
         DiversityManager.setTextField(txtDeyAttr,"towerBoxUI","txtDeyAttr");
         cmdEnter.label = DiversityManager.getString("towerBoxUI","cmdEnter");
         DiversityManager.setTextField(txtAdvert,"towerBoxUI","txtAdvert");
         cmd1.label = DiversityManager.getString("towerBoxUI","cmdLv");
         cmd2.label = DiversityManager.getString("towerBoxUI","cmdLv");
         cmd3.label = DiversityManager.getString("towerBoxUI","cmdLv");
         cmd4.label = DiversityManager.getString("towerBoxUI","cmdLv");
         cmd5.label = DiversityManager.getString("towerBoxUI","cmdLv");
         cmd6.label = DiversityManager.getString("towerBoxUI","cmdLv");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function destroy() : void
      {
         this.removerLsiten();
      }
   }
}

