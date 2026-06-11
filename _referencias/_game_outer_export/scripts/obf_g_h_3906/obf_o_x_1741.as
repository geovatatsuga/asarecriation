package obf_g_h_3906
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.rpg.vacantSpace.VacantSpaceBallInfo;
   import com.sunweb.game.rpg.vacantSpace.obf_9_Y_4477;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.VacantSpaceUIMC;
   
   public class obf_o_x_1741 extends VacantSpaceUIMC implements IPlayerUI
   {
      
      private var obf_e_E_2344:Array;
      
      public var balls:Object;
      
      public function obf_o_x_1741()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         titleBox.mouseEnabled = false;
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            this["ball" + _loc1_].gotoAndStop(1);
            this["txtPer" + _loc1_].text = "0%";
            _loc1_++;
         }
         this.addListener();
      }
      
      public function initDiversity() : void
      {
         txtInfo.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("vacantSpaceUI","txtInfo") + "</a>";
         DiversityManager.setTextField(txtTitle,"vacantSpaceUI","txtTitle");
         DiversityManager.setTextField(txtAttrTitle,"vacantSpaceUI","txtAttrTitle");
         DiversityManager.setTextField(txtBallLevelTitle,"vacantSpaceUI","txtBallLevelTitle");
         DiversityManager.setTextField(txtBallAttrTitle,"vacantSpaceUI","txtBallAttrTitle");
      }
      
      private function addListener() : void
      {
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         obf_K_e_3075.addUIMouseToolTip(txtInfo,"vacantSpaceInfo");
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            this["ball" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.obf_G_Z_2746);
            this["ball" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.obf_X_V_1099);
            this["ball" + _loc1_].addEventListener(MouseEvent.CLICK,this.obf_0___x_697);
            _loc1_++;
         }
      }
      
      private function removeListener() : void
      {
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         obf_K_e_3075.removeUIMouseToolTip(txtInfo);
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            this["ball" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,this.obf_G_Z_2746);
            this["ball" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,this.obf_X_V_1099);
            this["ball" + _loc1_].removeEventListener(MouseEvent.CLICK,this.obf_0___x_697);
            _loc1_++;
         }
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
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
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
      
      public function obf_G_Z_2746(param1:Event) : void
      {
         var _loc2_:Object = null;
         if(param1.currentTarget == ball0)
         {
            _loc2_ = obf_9_Y_4477.getBallConfig(0);
         }
         else if(param1.currentTarget == ball1)
         {
            _loc2_ = obf_9_Y_4477.getBallConfig(1);
         }
         else if(param1.currentTarget == ball2)
         {
            _loc2_ = obf_9_Y_4477.getBallConfig(2);
         }
         else if(param1.currentTarget == ball3)
         {
            _loc2_ = obf_9_Y_4477.getBallConfig(3);
         }
         var _loc3_:String = _loc2_ == null ? "" : JSONUtil.getStr(_loc2_,["name"]);
         var _loc4_:GameTipUI = new GameTipUI("ballTip");
         var _loc5_:int = 150;
         _loc4_.addTipInfo("<P align=\'center\'><FONT color=\'#FFFF00\'>" + _loc3_ + "</FONT>",_loc5_,_loc4_.maxRow + 1);
         GameTipManager.showTip(_loc4_);
      }
      
      public function obf_X_V_1099(param1:Event) : void
      {
         GameTipManager.closeTip("ballTip");
      }
      
      public function obf_0___x_697(param1:Event) : void
      {
         if(obf_K_e_3075.vacantSpaceBallUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.vacantSpaceBallUI);
         }
         var _loc2_:VacantSpaceBallInfo = null;
         var _loc3_:int = 0;
         if(param1.currentTarget == ball0)
         {
            _loc3_ = 0;
         }
         else if(param1.currentTarget == ball1)
         {
            _loc3_ = 1;
         }
         else if(param1.currentTarget == ball2)
         {
            _loc3_ = 2;
         }
         else if(param1.currentTarget == ball3)
         {
            _loc3_ = 3;
         }
         if(!this.balls || !this.balls[_loc3_])
         {
            _loc2_ = new VacantSpaceBallInfo();
            _loc2_.index = _loc3_;
         }
         else
         {
            _loc2_ = this.balls[_loc3_];
         }
         obf_K_e_3075.vacantSpaceBallUI.index = _loc3_;
         obf_K_e_3075.vacantSpaceBallUI.ballInfo = _loc2_;
         obf_K_e_3075.vacantSpaceBallUI.refresh();
         param1.stopPropagation();
         obf_K_e_3075.showUI(obf_K_e_3075.vacantSpaceBallUI);
      }
      
      public function refresh() : void
      {
         var _loc2_:Object = null;
         var _loc3_:VacantSpaceBallInfo = null;
         var _loc4_:Object = null;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         if(!this.balls)
         {
            this.balls = new Object();
         }
         var _loc1_:int = 0;
         while(_loc1_ < obf_9_Y_4477.balls.length)
         {
            _loc2_ = obf_9_Y_4477.balls[_loc1_];
            if(_loc2_)
            {
               _loc3_ = this.balls[_loc1_];
               if(!_loc3_)
               {
                  _loc3_ = new VacantSpaceBallInfo();
                  _loc3_.index = _loc1_;
                  this.balls[_loc1_] = _loc3_;
               }
               _loc4_ = obf_9_Y_4477.ballLevels[_loc3_.level];
               if(_loc4_)
               {
                  this["txtBallName" + _loc1_].htmlText = _loc2_.name;
                  this["txtBallLevel" + _loc1_].htmlText = "lv." + _loc3_.level;
                  this["txtAttrType" + _loc1_].htmlText = RoleAttributesModifierEnum.getAttributesName(_loc2_.attrType);
                  this["txtAttrValue" + _loc1_].htmlText = _loc3_.attrValue + "/" + _loc4_.attrMax;
                  this["txtBallAttrType" + _loc1_].htmlText = RoleAttributesModifierEnum.getAttributesName(_loc2_.ballAttrType);
                  _loc5_ = Number(_loc4_.ballAttrMul);
                  if(!_loc5_)
                  {
                     _loc5_ = 0;
                  }
                  this["txtBallAttrValue" + _loc1_].htmlText = Math.round(_loc5_ * 100) + "%";
                  _loc6_ = Math.round(_loc3_.attrValue * 100 / _loc4_.attrMax);
                  this["ball" + _loc1_].gotoAndStop(_loc6_ + 1);
                  this["txtPer" + _loc1_].htmlText = _loc6_ + "%";
               }
            }
            _loc1_++;
         }
      }
   }
}

