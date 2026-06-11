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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4737")]
   public dynamic class LandingHortationUIMC extends MovieClip
   {
      
      public var txtRunBoonGold:TextField;
      
      public var runBag0:IconBarMC;
      
      public var runBag1:IconBarMC;
      
      public var runBag3:IconBarMC;
      
      public var runBag2:IconBarMC;
      
      public var runButton:MainButton;
      
      public var txtRunBoon:TextField;
      
      public var dayBag0:IconBarMC;
      
      public var dayBag1:IconBarMC;
      
      public var dayBag3:IconBarMC;
      
      public var txtRunBonus:TextField;
      
      public var iconItem:MovieClip;
      
      public var dayBag2:IconBarMC;
      
      public var dayButton:MainButton;
      
      public var txtDayBonus:TextField;
      
      public var txtDays:TextField;
      
      public function LandingHortationUIMC()
      {
         super();
         obf_e_X_1310();
         obf_S_b_1489();
      }
      
      internal function obf_e_X_1310() : *
      {
         try
         {
            runButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         runButton.emphasized = false;
         runButton.enabled = true;
         runButton.label = "obf___4957";
         runButton.labelPlacement = "right";
         runButton.selected = false;
         runButton.toggle = false;
         runButton.visible = true;
         try
         {
            runButton["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_S_b_1489() : *
      {
         try
         {
            dayButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         dayButton.emphasized = false;
         dayButton.enabled = true;
         dayButton.label = "obf___4957";
         dayButton.labelPlacement = "right";
         dayButton.selected = false;
         dayButton.toggle = false;
         dayButton.visible = true;
         try
         {
            dayButton["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

