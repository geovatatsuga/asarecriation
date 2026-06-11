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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2178")]
   public dynamic class ActivationMC extends MovieClip
   {
      
      public var activationLv:TextField;
      
      public var obf_A_u_3278:TextField;
      
      public var txtActivationMaterial:TextField;
      
      public var txtActivationLv:TextField;
      
      public var txtActivationExplain:TextField;
      
      public var obf_V_L_2703:IconBarMC;
      
      public var cmdActivation:MainButton;
      
      public var txtActivationName:TextField;
      
      public function ActivationMC()
      {
         super();
         __setProp_cmdActivation_();
      }
      
      internal function __setProp_cmdActivation_() : *
      {
         try
         {
            cmdActivation["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdActivation.emphasized = false;
         cmdActivation.enabled = true;
         cmdActivation.label = "obf_____4715";
         cmdActivation.labelPlacement = "right";
         cmdActivation.selected = false;
         cmdActivation.toggle = false;
         cmdActivation.visible = true;
         try
         {
            cmdActivation["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

