package obf_O_e_3875
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.worldZone.command.Christmas.CommandCodePlayerGame;
   import com.sunweb.game.rpg.worldZone.command.Christmas.PlayerChristmasDrawAnswer;
   import com.sunweb.game.rpg.worldZone.command.Christmas.PlayerChristmasDrawRequest;
   import com.sunweb.game.rpg.worldZone.command.Christmas.PlayerChristmasPostNotify;
   import com.sunweb.game.rpg.worldZone.command.Christmas.PlayerChristmasShopRequest;
   import com.sunweb.game.rpg.worldZone.command.Christmas.PlayerChristmasValueNotify;
   
   public class obf_0_4_5_176
   {
      
      public static var christmasConfig:Object = WorldConfig.getValue("christmasDrawConfig");
      
      public function obf_0_4_5_176()
      {
         super();
      }
      
      public static function sendChristmasDrawReq(param1:int) : void
      {
         var _loc2_:PlayerChristmasDrawRequest = new PlayerChristmasDrawRequest();
         _loc2_.type = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendChristmasShopReq(param1:String) : void
      {
         var _loc2_:PlayerChristmasShopRequest = new PlayerChristmasShopRequest();
         _loc2_.itemCode = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerGame.PLAYER_CHRISTMAS_DRAW_ANSWER)
         {
            obf_8_D_2742(param1 as PlayerChristmasDrawAnswer);
         }
         else if(param1.code == CommandCodePlayerGame.PLAYER_CHRISTMAS_POST_NOTIFY)
         {
            obf_6_s_4281(param1 as PlayerChristmasPostNotify);
         }
         else if(param1.code == CommandCodePlayerGame.PLAYER_CHRISTMAS_VALUE_NOTIFY)
         {
            DiversityManager.setTextField(obf_K_e_3075.obf_T_j_1737.txtCent,"ChristmasUI","txtCent",[(param1 as PlayerChristmasValueNotify).value]);
            DiversityManager.setTextField(obf_K_e_3075.centShopUI.txtCent,"ChristmasUI","txtCent",[(param1 as PlayerChristmasValueNotify).value]);
         }
      }
      
      private static function obf_8_D_2742(param1:PlayerChristmasDrawAnswer) : void
      {
         if(!obf_K_e_3075.obf_T_j_1737)
         {
            return;
         }
         obf_K_e_3075.obf_T_j_1737.onHaveItems(param1.items);
      }
      
      private static function obf_6_s_4281(param1:PlayerChristmasPostNotify) : void
      {
         if(!obf_K_e_3075.obf_T_j_1737)
         {
            return;
         }
         obf_K_e_3075.obf_T_j_1737.showOtherInfo(param1.playerName,param1.itemCode);
      }
   }
}

