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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol364")]
   public dynamic class RebirthUIMC extends MovieClip
   {
      
      public var bgBox:MovieClip;
      
      public var txtSkillRebirth:TextField;
      
      public var moneyPoint:MovieClip;
      
      public var cmdPerfectRebirth:MainButton;
      
      public var txtPrompt:TextField;
      
      public var cmdSkillRebirth:MainButton;
      
      public var txtDeyTitle:TextField;
      
      public var cmdRebirth:MainButton;
      
      public function RebirthUIMC()
      {
         super();
         obf_i_d_2728();
         obf_p_L_4363();
         obf_4_D_2973();
      }
      
      internal function obf_i_d_2728() : *
      {
         try
         {
            cmdPerfectRebirth["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdPerfectRebirth.emphasized = false;
         cmdPerfectRebirth.enabled = true;
         cmdPerfectRebirth.label = "obf_____4816";
         cmdPerfectRebirth.labelPlacement = "right";
         cmdPerfectRebirth.selected = false;
         cmdPerfectRebirth.toggle = false;
         cmdPerfectRebirth.visible = true;
         try
         {
            cmdPerfectRebirth["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_p_L_4363() : *
      {
         try
         {
            cmdRebirth["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdRebirth.emphasized = false;
         cmdRebirth.enabled = true;
         cmdRebirth.label = "obf_____4746";
         cmdRebirth.labelPlacement = "right";
         cmdRebirth.selected = false;
         cmdRebirth.toggle = false;
         cmdRebirth.visible = true;
         try
         {
            cmdRebirth["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_4_D_2973() : *
      {
         try
         {
            cmdSkillRebirth["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSkillRebirth.emphasized = false;
         cmdSkillRebirth.enabled = true;
         cmdSkillRebirth.label = "obf_____4713";
         cmdSkillRebirth.labelPlacement = "right";
         cmdSkillRebirth.selected = false;
         cmdSkillRebirth.toggle = false;
         cmdSkillRebirth.visible = true;
         try
         {
            cmdSkillRebirth["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

