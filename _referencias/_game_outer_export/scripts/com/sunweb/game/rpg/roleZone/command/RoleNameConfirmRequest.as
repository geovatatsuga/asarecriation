package com.sunweb.game.rpg.roleZone.command
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RoleNameConfirmRequest extends obf_O_8_1034
   {
      
      public var name:String;
      
      public function RoleNameConfirmRequest()
      {
         super(CommandCodeRole.ROLE_NAME_CONFIRM_REQ);
      }
      
      override public function getFieldList() : Array
      {
         return ["name:string"];
      }
   }
}

