package com.sunweb.game.rpg.rideEquip
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.worldZone.command.rideEquipment.CommandCodePlayerRideEquipment;
   import com.sunweb.game.rpg.worldZone.command.rideEquipment.RideEquipDoRequest;
   import com.sunweb.game.rpg.worldZone.command.rideEquipment.RideEquipInheritAnswer;
   import com.sunweb.game.rpg.worldZone.command.rideEquipment.RideEquipInheritRequest;
   import com.sunweb.game.rpg.worldZone.command.rideEquipment.RideEquipRecreateAnswer;
   import com.sunweb.game.rpg.worldZone.command.rideEquipment.RideEquipRefineAnswer;
   import com.sunweb.game.rpg.worldZone.command.rideEquipment.RideEquipUpAnswer;
   import com.sunweb.game.rpg.worldZone.command.rideEquipment.RideSaveChangeRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_Y_7_1544
   {
      
      public static var lastTimestamp:Number = 0;
      
      public function obf_Y_7_1544()
      {
         super();
      }
      
      public static function getRideEquiConfig() : Object
      {
         return WorldConfig.getValue("rideEquConfig");
      }
      
      public static function getRideEquiStrengthCon() : Object
      {
         return JSONUtil.getValue(getRideEquiConfig(),"rideEquipment");
      }
      
      public static function getRideRefineCon() : Object
      {
         return JSONUtil.getValue(getRideEquiConfig(),"rideRefine");
      }
      
      public static function getRideRecreateCon() : Object
      {
         return JSONUtil.getValue(getRideEquiConfig(),"rideRecreate");
      }
      
      public static function getRideInheritCon() : Object
      {
         return JSONUtil.getValue(getRideEquiConfig(),"rideInherit");
      }
      
      public static function sendEquipCommand(param1:String, param2:Boolean, param3:int, param4:int) : void
      {
         var _loc5_:Number = new Date().getTime();
         if(_loc5_ - lastTimestamp < 1000)
         {
            return;
         }
         lastTimestamp = _loc5_;
         var _loc6_:RideEquipDoRequest = new RideEquipDoRequest();
         _loc6_.id = param1;
         _loc6_.isMoneyRefine = param2;
         _loc6_.kind = param3;
         _loc6_.type = param4;
         GameContext.worldClient.sendCommand(_loc6_);
      }
      
      public static function sendSaveInfo(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:RideSaveChangeRequest = new RideSaveChangeRequest();
         _loc4_.id = param1;
         _loc4_.kind = param2;
         _loc4_.type = param3;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public static function sendInherit(param1:String, param2:String) : void
      {
         var _loc3_:RideEquipInheritRequest = new RideEquipInheritRequest();
         _loc3_.doId = param1;
         _loc3_.passiveId = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerRideEquipment.RIDE_EQUIP_REFINE_ANSWER)
         {
            obf_0___6_521(param1 as RideEquipRefineAnswer);
         }
         else if(param1.code == CommandCodePlayerRideEquipment.RIDE_EQUIP_UP_ANSWER)
         {
            obf_Y_3_3001(param1 as RideEquipUpAnswer);
         }
         else if(param1.code == CommandCodePlayerRideEquipment.RIDE_EQUIP_RECREATE_ANSWER)
         {
            obf_m_A_4018(param1 as RideEquipRecreateAnswer);
         }
         else if(param1.code == CommandCodePlayerRideEquipment.RIDE_EQUIP_INHERIT_ANSWER)
         {
            obf_q_J_3671(param1 as RideEquipInheritAnswer);
         }
      }
      
      private static function obf_q_J_3671(param1:RideEquipInheritAnswer) : void
      {
         obf_K_e_3075.rideEquipInheritUI.inheritAnswer();
      }
      
      private static function obf_m_A_4018(param1:RideEquipRecreateAnswer) : void
      {
         obf_K_e_3075.rideEquipRecreateUI.recreateOverShow(param1.attrSoulTem,param1.attrTem,param1.attrFinalTem);
      }
      
      private static function obf_Y_3_3001(param1:RideEquipUpAnswer) : void
      {
         var _loc2_:RideEquipmentInfo = param1.info as RideEquipmentInfo;
         if(param1.type == 1)
         {
            obf_K_e_3075.rideEquipRefineUI.showRefineOkInfo(_loc2_.attrFinal);
         }
         else if(param1.type == 2)
         {
            obf_K_e_3075.rideEquipRecreateUI.recreateOkShow();
         }
         else if(param1.type == 3)
         {
            obf_K_e_3075.rideStrengthUI.obf_2_Y_3019(_loc2_);
         }
      }
      
      private static function obf_0___6_521(param1:RideEquipRefineAnswer) : void
      {
         if(param1.newAttr.length > 0 && param1.isLimit.length > 0)
         {
            obf_K_e_3075.rideEquipRefineUI.showRefiningInfo(param1.newAttr,param1.isLimit);
         }
         if(param1.soul > 0)
         {
            obf_K_e_3075.rideEquipRefineUI.showSoul(param1.soul);
         }
      }
   }
}

