package com.sunweb.game.rpg.roleZone.command
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RoleNameConfirmAnswer extends obf_O_8_1034
   {
      
      public var isNameAvailable:Boolean;
      
      public function RoleNameConfirmAnswer()
      {
         super(CommandCodeRole.ROLE_NAME_CONFIRM_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["isNameAvailable:boolean"];
      }
   }
}

