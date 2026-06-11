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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2381")]
   public dynamic class MakeChipBoxUIMC extends MovieClip
   {
      
      public var bgBox:MovieClip;
      
      public var cmdMake:MainButton;
      
      public var titleBox:MovieClip;
      
      public var cmdDraw:MainButton;
      
      public var cmdClose:SimpleButton;
      
      public var txtExplain:TextField;
      
      public var txtExplain1:TextField;
      
      public var txtExplain2:TextField;
      
      public var txtExplain3:TextField;
      
      public var txtName1:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var txtName3:TextField;
      
      public var txtName2:TextField;
      
      public function MakeChipBoxUIMC()
      {
         super();
         obf_1_2714();
         obf_m_1_4626();
      }
      
      internal function obf_m_1_4626() : *
      {
         try
         {
            cmdDraw["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdDraw.emphasized = false;
         cmdDraw.enabled = true;
         cmdDraw.label = "obf_______3532";
         cmdDraw.labelPlacement = "right";
         cmdDraw.selected = false;
         cmdDraw.toggle = false;
         cmdDraw.visible = true;
         try
         {
            cmdDraw["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_1_2714() : *
      {
         try
         {
            cmdMake["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdMake.emphasized = false;
         cmdMake.enabled = true;
         cmdMake.label = "obf_______933";
         cmdMake.labelPlacement = "right";
         cmdMake.selected = false;
         cmdMake.toggle = false;
         cmdMake.visible = true;
         try
         {
            cmdMake["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

