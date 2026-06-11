package com.sunweb.game.rpg.worldZone.command.gm
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class GM_CommandRequest extends obf_O_8_1034
   {
      
      public var cmdLine:String;
      
      public function GM_CommandRequest()
      {
         super(CommandCodeGM.GM_COMMAND_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["cmdLine:string"];
      }
   }
}

