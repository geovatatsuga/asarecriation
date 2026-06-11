package com.sunweb.game.rpg.farm
{
   import com.sunweb.game.rpg.role.obf_7_4687;
   
   public class obf_j_1_3698 extends FarmObject
   {
      
      public static var obf_Y_5_1487:String = "b41@sc3";
      
      public var kind:String;
      
      public function obf_j_1_3698(param1:String)
      {
         var _loc2_:Object = null;
         _loc2_ = obf_d_8_4301.getFarmBuildingInfo(param1);
         if(_loc2_ != null)
         {
            super(_loc2_,obf_Y_5_1487);
            obf_F_7_2340 |= obf_7_4687.FARM_BUILDING;
            this.kind = _loc2_.kind;
            return;
         }
         throw new Error("无法找到FarmBuilding模型obf__c_o_d_e_4682=" + param1);
      }
   }
}

