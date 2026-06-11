package com.sunweb.game.rpg.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class FamilyTaskInfo extends obf_2_M_853
   {
      
      public var taskId:int;
      
      public var timesTotal:int;
      
      public var timesAvailable:int;
      
      public function FamilyTaskInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["taskId:ushort","timesTotal:byte","timesAvailable:byte"];
      }
   }
}

