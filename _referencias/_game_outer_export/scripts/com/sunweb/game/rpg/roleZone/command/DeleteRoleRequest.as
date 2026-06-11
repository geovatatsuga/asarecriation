package com.sunweb.game.rpg.roleZone.command
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class DeleteRoleRequest extends obf_O_8_1034
   {
      
      public var name:String;
      
      public var password:String;
      
      public function DeleteRoleRequest()
      {
         super(CommandCodeRole.DELETE_ROLE_REQ);
      }
      
      override public function getFieldList() : Array
      {
         return ["name:string","password:string"];
      }
   }
}

