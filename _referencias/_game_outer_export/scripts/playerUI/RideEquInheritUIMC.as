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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1534")]
   public dynamic class RideEquInheritUIMC extends MovieClip
   {
      
      public var obf_H_w_3575:UIScrollBar;
      
      public var InstanceName_0:MovieClip;
      
      public var InstanceName_1:MovieClip;
      
      public var cmdCancel:MainButton;
      
      public var cmdOk:MainButton;
      
      public var icon0:IconBarMC;
      
      public var icon1:IconBarMC;
      
      public var iconPoint:MovieClip;
      
      public function RideEquInheritUIMC()
      {
         super();
         obf_0___k_569();
         obf_Z_I_760();
         obf_0_4_N_94();
      }
      
      internal function obf_0___k_569() : *
      {
         try
         {
            cmdOk["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdOk.emphasized = false;
         cmdOk.enabled = true;
         cmdOk.label = "obf___4891";
         cmdOk.labelPlacement = "right";
         cmdOk.selected = false;
         cmdOk.toggle = false;
         cmdOk.visible = true;
         try
         {
            cmdOk["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_Z_I_760() : *
      {
         try
         {
            cmdCancel["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdCancel.emphasized = false;
         cmdCancel.enabled = true;
         cmdCancel.label = "obf___4932";
         cmdCancel.labelPlacement = "right";
         cmdCancel.selected = false;
         cmdCancel.toggle = false;
         cmdCancel.visible = true;
         try
         {
            cmdCancel["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_4_N_94() : *
      {
         try
         {
            obf_H_w_3575["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_H_w_3575.direction = "vertical";
         obf_H_w_3575.scrollTargetName = "InstanceName_1";
         obf_H_w_3575.visible = true;
         try
         {
            obf_H_w_3575["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

