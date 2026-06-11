package com.sunweb.game.rpg.genie
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class GenieBriefInfo extends obf_2_M_853
   {
      
      public var genieId:String;
      
      public var genieCode:String;
      
      public function GenieBriefInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["genieId:string","genieCode:string"];
      }
   }
}

