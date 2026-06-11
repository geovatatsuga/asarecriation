package com.sunweb.game.rpg.roleZone.command
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class DeleteRoleAnswer extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var deleteState:int;
      
      public var willDeleteTime:String;
      
      public var failureReason:String;
      
      public function DeleteRoleAnswer()
      {
         super(CommandCodeRole.DELETE_ROLE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","deleteState:ubyte","willDeleteTime:string","failureReason:string"];
      }
   }
}

