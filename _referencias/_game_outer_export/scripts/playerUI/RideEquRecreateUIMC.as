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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1130")]
   public dynamic class RideEquRecreateUIMC extends MovieClip
   {
      
      public var txtAtt1:TextField;
      
      public var txtAtted1:TextField;
      
      public var soulRecreate:MainButton;
      
      public var txtAtted3:TextField;
      
      public var txtAtt2:TextField;
      
      public var txtAtted2:TextField;
      
      public var txtEx:TextField;
      
      public var txtSoul1:TextField;
      
      public var txtSoul2:TextField;
      
      public var txtSoul3:TextField;
      
      public var txtSouling1:TextField;
      
      public var txtSouling2:TextField;
      
      public var txtSouling3:TextField;
      
      public var cmdOK:MainButton;
      
      public var txtAtcing2:TextField;
      
      public var txtAtcing3:TextField;
      
      public var attributeRecreate:MainButton;
      
      public var txtAtt3:TextField;
      
      public var txtAtc2:TextField;
      
      public var txtAtc1:TextField;
      
      public var txtAtc3:TextField;
      
      public var txtAtcing1:TextField;
      
      public function RideEquRecreateUIMC()
      {
         super();
         obf_M_h_3957();
         obf_0_4649();
      }
      
      internal function obf_0_4649() : *
      {
         try
         {
            attributeRecreate["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         attributeRecreate.emphasized = false;
         attributeRecreate.enabled = true;
         attributeRecreate.label = "Reforge Attributes";
         attributeRecreate.labelPlacement = "right";
         attributeRecreate.selected = false;
         attributeRecreate.toggle = false;
         attributeRecreate.visible = true;
         try
         {
            attributeRecreate["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_M_h_3957() : *
      {
         try
         {
            soulRecreate["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         soulRecreate.emphasized = false;
         soulRecreate.enabled = true;
         soulRecreate.label = "Reforge Soul";
         soulRecreate.labelPlacement = "right";
         soulRecreate.selected = false;
         soulRecreate.toggle = false;
         soulRecreate.visible = true;
         try
         {
            soulRecreate["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

