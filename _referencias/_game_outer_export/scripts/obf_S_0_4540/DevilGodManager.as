package obf_S_0_4540
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.devilGod.CommandCodeDevilGod;
   import com.sunweb.game.rpg.worldZone.command.devilGod.DevilGodEatPetAnswer;
   import com.sunweb.game.rpg.worldZone.command.devilGod.DevilGodEatPetRequest;
   import com.sunweb.game.rpg.worldZone.command.devilGod.DevilGodInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.devilGod.DevilGodUseMoneyAnswer;
   import com.sunweb.game.rpg.worldZone.command.devilGod.DevilGodUseMoneyRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class DevilGodManager
   {
      
      private static var devilGodConfig:Object;
      
      public function DevilGodManager()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         devilGodConfig = param1;
      }
      
      public static function get devilGodOpenCond() : Object
      {
         return JSONUtil.getObject(devilGodConfig,["openCondition"]);
      }
      
      public static function get devilGodGrowByMoney() : int
      {
         return JSONUtil.getInt(devilGodConfig,["growByMoney"]);
      }
      
      public static function get devilPowerByPet() : int
      {
         return JSONUtil.getInt(devilGodConfig,["powerByPet"]);
      }
      
      public static function get devilGodGrowByPet() : Object
      {
         return JSONUtil.getObject(devilGodConfig,["growByPet"]);
      }
      
      public static function get devilGodPowerMax() : int
      {
         return JSONUtil.getInt(devilGodConfig,["powerMax"]);
      }
      
      public static function get devilGodDevilGodInfo() : Array
      {
         return JSONUtil.getValue(devilGodConfig,["devilGodInfo"]) as Array;
      }
      
      public static function get devilGodLosePower() : int
      {
         return JSONUtil.getInt(devilGodConfig,["losePower"]);
      }
      
      public static function sendDevilGodEatPetReq(param1:String) : void
      {
         var _loc2_:DevilGodEatPetRequest = new DevilGodEatPetRequest();
         _loc2_.petId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendDevilGodUseMoneyReq(param1:int) : void
      {
         var _loc2_:DevilGodUseMoneyRequest = new DevilGodUseMoneyRequest();
         _loc2_.useMoney = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeDevilGod.DEVIL_GOD_INFO_NOTIFY)
         {
            obf_k_M_3611(param1 as DevilGodInfoNotify);
         }
         else if(param1.code == CommandCodeDevilGod.DEVIL_GOD_USE_MONEY_ANSWER)
         {
            obf_0_1_O_346(param1 as DevilGodUseMoneyAnswer);
         }
         else if(param1.code == CommandCodeDevilGod.DEVIL_GOD_EAT_PET_ANSWER)
         {
            obf_C_M_3831(param1 as DevilGodEatPetAnswer);
         }
      }
      
      private static function obf_k_M_3611(param1:DevilGodInfoNotify) : void
      {
         obf_K_e_3075.devilGodUI.showDevilGodLevel(param1.devilGodLevel);
         obf_K_e_3075.devilGodUI.showDevilGodGrow(param1.devilGodGrow);
         obf_K_e_3075.devilGodUI.showDevilGodPower(param1.devilGodPower);
         obf_K_e_3075.devilGodUI.showAllInfo();
      }
      
      private static function obf_0_1_O_346(param1:DevilGodUseMoneyAnswer) : void
      {
         obf_K_e_3075.devilGodUI.showDevilGodGrow(param1.devilGodGrow);
         obf_K_e_3075.devilGodUseMoneyUI.obf_J_m_1486();
      }
      
      private static function obf_C_M_3831(param1:DevilGodEatPetAnswer) : void
      {
         obf_K_e_3075.devilGodUsePetUI.obf_0_0_2_552();
         obf_K_e_3075.devilGodUI.showDevilGodPower(param1.devilGodPower);
         obf_K_e_3075.devilGodUI.showDevilGodGrow(param1.devilGodGrow);
      }
   }
}

