package com.sunweb.game.rpg.roleZone.command
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RecoverRoleAnswer extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var isDone:Boolean;
      
      public var failureReason:String;
      
      public function RecoverRoleAnswer()
      {
         super(CommandCodeRole.RECOVER_ROLE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","isDone:boolean","failureReason:string"];
      }
   }
}

