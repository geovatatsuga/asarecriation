package com.sunweb.game.rpg.roleZone.command
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.role.RoleSystemInfo;
   
   public class CreateRoleAnswer extends obf_O_8_1034
   {
      
      public var role:RoleSystemInfo;
      
      public var failureReason:String;
      
      public function CreateRoleAnswer()
      {
         super(CommandCodeRole.CREATE_ROLE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["role:com.sunweb.game.rpg.role.RoleSystemInfo","failureReason:string"];
      }
   }
}

