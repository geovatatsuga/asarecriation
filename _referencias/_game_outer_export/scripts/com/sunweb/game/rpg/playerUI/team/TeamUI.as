package com.sunweb.game.rpg.playerUI.team
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.buff.BuffInfo;
   import com.sunweb.game.rpg.buff.BuffManager;
   import com.sunweb.game.rpg.netRole.RemotePlayer;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.team.TeamManager;
   import com.sunweb.game.rpg.team.TeamMemberInfo;
   import flash.display.Sprite;
   
   public class TeamUI extends Sprite implements IPlayerUI
   {
      
      public function TeamUI()
      {
         super();
         this.y = 120;
         this.visible = false;
      }
      
      public function showTeamBox(param1:Array, param2:String) : void
      {
         var _loc4_:TeamMemberInfo = null;
         var _loc5_:obf_0_2_y_392 = null;
         this.obf_Q_a_2368();
         if(obf_K_e_3075.playerInfoUI)
         {
            obf_K_e_3075.playerInfoUI.teamLeaderIcon.visible = false;
         }
         if(param2 == "" || !param1 || param1.length == 0)
         {
            return;
         }
         var _loc3_:int = 0;
         for each(_loc4_ in param1)
         {
            if(_loc4_.name != GameContext.localPlayer.id)
            {
               _loc5_ = new obf_0_2_y_392(_loc4_);
               if(_loc4_.name == param2)
               {
                  _loc5_.setTeamLeader(true);
               }
               _loc5_.y = _loc3_;
               _loc5_.name = _loc4_.name;
               this.addChild(_loc5_);
               _loc3_ += _loc5_.height;
               this.refreshMemberBuff(_loc4_.name);
            }
         }
         if(TeamManager.isLeader && Boolean(obf_K_e_3075.playerInfoUI))
         {
            obf_K_e_3075.playerInfoUI.teamLeaderIcon.visible = true;
         }
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
      }
      
      public function obf_9_3_4210(param1:String, param2:String) : void
      {
         var _loc3_:obf_0_2_y_392 = this.getChildByName(param1) as obf_0_2_y_392;
         if(_loc3_)
         {
            _loc3_.setTeamLeader(false);
         }
         var _loc4_:obf_0_2_y_392 = this.getChildByName(param2) as obf_0_2_y_392;
         if(_loc4_)
         {
            _loc4_.setTeamLeader(true);
         }
         if(obf_K_e_3075.playerInfoUI)
         {
            if(param1 == GameContext.localPlayer.id)
            {
               obf_K_e_3075.playerInfoUI.teamLeaderIcon.visible = false;
            }
            if(param2 == GameContext.localPlayer.id)
            {
               obf_K_e_3075.playerInfoUI.teamLeaderIcon.visible = true;
            }
         }
      }
      
      public function obf_w_O_1339(param1:String, param2:BuffInfo) : void
      {
         var _loc4_:Object = null;
         var _loc3_:obf_0_2_y_392 = this.getChildByName(param1) as obf_0_2_y_392;
         if(_loc3_)
         {
            _loc4_ = BuffManager.getBuffConfigById(param2.buffId);
            if(!_loc4_)
            {
               return;
            }
            if(!_loc4_.isDebuff)
            {
               _loc3_.buffUI.addBuff(param2);
            }
            else
            {
               _loc3_.debuffUI.addBuff(param2);
            }
         }
      }
      
      public function removeBuffByPlayerId(param1:String, param2:int) : void
      {
         var _loc4_:Object = null;
         var _loc3_:obf_0_2_y_392 = this.getChildByName(param1) as obf_0_2_y_392;
         if(_loc3_)
         {
            _loc4_ = BuffManager.getBuffConfigById(param2);
            if(!_loc4_)
            {
               return;
            }
            if(!_loc4_.isDebuff)
            {
               _loc3_.buffUI.removeBuff(param2);
            }
            else
            {
               _loc3_.debuffUI.removeBuff(param2);
            }
         }
      }
      
      public function refreshMemberBuff(param1:String) : void
      {
         if(!GameContext.currentMap)
         {
            return;
         }
         var _loc2_:RemotePlayer = GameContext.currentMap.remotePlayerSet.getObject(param1) as RemotePlayer;
         var _loc3_:obf_0_2_y_392 = this.getChildByName(param1) as obf_0_2_y_392;
         if(!_loc2_ || !_loc3_)
         {
            return;
         }
         _loc3_.buffUI.clearAllBuff();
         _loc3_.buffUI.obf_z_o_2257(_loc2_.buffList);
         _loc3_.debuffUI.clearAllBuff();
         _loc3_.debuffUI.obf_z_o_2257(_loc2_.debuffList);
      }
      
      public function clearMemberBuff(param1:String) : void
      {
         var _loc2_:obf_0_2_y_392 = this.getChildByName(param1) as obf_0_2_y_392;
         if(_loc2_)
         {
            _loc2_.buffUI.clearAllBuff();
            _loc2_.debuffUI.clearAllBuff();
         }
      }
      
      public function obf_0_2_M_210(param1:TeamMemberInfo) : void
      {
         var _loc2_:obf_0_2_y_392 = this.getChildByName(param1.name) as obf_0_2_y_392;
         if(_loc2_)
         {
            _loc2_.obf_p_N_3546(param1);
         }
      }
      
      public function obf_6_E_2559(param1:String, param2:uint, param3:uint) : void
      {
         var _loc4_:obf_0_2_y_392 = this.getChildByName(param1) as obf_0_2_y_392;
         if(_loc4_)
         {
            _loc4_.setHp(param2,param3);
         }
      }
      
      public function obf_G_w_2136(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:obf_0_2_y_392 = this.getChildByName(param1) as obf_0_2_y_392;
         if(_loc4_)
         {
            _loc4_.setMp(param2,param3);
         }
      }
      
      public function obf_Q_a_2368() : void
      {
         var _loc1_:obf_0_2_y_392 = null;
         while(this.numChildren > 0)
         {
            _loc1_ = this.getChildAt(0) as obf_0_2_y_392;
            if(_loc1_)
            {
               _loc1_.destroy();
               this.removeChild(_loc1_);
            }
         }
      }
      
      public function get mouseOn() : Boolean
      {
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
         this.obf_Q_a_2368();
      }
   }
}

