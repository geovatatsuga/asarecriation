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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol765")]
   public dynamic class RenewPlanUIMC extends MovieClip
   {
      
      public var planPoint:MovieClip;
      
      public var bag0:IconBarMC;
      
      public var bgBox:MovieClip;
      
      public var cmdRenew:MainButton;
      
      public var txtSelectPlan:TextField;
      
      public var obf_z_1002:UIScrollBar;
      
      public var txtDeyTitle:TextField;
      
      public var cmdClose:SimpleButton;
      
      public function RenewPlanUIMC()
      {
         super();
         obf_c_i_4075();
      }
      
      internal function obf_c_i_4075() : *
      {
         try
         {
            cmdRenew["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdRenew.emphasized = false;
         cmdRenew.enabled = true;
         cmdRenew.label = "obf___4868";
         cmdRenew.labelPlacement = "right";
         cmdRenew.selected = false;
         cmdRenew.toggle = false;
         cmdRenew.visible = true;
         try
         {
            cmdRenew["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

