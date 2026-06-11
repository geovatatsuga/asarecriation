package com.sunweb.game.rpg.roleZone.command
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RoleListAnswer extends obf_O_8_1034
   {
      
      public var roles:Array;
      
      public function RoleListAnswer()
      {
         super(CommandCodeRole.ROLE_LIST_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["roles:array(com.sunweb.game.rpg.role.RoleSystemInfo)"];
      }
   }
}

