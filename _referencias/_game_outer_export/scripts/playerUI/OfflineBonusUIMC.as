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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol701")]
   public dynamic class OfflineBonusUIMC extends MovieClip
   {
      
      public var bgBox:MovieClip;
      
      public var txtExp:TextField;
      
      public var titleBox:MovieClip;
      
      public var cmdOK:MainButton;
      
      public var txtDeyItems:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var txtDeyPrompt1:TextField;
      
      public var txtDeyPrompt2:TextField;
      
      public var bag0:IconBarMC;
      
      public var bag1:IconBarMC;
      
      public var bag3:IconBarMC;
      
      public var bag2:IconBarMC;
      
      public var bag4:IconBarMC;
      
      public var txtDeyExp:TextField;
      
      public var txtDeyTitle:TextField;
      
      public function OfflineBonusUIMC()
      {
         super();
         obf_7_X_4359();
      }
      
      internal function obf_7_X_4359() : *
      {
         try
         {
            cmdOK["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdOK.emphasized = false;
         cmdOK.enabled = true;
         cmdOK.label = "obf___4957";
         cmdOK.labelPlacement = "right";
         cmdOK.selected = false;
         cmdOK.toggle = false;
         cmdOK.visible = true;
         try
         {
            cmdOK["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

