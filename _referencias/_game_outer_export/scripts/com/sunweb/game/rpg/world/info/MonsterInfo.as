package com.sunweb.game.rpg.world.info
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class MonsterInfo extends obf_2_M_853
   {
      
      public var ownerPlayerId:String;
      
      public var id:String;
      
      public var monsterCode:String;
      
      public var level:int;
      
      public var x:int;
      
      public var y:int;
      
      public var pathArrayReversed:Array;
      
      public var walkSpeed:int;
      
      public var hpPercent:int;
      
      public var isBoss:Boolean;
      
      public var prefixArray:Array;
      
      public var buffArray:Array;
      
      public function MonsterInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["ownerPlayerId:string","id:string","monsterCode:string","level:short","x:short","y:short","pathArrayReversed:array(com.sunweb.game.rpg.world.map.MapPoint)","walkSpeed:short","hpPercent:byte","isBoss:boolean","prefixArray:array(string)","buffArray:array(com.sunweb.game.rpg.buff.BuffInfo)"];
      }
   }
}

