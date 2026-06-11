package com.sunweb.game.rpg.playerUI.team
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.netRole.RemotePlayer;
   import com.sunweb.game.rpg.playerUI.BuffUI;
   import com.sunweb.game.rpg.role.obf_I_5_1944;
   import com.sunweb.game.rpg.team.TeamMemberInfo;
   import com.sunweb.game.rpg.world.ui.obf_X_Z_4427;
   import com.sunweb.game.ui.HeadIconCode;
   import com.sunweb.game.utils.obf_9_V_1635;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import playerUI.TeamBoxUIMC;
   
   public class obf_0_2_y_392 extends TeamBoxUIMC
   {
      
      private var playerId:String;
      
      private var teamMemberInfo:TeamMemberInfo;
      
      private var obf_z_S_3535:BuffUI;
      
      private var _debuffUI:BuffUI;
      
      public function obf_0_2_y_392(param1:TeamMemberInfo)
      {
         super();
         teamLeaderIcon.visible = false;
         if(param1.isOnline)
         {
            txtName.textColor = 16777215;
         }
         else
         {
            headIconPoint.filters = [obf_9_V_1635.getGrayFilter()];
            txtName.textColor = 6710886;
         }
         txtLevel.text = param1.level + "";
         txtName.text = param1.name;
         this.playerId = param1.name;
         this.setHp(param1.hp,param1.hpMax);
         this.setMp(param1.mp,param1.mpMax);
         var _loc2_:DisplayObject = HeadIconCode.getHeadIconByInt(param1.headIconIndex);
         if(_loc2_)
         {
            _loc2_.scaleX = 0.5;
            _loc2_.scaleY = 0.5;
            headIconPoint.addChild(_loc2_);
         }
         var _loc3_:DisplayObject = obf_I_5_1944.getJobIcon32(param1.jobCode);
         if(_loc3_)
         {
            _loc3_.scaleX = 0.4;
            _loc3_.scaleY = 0.4;
            pointJobIcon.addChild(_loc3_);
         }
         this.teamMemberInfo = param1;
         this.obf_z_S_3535 = new BuffUI(true);
         buffPoint.addChild(this.obf_z_S_3535);
         this._debuffUI = new BuffUI(true);
         debuffPoint.addChild(this._debuffUI);
         this.addListener();
      }
      
      public function get buffUI() : BuffUI
      {
         return this.obf_z_S_3535;
      }
      
      public function get debuffUI() : BuffUI
      {
         return this._debuffUI;
      }
      
      private function addListener() : void
      {
         cmdMenu.addEventListener(MouseEvent.CLICK,this.onClickMenu);
         headIconPoint.addEventListener(MouseEvent.CLICK,this.obf_m_c_3163);
         txtName.addEventListener(MouseEvent.CLICK,this.obf_m_c_3163);
      }
      
      private function removeListener() : void
      {
         cmdMenu.removeEventListener(MouseEvent.CLICK,this.onClickMenu);
         headIconPoint.removeEventListener(MouseEvent.CLICK,this.obf_m_c_3163);
         txtName.removeEventListener(MouseEvent.CLICK,this.obf_m_c_3163);
      }
      
      public function obf_p_N_3546(param1:TeamMemberInfo) : void
      {
         if(param1.isOnline)
         {
            headIconPoint.filters = [];
            txtName.textColor = 16777215;
         }
         else
         {
            headIconPoint.filters = [new ColorMatrixFilter([0.33,0.33,0.33,0,0,0.33,0.33,0.33,0,0,0.33,0.33,0.33,0,0,0,0,0,1,0])];
            txtName.textColor = 6710886;
         }
         txtLevel.text = param1.level + "";
         txtName.text = param1.name;
         this.teamMemberInfo = param1;
      }
      
      public function setHp(param1:uint, param2:Number) : void
      {
         txtHp.text = param1 + "/" + param2;
         var _loc3_:int = param1 / param2 * 100;
         hpBar.gotoAndStop(_loc3_);
      }
      
      public function setMp(param1:int, param2:Number) : void
      {
         txtMp.text = param1 + "/" + param2;
         var _loc3_:int = param1 / param2 * 100;
         mpBar.gotoAndStop(_loc3_);
      }
      
      public function setTeamLeader(param1:Boolean) : void
      {
         teamLeaderIcon.visible = param1;
      }
      
      private function onClickMenu(param1:Event) : void
      {
         obf_X_Z_4427.showTeamMemberMenu(this.playerId,this.localToGlobal(new Point(this.mouseX,this.mouseY)));
      }
      
      private function obf_m_c_3163(param1:Event) : void
      {
         if(!GameContext.currentMap)
         {
            return;
         }
         var _loc2_:RemotePlayer = GameContext.currentMap.remotePlayerSet.obf_3_C_4291[this.playerId] as RemotePlayer;
         if(_loc2_)
         {
            GameContext.localPlayer.selectTarget(_loc2_);
         }
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this.teamMemberInfo = null;
      }
   }
}

