package com.sunweb.game.rpg.playerUI.playerInfo
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.buff.BuffManager;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.netRole.obf_n_u_l_l_2508;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.utils.JSONUtil;
   import fl.data.DataProvider;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.PlayerTitleUIMC;
   
   public class PlayerTitleUI extends PlayerTitleUIMC implements IPlayerUI
   {
      
      private var titleTypeButtons:Array;
      
      private var obf_A_v_2727:String;
      
      public function PlayerTitleUI()
      {
         var _loc2_:String = null;
         var _loc3_:TableButton = null;
         var _loc4_:TableButton = null;
         super();
         this.initDiversity();
         titleBox.mouseEnabled = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         listTitle.labelFunction = this.titleListLableFun;
         this.titleTypeButtons = new Array();
         var _loc1_:Array = obf_n_u_l_l_2508.getTitleType();
         for each(_loc2_ in _loc1_)
         {
            _loc4_ = new TableButton();
            _loc4_.name = _loc2_;
            _loc4_.width = 100;
            _loc4_.txtLabel.text = _loc2_;
            _loc4_.x = pointType.width;
            pointType.addChild(_loc4_);
            this.titleTypeButtons.push(_loc4_);
         }
         _loc3_ = new TableButton();
         _loc3_.name = "";
         DiversityManager.setTextField(_loc3_.txtLabel,"TitleUI","type_Other",null,true);
         _loc3_.x = pointType.width;
         pointType.addChild(_loc3_);
         this.titleTypeButtons.push(_loc3_);
         this.selectTitleType(JSONUtil.getStr(_loc1_,[0]));
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"TitleUI","txtTitle");
         DiversityManager.setTextField(txtDeyCurrentTitle,"TitleUI","txtCurrentTitle");
         DiversityManager.setTextField(txtDeyCurrentKitTitle,"TitleUI","txtCurrentKitTitle");
         cmdUseTitle.label = DiversityManager.getString("TitleUI","cmdUseTitle");
         cmdUseKitTitle.label = DiversityManager.getString("TitleUI","cmdUseKitTitle");
      }
      
      private function addListener() : void
      {
         var _loc1_:TableButton = null;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdUseTitle.addEventListener(MouseEvent.CLICK,this.obf_X_b_2063);
         cmdUseKitTitle.addEventListener(MouseEvent.CLICK,this.obf_z_p_4120);
         listTitle.addEventListener(Event.CHANGE,this.obf_j_q_2272);
         for each(_loc1_ in this.titleTypeButtons)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.obf_P_J_2440);
         }
      }
      
      private function removeListener() : void
      {
         var _loc1_:TableButton = null;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdUseTitle.removeEventListener(MouseEvent.CLICK,this.obf_X_b_2063);
         cmdUseKitTitle.removeEventListener(MouseEvent.CLICK,this.obf_z_p_4120);
         listTitle.removeEventListener(Event.CHANGE,this.obf_j_q_2272);
         for each(_loc1_ in this.titleTypeButtons)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.obf_P_J_2440);
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
      
      private function obf_X_b_2063(param1:Event) : void
      {
         if(!listTitle.selectedItem)
         {
            return;
         }
         GameContext.localPlayer.sendTitleChange(listTitle.selectedItem.titleIndex);
      }
      
      private function obf_z_p_4120(param1:Event) : void
      {
         if(!listTitle.selectedItem)
         {
            return;
         }
         GameContext.localPlayer.sendKitTitleChange(listTitle.selectedItem.titleIndex);
      }
      
      private function obf_j_q_2272(param1:Event) : void
      {
         var _loc3_:Object = null;
         var _loc2_:Object = listTitle.selectedItem;
         txtTitleAttribute.text = "";
         if(_loc2_)
         {
            _loc3_ = BuffManager.getBuffConfigById(_loc2_.titleBuffId);
            if(_loc3_)
            {
               txtTitleAttribute.htmlText = JSONUtil.getStr(_loc3_,["buffDetail"]);
            }
         }
      }
      
      private function obf_P_J_2440(param1:Event) : void
      {
         this.selectTitleType(param1.currentTarget.name);
      }
      
      private function titleListLableFun(param1:Object) : String
      {
         return JSONUtil.getStr(param1,["titleName"]);
      }
      
      private function selectTitleType(param1:String) : void
      {
         var _loc2_:TableButton = null;
         var _loc3_:Array = null;
         if(param1 == null)
         {
            param1 = "";
         }
         this.obf_A_v_2727 = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         for each(_loc2_ in this.titleTypeButtons)
         {
            _loc2_.gotoAndStop(_loc2_.name == param1 ? 2 : 1);
         }
         _loc3_ = obf_n_u_l_l_2508.getPlayerHasTitlesByType(param1);
         _loc3_.push({
            "titleIndex":0,
            "titleName":DiversityManager.getString("CommonPrompt","null")
         });
         listTitle.dataProvider = new DataProvider(_loc3_);
      }
      
      public function obf_s_w_i_t_c_h_41() : void
      {
         this.selectTitleType(this.obf_A_v_2727);
      }
      
      public function obf_B_J_3258() : void
      {
         var _loc2_:Object = null;
         if(GameContext.localPlayer)
         {
            obf_K_e_3075.playerFullInfoUI.txtPlayerTitle.text = obf_n_u_l_l_2508.getPlayerTitleName(GameContext.localPlayer.fullInfo.titleIndex);
            txtCurrentTitle.text = obf_n_u_l_l_2508.getPlayerTitleName(GameContext.localPlayer.fullInfo.titleIndex);
            txtCurrentKitTitle.text = obf_n_u_l_l_2508.getPlayerTitleName(GameContext.localPlayer.fullInfo.kitTitleIndex);
         }
         var _loc1_:Object = listTitle.selectedItem;
         txtTitleAttribute.text = "";
         if(_loc1_)
         {
            _loc2_ = BuffManager.getBuffConfigById(_loc1_.titleBuffId);
            if(_loc2_)
            {
               txtTitleAttribute.htmlText = JSONUtil.getStr(_loc2_,["buffDetail"]);
            }
         }
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return bgBox.getBounds(bgBox).contains(bgBox.mouseX,bgBox.mouseY);
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

