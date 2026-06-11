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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3050")]
   public dynamic class CountryUIMC extends MovieClip
   {
      
      public var txtWorldWit:TextField;
      
      public var txtWorldRoot:TextField;
      
      public var mapPoint:MovieClip;
      
      public var txtLandAttr:TextField;
      
      public var txtPeople:TextField;
      
      public var txtLandName:TextField;
      
      public var bgBox2:MovieClip;
      
      public var bgBox3:MovieClip;
      
      public var bgBox4:MovieClip;
      
      public var txtCountryLv:TextField;
      
      public var txtCountryName:TextField;
      
      public var txtUpCondition:TextField;
      
      public var txtCountryAttrs:TextField;
      
      public var txtLandAttrName:TextField;
      
      public var button1:SimpleButton;
      
      public var button2:SimpleButton;
      
      public var button3:SimpleButton;
      
      public var txtCountryAttrName:TextField;
      
      public var button6:SimpleButton;
      
      public var button7:SimpleButton;
      
      public var button8:SimpleButton;
      
      public var button9:SimpleButton;
      
      public var txtDeyTitle:TextField;
      
      public var button4:SimpleButton;
      
      public var button5:SimpleButton;
      
      public var titleBox:MovieClip;
      
      public var cmdLand:MainButton;
      
      public var bgBox:MovieClip;
      
      public var mapButtonsMC:MovieClip;
      
      public var cmdClose:SimpleButton;
      
      public var txtLandLv:TextField;
      
      public var cmdCountry:MainButton;
      
      public function CountryUIMC()
      {
         super();
         obf_0_7_W_229();
         obf_b_X_3339();
      }
      
      internal function obf_0_7_W_229() : *
      {
         try
         {
            cmdCountry["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdCountry.emphasized = false;
         cmdCountry.enabled = true;
         cmdCountry.label = "obf_____4823";
         cmdCountry.labelPlacement = "right";
         cmdCountry.selected = false;
         cmdCountry.toggle = false;
         cmdCountry.visible = true;
         try
         {
            cmdCountry["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_b_X_3339() : *
      {
         try
         {
            cmdLand["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdLand.emphasized = false;
         cmdLand.enabled = true;
         cmdLand.label = "obf_____4829";
         cmdLand.labelPlacement = "right";
         cmdLand.selected = false;
         cmdLand.toggle = false;
         cmdLand.visible = true;
         try
         {
            cmdLand["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

