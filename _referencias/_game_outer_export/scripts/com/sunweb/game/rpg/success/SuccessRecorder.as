package com.sunweb.game.rpg.success
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class SuccessRecorder extends obf_2_M_853
   {
      
      public var doneSuccesses:Array = new Array();
      
      public function SuccessRecorder()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["doneSuccesses:array(ushort)"];
      }
   }
}

