package com.sunweb.game.rpg.gameItem
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class ItemEquipmentInfo extends obf_2_M_853
   {
      
      public var isRandomQuality:Boolean;
      
      public var quality:int;
      
      public var durabilityMax:int;
      
      public var durabilityCurrent:int;
      
      public var isRandomExtAttr:Boolean;
      
      public var extAttributes:String;
      
      public var isBinded:Boolean = false;
      
      public var holeNumber:int = 0;
      
      public var embedGemCodeList:Array;
      
      public var refineLevel:int = 0;
      
      public var fusionAttributes:String;
      
      public var fusionEquCode:String;
      
      public var washRate:Number;
      
      public var skillHoleNum:int;
      
      public var fusionedSkillList:Array;
      
      public var extSkillList:Array;
      
      public var consciousLevel:int;
      
      public var consciousMaster:String;
      
      public var letteringWord:String;
      
      public var letteringRole:String;
      
      public var equLevel:int = 0;
      
      public var equExp:int = 0;
      
      public var demonAttr:String;
      
      public var rebirth:int;
      
      public var soulType:int;
      
      public var soulLevel:int;
      
      public var legendHole:int = 0;
      
      public var legends:Object;
      
      public var addSoulLevel:int;
      
      public var divineAttr:String;
      
      public var wingSpiritMap:Array;
      
      public var wingSpiritSkills:Object;
      
      public var feedGodAttr:String;
      
      public var kindGrowLevel:int;
      
      public var kindGrowRate:Number;
      
      public var revealSlotSkill:Array;
      
      public var revealSlotIndex:int;
      
      public var revealSkill:Object;
      
      public function ItemEquipmentInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["isRandomQuality:boolean","quality:byte","durabilityMax:short","durabilityCurrent:short","isRandomExtAttr:boolean","extAttributes:string","isBinded:boolean","holeNumber:byte","embedGemCodeList:array(string)","refineLevel:byte","fusionAttributes:string","fusionEquCode:string","washRate:float","skillHoleNum:byte","fusionedSkillList:array(com.sunweb.game.rpg.equ.EquSkillSlot)","extSkillList:array(com.sunweb.game.rpg.equ.EquSkillSlot)","consciousLevel:byte","consciousMaster:string","letteringWord:string","letteringRole:string","equLevel:ushort","equExp:vint","demonAttr:string","rebirth:ubyte","soulType:ubyte","soulLevel:ushort","legendHole:ubyte","legends:map(ubyte,string)","addSoulLevel:ushort","divineAttr:string","wingSpiritMap:array(com.sunweb.game.rpg.wingSpirit.WingSpiritInfo)","wingSpiritSkills:map(string,ubyte)","feedGodAttr:string","kindGrowLevel:ubyte","kindGrowRate:float","revealSlotSkill:array(com.sunweb.game.rpg.reveal.RevealSkillSlot)","revealSkill:map(string,ubyte)","revealSlotIndex:ubyte"];
      }
   }
}

