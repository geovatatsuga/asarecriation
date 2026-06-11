package com.sunweb.game.rpg.baby
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class BabyInfo extends obf_2_M_853
   {
      
      public var sex:int;
      
      public var level:int;
      
      public var exp:int;
      
      public var foodValue:int;
      
      public var strength:int;
      
      public var agility:int;
      
      public var wisdom:int;
      
      public var vitality:int;
      
      public var strengthMax:int;
      
      public var agilityMax:int;
      
      public var wisdomMax:int;
      
      public var vitalityMax:int;
      
      public var studyArea:int;
      
      public var studyOver:Object;
      
      public var collegeMap:Object;
      
      public var luckLand:int;
      
      public var travelLand:int;
      
      public var travelOver:int;
      
      public var bloodLevel:int;
      
      public var bloodExp:int;
      
      public function BabyInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["sex:ubyte","level:ubyte","exp:int","foodValue:ubyte","strength:int","agility:int","wisdom:int","vitality:int","strengthMax:int","agilityMax:int","wisdomMax:int","vitalityMax:int","studyArea:ubyte","studyOver:map(ubyte,int)","collegeMap:map(ubyte,ubyte)","luckLand:ubyte","travelLand:byte","travelOver:int","bloodLevel:ubyte","bloodExp:ushort"];
      }
   }
}

