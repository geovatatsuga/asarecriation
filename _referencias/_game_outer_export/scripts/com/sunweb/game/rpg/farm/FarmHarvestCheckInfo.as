package com.sunweb.game.rpg.farm
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class FarmHarvestCheckInfo extends obf_2_M_853
   {
      
      public var id:String;
      
      public var productRate:int;
      
      public var phaseIndex:int;
      
      public var phaseTimeLeftInSec:int;
      
      public var isIll:Boolean;
      
      public var promoteTimesCurrent:int = 0;
      
      public var productNumberTotal:int = 0;
      
      public var productNumberLeft:int = 0;
      
      public function FarmHarvestCheckInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["id:string","productRate:ubyte","phaseIndex:byte","phaseTimeLeftInSec:int","isIll:boolean","promoteTimesCurrent:ubyte","productNumberTotal:short","productNumberLeft:short"];
      }
   }
}

