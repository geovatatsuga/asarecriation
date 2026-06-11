package com.sunweb.game.rpg.worldZone.command
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class WorldLoginAnswer extends obf_O_8_1034
   {
      
      public var isDone:Boolean;
      
      public var failureReason:String;
      
      public function WorldLoginAnswer()
      {
         super(CommandCodeWorld.WORLD_LOGIN_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["isDone:boolean","failureReason:string"];
      }
   }
}

