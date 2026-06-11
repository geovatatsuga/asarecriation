package com.sunweb.game.rpg.worldZone.command.incubator
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class IncubatorInfoNotify extends obf_O_8_1034
   {
      
      public var itemCode:String;
      
      public var endTime:int;
      
      public var pressure:int;
      
      public var temp:int;
      
      public var power:int;
      
      public var haveItems:Object;
      
      public var state:int;
      
      public function IncubatorInfoNotify()
      {
         super(CommandCodeIncubator.INCUBATOR_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemCode:string","endTime:int","pressure:short","temp:short","power:short","haveItems:map(string,short)","state:ubyte"];
      }
   }
}

