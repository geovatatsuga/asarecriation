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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2120")]
   public dynamic class LockTowerFreeUIMC extends MovieClip
   {
      
      public var bg:MovieClip;
      
      public var cmdSure:MainButton;
      
      public var txtTitle:TextField;
      
      public var txtTip:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var cmdCancel:MainButton;
      
      public function LockTowerFreeUIMC()
      {
         super();
         obf_X_K_2248();
         obf_U_g_3246();
      }
      
      internal function obf_U_g_3246() : *
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
         cmdCancel.label = "cmdCancel";
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
      
      internal function obf_X_K_2248() : *
      {
         try
         {
            cmdSure["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSure.emphasized = false;
         cmdSure.enabled = true;
         cmdSure.label = "cmdSure";
         cmdSure.labelPlacement = "right";
         cmdSure.selected = false;
         cmdSure.toggle = false;
         cmdSure.visible = true;
         try
         {
            cmdSure["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

