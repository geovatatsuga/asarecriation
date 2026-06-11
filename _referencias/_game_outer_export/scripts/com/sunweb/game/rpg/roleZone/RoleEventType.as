package com.sunweb.game.rpg.roleZone
{
   import com.sunweb.game.rpg.roleZone.command.CommandCodeRole;
   
   public class RoleEventType
   {
      
      public static const ROLE_LIST_ANSWER:String = CommandCodeRole.ROLE_LIST_ANSWER.toString(16);
      
      public static const SELECT_ROLE_ANSWER:String = CommandCodeRole.SELECT_ROLE_ANSWER.toString(16);
      
      public static const CREATE_ROLE_ANSWER:String = CommandCodeRole.CREATE_ROLE_ANSWER.toString(16);
      
      public static const DELETE_ROLE_ANSWER:String = CommandCodeRole.DELETE_ROLE_ANSWER.toString(16);
      
      public static const ROLE_NAME_CONFIRM_ANSWER:String = CommandCodeRole.ROLE_NAME_CONFIRM_ANSWER.toString(16);
      
      public static const RECOVER_ROLE_ANSWER:String = CommandCodeRole.RECOVER_ROLE_ANSWER.toString(16);
      
      public static const SET_ROLE_PW_ANSWER:String = CommandCodeRole.SET_ROLE_PW_ANSWER.toString(16);
      
      public function RoleEventType()
      {
         super();
      }
   }
}

