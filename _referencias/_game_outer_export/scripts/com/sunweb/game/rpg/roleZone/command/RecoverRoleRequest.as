package com.sunweb.game.rpg.roleZone.command
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RecoverRoleRequest extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public function RecoverRoleRequest()
      {
         super(CommandCodeRole.RECOVER_ROLE_REQ);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string"];
      }
   }
}

