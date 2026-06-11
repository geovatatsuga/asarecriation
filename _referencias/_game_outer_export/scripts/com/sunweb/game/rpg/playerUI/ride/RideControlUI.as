package com.sunweb.game.rpg.playerUI.ride
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.PlayerMenuItem;
   import com.sunweb.game.rpg.playerUI.PlayerMenuUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.team.TeamManager;
   import com.sunweb.game.utils.obf_9_V_1635;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import playerUI.RideControlUIMC;
   
   public class RideControlUI extends RideControlUIMC implements IPlayerUI
   {
      
      private var obf_a_t_3618:Array;
      
      public function RideControlUI()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.y = 73;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         obf_9_V_1635.setSimpleButtonTooltip(cmdInviteIteam,DiversityManager.getString("RideControlUI","txtInviteTeam"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdKick,DiversityManager.getString("RideControlUI","txtKick"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdRideDown,DiversityManager.getString("RideControlUI","txtDown"));
      }
      
      private function addListener() : void
      {
         cmdInviteIteam.addEventListener(MouseEvent.CLICK,this.obf_V_4693);
         cmdRideDown.addEventListener(MouseEvent.CLICK,this.obf_v_2_969);
         cmdKick.addEventListener(MouseEvent.CLICK,this.obf_u_M_895);
      }
      
      private function removeListener() : void
      {
         cmdInviteIteam.removeEventListener(MouseEvent.CLICK,this.obf_V_4693);
         cmdRideDown.removeEventListener(MouseEvent.CLICK,this.obf_v_2_969);
         cmdKick.removeEventListener(MouseEvent.CLICK,this.obf_u_M_895);
      }
      
      public function set obf_0_8_3469(param1:Array) : void
      {
         this.obf_a_t_3618 = param1.concat();
      }
      
      private function obf_V_4693(param1:Event) : void
      {
         if(TeamManager.teamName == "")
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("TeamManagerUI","mustHaveTeam"));
            return;
         }
         if(GameContext.localPlayer)
         {
            GameContext.localPlayer.sendInviteTeamRide();
         }
      }
      
      private function obf_v_2_969(param1:Event) : void
      {
         if(GameContext.localPlayer)
         {
            GameContext.localPlayer.obf_2_4683("");
         }
      }
      
      private function obf_u_M_895(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc4_:PlayerMenuItem = null;
         var _loc5_:Point = null;
         var _loc6_:PlayerMenuItem = null;
         var _loc2_:PlayerMenuUI = new PlayerMenuUI("kickRidePlayer");
         for each(_loc3_ in this.obf_a_t_3618)
         {
            _loc6_ = new PlayerMenuItem(_loc3_,GameContext.localPlayer.kickRidePlayer,[_loc3_]);
            _loc2_.addMenuItem(_loc6_,_loc3_);
         }
         _loc4_ = new PlayerMenuItem(DiversityManager.getString("MenuUI","allMember"),this.obf_5_u_1684,null);
         _loc2_.addMenuItem(_loc4_,"all");
         _loc5_ = new Point(cmdKick.x,cmdKick.y);
         _loc5_ = this.localToGlobal(_loc5_);
         PlayerMenuUI.showMenu(_loc2_,_loc5_.x,_loc5_.y);
      }
      
      public function obf_5_u_1684() : void
      {
         var _loc1_:String = null;
         for each(_loc1_ in this.obf_a_t_3618)
         {
            GameContext.localPlayer.kickRidePlayer(_loc1_);
         }
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
         this.obf_a_t_3618 = new Array();
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

