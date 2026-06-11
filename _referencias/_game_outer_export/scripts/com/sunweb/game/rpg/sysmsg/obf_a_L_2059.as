package com.sunweb.game.rpg.sysmsg
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.sysmsg.CommandCodeSysMsg;
   import com.sunweb.game.rpg.worldZone.command.sysmsg.SysMsgViewAnswer;
   import com.sunweb.game.rpg.worldZone.command.sysmsg.SysMsgViewRequest;
   
   public class obf_a_L_2059
   {
      
      public function obf_a_L_2059()
      {
         super();
      }
      
      public static function obf_5_U_4501(param1:int) : void
      {
         var _loc2_:SysMsgViewRequest = new SysMsgViewRequest();
         _loc2_.pageIndex = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeSysMsg.SYSMSG_VIEW_ANSWER)
         {
            obf_B_M_2372(param1 as SysMsgViewAnswer);
         }
         else if(param1.code == CommandCodeSysMsg.SYSMSG_NEW_NOTIFY)
         {
            obf_m_y_3710();
         }
      }
      
      private static function obf_B_M_2372(param1:SysMsgViewAnswer) : void
      {
         if(Boolean(obf_K_e_3075.obf_L_9_3749) && param1.pageIndex <= 1)
         {
            obf_K_e_3075.obf_L_9_3749.obf_5_8_3960 = false;
         }
         if(obf_K_e_3075.obf_L_9_3749)
         {
            obf_K_e_3075.obf_L_9_3749.showSysMsg(param1.msgList,param1.pageIndex);
         }
      }
      
      private static function obf_m_y_3710() : void
      {
         if(obf_K_e_3075.obf_L_9_3749)
         {
            obf_K_e_3075.obf_L_9_3749.obf_5_8_3960 = true;
         }
      }
   }
}

