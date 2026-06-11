package com.sunweb.game.rpg.farm
{
   import com.sunweb.game.res.ResourceBag;
   import com.sunweb.game.res.obf_b_8_4256;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.netRole.AIObjectsBufferManager;
   import com.sunweb.game.utils.obf_l_y_733;
   import flash.utils.getTimer;
   
   public class obf_F_L_3912 extends obf_j_1_3698
   {
      
      private var checkTime:int;
      
      private var _buildingConfig:Object;
      
      public var obf_F_M_892:String;
      
      public var _timeLeftInHour:int;
      
      public function obf_F_L_3912(param1:String)
      {
         super(param1);
         this._buildingConfig = obf_d_8_4301.getFarmBuildingInfo(param1);
         if(this._buildingConfig)
         {
            this.obf_F_M_892 = this._buildingConfig.name;
         }
      }
      
      override protected function obf_N_O_3481() : void
      {
         var _loc1_:ResourceBag = AIObjectsBufferManager.getResBag("fh_" + this._buildingConfig.modelCode);
         _loc1_.obf_z_U_2156(obf_b_8_4256.getResIdToImport(this._buildingConfig.res));
         _loc1_.load();
      }
      
      public function set timeLeftInHour(param1:int) : void
      {
         this._timeLeftInHour = param1;
         this.checkTime = getTimer();
      }
      
      override public function set isTracked(param1:Boolean) : void
      {
         if(this.isTracked == param1)
         {
            return;
         }
         super.isTracked = param1;
         if(param1)
         {
            this.showInfo();
         }
         else
         {
            this.showLabel = false;
         }
      }
      
      public function canRemove() : Boolean
      {
         var _loc1_:obf_0_1_N_478 = this.getFarm();
         if(!_loc1_)
         {
            return false;
         }
         var _loc2_:obf_n_v_1693 = FarmTempletManager.getFarmTemplet(_loc1_.templetCode);
         if(_loc2_.farmType == FarmType.obf_0_7_w_551)
         {
            if(_loc1_.ownerId == GameContext.localPlayer.id)
            {
               return true;
            }
            return false;
         }
         if(_loc2_.farmType == FarmType.obf_5_b_4269)
         {
            return false;
         }
         if(_loc2_.farmType == FarmType.obf_U_z_3456)
         {
            return true;
         }
         if(_loc2_.farmType == FarmType.FAMILY_FARM)
         {
            return true;
         }
         return false;
      }
      
      public function showInfo() : void
      {
         var _loc1_:String = "";
         _loc1_ += this.obf_F_M_892;
         _loc1_ += "\n" + DiversityManager.getString("FarmPrompt","validTime",[obf_l_y_733.getTimeStringHour(this._timeLeftInHour * 1000 * 60 * 60 - (getTimer() - this.checkTime))]);
         if(this._buildingConfig)
         {
            _loc1_ += "\n";
         }
         this.setAndShowLabel(_loc1_);
      }
   }
}

