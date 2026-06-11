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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3152")]
   public dynamic class PetDepotUIMC extends MovieClip
   {
      
      public var page1:MovieClip;
      
      public var page2:MovieClip;
      
      public var page4:MovieClip;
      
      public var txtEquNum:TextField;
      
      public var txtArr:TextField;
      
      public var page3:MovieClip;
      
      public var bgBox:MovieClip;
      
      public var closeButton:SimpleButton;
      
      public var txtIconBarNum:TextField;
      
      public var cmdUpLv:MainButton;
      
      public var txtRemark1:TextField;
      
      public var txtRemark2:TextField;
      
      public var cmdPage1:TableButton;
      
      public var cmdPage2:TableButton;
      
      public var cmdPage3:TableButton;
      
      public var cmdPage4:TableButton;
      
      public var txtDayEquNum:TextField;
      
      public var txtLv:TextField;
      
      public var titleBox:MovieClip;
      
      public var txtDeyTitle:TextField;
      
      public var txtDayArr:TextField;
      
      public function PetDepotUIMC()
      {
         super();
         obf_b_d_2359();
      }
      
      internal function obf_b_d_2359() : *
      {
         try
         {
            cmdUpLv["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdUpLv.emphasized = false;
         cmdUpLv.enabled = true;
         cmdUpLv.label = "obf___4912";
         cmdUpLv.labelPlacement = "right";
         cmdUpLv.selected = false;
         cmdUpLv.toggle = false;
         cmdUpLv.visible = true;
         try
         {
            cmdUpLv["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

