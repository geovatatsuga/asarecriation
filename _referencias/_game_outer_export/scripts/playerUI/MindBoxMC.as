package playerUI
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2168")]
   public dynamic class MindBoxMC extends MovieClip
   {
      
      public var txtHit:TextField;
      
      public var equ1:MovieClip;
      
      public var equ2:MovieClip;
      
      public var equ3:MovieClip;
      
      public var txtRemark:TextField;
      
      public var cmdLvUp:MainButton;
      
      public var txtHat:TextField;
      
      public var txtLv:TextField;
      
      public var cmdTianMind:MainButton;
      
      public var txtDeyDodge:TextField;
      
      public var txtDeyLv:TextField;
      
      public var txtMp:TextField;
      
      public var txtAmulet:TextField;
      
      public var bgBox:MovieClip;
      
      public var txtDodge:TextField;
      
      public var txtDeyMp:TextField;
      
      public var txtAllExp:TextField;
      
      public var cmdDiMind:MainButton;
      
      public var cmdGodMind:MainButton;
      
      public var txtSay:TextField;
      
      public var txtShoes:TextField;
      
      public var obf_3_817:MovieClip;
      
      public var txtDeyAllExp:TextField;
      
      public var txtCritRate:TextField;
      
      public var txtDeyHitRate:TextField;
      
      public var txtCrit:TextField;
      
      public var txtMagicDefense:TextField;
      
      public var txtDeyExp:TextField;
      
      public var txtDeyMagicDefense:TextField;
      
      public var txtDayStar:TextField;
      
      public var txtHitRate:TextField;
      
      public var txtDeyCritRate:TextField;
      
      public var txtMindName:TextField;
      
      public var txtPhysicalAttack:TextField;
      
      public var txtDeyCrit:TextField;
      
      public var txtExp:TextField;
      
      public var txtHp:TextField;
      
      public var txtDeyPhysicalAttack:TextField;
      
      public var txtWeapon:TextField;
      
      public var txtDeyMagicAttack:TextField;
      
      public var txtDeyDodgeRate:TextField;
      
      public var txtDeyHp:TextField;
      
      public var txtClothes:TextField;
      
      public var txtRing:TextField;
      
      public var txtDeyPhysicalDefense:TextField;
      
      public var txtMagicAttack:TextField;
      
      public var txtDodgeRate:TextField;
      
      public var txtGlove:TextField;
      
      public var txtPhysicalDefense:TextField;
      
      public var txtStar:TextField;
      
      public var txtDeyHit:TextField;
      
      public var txtShield:TextField;
      
      public function MindBoxMC()
      {
         super();
         obf_R_3_3227();
         obf_Q_j_3486();
         obf_0_2_9_181();
      }
      
      internal function obf_R_3_3227() : *
      {
         try
         {
            cmdDiMind["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdDiMind.emphasized = false;
         cmdDiMind.enabled = true;
         cmdDiMind.label = "ghg";
         cmdDiMind.labelPlacement = "right";
         cmdDiMind.selected = false;
         cmdDiMind.toggle = false;
         cmdDiMind.visible = true;
         try
         {
            cmdDiMind["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_Q_j_3486() : *
      {
         try
         {
            cmdTianMind["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdTianMind.emphasized = false;
         cmdTianMind.enabled = true;
         cmdTianMind.label = "bghj";
         cmdTianMind.labelPlacement = "right";
         cmdTianMind.selected = false;
         cmdTianMind.toggle = false;
         cmdTianMind.visible = true;
         try
         {
            cmdTianMind["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_2_9_181() : *
      {
         try
         {
            cmdLvUp["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdLvUp.emphasized = false;
         cmdLvUp.enabled = true;
         cmdLvUp.label = "";
         cmdLvUp.labelPlacement = "right";
         cmdLvUp.selected = false;
         cmdLvUp.toggle = false;
         cmdLvUp.visible = true;
         try
         {
            cmdLvUp["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

