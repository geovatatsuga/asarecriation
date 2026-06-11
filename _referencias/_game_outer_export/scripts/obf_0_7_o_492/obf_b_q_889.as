package obf_0_7_o_492
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.magicCircle.CommandCodeMagicCircle;
   import com.sunweb.game.rpg.worldZone.command.magicCircle.MagicCircleInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.magicCircle.MagicCircleUpAnswer;
   import com.sunweb.game.rpg.worldZone.command.magicCircle.MagicCircleUpRequest;
   import com.sunweb.game.rpg.worldZone.command.magicCircle.MagicCircleUseAnswer;
   import com.sunweb.game.rpg.worldZone.command.magicCircle.MagicCircleUseRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_b_q_889
   {
      
      private static var magicCircleConfig:Object;
      
      public function obf_b_q_889()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         magicCircleConfig = param1;
      }
      
      public static function get config() : Object
      {
         return magicCircleConfig;
      }
      
      public static function get openCon() : Object
      {
         return JSONUtil.getObject(magicCircleConfig,["openCon"]);
      }
      
      public static function get magicCircleList() : Array
      {
         return JSONUtil.getValue(magicCircleConfig,["list"]) as Array;
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeMagicCircle.MAGIC_CIRCLE_INFO_NOTIFY)
         {
            obf_O_d_1673(param1 as MagicCircleInfoNotify);
         }
         else if(param1.code == CommandCodeMagicCircle.MAGIC_CIRCLE_UP_ANSWER)
         {
            obf_D_d_2186(param1 as MagicCircleUpAnswer);
         }
         else if(param1.code == CommandCodeMagicCircle.MAGIC_CIRCLE_USE_ANSWER)
         {
            obf_6_v_2511(param1 as MagicCircleUseAnswer);
         }
      }
      
      private static function obf_O_d_1673(param1:MagicCircleInfoNotify) : void
      {
         if(!obf_K_e_3075.magicCircleUI)
         {
            return;
         }
         obf_K_e_3075.magicCircleUI.hasMap = param1.hasMap;
         obf_K_e_3075.magicCircleUI.useIndex = param1.useIndex;
         obf_K_e_3075.magicCircleUI.refresh();
      }
      
      private static function obf_D_d_2186(param1:MagicCircleUpAnswer) : void
      {
         if(!obf_K_e_3075.magicCircleUI)
         {
            return;
         }
         if(!obf_K_e_3075.magicCircleUI.hasMap)
         {
            obf_K_e_3075.magicCircleUI.hasMap = new Object();
         }
         obf_K_e_3075.magicCircleUI.hasMap[param1.magicCircleIndex] = param1.magicCircleLevel;
         obf_K_e_3075.magicCircleUI.refresh();
      }
      
      private static function obf_6_v_2511(param1:MagicCircleUseAnswer) : void
      {
         if(!obf_K_e_3075.magicCircleUI)
         {
            return;
         }
         obf_K_e_3075.magicCircleUI.useIndex = param1.magicCircleIndex;
         obf_K_e_3075.magicCircleUI.refresh();
      }
      
      public static function sendMagicCircleUpRequest(param1:int) : void
      {
         var _loc2_:MagicCircleUpRequest = new MagicCircleUpRequest();
         _loc2_.magicCircleIndex = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendMagicCircleUseRequest(param1:int) : void
      {
         var _loc2_:MagicCircleUseRequest = new MagicCircleUseRequest();
         _loc2_.magicCircleIndex = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
   }
}

