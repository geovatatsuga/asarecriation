package com.sunweb.game.rpg.role
{
   import com.sunweb.game.rpg.role.action.obf_S_c_3330;
   
   public class obf_e_1465 extends obf_0_Y_3475
   {
      
      public static var obf_M_o_2357:String = "cff";
      
      protected var _modelCode:String;
      
      public var ownerPlayerId:String;
      
      protected var obf_L_z_3505:int;
      
      public function obf_e_1465(param1:String, param2:String = null)
      {
         super();
         obf_F_7_2340 |= obf_7_4687.obf_0_7_U_454;
         this._modelCode = param1;
         if(param2 == null)
         {
            param2 = obf_M_o_2357;
         }
         useMonsterModel(this._modelCode,param2,true);
         var _loc3_:Object = RoleModel.getMonsterModel(param1);
         if(_loc3_ == null)
         {
            throw new Error("Can not find monster model: " + param1);
         }
         if(_loc3_.walkStepLength != null && _loc3_.walkStepLength > 0)
         {
            walkStepLength = _loc3_.walkStepLength;
         }
         this.obf_L_z_3505 = _loc3_.maxModelHeight;
         walkSpeed = 200;
      }
      
      public function get modelCode() : String
      {
         return this._modelCode;
      }
      
      override public function getTopmostY() : int
      {
         return this.obf_L_z_3505 > 0 ? int(-this.obf_L_z_3505) : int(super.getTopmostY());
      }
      
      public function getOwnerPlayer() : obf_0_M_3913
      {
         if(this.ownerPlayerId == null || this.ownerPlayerId == "" || _map == null)
         {
            return null;
         }
         return _map.getObjectById(this.ownerPlayerId) as obf_0_M_3913;
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
               this.getMap().monsterSet.removeObject(this);
            }
            catch(e:Error)
            {
            }
         }
         super.obf_0_2_2429();
      }
   }
}

