package com.sunweb.game.rpg.roleZone.command
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class SelectRoleAnswer extends obf_O_8_1034
   {
      
      public var isDone:Boolean;
      
      public var failureReason:String;
      
      public function SelectRoleAnswer()
      {
         super(CommandCodeRole.SELECT_ROLE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["isDone:boolean","failureReason:string"];
      }
   }
}

