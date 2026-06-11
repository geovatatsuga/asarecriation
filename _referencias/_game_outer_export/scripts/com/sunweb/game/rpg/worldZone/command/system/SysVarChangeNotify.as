package com.sunweb.game.rpg.worldZone.command.system
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.worldZone.command.CommandCodeWorld;
   
   public class SysVarChangeNotify extends obf_O_8_1034
   {
      
      public var boolVars:Object;
      
      public var intVars:Object;
      
      public var strVars:Object;
      
      public function SysVarChangeNotify()
      {
         super(CommandCodeWorld.SYS_VAR_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["boolVars:map(string,boolean)","intVars:map(string,vint)","strVars:map(string,string)"];
      }
   }
}

