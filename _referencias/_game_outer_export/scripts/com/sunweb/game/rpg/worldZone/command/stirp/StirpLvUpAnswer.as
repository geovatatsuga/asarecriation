package com.sunweb.game.rpg.worldZone.command.stirp
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.role.RoleAttributesInfo;
   
   public class StirpLvUpAnswer extends obf_O_8_1034
   {
      
      public var stirpLevel:int;
      
      public var potentialLevel:int;
      
      public var potentialValue:int;
      
      public var isStirpLvUp:Boolean;
      
      public var isBuleLvUp:Boolean;
      
      public var stirpAttrInfo:RoleAttributesInfo;
      
      public function StirpLvUpAnswer()
      {
         super(CommandCodeStirp.PLAYER_STIRP_LVUP_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["stirpLevel:int","potentialLevel:ubyte","potentialValue:int","isStirpLvUp:boolean","isBuleLvUp:boolean"];
      }
   }
}

