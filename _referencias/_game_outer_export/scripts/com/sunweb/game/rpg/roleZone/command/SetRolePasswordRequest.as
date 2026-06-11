package com.sunweb.game.rpg.roleZone.command
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class SetRolePasswordRequest extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var oldPassword:String;
      
      public var password:String;
      
      public function SetRolePasswordRequest()
      {
         super(CommandCodeRole.SET_ROLE_PW_REQ);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","oldPassword:string","password:string"];
      }
   }
}

