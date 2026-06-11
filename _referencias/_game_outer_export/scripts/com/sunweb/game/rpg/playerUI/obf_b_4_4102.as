package com.sunweb.game.rpg.playerUI
{
   import obf_g_A_3629.ChatDecoder;
   import obf_g_A_3629.obf_g_u_3212;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.mate.MateRelationInfo;
   import com.sunweb.game.rpg.mate.MateRelationType;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.social.FriendInfo;
   import com.sunweb.game.rpg.social.FriendManager;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import fl.data.DataProvider;
   import fl.events.ScrollEvent;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import playerUI.FriendBoxUIMC;
   
   public class obf_b_4_4102 extends FriendBoxUIMC implements IPlayerUI
   {
      
      private var contentHeight:int;
      
      public function obf_b_4_4102()
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth - 300;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         titleBox.mouseEnabled = false;
         friendPoint.scrollRect = new Rectangle(0,0,scrollFriend.x - friendPoint.x,scrollFriend.height);
         scrollFriend.pageSize = scrollFriend.height;
         scrollFriend.minScrollPosition = 1;
         this.showBadPlayer(false);
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         txtDeyMatePlayer.mouseEnabled = false;
         txtDeyMatePlayer.text = DiversityManager.getString("FriendUI","txtMatePlayer");
         txtDeyRelation.mouseEnabled = false;
         txtDeyRelation.text = DiversityManager.getString("FriendUI","txtRelation");
         txtDeyQinMi.mouseEnabled = false;
         txtDeyQinMi.text = DiversityManager.getString("FriendUI","txtQinMi");
         DiversityManager.setTextField(txtDeyTitle,"FriendUI","txtTitle");
         DiversityManager.setTextField(txtDeyCouples,"FriendUI","txtCouples");
         DiversityManager.setTextField(txtDeyFriend,"FriendUI","txtFriend");
         cmdAddFriend.label = DiversityManager.getString("FriendUI","cmdAddFriend");
         DiversityManager.setTextField(badPlayerBox.txtDeyTitle,"FriendUI","badPlayer");
         badPlayerBox.cmdDel.label = DiversityManager.getString("FriendUI","cmdDelBadPlayer");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdAddFriend.addEventListener(MouseEvent.CLICK,this.onAddFriend);
         cmdBadPlayer.addEventListener(MouseEvent.CLICK,this.obf_0_5_Y_720);
         badPlayerBox.cmdDel.addEventListener(MouseEvent.CLICK,this.obf_R_g_1808);
         scrollFriend.addEventListener(ScrollEvent.SCROLL,this.obf_C_2_4260);
         inputAddFriendName.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_J_6_2780);
         inputAddFriendName.addEventListener(KeyboardEvent.KEY_UP,this.obf_J_6_2780);
         txtMate.addEventListener(TextEvent.LINK,this.obf_d_L_2886);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdAddFriend.removeEventListener(MouseEvent.CLICK,this.onAddFriend);
         cmdBadPlayer.removeEventListener(MouseEvent.CLICK,this.obf_0_5_Y_720);
         badPlayerBox.cmdDel.removeEventListener(MouseEvent.CLICK,this.obf_R_g_1808);
         scrollFriend.removeEventListener(ScrollEvent.SCROLL,this.obf_C_2_4260);
         inputAddFriendName.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_J_6_2780);
         inputAddFriendName.removeEventListener(KeyboardEvent.KEY_UP,this.obf_J_6_2780);
         txtMate.removeEventListener(TextEvent.LINK,this.obf_d_L_2886);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function obf_J_6_2780(param1:Event) : void
      {
         param1.stopPropagation();
      }
      
      private function obf_C_2_4260(param1:ScrollEvent) : void
      {
         friendPoint.scrollRect = new Rectangle(0,param1.position,scrollFriend.x - friendPoint.x,scrollFriend.height);
      }
      
      private function obf_d_L_2886(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      public function setMate(param1:MateRelationInfo) : void
      {
         this.obf_c_L_1167();
         if(param1)
         {
            txtMate.htmlText = obf_L_l_4100.isEmpty(param1.mateName) ? "" : ChatDecoder.decode(obf_g_u_3212.getRoleLinkCode(param1.mateName));
            txtRelation.text = param1.relationType != MateRelationType.NONE ? DiversityManager.getString("MatePrompt",param1.relationType + "") : "";
            txtQinMi.text = param1.mateValue + "";
         }
      }
      
      private function obf_c_L_1167() : void
      {
         txtMate.htmlText = "";
         txtRelation.text = "";
         txtQinMi.text = "";
      }
      
      private function showBadPlayer(param1:Boolean) : void
      {
         badPlayerBox.visible = param1;
         cmdBadPlayer.label = DiversityManager.getString("FriendUI","badPlayer") + (param1 ? "<<" : ">>");
      }
      
      public function setBadPlayerList(param1:Array) : void
      {
         badPlayerBox.listBadPlayer.dataProvider = new DataProvider(param1);
      }
      
      private function obf_0_5_Y_720(param1:Event) : void
      {
         this.showBadPlayer(!badPlayerBox.visible);
      }
      
      private function obf_R_g_1808(param1:Event) : void
      {
         if(!badPlayerBox.listBadPlayer.selectedItem)
         {
            return;
         }
         FriendManager.obf_G_1_4098(badPlayerBox.listBadPlayer.selectedItem.data);
      }
      
      private function onAddFriend(param1:Event) : void
      {
         if(inputAddFriendName.text == "")
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FriendUI","promptAddError_NoName"));
            return;
         }
         FriendManager.sendAddFriend(inputAddFriendName.text);
      }
      
      public function addAllFriend() : void
      {
         var _loc1_:FriendInfo = null;
         this.contentHeight = 0;
         for each(_loc1_ in FriendManager.friendList)
         {
            this.addFriend(_loc1_);
         }
         this.refreshFriendList();
      }
      
      public function addFriend(param1:FriendInfo) : void
      {
         if(friendPoint.getChildByName(param1.friendName) != null)
         {
            return;
         }
         var _loc2_:obf_f_N_4366 = new obf_f_N_4366(param1);
         _loc2_.name = param1.friendName;
         _loc2_.y = this.contentHeight;
         this.contentHeight += _loc2_.height;
         friendPoint.addChild(_loc2_);
      }
      
      public function removeFriend(param1:String) : void
      {
         var _loc2_:obf_f_N_4366 = friendPoint.getChildByName(param1) as obf_f_N_4366;
         if(!_loc2_)
         {
            return;
         }
         _loc2_.destroy();
         friendPoint.removeChild(_loc2_);
      }
      
      public function refreshFriend(param1:String) : void
      {
         var _loc2_:obf_f_N_4366 = friendPoint.getChildByName(param1) as obf_f_N_4366;
         if(!_loc2_)
         {
            return;
         }
         _loc2_.refresh();
      }
      
      public function refreshFriendList() : void
      {
         var _loc1_:FriendInfo = null;
         var _loc2_:FriendInfo = null;
         var _loc3_:obf_f_N_4366 = null;
         var _loc4_:obf_f_N_4366 = null;
         FriendManager.sortFriendList();
         this.contentHeight = 0;
         for each(_loc1_ in FriendManager.onlineFriendList)
         {
            _loc3_ = friendPoint.getChildByName(_loc1_.friendName) as obf_f_N_4366;
            if(_loc3_)
            {
               _loc3_.refresh();
               _loc3_.y = this.contentHeight;
               this.contentHeight += _loc3_.height;
            }
         }
         for each(_loc2_ in FriendManager.offlineFriendList)
         {
            _loc4_ = friendPoint.getChildByName(_loc2_.friendName) as obf_f_N_4366;
            if(_loc4_)
            {
               _loc4_.refresh();
               _loc4_.y = this.contentHeight;
               this.contentHeight += _loc4_.height;
            }
         }
         txtFriendCount.text = JSONUtil.getInt(FriendManager.onlineFriendList,["length"]) + "/" + (JSONUtil.getInt(FriendManager.onlineFriendList,["length"]) + JSONUtil.getInt(FriendManager.offlineFriendList,["length"]));
         if(this.contentHeight > scrollFriend.height)
         {
            if(friendPoint.scrollRect.y > this.contentHeight - scrollFriend.height)
            {
               friendPoint.scrollRect = new Rectangle(0,this.contentHeight - scrollFriend.height,scrollFriend.x - friendPoint.x,scrollFriend.height);
            }
            scrollFriend.maxScrollPosition = this.contentHeight - scrollFriend.height;
            scrollFriend.scrollPosition = friendPoint.scrollRect.y;
         }
         scrollFriend.visible = scrollFriend.enabled;
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      public function get mouseOn() : Boolean
      {
         var _loc1_:DisplayObject = badPlayerBox.visible ? this : bgBox;
         if(this.visible)
         {
            return _loc1_.getBounds(this).contains(this.mouseX,this.mouseY);
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
         var _loc1_:obf_f_N_4366 = null;
         while(friendPoint.numChildren > 0)
         {
            _loc1_ = friendPoint.getChildAt(0) as obf_f_N_4366;
            if(_loc1_)
            {
               _loc1_.destroy();
               friendPoint.removeChild(_loc1_);
            }
         }
         this.removeListener();
         this.obf_c_L_1167();
      }
   }
}

