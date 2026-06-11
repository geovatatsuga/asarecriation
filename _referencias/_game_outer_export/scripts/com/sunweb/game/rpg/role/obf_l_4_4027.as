package com.sunweb.game.rpg.role
{
   public class obf_l_4_4027 extends obf_0_Y_3475
   {
      
      public static var obf_i_A_4163:String = "nff";
      
      protected var _modelCode:String;
      
      protected var obf_L_z_3505:int;
      
      public function obf_l_4_4027(param1:String, param2:String = null)
      {
         super();
         obf_F_7_2340 |= obf_7_4687.NPC;
         this._modelCode = param1;
         if(param2 == null)
         {
            param2 = obf_i_A_4163;
         }
         useMonsterModel(this._modelCode,param2,true);
         var _loc3_:Object = RoleModel.getMonsterModel(param1);
         if(_loc3_ == null)
         {
            throw new Error("Can not find npc model: " + param1);
         }
         this.obf_L_z_3505 = _loc3_.maxModelHeight;
         walkSpeed = 200;
      }
      
      override public function getTopmostY() : int
      {
         return this.obf_L_z_3505 > 0 ? int(-this.obf_L_z_3505) : int(super.getTopmostY());
      }
      
      override protected function obf_0_2_2429() : void
      {
         if(obf_r_t_1891)
         {
            try
            {
               this.getMap().npcSet.removeObject(this);
            }
            catch(e:Error)
            {
            }
         }
         super.obf_0_2_2429();
      }
   }
}

