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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol480")]
   public dynamic class AdhocBoxUIMC extends MovieClip
   {
      
      public var cmdNextPage:MainButton;
      
      public var itemPoint:MovieClip;
      
      public var cmdPrvPage:MainButton;
      
      public var txtspTitle:TextField;
      
      public var bgBox:MovieClip;
      
      public var moneyPoint:MovieClip;
      
      public var titleBox:MovieClip;
      
      public var txtTime:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var txtPage:TextField;
      
      public function AdhocBoxUIMC()
      {
         super();
         obf_6_M_3340();
         obf_0_5_8_65();
      }
      
      internal function obf_6_M_3340() : *
      {
         try
         {
            cmdNextPage["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdNextPage.emphasized = false;
         cmdNextPage.enabled = true;
         cmdNextPage.label = "obf____4854";
         cmdNextPage.labelPlacement = "right";
         cmdNextPage.selected = false;
         cmdNextPage.toggle = false;
         cmdNextPage.visible = true;
         try
         {
            cmdNextPage["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_5_8_65() : *
      {
         try
         {
            cmdPrvPage["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdPrvPage.emphasized = false;
         cmdPrvPage.enabled = true;
         cmdPrvPage.label = "obf____4858";
         cmdPrvPage.labelPlacement = "right";
         cmdPrvPage.selected = false;
         cmdPrvPage.toggle = false;
         cmdPrvPage.visible = true;
         try
         {
            cmdPrvPage["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

