package com.sunweb.game.rpg.mail
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.mail.CommandCodeMail;
   import com.sunweb.game.rpg.worldZone.command.mail.MailDeleteRequest;
   import com.sunweb.game.rpg.worldZone.command.mail.MailListAnswer;
   import com.sunweb.game.rpg.worldZone.command.mail.MailListRequest;
   import com.sunweb.game.rpg.worldZone.command.mail.MailNewNotify;
   import com.sunweb.game.rpg.worldZone.command.mail.MailSendAnswer;
   import com.sunweb.game.rpg.worldZone.command.mail.MailSendRequest;
   import com.sunweb.game.rpg.worldZone.command.mail.MailViewAnswer;
   import com.sunweb.game.rpg.worldZone.command.mail.MailViewRequest;
   
   public class obf_G_6_4257
   {
      
      public static const obf_0_9_5_629:int = 0;
      
      public static const obf_p_U_3894:int = 1;
      
      public function obf_G_6_4257()
      {
         super();
      }
      
      public static function showSendMailUI(param1:int, param2:String) : void
      {
         obf_K_e_3075.closeUI(obf_K_e_3075.mailViewUI);
         if(obf_K_e_3075.mailSendUI)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.mailSendUI);
            obf_K_e_3075.mailSendUI.setSendMailType(param1,param2);
         }
      }
      
      public static function sendMailList(param1:int) : void
      {
         var _loc2_:MailListRequest = new MailListRequest();
         _loc2_.pageIndex = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendDeleteMail(param1:int) : void
      {
         var _loc2_:MailDeleteRequest = new MailDeleteRequest();
         _loc2_.mailId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
         if(obf_K_e_3075.mailListUI)
         {
            obf_K_e_3075.mailListUI.refreshList();
         }
      }
      
      public static function sendViewMail(param1:int) : void
      {
         var _loc2_:MailViewRequest = new MailViewRequest();
         _loc2_.mailId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendMail(param1:String, param2:int, param3:String, param4:String) : void
      {
         var _loc5_:MailSendRequest = new MailSendRequest();
         _loc5_.targetPlayer = param1;
         _loc5_.mailType = param2;
         _loc5_.mailTitle = param3;
         _loc5_.mailContent = param4;
         GameContext.worldClient.sendCommand(_loc5_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeMail.MAIL_LIST_ANSWER)
         {
            onMailList(param1 as MailListAnswer);
         }
         else if(param1.code == CommandCodeMail.MAIL_VIEW_ANSWER)
         {
            obf_u_e_1703(param1 as MailViewAnswer);
         }
         else if(param1.code == CommandCodeMail.MAIL_SEND_ANSWER)
         {
            obf_Q_P_1178(param1 as MailSendAnswer);
         }
         else if(param1.code == CommandCodeMail.MAIL_NEW_NOTIFY)
         {
            obf_O_j_1474(param1 as MailNewNotify);
         }
      }
      
      private static function onMailList(param1:MailListAnswer) : void
      {
         if(obf_K_e_3075.mailListUI)
         {
            obf_K_e_3075.mailListUI.setMailList(param1.mailList,param1.pageIndex);
         }
      }
      
      private static function obf_u_e_1703(param1:MailViewAnswer) : void
      {
         if(obf_K_e_3075.mailViewUI)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.mailViewUI);
            obf_K_e_3075.mailViewUI.setMailContent(param1.mail);
         }
      }
      
      private static function obf_Q_P_1178(param1:MailSendAnswer) : void
      {
         if(param1.isSucceed)
         {
            obf_6_D_3816.print(DiversityManager.getString("MailSendUI","prompt_sendComplete"));
         }
         else
         {
            obf_6_D_3816.print(DiversityManager.getString("MailSendUI","prompt_sendFailed"));
         }
      }
      
      private static function obf_O_j_1474(param1:MailNewNotify) : void
      {
         if(obf_K_e_3075.systemTipUI)
         {
            obf_K_e_3075.systemTipUI.setMail(true);
         }
         if(Boolean(obf_K_e_3075.mailListUI) && obf_K_e_3075.mailListUI.visible)
         {
            obf_K_e_3075.mailListUI.refreshList();
         }
      }
   }
}

