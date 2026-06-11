package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.playerUI.managers.VersionConfig;
   import com.sunweb.game.rpg.settingConfig.NumberConfig;
   import com.sunweb.game.rpg.social.FriendInfo;
   import com.sunweb.game.rpg.social.FriendManager;
   import com.sunweb.game.rpg.world.ui.obf_X_Z_4427;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import playerUI.FriendBoxCellMC;
   
   public class obf_f_N_4366 extends FriendBoxCellMC
   {
      
      private var obf_s_V_1677:FriendInfo;
      
      public function obf_f_N_4366(param1:FriendInfo)
      {
         super();
         this.initDiversity();
         this.obf_s_V_1677 = param1;
         this.refresh();
         this.addListener();
         txtSendGift.visible = VersionConfig.enableFriendGift;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         txtSendGift.text = DiversityManager.getString("FriendUI","txtGiveGift");
      }
      
      private function addListener() : void
      {
         this.addEventListener(MouseEvent.CLICK,this.onClick);
         txtSendGift.addEventListener(MouseEvent.CLICK,this.onClickSendGift);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(MouseEvent.CLICK,this.onClick);
         txtSendGift.removeEventListener(MouseEvent.CLICK,this.onClickSendGift);
      }
      
      private function onClickSendGift(param1:Event) : void
      {
         if(!this.obf_s_V_1677)
         {
            return;
         }
         FriendManager.sendGift(this.obf_s_V_1677.friendName);
         param1.stopPropagation();
      }
      
      public function refresh() : void
      {
         var _loc2_:DisplayObject = null;
         if(!this.obf_s_V_1677)
         {
            return;
         }
         sexIcon.gotoAndStop(this.obf_s_V_1677.sex == 1 ? 1 : 2);
         txtLevel.text = this.obf_s_V_1677.level + "";
         txtName.text = this.obf_s_V_1677.friendName;
         txtRelValue.text = this.obf_s_V_1677.relationValue + "";
         txtRelLevel.text = FriendManager.getFriendRelLevelName(FriendManager.getFriendRelLevel(this.obf_s_V_1677.relationValue));
         var _loc1_:int = this.obf_s_V_1677.sex == 0 ? 16751001 : 10066431;
         txtName.textColor = this.obf_s_V_1677.isOnline ? uint(_loc1_) : 6710886;
         txtRelLevel.textColor = this.obf_s_V_1677.isOnline ? 16777215 : 6710886;
         while(moodPoint.numChildren > 0)
         {
            moodPoint.removeChildAt(0);
         }
         if(this.obf_s_V_1677.isOnline)
         {
            _loc2_ = GameItemManager.getItemIcon(JSONUtil.getStr(NumberConfig.getSettingObject("relMoodItems"),[this.obf_s_V_1677.moodIndex + ""]));
            if(_loc2_)
            {
               moodPoint.addChild(_loc2_);
            }
         }
      }
      
      private function onClick(param1:Event) : void
      {
         obf_X_Z_4427.showFriendMenu(this.obf_s_V_1677,this.localToGlobal(new Point(this.mouseX,this.mouseY)));
      }
      
      public function destroy() : void
      {
         this.obf_s_V_1677 = null;
         this.removeListener();
      }
   }
}

