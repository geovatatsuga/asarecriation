package obf_0_2_t_601
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.reGrow.CommandCodePlayerReGrow;
   import com.sunweb.game.rpg.worldZone.command.reGrow.PlayerInOutExpAnswer;
   import com.sunweb.game.rpg.worldZone.command.reGrow.PlayerInOutExpRequest;
   import com.sunweb.game.rpg.worldZone.command.reGrow.PlayerMakeItemAnswer;
   import com.sunweb.game.rpg.worldZone.command.reGrow.PlayerMakeItemRequest;
   import com.sunweb.game.rpg.worldZone.command.reGrow.PlayerReGrowAnswer;
   import com.sunweb.game.rpg.worldZone.command.reGrow.PlayerReGrowNotify;
   import com.sunweb.game.rpg.worldZone.command.reGrow.PlayerReGrowRequest;
   
   public class obf_o_H_2969
   {
      
      private static var _regrowConfig:Object;
      
      public function obf_o_H_2969()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         _regrowConfig = param1;
      }
      
      public static function get regrowConfig() : Object
      {
         return _regrowConfig;
      }
      
      public static function get obf_3_z_2032() : int
      {
         return _regrowConfig.reGrowMaxLv;
      }
      
      public static function get obf_I_3_3228() : Object
      {
         return _regrowConfig.upLevelCon;
      }
      
      public static function get obf_2_2_1859() : Array
      {
         return _regrowConfig.attr;
      }
      
      public static function get obf_p_x_1964() : int
      {
         return _regrowConfig.attrPt;
      }
      
      public static function get obf_R_o_2175() : Object
      {
         return _regrowConfig.useExpPoolCon;
      }
      
      public static function get obf_m_u_3166() : uint
      {
         return _regrowConfig.expMax;
      }
      
      public static function get obf_O_v_3554() : Object
      {
         return _regrowConfig.alchemyCon;
      }
      
      public static function get regrowAlchemyNeed() : Array
      {
         return _regrowConfig.alchemyNeed;
      }
      
      public static function get obf_h_M_2790() : String
      {
         return _regrowConfig.alchemyItemCode;
      }
      
      public static function get obf_1_Z_2231() : int
      {
         return _regrowConfig.openByReborn;
      }
      
      public static function sendPlayerReGrowRequest() : void
      {
         var _loc1_:PlayerReGrowRequest = new PlayerReGrowRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendPlayerInOutExpRequest(param1:int) : void
      {
         var _loc2_:PlayerInOutExpRequest = new PlayerInOutExpRequest();
         _loc2_.type = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendPlayerMakeItemRequest() : void
      {
         var _loc1_:PlayerMakeItemRequest = new PlayerMakeItemRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerReGrow.PLAYER_IN_OUT_EXP_ANSWER)
         {
            obf_0_0_0_442(param1 as PlayerInOutExpAnswer);
         }
         else if(param1.code == CommandCodePlayerReGrow.PLAYER_MAKE_ITEM_ANSWER)
         {
            obf_D_p_2371(param1 as PlayerMakeItemAnswer);
         }
         else if(param1.code == CommandCodePlayerReGrow.PLAYER_RE_GROW_ANSWER)
         {
            obf_g_M_1290(param1 as PlayerReGrowAnswer);
         }
         else if(param1.code == CommandCodePlayerReGrow.PLAYER_RE_GROW_NOTIFY)
         {
            obf_0_0_n_591(param1 as PlayerReGrowNotify);
         }
      }
      
      private static function obf_g_M_1290(param1:PlayerReGrowAnswer) : void
      {
         obf_K_e_3075.obf_a_A_1284.showAttrs(param1.reGrowLevel);
      }
      
      private static function obf_D_p_2371(param1:PlayerMakeItemAnswer) : void
      {
         obf_K_e_3075.obf_a_A_1284.setExpBall(param1.exp);
      }
      
      private static function obf_0_0_0_442(param1:PlayerInOutExpAnswer) : void
      {
         obf_K_e_3075.obf_a_A_1284.setExpBall(param1.exp);
      }
      
      private static function obf_0_0_n_591(param1:PlayerReGrowNotify) : void
      {
         obf_K_e_3075.obf_a_A_1284.showAttrs(param1.reGrowLevel);
         obf_K_e_3075.obf_a_A_1284.setExpBall(param1.reGrowExp);
      }
   }
}

