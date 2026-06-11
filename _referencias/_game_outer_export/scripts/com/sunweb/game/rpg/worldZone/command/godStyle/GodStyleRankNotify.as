package com.sunweb.game.rpg.worldZone.command.godStyle
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class GodStyleRankNotify extends obf_O_8_1034
   {
      
      public var godStyleId:String;
      
      public var rankList:Array;
      
      public function GodStyleRankNotify()
      {
         super(CommandCodeGodStyle.GOD_STYLE_RANK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["godStyleId:string","rankList:array(com.sunweb.game.rpg.godStyle.GodStyleRankInfo)"];
      }
   }
}

