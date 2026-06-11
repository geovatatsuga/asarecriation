package com.sunweb.game.rpg.activity
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class ConsumeInfo extends obf_2_M_853
   {
      
      public var playerName:String;
      
      public var headIconIndex:int;
      
      public var consume:int;
      
      public function ConsumeInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["playerName:string","headIconIndex:ushort","consume:int"];
      }
   }
}

