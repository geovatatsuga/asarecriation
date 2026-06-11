package com.sunweb.game.rpg.roleZone.command
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.role.RoleBaseInfo;
   
   public class CreateRoleRequest extends obf_O_8_1034
   {
      
      public var landCode:String;
      
      public var role:RoleBaseInfo;
      
      public function CreateRoleRequest()
      {
         super(CommandCodeRole.CREATE_ROLE_REQ);
      }
      
      override public function getFieldList() : Array
      {
         return ["landCode:string","role:com.sunweb.game.rpg.role.RoleBaseInfo"];
      }
      
      override public function getDigestKey() : int
      {
         return 61701;
      }
   }
}

