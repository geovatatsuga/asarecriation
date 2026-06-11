package com.sunweb.game.rpg.worldZone.command.gm
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class GM_CommandAnswer extends obf_O_8_1034
   {
      
      public var result:String;
      
      public function GM_CommandAnswer()
      {
         super(CommandCodeGM.GM_COMMAND_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["result:string"];
      }
   }
}

