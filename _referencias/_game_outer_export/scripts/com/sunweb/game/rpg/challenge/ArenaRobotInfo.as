package com.sunweb.game.rpg.challenge
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class ArenaRobotInfo extends obf_2_M_853
   {
      
      public var name:String;
      
      public var level:int;
      
      public var robotLevel:int;
      
      public var job:int;
      
      public var sex:int;
      
      public function ArenaRobotInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["name:string","level:ubyte","robotLevel:ushort","job:ubyte","sex:ubyte"];
      }
   }
}

