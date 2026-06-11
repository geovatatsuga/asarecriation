package com.sunweb.game.rpg.playerUI.activity
{
   import obf_a_F_1055.obf_b_p_3604;
   import obf_g_A_3629.ChatDecoder;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.activity.obf_J_F_3431;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import fl.events.ScrollEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import playerUI.ActivityUIMC;
   
   public class ActivityUI extends ActivityUIMC implements IPlayerUI
   {
      
      private var typeTableCmds:Array;
      
      private var obf_r_l_2445:String;
      
      public var nameStr:String = "";
      
      public function ActivityUI()
      {
         var _loc2_:String = null;
         var _loc3_:TableButton = null;
         super();
         this.cacheAsBitmap = true;
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         titleBox.mouseEnabled = false;
         obf_h_I_782.pageSize = obf_h_I_782.height;
         this.typeTableCmds = new Array();
         var _loc1_:Array = obf_J_F_3431.getTypeList();
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = new TableButton();
            _loc3_.width = 75;
            _loc3_.txtLabel.text = _loc2_;
            _loc3_.name = _loc2_;
            _loc3_.gotoAndStop(1);
            _loc3_.x = pointType.width;
            pointType.addChild(_loc3_);
            this.typeTableCmds.push(_loc3_);
         }
         this.obf_r_l_2445 = JSONUtil.getStr(_loc1_,[0]);
         this.obf_2_c_2782();
         this.addListener();
         this.refreshList();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"ActivityUI","txtTitle");
         DiversityManager.setTextField(txtDeyActDate,"ActivityUI","txtActDate");
         DiversityManager.setTextField(txtDeyActName,"ActivityUI","txtActName");
         DiversityManager.setTextField(txtDeyActLevel,"ActivityUI","txtActLevel");
         DiversityManager.setTextField(txtDeyActTimes,"ActivityUI","txtActTimes");
         DiversityManager.setTextField(txtDeyActStatus,"ActivityUI","txtActStatus");
         DiversityManager.setTextField(txtDeyActNpc,"ActivityUI","txtActNpc");
         DiversityManager.setTextField(txtDeyActTime,"ActivityUI","txtActTime");
         DiversityManager.setTextField(txtDeyActDate2,"ActivityUI","txtActDate2");
      }
      
      private function addListener() : void
      {
         var _loc1_:TableButton = null;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         obf_h_I_782.addEventListener(ScrollEvent.SCROLL,this.obf_f_f_3217);
         txtActNpc.addEventListener(TextEvent.LINK,this.onClickLink);
         txtInfo.addEventListener(TextEvent.LINK,this.onClickLink);
         for each(_loc1_ in this.typeTableCmds)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.obf_J_C_3711);
         }
      }
      
      private function removeListener() : void
      {
         var _loc1_:TableButton = null;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         obf_h_I_782.removeEventListener(ScrollEvent.SCROLL,this.obf_f_f_3217);
         txtActNpc.removeEventListener(TextEvent.LINK,this.onClickLink);
         txtInfo.removeEventListener(TextEvent.LINK,this.onClickLink);
         for each(_loc1_ in this.typeTableCmds)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.obf_J_C_3711);
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
      
      private function onClickLink(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      private function obf_f_f_3217(param1:Event) : void
      {
         pointActivity.scrollRect = new Rectangle(0,obf_h_I_782.scrollPosition,obf_h_I_782.x - pointActivity.x,obf_h_I_782.height);
      }
      
      private function obf_w_j_2452(param1:Event) : void
      {
         this.showActContent(param1.currentTarget.actCode);
      }
      
      private function obf_J_C_3711(param1:Event) : void
      {
         if(param1.currentTarget.name != this.obf_r_l_2445)
         {
            this.obf_r_l_2445 = param1.currentTarget.name;
            this.obf_2_c_2782();
            this.refreshList();
         }
      }
      
      private function obf_2_c_2782() : void
      {
         var _loc1_:TableButton = null;
         for each(_loc1_ in this.typeTableCmds)
         {
            _loc1_.gotoAndStop(_loc1_.name == this.obf_r_l_2445 ? 2 : 1);
         }
      }
      
      public function refreshList() : void
      {
         var _loc3_:Object = null;
         var _loc4_:obf_6_C_2385 = null;
         this.clearList();
         this.obf_0_5_w_673();
         pointActivity.scrollRect = new Rectangle(0,0,obf_h_I_782.x - pointActivity.x,obf_h_I_782.height);
         var _loc1_:int = 0;
         var _loc2_:Array = obf_J_F_3431.getTypeConfig(this.obf_r_l_2445);
         for each(_loc3_ in _loc2_)
         {
            if(!(!_loc3_ || JSONUtil.getBoolean(_loc3_,["isDisabled"]) || !JSONUtil.getBoolean(_loc3_,["showInList"])))
            {
               _loc4_ = new obf_6_C_2385(_loc3_);
               _loc4_.y = _loc1_;
               pointActivity.addChild(_loc4_);
               _loc4_.addEventListener(MouseEvent.CLICK,this.obf_w_j_2452);
               _loc1_ += _loc4_.height;
            }
         }
         if(_loc1_ > obf_h_I_782.height)
         {
            obf_h_I_782.maxScrollPosition = _loc1_ - obf_h_I_782.height;
         }
      }
      
      public function clearList() : void
      {
         var actBox:obf_6_C_2385 = null;
         while(pointActivity.numChildren > 0)
         {
            actBox = pointActivity.getChildAt(0) as obf_6_C_2385;
            try
            {
               actBox.removeEventListener(MouseEvent.CLICK,this.obf_w_j_2452);
            }
            catch(e:Error)
            {
            }
            if(actBox)
            {
               actBox.destroy();
            }
            pointActivity.removeChildAt(0);
         }
      }
      
      public function showActContent(param1:String) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc2_:Object = obf_J_F_3431.getActConfig(param1);
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:String = "";
         for each(_loc4_ in _loc2_.listNpc)
         {
            _loc6_ = _loc4_.split("@");
            if(!obf_L_l_4100.isEmpty(_loc3_))
            {
               _loc3_ += "、";
            }
            _loc3_ += obf_7_6_4416.getNpcLinkA(obf_b_p_3604.getNpcFullBriefName(_loc4_),_loc6_[1],_loc6_[0]);
         }
         txtActNpc.htmlText = _loc3_;
         txtActTime.text = JSONUtil.getStr(_loc2_,["listTime"],DiversityManager.getString("ActivityUI","actNoTimeLimit"));
         _loc5_ = "";
         if(_loc2_.dayLimitInWeek)
         {
            _loc5_ += DiversityManager.getString("ActivityUI","actDateWeek") + _loc2_.dayLimitInWeek.join("、");
         }
         if(_loc2_.dateLimit)
         {
            _loc5_ += "\n" + _loc2_.dateLimit.join("、");
         }
         if(obf_L_l_4100.isEmpty(_loc5_))
         {
            _loc5_ = DiversityManager.getString("ActivityUI","actNoTimeLimit");
         }
         txtActDate.text = _loc5_;
         txtInfo.htmlText = ChatDecoder.decode(obf_K_e_3075.getSwitchString(_loc2_.listDetail));
         obf_h_o_2384.update();
      }
      
      public function obf_0_5_w_673() : void
      {
         txtActNpc.htmlText = "";
         txtActTime.text = "";
         txtActDate.text = "";
         txtInfo.htmlText = "";
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
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this.clearList();
      }
   }
}

