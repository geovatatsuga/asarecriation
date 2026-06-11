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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4751")]
   public dynamic class PlayerSkillFastApplyUIMC extends MovieClip
   {
      
      public var txtSkill:TextField;
      
      public var bgBox:MovieClip;
      
      public var bagSkill:IconBarMC;
      
      public var txtDeyTitle:TextField;
      
      public var cmdSkill:MainButton;
      
      public var cmdClose:SimpleButton;
      
      public function PlayerSkillFastApplyUIMC()
      {
         super();
         obf_v_q_959();
      }
      
      internal function obf_v_q_959() : *
      {
         try
         {
            cmdSkill["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSkill.emphasized = false;
         cmdSkill.enabled = true;
         cmdSkill.label = "obf___4878";
         cmdSkill.labelPlacement = "right";
         cmdSkill.selected = false;
         cmdSkill.toggle = false;
         cmdSkill.visible = true;
         try
         {
            cmdSkill["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

