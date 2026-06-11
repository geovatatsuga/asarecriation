package com.sunweb.game.rpg.netRole
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.res.ResourceBag;
   import com.sunweb.game.rpg.animal.AnimalInfo;
   import com.sunweb.game.rpg.role.RoleModel;
   import com.sunweb.game.rpg.role.obf_Z_Q_3056;
   import com.sunweb.game.rpg.role.obf_e_1465;
   import com.sunweb.game.rpg.role.action.obf_S_c_3330;
   import com.sunweb.game.rpg.world.obf_2_V_3982;
   import com.sunweb.game.rpg.world.map.MapManager;
   import com.sunweb.game.rpg.world.map.MapPoint;
   import com.sunweb.game.rpg.worldZone.command.animal.AnimalMoveNotify;
   import com.sunweb.game.rpg.worldZone.command.animal.CommandCodePlayerAnimal;
   
   public class obf_9_c_4534 extends obf_e_1465
   {
      
      public var animalInfull:AnimalInfo;
      
      public function obf_9_c_4534(param1:String, param2:AnimalInfo = null, param3:String = null)
      {
         super(param1,param3);
         this.animalInfull = param2;
      }
      
      override protected function obf_N_O_3481() : void
      {
         var _loc1_:ResourceBag = AIObjectsBufferManager.getResBag("m_" + modelCode);
         _loc1_.obf_z_U_2156(RoleModel.getMonsterModelResId(modelCode));
         _loc1_.load();
      }
      
      override public function set isTracked(param1:Boolean) : void
      {
         super.isTracked = param1;
         this.setName(param1);
      }
      
      override public function showStrickenAction() : void
      {
         if(this.isUsingSkill)
         {
            return;
         }
         this.doAction(obf_S_c_3330.obf_y_Y_2903);
      }
      
      override protected function obf_0_2_2429() : void
      {
         if(obf_r_t_1891)
         {
            try
            {
               this.getMap().animalSet.removeObject(this);
            }
            catch(e:Error)
            {
            }
         }
         super.obf_0_2_2429();
      }
      
      public function setName(param1:Boolean = false) : void
      {
         if(!this.animalInfull)
         {
            return;
         }
         var _loc2_:String = "";
         _loc2_ += "<font color=\'#" + obf_1_R_3404.getColor(this.animalInfull.level).toString(16) + "\'>" + obf_2_V_3982.getTrianerName(this.animalInfull.animalCode) + "</font>";
         if(param1)
         {
            _loc2_ += "<br><font color=\'#99CC00\'>" + this.animalInfull.animalOwnerName + "</font>";
         }
         this.setAndShowLabel(_loc2_);
      }
      
      public function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerAnimal.ANIMAL_MOVE_NOTIFY)
         {
            this.obf_j_a_2365(param1 as AnimalMoveNotify);
         }
      }
      
      private function obf_j_a_2365(param1:AnimalMoveNotify) : void
      {
         var _loc3_:Boolean = false;
         if(!this.animalInfull)
         {
            return;
         }
         this.walkSpeed = param1.walkSpeed;
         if(param1.reasonCode == obf_Z_Q_3056.obf_z_n_3070 && this.isInStage)
         {
            MapManager.instance.showMapFastMoveBlur(this,param1.position.x,param1.position.y);
         }
         this.animalInfull.x = param1.position.x;
         this.animalInfull.y = param1.position.y;
         var _loc2_:int = this.getLineDistancePt(param1.position.x,param1.position.y);
         if(!param1.pathArrayReversed || param1.pathArrayReversed.length == 0)
         {
            this.moveToPixel(param1.position.x,param1.position.y);
            this.stopWalking();
         }
         else
         {
            _loc3_ = param1.reasonCode != obf_Z_Q_3056.obf_z_n_3070 && _loc2_ < 200;
            this.walkAlongPath(MapPoint.MapArrayToPoint(param1.pathArray),_loc3_);
         }
      }
   }
}

