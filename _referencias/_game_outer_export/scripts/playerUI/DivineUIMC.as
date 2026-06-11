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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1327")]
   public dynamic class DivineUIMC extends MovieClip
   {
      
      public var txtDivineName:TextField;
      
      public var cmdDivine:MainButton;
      
      public var txtNextAttrExplain:TextField;
      
      public var bgBox:MovieClip;
      
      public var equipIcon:IconBarMC;
      
      public var titleBox:MovieClip;
      
      public var txtDayCurrentAttr2:TextField;
      
      public var txtNextAtts:TextField;
      
      public var cmdGain:MainButton;
      
      public var txtCurrentAttrExplain:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var txtEquip:TextField;
      
      public var txtDayCurrentAttr:TextField;
      
      public var txtExplain:TextField;
      
      public var txtValue:TextField;
      
      public var txtDivineValue:TextField;
      
      public var cmdUp:MainButton;
      
      public var txtNum:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var txtCurrentAtts:TextField;
      
      public function DivineUIMC()
      {
         super();
         obf_r_a_3976();
         obf_r_U_811();
         obf_K_b_2455();
      }
      
      internal function obf_r_a_3976() : *
      {
         try
         {
            cmdDivine["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdDivine.emphasized = false;
         cmdDivine.enabled = true;
         cmdDivine.label = "obf_____4719";
         cmdDivine.labelPlacement = "right";
         cmdDivine.selected = false;
         cmdDivine.toggle = false;
         cmdDivine.visible = true;
         try
         {
            cmdDivine["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_r_U_811() : *
      {
         try
         {
            cmdUp["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdUp.emphasized = false;
         cmdUp.enabled = true;
         cmdUp.label = "obf_____4803";
         cmdUp.labelPlacement = "right";
         cmdUp.selected = false;
         cmdUp.toggle = false;
         cmdUp.visible = true;
         try
         {
            cmdUp["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_K_b_2455() : *
      {
         try
         {
            cmdGain["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdGain.emphasized = false;
         cmdGain.enabled = true;
         cmdGain.label = "Receive Divination Device";
         cmdGain.labelPlacement = "right";
         cmdGain.selected = false;
         cmdGain.toggle = false;
         cmdGain.visible = true;
         try
         {
            cmdGain["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

