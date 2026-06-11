package com.sunweb.game.rpg.worldZone.command.pis
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PisCheckNotify extends obf_O_8_1034
   {
      
      public var isChild:Boolean;
      
      public var pisStatus:int;
      
      public var pisOnlineSec:int;
      
      public function PisCheckNotify()
      {
         super(CommandCodePIS.PIS_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["isChild:boolean","pisStatus:byte","pisOnlineSec:int"];
      }
   }
}

