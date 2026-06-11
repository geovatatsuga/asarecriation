package com.sunweb.game.rpg.worldZone.command.system
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.worldZone.command.CommandCodeWorld;
   
   public class SysVarClearNotify extends obf_O_8_1034
   {
      
      public var boolVars:Array;
      
      public var intVars:Array;
      
      public var strVars:Array;
      
      public function SysVarClearNotify()
      {
         super(CommandCodeWorld.SYS_VAR_CLEAR_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["boolVars:array(string)","intVars:array(string)","strVars:array(string)"];
      }
   }
}

