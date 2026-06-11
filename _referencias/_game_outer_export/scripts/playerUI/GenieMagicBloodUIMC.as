package playerUI
{
   import adobe.utils.*;
   import fl.controls.UIScrollBar;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2067")]
   public dynamic class GenieMagicBloodUIMC extends MovieClip
   {
      
      public var txtAttr:TextField;
      
      public var cmdTalent:MainButton;
      
      public var obf_i_C_3008:UIScrollBar;
      
      public var txtSkill:TextField;
      
      public var pointBlood:MovieClip;
      
      public var txtAttrName:TextField;
      
      public var txtGenieTalentLv:TextField;
      
      public var txtStone:TextField;
      
      public var txtskillAttr:TextField;
      
      public var txtChance:TextField;
      
      public function GenieMagicBloodUIMC()
      {
         super();
         obf_N_S_1729();
      }
      
      internal function obf_N_S_1729() : *
      {
         try
         {
            cmdTalent["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdTalent.emphasized = false;
         cmdTalent.enabled = true;
         cmdTalent.label = "obf_____4759";
         cmdTalent.labelPlacement = "right";
         cmdTalent.selected = false;
         cmdTalent.toggle = false;
         cmdTalent.visible = true;
         try
         {
            cmdTalent["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

