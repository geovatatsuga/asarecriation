package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.family.obf_F_9_1495;
   import com.sunweb.game.rpg.family.obf_Q_D_1342;
   import com.sunweb.game.rpg.map.MapInteractiveObject;
   import com.sunweb.game.rpg.netRole.RemotePlayer;
   import com.sunweb.game.rpg.netRole.obf_1_R_3404;
   import com.sunweb.game.rpg.netRole.obf_9_c_4534;
   import com.sunweb.game.rpg.netRole.obf_T_L_801;
   import com.sunweb.game.rpg.playerUI.managers.VersionConfig;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.obf_0_Y_3475;
   import com.sunweb.game.rpg.social.FriendManager;
   import com.sunweb.game.rpg.team.TeamManager;
   import com.sunweb.game.rpg.trade.obf_G_0_3203;
   import com.sunweb.game.rpg.world.MonsterInfoUtil;
   import com.sunweb.game.rpg.world.MonsterSpecies;
   import com.sunweb.game.rpg.world.obf_2_V_3982;
   import com.sunweb.game.ui.HeadIconCode;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import playerUI.TargetInfoUIMC;
   
   public class TargetInfoUI extends TargetInfoUIMC implements IPlayerUI
   {
      
      private var obf_z_S_3535:BuffUI;
      
      private var _debuffUI:BuffUI;
      
      private var obf_i_x_1126:String;
      
      public function TargetInfoUI()
      {
         super();
         hpBar.gotoAndStop(100);
         mpBar.gotoAndStop(100);
         this.visible = false;
         this.obf_z_S_3535 = new BuffUI(true);
         buffPoint.addChild(this.obf_z_S_3535);
         this._debuffUI = new BuffUI(true);
         this._debuffUI.y = 18;
         buffPoint.addChild(this._debuffUI);
         this.addListener();
         this.x = GameContext.gameStage.stageWidth / 2;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
      }
      
      public function get buffUI() : BuffUI
      {
         return this.obf_z_S_3535;
      }
      
      public function get debuffUI() : BuffUI
      {
         return this._debuffUI;
      }
      
      public function get targetId() : String
      {
         return this.obf_i_x_1126;
      }
      
      private function addListener() : void
      {
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         this.addEventListener(MouseEvent.CLICK,this.onClickTarget);
      }
      
      private function removeListener() : void
      {
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         this.removeEventListener(MouseEvent.CLICK,this.onClickTarget);
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth / 2;
      }
      
      private function onClickTarget(param1:MouseEvent) : void
      {
         var _loc2_:RemotePlayer = null;
         var _loc3_:PlayerMenuUI = null;
         var _loc4_:Point = null;
         if(GameContext.localPlayer.obf_0_6_a_430 != null && GameContext.localPlayer.obf_0_6_a_430 is RemotePlayer)
         {
            _loc2_ = GameContext.localPlayer.obf_0_6_a_430 as RemotePlayer;
            _loc3_ = new PlayerMenuUI("targetPlayer",160);
            _loc3_.addMenuItemByObject([{
               "id":"whisper",
               "value":{
                  "label":DiversityManager.getString("MenuUI","whisper"),
                  "fun":obf_K_e_3075.obf_e_q_2572.whisper,
                  "par":[_loc2_.id]
               }
            },{
               "id":"trade",
               "value":{
                  "label":DiversityManager.getString("MenuUI","trade"),
                  "fun":obf_G_0_3203.tradeToPlayer,
                  "par":[_loc2_.id]
               }
            },{
               "id":"addFriend",
               "value":{
                  "label":DiversityManager.getString("MenuUI","addFriend"),
                  "fun":FriendManager.sendAddFriend,
                  "par":[_loc2_.id]
               }
            },{
               "id":"inviteFamily",
               "value":{
                  "label":DiversityManager.getString("MenuUI","familyInvite"),
                  "fun":obf_F_9_1495.sendInviteFamily,
                  "par":[_loc2_.id]
               }
            },{
               "id":"ride",
               "value":{
                  "label":DiversityManager.getString("MenuUI","ride"),
                  "fun":null,
                  "par":null
               }
            },{
               "id":"team",
               "value":{
                  "label":DiversityManager.getString("MenuUI","inviteTeam"),
                  "fun":TeamManager.sendAutoInvite,
                  "par":[_loc2_.id]
               }
            },{
               "id":"badPlayer",
               "value":{
                  "label":DiversityManager.getString("MenuUI","addBadPlayer"),
                  "fun":FriendManager.addBadPlayer,
                  "par":[_loc2_.id]
               }
            },{
               "id":"viewPlayer",
               "value":{
                  "label":DiversityManager.getString("MenuUI","viewPlayer"),
                  "fun":GameContext.localPlayer.sendViewRemote,
                  "par":[_loc2_.id]
               }
            }]);
            if(_loc2_.obf_I_0_1698.teamName != "" && TeamManager.obf_r_f_4011 == "")
            {
               DiversityManager.setTextField(_loc3_.getMenuItem("team").txtItemLabel,"MenuUI","joinTeam",null,true);
            }
            if(!GameContext.localPlayer.obf_O_l_2706(obf_Q_D_1342.obf_P_3_810))
            {
               _loc3_.getMenuItem("inviteFamily").itemEnabled = false;
            }
            _loc3_.getMenuItem("ride").itemEnabled = false;
            if(GameContext.localPlayer.isActiveRiding)
            {
               if(!_loc2_.isActiveOrPassiveRiding)
               {
                  DiversityManager.setTextField(_loc3_.getMenuItem("ride").txtItemLabel,"MenuUI","inviteRide",null,true);
                  _loc3_.getMenuItem("ride").callBackFun = GameContext.localPlayer.obf_P_v_1396;
                  _loc3_.getMenuItem("ride").callBackPar = [_loc2_.id];
                  _loc3_.getMenuItem("ride").itemEnabled = true;
               }
            }
            else if(!GameContext.localPlayer.isActiveOrPassiveRiding)
            {
               if(_loc2_.isActiveRiding)
               {
                  DiversityManager.setTextField(_loc3_.getMenuItem("ride").txtItemLabel,"MenuUI","joinRide",null,true);
                  _loc3_.getMenuItem("ride").callBackFun = GameContext.localPlayer.obf_D_z_3450;
                  _loc3_.getMenuItem("ride").callBackPar = [_loc2_.id];
                  _loc3_.getMenuItem("ride").itemEnabled = true;
               }
            }
            _loc3_.getMenuItem("whisper").itemEnabled = VersionConfig.enableWhisper;
            _loc3_.getMenuItem("whisper").visible = VersionConfig.enableWhisper;
            _loc4_ = this.localToGlobal(new Point(this.mouseX,this.mouseY));
            PlayerMenuUI.showMenu(_loc3_,_loc4_.x,_loc4_.y);
         }
      }
      
      public function setTargetInfo(param1:MapInteractiveObject) : void
      {
         var _loc2_:RemotePlayer = null;
         var _loc3_:obf_T_L_801 = null;
         var _loc4_:Object = null;
         var _loc5_:obf_9_c_4534 = null;
         this.obf_z_S_3535.clearAllBuff();
         this._debuffUI.clearAllBuff();
         if(param1 is obf_0_Y_3475 && param1 != GameContext.localPlayer)
         {
            this.buffUI.obf_z_o_2257((param1 as obf_0_Y_3475).buffList);
            this.debuffUI.obf_z_o_2257((param1 as obf_0_Y_3475).debuffList);
         }
         this.obf_i_x_1126 = param1.id;
         this.visible = true;
         labelName.textColor = 16777215;
         if(param1 is RemotePlayer)
         {
            _loc2_ = param1 as RemotePlayer;
            labelName.text = _loc2_.id;
            labelLevel.text = _loc2_.level + "";
            this.setHeadIcon(true,_loc2_.obf_k_0_1406);
            hpBar.gotoAndStop(_loc2_.hpPercent);
         }
         else if(param1 == GameContext.localPlayer)
         {
            labelName.text = GameContext.localPlayer.id;
            labelLevel.text = GameContext.localPlayer.level + "";
            this.setHeadIcon(true,GameContext.localPlayer.fullInfo.headIconIndex);
            this.setHpPercent(GameContext.localPlayer.hpPercent);
         }
         else if(param1 is obf_T_L_801)
         {
            _loc3_ = param1 as obf_T_L_801;
            labelName.text = _loc3_.obf_w_I_2773;
            labelLevel.text = _loc3_.level + "";
            labelName.textColor = _loc3_.labelColor;
            hpBar.gotoAndStop(_loc3_.hpPercent);
            _loc4_ = MonsterInfoUtil.getMonsterInfo(_loc3_.monsterCode);
            this.setHeadIcon(false,JSONUtil.getInt(_loc4_,["species"]));
         }
         else if(param1 is obf_9_c_4534)
         {
            _loc5_ = param1 as obf_9_c_4534;
            if(!_loc5_.animalInfull)
            {
               return;
            }
            labelName.text = obf_2_V_3982.getTrianerName(_loc5_.animalInfull.animalCode);
            labelName.textColor = obf_1_R_3404.getColor(_loc5_.animalInfull.level);
            labelLevel.text = _loc5_.animalInfull.level + "";
            this.setHeadIcon(false,10,obf_2_V_3982.getAnimalIcon(_loc5_.animalInfull.animalCode));
            this.setHpPercent(_loc5_.animalInfull.animalAtr.hpPercent);
         }
      }
      
      public function hpChange(param1:int, param2:int) : void
      {
         this.setHpPercent(param1 / param2 * 100);
      }
      
      public function mpChange(param1:int, param2:int) : void
      {
         this.setMpPercent(param1 / param2 * 100);
      }
      
      private function setHeadIcon(param1:Boolean, param2:int, param3:String = "") : void
      {
         var _loc4_:DisplayObject = null;
         while(headIconPoint.numChildren > 0)
         {
            headIconPoint.removeChildAt(0);
         }
         if(param1)
         {
            _loc4_ = HeadIconCode.getHeadIconByInt(param2);
            if(_loc4_)
            {
               _loc4_.scaleX = 0.5;
               _loc4_.scaleY = 0.5;
            }
         }
         else if(obf_L_l_4100.isEmpty(param3))
         {
            _loc4_ = MonsterSpecies.getMonsterSpeciesIcon(param2);
         }
         else
         {
            _loc4_ = ResourceManager.instance.getDisplayObject(param3);
         }
         if(_loc4_)
         {
            headIconPoint.addChild(_loc4_);
         }
      }
      
      private function setJobIcon(param1:int) : void
      {
      }
      
      public function setHpPercent(param1:int) : void
      {
         hpBar.gotoAndStop(param1);
      }
      
      public function setMpPercent(param1:int) : void
      {
         mpBar.gotoAndStop(param1);
      }
      
      private function headIconChangeForRemote(param1:int) : void
      {
      }
      
      private function headIconChangeForMonster() : void
      {
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
         this.obf_i_x_1126 = "";
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

